import 'package:flutter/material.dart';
import 'package:wisteria/utils/app_theme.dart';

class WisteriaTextField extends StatefulWidget {
  const WisteriaTextField({
    super.key,
    required this.controller,
    required this.width,
    this.obscureText = false,
    this.hintText
  });

  final TextEditingController controller;
  final double width;
  final bool obscureText;
  final String? hintText;

  @override
  State<WisteriaTextField> createState() => _WisteriaTextFieldState();
}

class _WisteriaTextFieldState extends State<WisteriaTextField> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      obscureText: widget.obscureText,
      style: AppTheme.appFont().copyWith(
        fontSize: 13
      ),
      textAlign: TextAlign.left,
      textAlignVertical: TextAlignVertical.top,
      cursorColor: Colors.grey,
      decoration: InputDecoration(
        hintText: widget.hintText,
        hintStyle: const TextStyle(
          color: Colors.grey
        ),
        isDense: true,
        filled: true,
        fillColor: Colors.white,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(2),
          borderSide: const BorderSide(
            color: Color.fromARGB(255, 230, 230, 230),
            width: 2.0,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(2),
          borderSide: const BorderSide(
            color: Color.fromARGB(255, 200, 200, 200),
            width: 2.0,
          ),
        ),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 12,
          horizontal: 12,
        ),
      ),
    );
  }
}
