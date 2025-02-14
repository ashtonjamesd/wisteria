import 'package:flutter/material.dart';
import 'package:wisteria/app/constants.dart';
import 'package:wisteria/app/utils/app_controller.dart';
import 'package:wisteria/app/utils/globals.dart';
import 'package:wisteria/app/views/profile/utils/profile_view_controller.dart';
import 'package:wisteria/app/widgets/wisteria_button.dart';
import 'package:wisteria/app/widgets/wisteria_field.dart';

import '../../widgets/wisteria_text.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final controller = ProfileViewController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryWhite,
      body: profileView(),
    );
  }

  Widget profileView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 40),

        Padding(
          padding: const EdgeInsets.only(left: 32),
          child: WisteriaText(
            text: "profile", 
            color: primaryTextColor,
            size: 24,
          ),
        ),

        const SizedBox(height: 28),

        profileBox(),
      ],
    );
  }

  Widget profileBox() {
    return SizedBox(
      height: MediaQuery.sizeOf(context).height - 230,
      child: AppController.instance.user == null ? notLoggedInScreen() : loggedInScreen(),
    );
  }

  Widget loggedInScreen() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 24),
        welcomeText(),

        const SizedBox(height: 24),

        userField("username", AppController.instance.user!.username),
        const SizedBox(height: 16),

        userField("exercises complete", AppController.instance.user!.exercisesComplete.toString()),
        const SizedBox(height: 16),

      ],
    );
  }

  Widget userField(String field, String value) {
    return Padding(
      padding: const EdgeInsets.only(left: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          WisteriaText(
            text: field,
            color: primaryTextColor,
            size: 16,
            isBold: true,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16),
            child: WisteriaText(
              text: value,
              color: secondaryTextColor,
              size: 16,
            ),
          ),
        ],
      ),
    );
  }

  Widget welcomeText() {
    return Padding(
      padding: const EdgeInsets.only(left: 16),
      child: Row(
        children: [
          WisteriaText(
            text: "welcome, ",
            color: primaryTextColor,
            size: 28,
          ),
          WisteriaText(
            text: "${AppController.instance.user!.username}!",
            color: secondaryTextColor,
            size: 32,
            isBold: true,
          ),
        ],
      ),
    );
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
          text: "save your progress", 
          color: primaryTextColor, 
          size: 22
        ),
        WisteriaText(
          text: "create an account to save your progress in exercises", 
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
      text: "sign up with email", 
      onTap: () {
        push(context, setEmailScreen());
      }
    );
  }

  Widget setEmailScreen() {
    return enterFieldScreen(
      "enter your email", 
      "name@example.com", 
      controller.emailController, 
      () {
        if (!controller.isValidateEmail(controller.emailController.text)) {
          return;
        }

        push(context, setPasswordScreen());
      }
    );
  }

  Widget setPasswordScreen() {
    return enterFieldScreen(
      "set a password", 
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
      "how should we address you?", 
      "john_doe (min. 3 characters)", 
      controller.usernameController, 
      () async {
        if (!controller.isValidPassword(controller.passwordController.text)) {
          return;
        }

        final result = await controller.registerUser();
        // final user = await controller.loginUser();

        if (result.isSuccess) {
          push(
            context, 
            infoScreen(
              "account created successfully", "welcome ${controller.usernameController.text}", 
              () {
                  pop(context);
                  pop(context);
                  pop(context);
                  pop(context);
              }
            ),
          );

          return;
        }

        push(
          context, 
          infoScreen(
            "unable to create account", "please try again later or raise an error with support", 
            () {
              pop(context);
              pop(context);
              pop(context);
            }
          ),
        );

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

            const SizedBox(height: 32),

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
      "enter your email", 
      "name@example.com", 
      controller.emailController, 
      () {
        if (!controller.isValidateEmail(controller.emailController.text)) {
          return;
        }

        push(context, enterPasswordScreen());
      }
    );
  }

  Widget enterPasswordScreen() {
    return enterFieldScreen(
      "enter your password", 
      "", 
      controller.passwordController, 
      isPassword: true,
      () async {
        final result = await controller.loginUser();
        
        if (!result.isSuccess) {
          push(
            context, 
            infoScreen(
              "invalid credentials", "incorrect email or password", 
              () {
                pop(context);
                pop(context);
                pop(context);
              }
            ),
          );

          return;
        }

        pop(context);
        pop(context);

        setState(() {
          AppController.instance.user = result.value;
        });
      }
    );
  }


  Widget enterFieldScreen(String header, String hintText, TextEditingController textController, Function onTap, {String buttonText = "continue", bool isPassword = false}) {
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
}