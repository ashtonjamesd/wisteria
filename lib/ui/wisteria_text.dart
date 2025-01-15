import 'package:flutter/material.dart';
import 'package:wisteria/utils/app_theme.dart';

class WisteriaText extends StatelessWidget {
  const WisteriaText({
    super.key, 
    required this.text,
    required this.size,
    this.color = AppTheme.textColor,
    this.weight = FontWeight.normal,
    this.letterSpacing
  });

  final String text;
  final double size;
  final Color color;
  final FontWeight weight;
  final double? letterSpacing;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: AppTheme.appFont().copyWith(
        color: color,
        fontSize: size,
        fontWeight: weight,
        letterSpacing: letterSpacing,
      )
    );
  }
}