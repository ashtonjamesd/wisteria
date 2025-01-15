import 'package:flutter/material.dart';
import 'package:wisteria/utils/app_theme.dart';

class WisteriaBox extends StatelessWidget {
  const WisteriaBox({
    super.key, 
    this.width,
    this.height,
    this.backgroundColor = AppTheme.boxBackgroundColor,
    required this.child
  });

  final double? width;
  final double? height;
  final Color? backgroundColor;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width, height: height,
      decoration: BoxDecoration(
        border: Border.all(color: AppTheme.borderColor),
        borderRadius: BorderRadius.circular(4),
        color: backgroundColor,
      ),
      child: child,
    );
  }
}