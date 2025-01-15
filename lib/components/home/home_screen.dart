import 'package:flutter/material.dart';
import 'package:wisteria/components/authentication/register_view.dart';
import 'package:wisteria/ui/wisteria_button.dart';
import 'package:wisteria/ui/wisteria_text.dart';
import 'package:wisteria/utils/app_theme.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          pageTitle(),
          const Spacer(),

          Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                wisteriaInfo(),
                authButtons(screenWidth, screenHeight),
              ],
            ),
          ),

          const SizedBox(height: 18)
        ],
      )
    );
  }

  Widget pageTitle() {
    return const Padding(
      padding: EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          WisteriaText(
            text: "wisteria",
            size: 24,
            weight: FontWeight.bold,
          ),
        ],
      ),
    );
  }

  Widget wisteriaInfo() {
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          WisteriaText(
            text: "An engine in your pocket.",
            size: 24,
          ),
          WisteriaText(
            text: "Create, build, and share pixel art games directly on \nyour mobile device.",
            size: 14
          ),
          
          SizedBox(height: 32)
        ]
      ),
    );
  }

  Widget authButtons(double screenWidth, double screenHeight) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        WisteriaButton(
          width: screenWidth * 0.9,
          text: "Log in", 
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const RegisterView())
            );
          }
        ),

        const SizedBox(height: 12),
        WisteriaButton(
          textColor: AppTheme.textColor, 
          backgroundColor: AppTheme.backgroundColor,
          width: screenWidth * 0.9,
          text: "Register",
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const RegisterView())
            );
          }
        )
      ],
    );
  }
}