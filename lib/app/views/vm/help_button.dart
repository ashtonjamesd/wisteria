import 'package:flutter/material.dart';
import 'package:wisteria/app/common/wisteria_box.dart';
import 'package:wisteria/app/common/wisteria_button.dart';
import 'package:wisteria/app/common/wisteria_text.dart';
import 'package:wisteria/app/constants.dart';

class HelpButton extends StatefulWidget {
  const HelpButton({super.key});

  @override
  State<HelpButton> createState() => _HelpButtonState();
}

class _HelpButtonState extends State<HelpButton> {
  @override
  Widget build(BuildContext context) {
    return WisteriaButton(
      width: 80, 
      color: primaryGrey, 
      text: "help", 
      onTap: () {
        showDialog(context: context, builder: (context) {
          return helpDialog();
        });
      }
    );
  }

  Widget helpDialog() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        WisteriaBox(
          width: 240, 
          height: 320, 
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: WisteriaText(
                    text: "Welcome to Wisteria.", 
                    color: textColor, 
                    size: 15
                  ),
                ),
              ),
              
              Padding(
                padding: const EdgeInsets.all(8),
                child: WisteriaText(
                  text: helpMessage, 
                  color: textColor, 
                  size: 12
                ),
              ),

              const Spacer(),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  WisteriaButton(
                    width: 80, 
                    color: primaryGrey, 
                    text: "okay", 
                    onTap: () {
                      Navigator.pop(context);
                    }
                  ),
                ],
              ),

              const SizedBox(height: 16)
            ],
          )
        ),
      ],
    );
  }
}