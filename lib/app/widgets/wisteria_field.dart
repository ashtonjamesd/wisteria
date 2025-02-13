import 'package:flutter/material.dart';
import 'package:wisteria/app/constants.dart';

class WisteriaField extends StatefulWidget {
  const WisteriaField({
    super.key, 
    required this.controller,
    this.hintText,
    this.obscure = false,
    this.autoFocus = false
  });

  final TextEditingController controller;
  final bool obscure;
  final bool autoFocus;
  final String? hintText;

  @override
  State<WisteriaField> createState() => _WisteriaFieldState();
}

class _WisteriaFieldState extends State<WisteriaField> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: widget.obscure,
      autofocus: widget.autoFocus,
      style: const TextStyle(
        color: Color.fromARGB(255, 92, 92, 92),
        fontSize: 14,
        fontFamily: "Inter",
        fontWeight: FontWeight.w500
      ),
      controller: widget.controller,
      textAlignVertical: TextAlignVertical.top,
      maxLines: 1,
      cursorColor: const Color.fromARGB(255, 195, 195, 195),
      decoration: InputDecoration(
        filled: true,
        hintText: widget.hintText,
        hintStyle: TextStyle(
          color: primaryGrey,
          fontSize: 14
        ),
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
          vertical: 12.0, 
          horizontal: 16.0,
        ),
      ),
    );
  }
}