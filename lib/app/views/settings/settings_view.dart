import 'package:flutter/material.dart';
import 'package:simple_icons/simple_icons.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:wisteria/app/preferences.dart';
import 'package:wisteria/app/utils/auth/auth_service.dart';
import 'package:wisteria/app/utils/globals.dart';
import 'package:wisteria/app/views/welcome/welcome_view.dart';
import 'package:wisteria/app/widgets/wisteria_box.dart';
import 'package:wisteria/app/widgets/wisteria_button.dart';
import 'package:wisteria/app/widgets/wisteria_icon.dart';
import 'package:wisteria/app/widgets/wisteria_slider.dart';
import 'package:wisteria/app/widgets/wisteria_text.dart';
import 'package:wisteria/app/constants.dart';
import 'package:wisteria/app/utils/app_controller.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../widgets/wisteria_window.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  final authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryWhite,
      body: settingsView(),
    );
  }

  Widget settingsView() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 40),
      
          Padding(
            padding: const EdgeInsets.only(left: 32),
            child: WisteriaText(
              text: "settings", 
              color: primaryTextColor,
              size: 24,
            ),
          ),
      
          const SizedBox(height: 28),
          settingsBox(),
        ],
      ),
    );
  }

  Widget settingsBox() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          userSettings(),
          const SizedBox(height: 24),
            
          settingsHeader("App Settings", hasTopPadding: false),
          trueOrFalseSetting(
            "Show help dialogues", 
            "Show information about components when tapped", 
            (value) {
              AppController.instance.settings.showInfoDialogs = value;
            }
          ),

          const SizedBox(height: 8),
          basicSetting(
            "Reset Tutorial", Icons.menu,
            () {
              showDialog(context: context, builder: (context) {
                AppController.instance.setPreference(shownInitialHelpDialoguePref, "false");
                return basicDialogue("Reset Tutorial");
              });
            }
          ),
      
          settingsHeader("Contact"),
          basicSetting(
            "Terms and Conditions", Icons.file_copy,
            () {
              showDialog(context: context, builder: (context) {
                return termsAndConditions();
              });
            }
          ),
            
          basicSetting(
            "Privacy Policy", Icons.lock,
            () {
              showDialog(context: context, builder: (context) {
                return privacyPolicy();
              });
            }
          ),
          basicSetting(
            "Support", Icons.help,
            () {
              showDialog(context: context, builder: (context) {
                return helpDialogue();
              });
            }
          ),
            
          settingsHeader("Share"),
          basicSetting(
            "View the code", SimpleIcons.github,
            () async {
              final uri = Uri.parse(githubUrl);
              if (await canLaunchUrl(uri)){
                  await launchUrl(uri);
              }
            }
          ),
          // basicSetting(
          //   "Follow us on Instagram", SimpleIcons.instagram,
          //   () {
              
          //   }
          // ),
          // basicSetting(
          //   "Follow us on Twitter", SimpleIcons.twitter,
          //   () {
              
          //   }
          // ),

          const SizedBox(height: 32),

          logoutButton(),
            
          // const Spacer(),
          copyrightNotice()
        ],
      ),
    );
  }

  Widget logoutButton() {
    if (AppController.instance.user == null) {
      return SizedBox();
    }

    return WisteriaButton(
      width: MediaQuery.sizeOf(context).width - 40, 
      color: primaryGrey,
      text: "Logout",
      textSize: 18,
      height: 40,
      onTap: () async {
        await authService.logout();
        setState(() {});

        // showDialog(context: context, builder: (context) {
        //   return basicDialogue("Logged Out");
        // });

        await AppController.instance.resetPreferences();
        push(context, WelcomeView());
      }
    );
  }

  Widget basicDialogue(String message) {
    return WisteriaWindow(
      header: "", 
      messageWidget: Padding(
        padding: const EdgeInsets.only(bottom: 16),
        child: Center(
          child: WisteriaText(
            text: message,
            size: 16,
            isBold: true,
          ),
        ),
      ), 
      width: 240, 
      height: 140
    );
  }

  Widget userSettings() {
    if (AppController.instance.user == null) {
      return SizedBox();
    }

    return Column(
      children: [
        infoSetting("Email", AppController.instance.user!.email),
        infoSetting("Username", AppController.instance.user!.username),
      ],
    );
  }

  Widget termsAndConditions() {
    return WisteriaWindow(
      header: "Terms and Conditions", 
      width: 280, 
      height: 240,
      messageWidget: WisteriaText(
        text: termsAndConditionsMessage
      ),
    );
  }

  Widget privacyPolicy() {
    return WisteriaWindow(
      header: "Privacy Policy", 
      width: 280, 
      height: 240,
      messageWidget: WisteriaText(
        text: privacyPolicyMessage
      ),
    );
  }

  Widget helpDialogue() {
    return WisteriaWindow(
      header: "Need Support?", 
      messageWidget: Padding(
        padding: const EdgeInsets.all(8),
        child: WisteriaText(
          text: supportMessage, 
          color: primaryTextColor, 
          size: 12
        ),
      ), 
      width: 280, 
      height: 240
    );
  }

  Widget copyrightNotice() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(height: 64),

        WisteriaText(
          text: "© 2025 Wisteria",
          color: primaryTextColor,
          size: 12,
        ),
      ],
    );
  }

  Widget settingsHeader(String text, {bool hasTopPadding = true}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(
            top: hasTopPadding ? 24 : 0,
            left: 32,
            bottom: 4
          ),
          child: WisteriaText(
            isBold: true,
            size: 14,
            text: text
          ),
        ),

        SizedBox(height: 12),
      ],
    );
  }

  Widget trueOrFalseSetting(String name, String desc, Function(bool) onChanged) {
    final screen = MediaQuery.sizeOf(context);
    bool value = AppController.instance.settings.showInfoDialogs;

    return Container(
      width: screen.width / widthFactor ,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 240, 240, 240),
        borderRadius: BorderRadius.circular(boxBorderRadius),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          WisteriaText(
            text: name, 
            color: primaryTextColor, 
            size: 16,
          ),
          WisteriaText(
            text: desc, 
            color: primaryTextColor.withOpacity(0.8),
            size: 12,
          ),
    
          const SizedBox(height: 16),
          WisteriaSlider(value: value, onChanged: (value) {
            onChanged(value);
          }),
        ],
      ),
    );
  }

  Widget infoSetting(String header, String value) {
    final screen = MediaQuery.sizeOf(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(width: 12, height: 12),

        WisteriaText(
          text: header,
          isBold: true,
          size: 15,
        ),

        WisteriaBox(
          width: screen.width - 40, 
          height: 50,
          color: primaryWhite,
          showBorder: true,
          borderColor: primaryGrey,
          child: Row(
            children: [
              const SizedBox(width: 12),
        
              WisteriaText(
                text: value,
                size: 15,
              ),
            ],
          )
        ),
      ],
    );
  }

  Widget basicSetting(String text, IconData icon, Function onTap) {
    final screen = MediaQuery.sizeOf(context);

    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: WisteriaBox(
        width: screen.width - 40, 
        height: 50,
        color: primaryWhite,
        showBorder: true,
        borderColor: primaryGrey,
        child: Row(
          children: [
            const SizedBox(width: 12),
      
            WisteriaIcon(
              icon: icon,
              color: primaryTextColor,
              size: 20,
            ),
            const SizedBox(width: 12),
      
            WisteriaText(
              text: text,
              size: 15,
            ),
          ],
        )
      ),
    );
  }
}
