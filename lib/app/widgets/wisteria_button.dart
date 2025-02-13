import 'package:flutter/material.dart';
import 'package:wisteria/app/widgets/wisteria_text.dart';
import 'package:wisteria/app/constants.dart';

class WisteriaButton extends StatefulWidget {
  const WisteriaButton({
    super.key,
    required this.width,
    this.height = 32,
    this.icon,
    required this.color,
    this.text,
    this.showBorder = false,
    required this.onTap,
  });

  final double width;
  final double height;
  final Color color;
  final String? text;
  final IconData? icon;
  final VoidCallback onTap;
  final bool showBorder;

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
            border: widget.showBorder ? Border.all(color: const Color.fromARGB(255, 76, 76, 76)) : null,
          ),
          child: Center(
            child: widget.icon == null ? WisteriaText(
              text: widget.text!,
              color: Colors.white,
              size: 14,
            ) : Icon(
              widget.icon!,
              size: 14,
              color: primaryWhite,
            )
          ),
        ),
      ),
    );
  }
}