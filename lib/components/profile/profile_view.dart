import 'package:flutter/material.dart';
import 'package:wisteria/components/authentication/models/wisteria_user.dart';
import 'package:wisteria/ui/wisteria_box.dart';
import 'package:wisteria/ui/wisteria_text.dart';
import 'package:wisteria/utils/app_theme.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({
    super.key, 
    required this.user
  });

  final WisteriaUser user;

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;

    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: Column(
        children: [
          WisteriaBox(
            width: screenWidth,
            backgroundColor: AppTheme.backgroundColor,
            child: WisteriaText(
              text: widget.user.username,
              size: 14
            )
          )
        ],
      ),
    );
  }
}