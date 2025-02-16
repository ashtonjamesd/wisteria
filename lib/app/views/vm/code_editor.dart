import 'package:flutter/material.dart';
import 'package:wisteria/app/constants.dart';
import 'package:wisteria/app/views/vm/code_editor_box.dart';

class CodeEditor extends StatefulWidget {
  const CodeEditor({
    super.key, 
    required this.controller
  });

  final TextEditingController controller;

  @override
  State<CodeEditor> createState() => _CodeEditorState();
}

class _CodeEditorState extends State<CodeEditor> {

  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.sizeOf(context);

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Container(
          height: screen.height * 0.7,
          width: screen.width * 0.8,
          decoration: BoxDecoration(
            color: primaryWhite,
            borderRadius: BorderRadius.circular(boxBorderRadius),
          ),
          child: CodeEditorBox(
            controller: widget.controller, 
          )
        ),
      ),
    );
  }
}