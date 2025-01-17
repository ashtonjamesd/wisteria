import 'package:flutter/material.dart';
import 'package:wisteria/components/authentication/views/login_view.dart';
import 'package:wisteria/components/authentication/views/register_view.dart';
import 'package:wisteria/constants.dart';
import 'package:wisteria/ui/wisteria_button.dart';
import 'package:wisteria/ui/wisteria_text.dart';
import 'package:wisteria/utils/app_theme.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
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

                const SizedBox(height: 24)
              ],
            ),
          ),

          const SizedBox(height: 18)
        ],
      )
    );
  }

  Widget pageTitle() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          WisteriaText(
            text: appName.toLowerCase(),
            size: 30,
            weight: FontWeight.bold,
            letterSpacing: 1,
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
            text: appHomeHeader,
            size: 24,
          ),
          WisteriaText(
            text: appHomeText,
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
          width: screenWidth * 0.85,
          text: "Log in", 
          onTap: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const LoginView())
            );
          }
        ),

        const SizedBox(height: 12),
        WisteriaButton(
          textColor: AppTheme.textColor, 
          backgroundColor: AppTheme.backgroundColor,
          width: screenWidth * 0.85,
          text: "Register",
          onTap: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const RegisterView())
            );
          }
        )
      ],
    );
  }
}