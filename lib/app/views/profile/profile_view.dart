import 'package:flutter/material.dart';
import 'package:wisteria/app/constants.dart';

import '../../common/wisteria_text.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
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
            color: textColor,
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
    return SizedBox();
  }
}