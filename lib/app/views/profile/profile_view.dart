import 'package:flutter/material.dart';
import 'package:wisteria/app/constants.dart';
import 'package:wisteria/app/views/profile/utils/profile_view_controller.dart';
import 'package:wisteria/app/widgets/wisteria_button.dart';

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

        Center(
          child: profileBox()
        ),
      ],
    );
  }

  Widget profileBox() {
    return SizedBox(
      height: MediaQuery.sizeOf(context).height - 230,
      child: Center(
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
        )
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
          WisteriaText(
            color: primaryTextColor,
            text: "Login here",
            isBold: true,
            size: 18,
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