import 'package:flutter/material.dart';
import 'package:wisteria/utils/app_theme.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: Column(
        children: [
          pageTitle(),

        ],
      )
    );
  }

  Widget pageTitle() {
    return const Padding(
      padding: EdgeInsets.all(16),
      child: Text(
        "wisteria",
        style: TextStyle(
          color: Colors.black,
          fontSize: 24,
          fontWeight: FontWeight.bold,
          letterSpacing: 0.8
        ),
      ),
    );
  }
}