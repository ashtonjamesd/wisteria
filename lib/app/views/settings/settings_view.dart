import 'package:flutter/material.dart';
import 'package:wisteria/app/common/wisteria_slider.dart';
import 'package:wisteria/app/common/wisteria_text.dart';
import 'package:wisteria/app/constants.dart';
import 'package:wisteria/app/utils/app_controller.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryWhite,
      body: settingsView(),
    );
  }

  Widget settingsView() {
    return Column(
      children: [
        WisteriaText(
          text: "Settings", 
          color: primaryGrey, 
          size: 28,
        ),
        settingsBox(),
      ],
    );
  }

  Widget settingsBox() {
    return Column(
      children: [
        trueOrFalseSetting(
          "Show Help Dialogues", 
          "Show information about components when clicked", 
          (value) {
            AppController.instance.settings.showInfoDialogs = value;
          }
        ),
      ],
    );
  }

  Widget trueOrFalseSetting(String name, String desc, Function(bool) onChanged) {
    bool value = AppController.instance.settings.showInfoDialogs;

    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 8.0, 
        horizontal: 24.0
      ),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 240, 240, 240),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            WisteriaText(
              text: name, 
              color: textColor, 
              size: 16,
            ),
            WisteriaText(
              text: desc, 
              color: textColor.withOpacity(0.8),
              size: 12,
            ),

            const SizedBox(height: 16),
            WisteriaSlider(value: value, onChanged: (value) {
              onChanged(value);
            }),
          ],
        ),
      ),
    );
  }
}
