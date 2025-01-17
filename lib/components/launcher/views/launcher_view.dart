import 'package:flutter/material.dart';
import 'package:wisteria/components/authentication/models/wisteria_user.dart';
import 'package:wisteria/components/profile/profile_view.dart';
import 'package:wisteria/constants.dart';
import 'package:wisteria/ui/wisteria_box.dart';
import 'package:wisteria/ui/wisteria_button.dart';
import 'package:wisteria/ui/wisteria_icon_button.dart';
import 'package:wisteria/ui/wisteria_text.dart';
import 'package:wisteria/ui/wisteria_window.dart';
import 'package:wisteria/utils/app_theme.dart';

import '../controllers/launcher_controller.dart';

class LauncherView extends StatefulWidget {
  const LauncherView({
    super.key, 
    required this.user
  });

  final WisteriaUser user;

  @override
  State<LauncherView> createState() => _LauncherViewState();
}

class _LauncherViewState extends State<LauncherView> {
  final launcherController = LauncherController();

  void showWelcomeBox() {
    showDialog(context: context, builder: (context) {
      return WisteriaWindow(
        width: 400,
        height: 220,
        showCloseButton: false,
        child: welcomeBox()
      );
    });
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showWelcomeBox();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: Column(
        children: [
          navBar()
        ],
      )
    );
  }

  Widget navBar() {
    return WisteriaBox(
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: WisteriaIconButton(
              icon: Icons.person,
              onTap: () {
                Navigator.pushReplacement(context, 
                  MaterialPageRoute(builder: (context) => ProfileView(
                    user: widget.user,
                  ))
                );
              }
            ),
          )
        ],
      ) 
    );
  }

  Widget welcomeBox() {
    return Column(
      children: [
        const SizedBox(height: 16),
        const WisteriaText(
          weight: FontWeight.bold,
          text: appGreetingHeader, 
          size: 18
        ),
        
        const SizedBox(height: 16),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: WisteriaText(
            text: appGreetingMessage,
            weight: FontWeight.w500,
            size: 14
          ),
        ),

        const SizedBox(height: 52),
        WisteriaButton(
          width: 200,
          backgroundColor: AppTheme.bluePrimary,
          text: const WisteriaText(
            color: Colors.white,
            text: appGreetingButtonMessage,
            size: 17,
            weight: FontWeight.bold,
            letterSpacing: 0.9,
          ),
          onTap: () {
            Navigator.pop(context);
          }
        )
      ],
    );
  }
}