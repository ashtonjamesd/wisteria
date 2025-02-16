
import 'package:flutter/material.dart';
import 'package:wisteria/app/views/vm/code_editor_box.dart';
import 'package:wisteria/app/widgets/wisteria_box.dart';
import 'package:wisteria/app/widgets/wisteria_button.dart';

import '../../../constants.dart';
import '../../../widgets/wisteria_text.dart';
import '../models/exercise_model.dart';

class ExerciseView extends StatefulWidget {
  const ExerciseView({
    super.key, 
    required this.model
  });

  final ExerciseModel model;

  @override
  State<ExerciseView> createState() => _ExerciseViewState();
}

class _ExerciseViewState extends State<ExerciseView> {
  final codeController = TextEditingController();
  bool hintRevealed = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryWhite,
      body: exerciseView(),
    );
  }

  Widget exerciseView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 40),

        Padding(
          padding: const EdgeInsets.only(left: 32),
          child: WisteriaText(
            text: widget.model.title, 
            color: primaryTextColor,
            size: 24,
          ),
        ),

        Center(
          child: exerciseBox()
        ),
      ],
    );
  }

  Widget exerciseBox() {
    final screen = MediaQuery.sizeOf(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),

        Padding(
          padding: const EdgeInsets.only(left: 32, right: 32),
          child: WisteriaText(
            text: widget.model.description,
            size: 16,
            color: primaryTextColor,
          ),
        ),

        const SizedBox(height: 24),

        Center(
          child: codeEditor()
        ),

        revealHintBox(screen)
      ],
    );
  }

  Widget runCodeButton() {
    return SizedBox();
  }


  Widget codeEditor() {
    return WisteriaBox(
      width: MediaQuery.sizeOf(context).width - 40,
      height: 320,
      showBorder: true,
      borderColor: primaryGrey,
      child: CodeEditorBox(
        controller: codeController, 
        isCloseable: false,
      ),
    );
  }

  Widget revealHintBox(Size screen) {
    return Padding(
      padding: const EdgeInsets.only(left: 32, top: 24, right: 32),
      child: GestureDetector(
        onTap: () {
          setState(() {
            hintRevealed = !hintRevealed;
          });
        },
        child: hintRevealed ? revealedHintBox(screen) : unrevealedHintBox(screen)
      ),
    );
  }

  Widget unrevealedHintBox(Size screen) {
    return WisteriaBox(
      width: screen.width,
      height: 50,
      showBorder: true,
      child: Center(
        child: WisteriaText(
          text: "Reveal Hint",
        )
      )
    );
  }

  Widget revealedHintBox(Size screen) {
    return WisteriaBox(
      width: screen.width,
      height: 50, 
      showBorder: true,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: WisteriaText(
          text: widget.model.hint,
          color: primaryTextColor,
        ),
      )
    );
  }
}