import 'package:wisteria/app/utils/db/db_service.dart';
import 'package:wisteria/app/utils/result.dart';
import 'package:wisteria/app/views/exercises/models/exercise_model.dart';
import 'package:wisteria/vm/vm.dart';

import '../../../../vm/constants.dart';

final class ExerciseViewController {
  final _db = DbService();

  Future<List<ExerciseModel>> getExercises() async {
    final exercises = await _db.getExercises();
    exercises.sort((a, b) => a.level.compareTo(b.level));

    return exercises;
  }

  Result validateSubmission(ExerciseModel model, final VirtualMachine vm) {
    for (var instr in model.instructionConditions) {
      if (!vm.programString.toLowerCase().contains(instr.toLowerCase())) {
        return Result.failure("Submission must use the '$instr' instruction");
      }
    }

    if (vm.stdout.length < model.expectedOutputs.length) {
      return Result.failure("Incorrect values in the standard output.");
    }

    for (int i = 0; i < model.expectedOutputs.length; i++) {
      if (vm.stdout[i] != model.expectedOutputs[i]) {
        return Result.failure("Incorrect values in the standard output.");
      }
    }

    for (var register in model.registerConditions.entries) {
      final registerValue = switch (register.key) {
        R1_NAME => vm.ra,
        R2_NAME => vm.rb,
        R3_NAME => vm.rc,
        R4_NAME => vm.rd,
        _ => -1
      };

      if (registerValue == -1) {
        print("register value was -1. This may be an error");
      }

      if (registerValue != register.value) {
        return Result.failure("The register '${register.key}' does not contain the correct value.");
      }
    }

    return Result.success(true);
  }
}