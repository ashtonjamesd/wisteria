import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';

const String helpMessage =  
"""  
Wisteria is an interactive app designed to teach assembly language and low-level programming through a virtual machine that simulates real CPU execution.

Practice and experiment with guided exercises while gaining experience in writing and debugging assembly.

Head to the exercises tab to start learning assembly programming or experiment with the vm sandbox.
""";  


const String registerDescription = 
"""
General-purpose registers are fast, small storage locations in the CPU that hold intermediate data during execution, supporting operations like arithmetic, logic, and memory addressing to speed up processing.
""";

const String machineCodeDesc = 
"""
Machine code is the low-level binary representation of a program that the CPU directly executes. It consists of sequences of 0s and 1s that correspond to specific instructions, making it the most fundamental language a computer understands.
""";

const String asmDesc = 
"""
Assembly language is a human-readable, low-level programming language that corresponds closely to machine code. It uses mnemonics and symbols to represent instructions, making it easier to write and understand compared to raw binary code.
""";

const String flagDescription = 
"""
Flags are special registers that store status information about the CPU's operations. They help control conditional execution by indicating results such as zero, carry, sign, and overflow, enabling decision-making in programs.
""";


const String memoryDescription = 
"""
Memory stores data and instructions for the CPU, providing temporary storage for active processes and enabling quick access to information during execution.
""";

const String programCounterDescription = 
"""
The program counter (PC) tracks the address of the next instruction to execute, ensuring the CPU processes instructions in the correct sequence.
""";

const String supportMessage = 
"""
If you need help, check our official documentation on the GitHub repository. If you think you have encountered a bug, please report it.

This is an early release, so you may encounter bugs. We appreciate your patience and encourage you to report any issues via the email on our GitHub page. Thank you!
""";

const String termsAndConditionsMessage = 
"""

""";

const String privacyPolicyMessage = 
"""

""";

// 10th fibonacci counter
const String exampleProgramOne = 
"""
mov ra 0
mov rb 1
mov rc 10

fib:
  out ra
  
  mov rd ra
  add rd rb
  
  mov ra rb
  mov rb rd

  dec rc
  cmp rc 0

  jne fib

  halt
""";

const String githubUrl = "https://github.com/rxgq/wisteria";
const String privacyPolicyUrl= "$githubUrl/blob/main/privacy_policy.md";
const String termsAndConditionsUrl = "$githubUrl/blob/main/terms_and_conditions.md";

const double consoleHeight = 120;
const double userInterfaceHeight = 130;
const double cpuInterfaceHeight = 240;

const double asmBoxWidth = 70;
const double infoWidgetHeight = 174;

const double widthFactor = 1.1;

const double boxPadding = 2;
const double boxBorderRadius = 2;

const Color primaryGrey = Color.fromARGB(255, 219, 219, 219);
const Color primaryWhite = Colors.white;
const Color primaryTextColor = Color.fromARGB(255, 95, 95, 95);
const Color secondaryTextColor = Color.fromARGB(255, 131, 131, 131);

const Color selectedIconColor = Color.fromARGB(255, 53, 53, 53);

// TextStyle appFont = GoogleFonts.roboto();