import 'package:flutter/material.dart';
import 'package:wisteria/ui/wisteria_box.dart';
import 'package:wisteria/ui/wisteria_text.dart';
import 'package:wisteria/utils/app_theme.dart';

class WisteriaButton extends StatefulWidget {
  const WisteriaButton({
    super.key,
    this.width,
    this.height = 50,
    this.backgroundColor = AppTheme.boxBackgroundColor,
    this.textColor = AppTheme.textColor,
    required this.text,
    required this.onTap
  });

  final double? width;
  final double? height;
  final String text;
  final VoidCallback onTap;
  final Color backgroundColor;
  final Color textColor;

  @override
  State<WisteriaButton> createState() => _WisteriaButtonState();
}

class _WisteriaButtonState extends State<WisteriaButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: button()
      ),
    );
  }

  Widget button() {
    return WisteriaBox(
      backgroundColor: widget.backgroundColor,
      width: widget.width,
      height: widget.height,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
            child: WisteriaText(
              text: widget.text, 
              size: 14
            )
          ),
        ],
      )
    );
  }
}