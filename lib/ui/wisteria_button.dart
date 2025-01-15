import 'package:flutter/material.dart';
import 'package:wisteria/ui/wisteria_box.dart';

class WisteriaButton extends StatefulWidget {
  const WisteriaButton({
    super.key,
    required this.text,
    required this.onTap
  });

  final String text;
  final VoidCallback onTap;

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
        child: WisteriaBox(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
            child: Text(
              widget.text,
              style: const TextStyle(
                fontSize: 14
              ),
            ),
          )
        ),
      ),
    );
  }
}