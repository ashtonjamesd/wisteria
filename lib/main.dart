import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:wisteria/vm/assembler/assembler.dart';
import 'package:wisteria/vm/parser/lexer.dart';
import 'package:wisteria/vm/vm.dart';
import 'firebase_options.dart';

void main() async {
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    runApp(const App());
  } catch (e) {
    print('Error: $e');
  }
}

class App extends StatelessWidget {
  const App({super.key});

  Future run() async {
    String x = 
"""
segment data
  msg = alloc "Hello, World!"

segment text

main:
  mov r1 100
  add r1 200

  mov rax 1
  mov rbx msg
  call

  mov rax 2
  mov rbx 0
  call
""";

x = 
"""
mov rax 1

START:
  out rax
  inc rax

  jump START
""";

    final lexer = Lexer(program: x);
    final tokens = lexer.tokenize();

    // for (var x in tokens) print(x);

    final assembler = Assembler(tokens: tokens);
    final program = assembler.assemble();

    print(program.join(" "));

    // program.removeWhere((x) => x == 0);
    final vm = VirtualMachine(program: program);
    vm.run();
  }

  @override
  Widget build(BuildContext context) {
    run();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold()
    );
  }
}