import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:wisteria/app/db/db_service.dart';
import 'package:wisteria/app/views/exercises/models/exercise_model.dart';
import 'package:wisteria/app/widgets/wisteria_box.dart';

import '../../../constants.dart';
import '../../../app_controller.dart';
import '../../../widgets/wisteria_loading_icon.dart' show WisteriaLoadingIcon;
import '../../../widgets/wisteria_text.dart';

class LoggedInView extends StatefulWidget {
  const LoggedInView({
    super.key, 
    required this.update
  });

  final VoidCallback update;

  @override
  State<LoggedInView> createState() => _LoggedInViewState();
}

class _LoggedInViewState extends State<LoggedInView> {
  final db = DbService();

  int exercisesComplete = 0;
  List<ExerciseModel> exercises = []; 

  final user = AppController.instance.user!;

  bool isLoading = true;

  @override
  void initState() {
    initProfile();
    super.initState();
  }

  Future<void> initProfile() async {
    var submissions = await db.getSubmissions(user.uid);

    var table = HashSet();
    table.addAll(submissions);
    exercisesComplete = table.length;

    final result = await db.getExercises();
    if (result.isSuccess) {
      exercises = result.value!;
    } else {
      // handle
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoading ? loadingIcon() : loggedInScreen();
  }

  Widget loadingIcon() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 80),
            child: WisteriaLoadingIcon(
              text: "Loading Profile...",
            ),
          ),
        ],
      ),
    );
  }

  Widget loggedInScreen() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 24),
        welcomeText(),

        const SizedBox(height: 24),
        statBox("exercises complete", "${exercisesComplete.toString()} / ${exercises.length}"),
      ],
    );
  }

  Widget statBox(String stat, String value) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          WisteriaText(
            text: stat,
            size: 14,
            isBold: true,
            color: primaryTextColor,
          ),
          WisteriaBox(
            width: 170,
            height: 50,
            borderColor: primaryTextColor,
            showBorder: true,
            color: primaryWhite,
            child: Center(
              child: WisteriaText(
                text: value,
                size: 24,
                isBold: true,
                color: primaryTextColor,
              ),
            )
          ),
        ],
      ),
    );
  }

  Widget userField(String field, String value) {
    return Padding(
      padding: const EdgeInsets.only(left: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          WisteriaText(
            text: field,
            color: primaryTextColor,
            size: 16,
            isBold: true,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16),
            child: WisteriaText(
              text: value,
              color: secondaryTextColor,
              size: 16,
            ),
          ),
        ],
      ),
    );
  }

  Widget welcomeText() {
    return Padding(
      padding: const EdgeInsets.only(left: 16),
      child: Row(
        children: [
          WisteriaText(
            text: "welcome, ",
            color: primaryTextColor,
            size: 28,
          ),
          WisteriaText(
            text: "${AppController.instance.user!.username}!",
            color: secondaryTextColor,
            size: 32,
            isBold: true,
          ),
        ],
      ),
    );
  }
}