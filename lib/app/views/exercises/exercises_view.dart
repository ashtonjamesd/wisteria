import 'package:flutter/material.dart';
import 'package:wisteria/app/constants.dart';

import '../../widgets/wisteria_text.dart';

class ExercisesView extends StatefulWidget {
  const ExercisesView({super.key});

  @override
  State<ExercisesView> createState() => _ExercisesViewState();
}

class _ExercisesViewState extends State<ExercisesView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryWhite,
      body: exercisesView(),
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

        const SizedBox(height: 28),

        Center(
          child: exercisesBox()
        ),
      ],
    );
  }

  Widget exercisesBox() {
    return SizedBox();
  }
}