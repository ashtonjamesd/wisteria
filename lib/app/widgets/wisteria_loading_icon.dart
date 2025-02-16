import 'package:flutter/material.dart';
import 'package:wisteria/app/constants.dart';
import 'package:wisteria/app/widgets/wisteria_text.dart';

class WisteriaLoadingIcon extends StatelessWidget {
  const WisteriaLoadingIcon({
    super.key, 
    required this.text
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        WisteriaText(
          text: text,
          color: primaryTextColor,
          size: 18,
        ),
        const SizedBox(height: 12),
        CircularProgressIndicator(
          color: primaryGrey,
        ),
      ],
    );
  }
}