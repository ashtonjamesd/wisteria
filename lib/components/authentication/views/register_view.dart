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

  Future setAuthMessage(String? message) async {
    setState(() {
      controller.authMessage = "";
    });

    await Future.delayed(const Duration(milliseconds: 150));

    setState(() {
      controller.authMessage = message ?? "";
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
                controller: usernameController,
                hintText: "username",
              ),
            ),
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: WisteriaTextField(
                width: 80,
                controller: emailController,
                hintText: "email",
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
            text: controller.authMessage,
            color: const Color.fromARGB(255, 255, 141, 133),
            size: 14,
          ),
        ),
      ],
    );
  }

  Widget pageTitle() {
    return const WisteriaText(
      text: "Welcome to Wisteria!",
      size: 28,
    );
  }

  Widget registerButton(double screenWidth) {
    return WisteriaButton(
      backgroundColor: Colors.white,
      width: screenWidth,
      text: const WisteriaText(text: "Register", size: 14),
      onTap: () async {
        var result = await controller.registerUser(
          usernameController.text, emailController.text, passwordController.text
        );

        if (!result.isSuccess) {
          setAuthMessage(result.error);
          return;
        }

        Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const LoginView())
        );
      }
    );
  }

  Widget loginButton(double screenWidth) {
    return WisteriaButton(
      width: screenWidth,
      text: const WisteriaText(text: "Log in", size: 14),
      onTap: () async {
        Navigator.pushReplacement(context,
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