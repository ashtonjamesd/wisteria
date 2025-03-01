import 'package:flutter/material.dart';
import 'package:wisteria/app/constants.dart';
import 'package:wisteria/app/widgets/wisteria_text.dart';

class DocsView extends StatefulWidget {
  const DocsView({super.key});

  @override
  State<DocsView> createState() => _DocsViewState();
}

class _DocsViewState extends State<DocsView> {
@override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryWhite,
      body: docsView(),
    );
  }

  Widget docsView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 40),

        Padding(
          padding: const EdgeInsets.only(left: 32),
          child: WisteriaText(
            text: "documentation", 
            color: primaryTextColor,
            size: 24,
          ),
        ),

        const SizedBox(height: 24),

        Padding(
          padding: const EdgeInsets.only(left: 32),
          child: WisteriaText(
            text: "Here you will find information on the assembly language syntax and the ISA.", 
            color: primaryTextColor,
            size: 14,
          ),
        ),

        header("Instructions"),
        instruction("MOV <register> <value>", "The MOV instruction places a given value into a register."),

        instruction("ADD <arg1> <arg2>", "The ADD instruction adds a value to a register."),
        instruction("SUB <arg1> <arg2>", "The SUB instruction subtracts a value from a register."),
        instruction("MUL <arg1> <arg2>", "The MUL instruction multiplies a register by a value"),
        instruction("DIV <arg1> <arg2>", "The DIV instruction multiplies a register by a value"),
      ],
    );
  }

  Widget header(String text) {
    return WisteriaText(
      text: text,
      size: 22,
      isBold: true,
    );
  }

  Widget instruction(String instr, String desc) {
    return Column(
      children: [
        WisteriaText(
          text: instr
        ),
        const SizedBox(height: 12),

        WisteriaText(
          text: desc
        ),

        const SizedBox(height: 28),
      ],
    );
  }
}