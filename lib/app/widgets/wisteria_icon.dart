import 'package:flutter/material.dart';
import 'package:wisteria/app/constants.dart';

class WisteriaIcon extends StatelessWidget {
  const WisteriaIcon({
    super.key, 
    required this.icon,
    this.size = 18,
    this.color = primaryGrey
  });

  final IconData icon;
  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Icon(
      icon,
      size: size,
      color: color,
    );
  }
}