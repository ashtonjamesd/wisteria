import 'package:flutter/material.dart';

import '../constants.dart';
import 'wisteria_box.dart';
import 'wisteria_button.dart';
import 'wisteria_text.dart';

class WisteriaWindow extends StatelessWidget {
  const WisteriaWindow({
    super.key, 
    required this.header, 
    required this.messageWidget, 
    required this.width, 
    required this.height
  });

  final String header;
  final Widget messageWidget;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        WisteriaBox(
          width: width, 
          height: height, 
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: WisteriaText(
                    text: header, 
                    color: primaryTextColor, 
                    size: 15
                  ),
                ),
              ),
              
              messageWidget,

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