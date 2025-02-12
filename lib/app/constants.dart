import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';

const String helpMessage = 
"""
Wisteria is a virtual machine designed to help you learn the inner workings of a CPU.

The app will allow you to experiment with a virtual machine that executes machine code just like a real processor.

A good place to start may be the exercises tab.
""";

const double consoleHeight = 120;
const double userInterfaceHeight = 130;
const double cpuInterfaceHeight = 240;

const double asmBoxWidth = 70;

const double widthFactor = 1.1;

const double boxPadding = 2;
const double boxBorderRadius = 2;

const Color primaryGrey = Color.fromARGB(255, 219, 219, 219);
const Color primaryWhite = Colors.white;
const Color textColor = Color.fromARGB(255, 95, 95, 95);

// TextStyle appFont = GoogleFonts.roboto();