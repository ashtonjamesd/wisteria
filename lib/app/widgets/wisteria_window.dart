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
    required this.height,
    this.onTapOkay
  });

  final String header;
  final Widget messageWidget;
  final double width;
  final double height;
  final VoidCallback? onTapOkay;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: WisteriaBox(
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
                          
                          if (onTapOkay != null) {
                            onTapOkay!();
                          }
                        }
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 16)
                ],
              )
            ),
          ),
        ],
      ),
    ); 
  }
}