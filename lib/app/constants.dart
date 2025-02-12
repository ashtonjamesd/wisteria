import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';

const String helpMessage = 
"""
Wisteria is an app designed to help you learn assembly code and the inner workings of a CPU.

The app will allow you to experiment with a virtual machine that reads assembly and executes machine code just like a real processor.

A good place to start would be the exercises tab.
""";

const String registerDescription = 
"""
General-purpose registers are fast, small storage locations in the CPU that hold intermediate data during execution, supporting operations like arithmetic, logic, and memory addressing to speed up processing.
""";

const String memoryDescription = 
"""
Memory stores data and instructions for the CPU, providing temporary storage for active processes and enabling quick access to information during execution.
""";

const String programCounterDescription = 
"""
The program counter (PC) tracks the address of the next instruction to execute, ensuring the CPU processes instructions in the correct sequence.
""";

const String githubUrl = "https://github.com/rxgq/wisteria";

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
const Color textColor = Color.fromARGB(255, 95, 95, 95);

// TextStyle appFont = GoogleFonts.roboto();