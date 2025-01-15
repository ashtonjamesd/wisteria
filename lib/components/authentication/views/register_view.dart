import 'package:flutter/material.dart';
import 'package:wisteria/components/authentication/controllers/auth_controller.dart';
import 'package:wisteria/components/authentication/views/login_view.dart';
import 'package:wisteria/components/home/home_screen.dart';
import 'package:wisteria/ui/wisteria_box.dart';
import 'package:wisteria/ui/wisteria_button.dart';
import 'package:wisteria/ui/wisteria_icon_button.dart';
import 'package:wisteria/ui/wisteria_text.dart';
import 'package:wisteria/ui/wisteria_text_field.dart';
import 'package:wisteria/utils/app_theme.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final controller = AuthController();

  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    final boxWidth = screenWidth * 0.85;

    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          backButton(),
          const Spacer(),
          
          pageTitle(),
          const SizedBox(height: 24),

          registerBox(boxWidth),

          const SizedBox(height: 12),
          registerButton(boxWidth),

          const SizedBox(height: 16),
          orText(boxWidth),
          const SizedBox(height: 16),

          loginButton(boxWidth),
          const SizedBox(height: 42)
        ],
      ),
    );
  }

  Widget backButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: WisteriaIconButton(
            icon: Icons.arrow_back_rounded, 
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const HomeView())
              );
            }
          ),
        ),
      ],
    );
  }

  Widget registerBox(double boxWidth) {
    return Center(
      child: WisteriaBox(
        width: boxWidth, height: 300,
        child: Column(
          children: [
            const SizedBox(height: 4),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: WisteriaTextField(
                width: 80,
                controller: usernameController,
                hintText: "username",
                obscureText: true,
              ),
            ),
            const SizedBox(height: 4),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: WisteriaTextField(
                width: 80,
                controller: emailController,
                hintText: "email",
              ),
            ),
            const SizedBox(height: 4),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: WisteriaTextField(
                width: 80,
                controller: passwordController,
                hintText: "password",
                obscureText: true,
              ),
            ),
          ],
        )
      ),
    );
  }

  Widget pageTitle() {
    return const WisteriaText(
      text: "Create your account",
      size: 28,
    );
  }

  Widget registerButton(double screenWidth) {
    return WisteriaButton(
      backgroundColor: Colors.white,
      textColor: Colors.black,
      width: screenWidth,
      text: "Register",
      onTap: () async {
        
      }
    );
  }

  Widget loginButton(double screenWidth) {
    return WisteriaButton(
      width: screenWidth,
      text: "Log in",
      onTap: () async {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginView())
        );
      }
    );
  }

  Widget orText(double screenWidth) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        orTextLine(screenWidth),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 12),
          child: WisteriaText(
            text: "or",
            size: 14,
            color: Colors.grey,
          ),
        ),
        orTextLine(screenWidth)
      ],
    );
  }

  Widget orTextLine(double screenWidth) {
    return Container(
      width: screenWidth / 2 - 20, height: 1,
      color: const Color.fromARGB(255, 215, 215, 215),
    );
  }
}