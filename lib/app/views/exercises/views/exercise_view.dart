
import 'package:flutter/material.dart';
import 'package:wisteria/app/utils/globals.dart';
import 'package:wisteria/app/views/vm/code_editor_box.dart';
import 'package:wisteria/app/views/vm/console_box.dart';
import 'package:wisteria/app/views/vm/stdout_box.dart';
import 'package:wisteria/app/widgets/wisteria_box.dart';
import 'package:wisteria/app/widgets/wisteria_button.dart';
import 'package:wisteria/app/widgets/wisteria_window.dart';
import 'package:wisteria/vm/vm.dart';

import '../../../constants.dart';
import '../../../widgets/wisteria_text.dart';
import '../models/exercise_model.dart';
import '../utils/exercise_view_controller.dart';

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
  final controller = ExerciseViewController();

  final codeController = TextEditingController();
  bool hintRevealed = false;

  bool isRunningCode = false;

  late var vm = VirtualMachine(
    () {
      setState(() {});
    }, 
    programString: codeController.text
  );

  void onCompletion() {
    showDialog(
      context: context, 
      builder: (context) {
        return completionDialogue();
      }
    );
  }

  Future<void> onRunCode() async {
    if (isRunningCode) return;

    setState(() {
      isRunningCode = true;
    });

    vm = VirtualMachine(
      () {
        setState(() {});
      }, 
      hasDelays: false,
      programString: "${widget.model.preInstructions} ${codeController.text}"
    );

    await vm.run();

    setState(() {
      isRunningCode = false;
    });
  }

  Future<void> onSubmit() async {
    await onRunCode();

    if (vm.stdout.isEmpty) {
      showDialog(context: context, builder: (context) {
        return failedDialogue();
      });

      return;
    }

    final result = controller.validateSubmission(widget.model, vm);
    if (result.isFailure) {
      vm.output(result.error.toString());

      showDialog(context: context, builder: (context) {
        return failedDialogue();
      });

      return;
    }

    onCompletion();
  }

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
      crossAxisAlignment: CrossAxisAlignment.center,
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

        codeEditor(),

        ConsoleBox(
          vm: vm, 
          showBorder: true,
          width: MediaQuery.sizeOf(context).width - 40,
        ),

        StdoutBox(screen: screen, vm: vm),
        const SizedBox(height: 16),

        revealHintBox(screen),

        const SizedBox(height: 8),
        SizedBox(
          width: MediaQuery.sizeOf(context).width - 40,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              backButton(),
              runCodeButton(),
              submitButton()
            ],
          ),
        ),

      ],
    );
  }

  Widget backButton() {
    return WisteriaButton(
      width: 100,
      height: 40,
      color: primaryWhite,
      text: "Back",
      textColor: primaryTextColor,
      showBorder: true,
      onTap: () async {
        pop(context);
      }
    );
  }

  Widget submitButton() {
    return Padding(
      padding: const EdgeInsets.only(left: 20),
      child: WisteriaButton(
        width: 100,
        height: 40,
        color: primaryWhite,
        text: "Submit",
        textColor: primaryTextColor,
        showBorder: true,
        onTap: () async {
          await onSubmit();
        }
      ),
    );
  }

  Widget runCodeButton() {
    return Padding(
      padding: const EdgeInsets.only(left: 20),
      child: WisteriaButton(
        width: 100,
        height: 40,
        color: primaryWhite,
        text: isRunningCode ? "Running..." : "Run",
        textColor: primaryTextColor,
        showBorder: true,
        onTap: () async {
          await onRunCode();
        }
      ),
    );
  }

  Widget failedDialogue() {
    return WisteriaWindow(
      header: "Exercise Failed",
      messageWidget: Center(
        child: SizedBox(
          width: 200,
          child: WisteriaText(
            align: TextAlign.center,
            text: "Not quite! Ensure you have followed the exercise instructions.",
            size: 13,
          ),
        ),
      ),
      width: 240, 
      height: 160
    );
  }

  Widget completionDialogue() {
    return WisteriaWindow(
      header: "Exercise Complete", 
      onTapOkay: () {
        pop(context);
      },
      messageWidget: Center(
        child: SizedBox(
          width: 200,
          child: WisteriaText(
            align: TextAlign.center,
            text: "Well Done! You passed this exercise.",
            size: 13,
          ),
        ),
      ),
      width: 240, 
      height: 160
    );
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
    return GestureDetector(
      onTap: () {
        setState(() {
          hintRevealed = !hintRevealed;
        });
      },
      child: hintRevealed ? revealedHintBox(screen) : unrevealedHintBox(screen)
    );
  }

  Widget unrevealedHintBox(Size screen) {
    return WisteriaBox(
      width: MediaQuery.sizeOf(context).width - 40,
      height: 100,
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
      width: MediaQuery.sizeOf(context).width - 40,
      height: 100,
      showBorder: true,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: WisteriaText(
            text: widget.model.hint,
            color: primaryTextColor,
          ),
        ),
      )
    );
  }
}