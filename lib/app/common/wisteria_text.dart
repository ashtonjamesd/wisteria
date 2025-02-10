import 'package:flutter/material.dart';

class WisteriaText extends StatelessWidget {
  const WisteriaText({
    super.key, 
    required this.text
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        
      )
    );
  }
}