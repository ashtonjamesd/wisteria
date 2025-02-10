import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:wisteria/vm/tests/vm_tests.dart';
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
mov rax 10
and rax 2

out rax

""";

    final vmTester = VmTests();
    vmTester.runAllTests();
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