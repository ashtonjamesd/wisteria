import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:wisteria/components/authentication/home_screen.dart';
import 'package:wisteria/components/authentication/register_view.dart';
import 'firebase_options.dart';

void main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen()
    );
  }
}
