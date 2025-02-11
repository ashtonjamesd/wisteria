import 'package:flutter/material.dart';

class WisteriaText extends StatelessWidget {
  const WisteriaText({
    super.key, 
    required this.text,
    required this.color,
    required this.size,
  });

  final String text;
  final Color color;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: color,
        fontSize: size
      )
    );
  }
}