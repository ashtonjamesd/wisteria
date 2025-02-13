import 'package:flutter/material.dart';
import 'package:wisteria/app/widgets/wisteria_slider.dart';
import 'package:wisteria/app/widgets/wisteria_text.dart';
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
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 40),

        Padding(
          padding: const EdgeInsets.only(left: 32),
          child: WisteriaText(
            text: "settings", 
            color: textColor,
            size: 24,
          ),
        ),

        const SizedBox(height: 28),

        Center(
          child: settingsBox()
        ),
      ],
    );
  }

  Widget settingsBox() {
    return Column(
      children: [
        trueOrFalseSetting(
          "show help dialogues", 
          "show information about components when tapped", 
          (value) {
            AppController.instance.settings.showInfoDialogs = value;
          }
        ),
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
    );
  }
}
