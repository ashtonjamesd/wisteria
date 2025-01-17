import 'package:flutter/material.dart';
import 'package:wisteria/utils/app_theme.dart';

class WisteriaBox extends StatelessWidget {
  const WisteriaBox({
    super.key, 
    this.width,
    this.height,
    this.backgroundColor = AppTheme.boxBackgroundColor,
    required this.child,
    this.hasBorder = true,
  });

  final double? width;
  final double? height;
  final Color? backgroundColor;
  final Widget child;
  final bool hasBorder;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width, height: height,
      decoration: BoxDecoration(
        border: hasBorder ? Border.all(color: AppTheme.borderColor) : null,
        borderRadius: BorderRadius.circular(4),
        color: backgroundColor,
      ),
      child: child,
    );
  }
}