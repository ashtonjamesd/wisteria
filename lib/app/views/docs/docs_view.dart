import 'package:flutter/material.dart';
import 'package:wisteria/app/constants.dart';
import 'package:wisteria/app/utils/globals.dart';
import 'package:wisteria/app/widgets/wisteria_button.dart';
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
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 40),
      
          Padding(
            padding: const EdgeInsets.only(left: 32),
            child: Row(
              children: [
                WisteriaText(
                  text: "documentation", 
                  color: primaryTextColor,
                  size: 24,
                ),

                const Spacer(),
                Padding(
                  padding: const EdgeInsets.only(top: 16, right: 16),
                  child: WisteriaButton(
                    width: 100,
                    color: primaryGrey,
                    text: "back", 
                    onTap: () {
                      pop(context);
                    }
                  ),
                )
              ],
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
      
          const SizedBox(height: 32),
          header("Instructions"),
          instruction("MOV <register>  <arg>", "The MOV instruction places a given value into a register."),

          instruction("NOP", "Does nothing."),
          instruction("HALT", "Terminates program execution immediately"),
          instruction("OUT  <register>", "Outputs the value of a register."),
      
          instruction("ADD  <register>  <arg>", "Adds a value to a register."),
          instruction("SUB  <register>  <arg>", "Subtracts a value from a register."),
          instruction("MUL  <register>  <arg>", "Multiplies a register by a value"),
          instruction("DIV  <register>", "Divides RA by the given argument. The result is stored in RA, and the remained in RB."),
      
          instruction("INC  <register>", "Adds one to the given register."),
          instruction("DEC  <register>", "Subtracts one to the given register."),

          instruction("JUMP  <label>", "Jumps to a specific label in the program."),
          instruction("CMP  <register>  <arg>", "Performs a subtraction on the register value and the given argument. \n\nIf the comparison results in a negative number, the sign flag (SF) is set to true. If the comparison results in 0, then the zero flag (ZF) is set.\n\nFor instance, lets assume the value in RA is 5. CMP RA 5 (CMP 5 5) will result in the ZF being set as 5 - 5 is 0."),

          instruction("JNE  <label>", "Jumps to a specific label if the zero flag is false."),
          instruction("JE  <label>", "Jumps to a specific label if the zero flag is true."),

          instruction("JG  <label>", "Jumps to a specific label if the zero flag is false and the sign flag is false."),
          instruction("JL  <label>", "Jumps to a specific label if the sign flag is true."),

          instruction("JLE  <label>", "Jumps to a specific label if the zero flag is true or the sign flag is true."),
          instruction("JGE  <label>", "Jumps to a specific label if the zero flag is true or the sign flag is false."),
          instruction("NEG  <register>", "Negates the value of a register"),

          instruction("AND  <register>  <arg>", "Performs logical and on the register with the given argument and stores the result in the given register."),
          instruction("OR  <register>  <arg>", "Performs logical or on the register with the given argument and stores the result in the given register."),
          instruction("XOR  <register>  <arg>", "Performs logical xor on the register with the given argument and stores the result in the given register."),
          instruction("NOT  <register>", "Performs logical not on the register and stores the result in the given register."),
        ],
      ),
    );
  }

  Widget header(String text) {
    return Padding(
      padding: const EdgeInsets.only(left: 32),
      child: WisteriaText(
        text: text,
        size: 22,
        isBold: true,
      ),
    );
  }

  Widget instruction(String instr, String desc) {
    return Padding(
      padding: const EdgeInsets.only(left: 32, right: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          WisteriaText(
            text: instr,
            size: 18,
            isBold: true,
          ),
          const SizedBox(height: 12),
      
          WisteriaText(
            text: desc
          ),
      
          const SizedBox(height: 32),
        ],
      ),
    );
  }
}