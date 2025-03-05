import 'package:flutter/material.dart';
import 'package:wisteria/app/constants.dart';
import 'package:wisteria/app/app_controller.dart';
import 'package:wisteria/app/utils/globals.dart';
import 'package:wisteria/app/views/docs/docs_view.dart';
import 'package:wisteria/app/views/exercises/models/exercise_model.dart';
import 'package:wisteria/app/views/exercises/models/submission_model.dart';
import 'package:wisteria/app/views/exercises/utils/exercise_view_controller.dart';
import 'package:wisteria/app/views/exercises/views/exercise_view.dart';
import 'package:wisteria/app/widgets/wisteria_box.dart';
import 'package:wisteria/app/widgets/wisteria_button.dart';
import 'package:wisteria/app/widgets/wisteria_icon.dart';
import 'package:wisteria/app/widgets/wisteria_loading_icon.dart';
import '../../../widgets/wisteria_text.dart';

class ExercisesView extends StatefulWidget {
  const ExercisesView({super.key});

  @override
  State<ExercisesView> createState() => _ExercisesViewState();
}

class _ExercisesViewState extends State<ExercisesView> {
  final controller = ExerciseViewController();

  List<ExerciseModel> exercises = [];
  List<SubmissionModel> submissions = [];

  bool isLoading = false;

  @override
  void initState() {
    initExerciseView();
    super.initState();
  }

  Future<void> initExerciseView() async {
    setState(() {
      isLoading = true;
    });

    exercises = await controller.getExercises();

    final user = AppController.instance.user;
    if (user != null) {
      submissions = await controller.getSubmissions(user.uid);
    }
    
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryWhite,
      body: isLoading ? loadingIcon() : exercisesView(),
    );
  }

  Widget loadingIcon() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          WisteriaLoadingIcon(
            text: "Loading Exercises...",
          ),
        ],
      ),
    );
  }

  Widget exercisesView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 40),

        Padding(
          padding: const EdgeInsets.only(left: 32),
          child: WisteriaText(
            text: "exercises", 
            color: primaryTextColor,
            size: 24,
          ),
        ),

        const SizedBox(height: 24),

        Padding(
          padding: const EdgeInsets.only(left: 32),
          child: WisteriaText(
            text: "Here you can complete programming challenges using assembly code.", 
            color: primaryTextColor,
            size: 14,
          ),
        ),

        Center(
          child: exercisesBox()
        ),

        const Spacer(),

        docsButton()
      ],
    );
  }

  Widget exercisesBox() {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: SizedBox(
        height: 500,
        child: ListView.builder(
          itemCount: exercises.length,
          itemBuilder: (context, index) {
            return exerciseItem(exercises[index]);
          }
        ),
      ),
    );
  }

  bool isComplete(ExerciseModel model) {
    if (submissions.map((x) => x.exerciseId).contains(model.id)) {
      return true;
    }

    return false;
  }

  Widget exerciseItem(ExerciseModel model) {
    return GestureDetector(
      onTap: () {
        push(context, ExerciseView(
          model: model,
          setState: () async {
            await initExerciseView();
          },
        ));
      },
      child: WisteriaBox(
        width: MediaQuery.sizeOf(context).width - 20,
        height: 50,
        borderColor: primaryGrey,
        showBorder: true,
        child: Row(
          children: [
            const SizedBox(width: 24),
            WisteriaText(
              text: model.title,
              color: primaryTextColor,
            ),
            const SizedBox(width: 24),

            const Spacer(),

            if (isComplete(model)) 
              Padding(
                padding: const EdgeInsets.only(right: 12),
                child: WisteriaIcon(icon: Icons.check),
              ),
      
            WisteriaText(
              text: "Exercise ${model.level.toString()}",
              color: primaryTextColor,
              isBold: true,
            ),
      
            const SizedBox(width: 24),
            WisteriaIcon(
              icon: Icons.arrow_forward,
              size: 22,
            ),
            const SizedBox(width: 12),
          ],
        )
      ),
    );
  }

  Widget docsButton() {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, bottom: 8),
      child: WisteriaButton(
        width: 170, 
        height: 40,
        color: primaryGrey, 
        text: "view documentation",
        onTap: () {
          push(context, DocsView());
        }
      ),
    );
  }
}