import 'package:flutter/material.dart';
import 'package:wisteria/app/constants.dart';

class InfoIcon extends StatefulWidget {
  const InfoIcon({
    super.key, 
    required this.text
  });

  final String text;

  @override
  State<InfoIcon> createState() => _InfoIconState();
}

class _InfoIconState extends State<InfoIcon> {
  bool isDisplayed = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          setState(() {
            isDisplayed = !isDisplayed;
          });
        },
        child: Icon(
          Icons.info,
          color: primaryGrey,
          size: 20,
        ),
      ),
    );
  }
}