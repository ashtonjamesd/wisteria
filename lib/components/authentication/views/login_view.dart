import 'package:flutter/material.dart';
import 'package:wisteria/components/authentication/views/register_view.dart';
import 'package:wisteria/components/launcher/views/launcher_view.dart';

import '../../../ui/wisteria_box.dart';
import '../../../ui/wisteria_button.dart';
import '../../../ui/wisteria_icon_button.dart';
import '../../../ui/wisteria_text.dart';
import '../../../ui/wisteria_text_field.dart';
import '../../../utils/app_theme.dart';
import '../../home/home_screen.dart';
import '../controllers/auth_controller.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final controller = AuthController();

  final emailOrUsernameController = TextEditingController();
  final passwordController = TextEditingController();

  String authMessage = "";

  Future setAuthMessage(String? message) async {
    setState(() {
      authMessage = "";
    });

    await Future.delayed(const Duration(milliseconds: 150));

    setState(() {
      authMessage = message ?? "";
    });
  }

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
          loginButton(boxWidth),

          const SizedBox(height: 16),
          orText(boxWidth),
          const SizedBox(height: 16),

          registerButton(boxWidth),
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
        backgroundColor: AppTheme.backgroundColor,
        hasBorder: false,
        width: boxWidth, height: 300,
        child: Column(
          children: [
            const SizedBox(height: 4),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: WisteriaTextField(
                width: 80,
                controller: emailOrUsernameController,
                hintText: "email or username",
              ),
            ),
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: WisteriaTextField(
                width: 80,
                controller: passwordController,
                hintText: "password",
                obscureText: true,
              ),
            ),

            errorMessage()
          ],
        )
      ),
    );
  }

  Widget errorMessage() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 12, top: 8),
          child: WisteriaText(
            text: authMessage,
            color: const Color.fromARGB(255, 255, 141, 133),
            size: 14,
          ),
        ),
      ],
    );
  }

  Widget pageTitle() {
    return const WisteriaText(
      text: "Welcome back",
      size: 28,
    );
  }

  Widget registerButton(double screenWidth) {
    return WisteriaButton(
      width: screenWidth,
      text: const WisteriaText(text: "Register", size: 14),
      onTap: () async {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const RegisterView())
        );
      }
    );
  }

  Widget loginButton(double screenWidth) {
    return WisteriaButton(
      backgroundColor: Colors.white,
      width: screenWidth,
      text: const WisteriaText(text: "Log in", size: 14),
      onTap: () async {
        final result = await controller.loginUser(emailOrUsernameController.text, passwordController.text);
        if (!result.isSuccess) {
          setAuthMessage(result.error);
          return;
        }

        Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const LauncherView())
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