import 'package:flutter/material.dart';
import 'package:wisteria/app/views/profile/utils/profile_view_controller.dart';
import 'package:wisteria/app/views/profile/views/profile_view.dart';
import 'package:wisteria/app/widgets/wisteria_icon.dart';
import '../../../constants.dart';
import '../../../utils/globals.dart';
import '../../../widgets/wisteria_button.dart';
import '../../../widgets/wisteria_field.dart';
import '../../../widgets/wisteria_text.dart';

class NotLoggedInView extends StatefulWidget {
  const NotLoggedInView({
    super.key, 
    required this.update
  });

  final VoidCallback update;

  @override
  State<NotLoggedInView> createState() => _NotLoggedInViewState();
}

class _NotLoggedInViewState extends State<NotLoggedInView> {
  final controller = ProfileViewController();

  @override
  Widget build(BuildContext context) {
    return notLoggedInScreen();
  }

  Widget notLoggedInScreen() {
    return Center(
      child: Column(
        children: [
          const SizedBox(height: 120),
          saveYourProgress(),
      
          const Spacer(),
      
          signUpWithEmailButton(),
          const SizedBox(height: 12),
          loginButton(),
      
          const SizedBox(height: 32),
          
          agreeTsAndCs()
        ],
      ),
    );
  }

  Widget saveYourProgress() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        WisteriaText(
          text: "Save your progress", 
          color: primaryTextColor, 
          size: 22
        ),
        WisteriaText(
          text: "Create an account to save your progress in exercises", 
          color: secondaryTextColor, 
          size: 14
        ),
      ],
    );
  }

  Widget signUpWithEmailButton() {
    return WisteriaButton(
      width: 240, 
      height: 40,
      color: primaryGrey,
      text: "Sign up with email", 
      onTap: () {
        push(context, setEmailScreen());
      }
    );
  }

  Widget loginButton() {
    return Padding(
      padding: const EdgeInsets.only(right: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          WisteriaText(
            text: "or", 
            color: secondaryTextColor, 
            size: 14
          ),
          const SizedBox(width: 12),
          GestureDetector(
            onTap: () {
              push(context, enterEmailScreen());
            },
            child: WisteriaText(
              color: primaryTextColor,
              text: "Login here",
              isBold: true,
              size: 18,
            ),
          ),
        ],
      ),
    );
  }

  Widget agreeTsAndCs() {
    return WisteriaText(
      text: "By signing up, you accept our Terms and Conditions.", 
      color: secondaryTextColor, 
      size: 14
    );
  }

  Widget setEmailScreen() {
    return enterFieldScreen(
      "Enter your email", 
      "name@example.com", 
      controller.emailController, 
      () {
        if (!controller.isValidEmail(controller.emailController.text)) {
          return;
        }

        push(context, setPasswordScreen());
      }
    );
  }

  Widget setPasswordScreen() {
    return enterFieldScreen(
      "Set a password", 
      "min. 8 characters", 
      controller.passwordController,
      isPassword: true,
      () {
        if (!controller.isValidPassword(controller.passwordController.text)) {
          return;
        }

        push(context, enterUsernameScreen());
      }
    );
  }

  Widget enterUsernameScreen() {
    return enterFieldScreen(
      "How should we address you?", 
      "john_doe (min. 3 characters)", 
      controller.usernameController, 
      () async {
        if (!controller.isValidPassword(controller.passwordController.text)) {
          return;
        }

        final result = await controller.registerUser();
        await controller.loginUser();

        if (result.isSuccess) {
          push(
            context, 
            infoScreen(
              "Account created successfully", "Welcome ${controller.usernameController.text}", 
              () {
                  pop(context);
                  pop(context);
                  pop(context);
                  pop(context);
              }
            ),
          );

          controller.cleanup();
          return;
        }

        push(
          context, 
          infoScreen(
            "Unable to create account", "Please try again later or raise an error with support", 
            () {
              pop(context);
              pop(context);
              pop(context);
              pop(context);
            }
          ),
        );

        controller.cleanup();
        return;
      }
    );
  }

  Widget infoScreen(String header, String description, Function onTapOkay) {
    final screen = MediaQuery.sizeOf(context);

    return Scaffold(
      backgroundColor: primaryWhite,
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 120),
            WisteriaText(
              text: header,
              size: 22,
              isBold: true,
            ),
            const SizedBox(height: 16),

            WisteriaText(
              text: description,
              size: 16,
            ),
            const SizedBox(height: 48),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: WisteriaButton(
                width: screen.width * 0.4,
                color: primaryGrey,
                text: "okay",
                textColor: primaryWhite,
                height: 40,
                onTap: () async {
                  await onTapOkay();
                }
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget enterEmailScreen() {
    return enterFieldScreen(
      "Enter your email", 
      "name@example.com", 
      controller.emailController, 
      onBack: () {
        controller.emailController.clear();
        controller.passwordController.clear();
      },
      () {
        if (!controller.isValidEmail(controller.emailController.text)) {
          return;
        }

        push(context, enterPasswordScreen());
      }
    );
  }

  Widget enterPasswordScreen() {
    return enterFieldScreen(
      "Enter your password", 
      "", 
      controller.passwordController, 
      isPassword: true,
      () async {
        final result = await controller.loginUser();
        
        if (!result.isSuccess) {
          push(
            context, 
            infoScreen(
              "Invalid credentials", "Incorrect email or password", 
              () {
                pop(context);
                pop(context);
                pop(context);

                controller.emailController.clear();
                controller.passwordController.clear();
              }
            ),
          );

          return;
        }

        pop(context);
        pop(context);

        setState(() {});
        widget.update();
      }
    );
  }

  Widget enterFieldScreen(String header, String hintText, TextEditingController textController, Function onTap, {String buttonText = "continue", bool isPassword = false, Function? onBack}) {
    final screen = MediaQuery.sizeOf(context);

    return Scaffold(
      backgroundColor: primaryWhite,
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 120),

            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 32),
                  child: GestureDetector(
                    onTap: () {
                      if (onBack != null) {
                        onBack();
                      }
                      pop(context);
                    },
                    child: WisteriaIcon(
                      icon: Icons.arrow_back,
                      size: 24,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            WisteriaText(
              text: header,
              size: 22,
              isBold: true,
            ),
            
            SizedBox(
              width: screen.width - 40,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: WisteriaField(
                  obscure: isPassword,
                  hintText: hintText,
                  controller: textController
                ),
              )
            ),

            const SizedBox(height: 32),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: WisteriaButton(
                width: screen.width * 0.4,
                color: primaryGrey,
                text: buttonText,
                textColor: primaryWhite,
                height: 40,
                onTap: () async {
                  await onTap();
                }
              ),
            )
          ],
        ),
      ),
    );
  }
}