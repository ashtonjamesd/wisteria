import 'package:flutter/material.dart';

class WisteriaIconButton extends StatefulWidget {
  const WisteriaIconButton({
    super.key, 
    required this.icon, 
    required this.onTap
  });

  final IconData icon;
  final VoidCallback onTap;

  @override
  State<WisteriaIconButton> createState() => _WisteriaIconButtonState();
}

class _WisteriaIconButtonState extends State<WisteriaIconButton> {
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: Icon(
          widget.icon,
          color: Colors.grey,
          size: 24,
        ),
      ),
    );
  }
}