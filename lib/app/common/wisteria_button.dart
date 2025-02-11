import 'package:flutter/material.dart';
import 'package:wisteria/app/common/wisteria_text.dart';
import 'package:wisteria/app/constants.dart';

class WisteriaButton extends StatefulWidget {
  const WisteriaButton({
    super.key,
    required this.width,
    this.height = 32,
    required this.color,
    required this.text,
    required this.onTap,
  });

  final double width;
  final double height;
  final Color color;
  final String text;
  final VoidCallback onTap;

  @override
  State<WisteriaButton> createState() => _WisteriaButtonState();
}

class _WisteriaButtonState extends State<WisteriaButton> {
  bool _isHovered = false;
  bool _isPressed = false;

  Color _getButtonColor() {
    if (_isPressed) {
      return widget.color.withOpacity(0.6);
    } else if (_isHovered) {
      return widget.color.withOpacity(0.8);
    }
    return widget.color;
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTapDown: (_) => setState(() => _isPressed = true),
        onTapUp: (_) {
          setState(() => _isPressed = false);
          widget.onTap();
        },
        onTapCancel: () => setState(() => _isPressed = false),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 100),
          width: widget.width,
          height: widget.height,
          decoration: BoxDecoration(
            color: _getButtonColor(),
            borderRadius: BorderRadius.circular(boxBorderRadius),
          ),
          child: Center(
            child: WisteriaText(
              text: widget.text,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}