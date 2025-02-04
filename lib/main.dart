import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
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

  @override
  Widget build(BuildContext context) {
    String x = 
"""
section .code
  mov r1 100 add r1 200
""";

    final lexer = Lexer(program: x);
    final program = lexer.tokenize();



    // var vm = VirtualMachine(program: program);
    // vm.run();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold()
    );
  }
}
