import 'package:flutter/material.dart';
import 'package:wisteria/components/authentication/auth_controller.dart';
import 'package:wisteria/ui/wisteria_box.dart';
import 'package:wisteria/ui/wisteria_button.dart';
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

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    final boxWidth = screenWidth * 0.9;

    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          pageTitle(),
          const SizedBox(height: 24),

          registerBox(boxWidth),

          const SizedBox(height: 12),
          _registerButton(boxWidth)
        ],
      ),
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

  Widget _registerButton(double screenWidth) {
    return WisteriaButton(
      width: screenWidth,
      text: "register",
      onTap: () async {
        var result = await controller.registerUser(emailController.text, passwordController.text);
        if (!result.isSuccess) {
          print(result.error);
          return;
        }

        if (result.value == true) {

        }
      }
    );
  }
}