import 'package:flutter/material.dart';
import 'package:wisteria/app/constants.dart';

class WisteriaText extends StatelessWidget {
  const WisteriaText({
    super.key, 
    required this.text,
    this.color = primaryTextColor,
    this.size = 14,
    this.isBold = false
  });

  final String text;
  final Color color;
  final double size;
  final bool isBold;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: color,
        fontSize: size,
        fontWeight: isBold ? FontWeight.bold : null
      )
    );
  }
}