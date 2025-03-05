import 'package:wisteria/app/utils/db/db_service.dart';
import 'package:wisteria/app/utils/result.dart';
import 'package:wisteria/app/views/exercises/models/exercise_model.dart';
import 'package:wisteria/app/views/exercises/models/submission_model.dart';
import 'package:wisteria/vm/vm.dart';

import '../../../../vm/constants.dart';

final class ExerciseViewController {
  final _db = DbService();

  Future<List<ExerciseModel>> getExercises() async {
    final exercises = await _db.getExercises();
    exercises.sort((a, b) => a.level.compareTo(b.level));

    return exercises;
  }

  Future<List<SubmissionModel>> getSubmissions(String uid) async {
    final submissions = await _db.getSubmissions(uid);

    return submissions;
  }

  Result validateSubmission(final ExerciseModel model, final VirtualMachine vm) {
    // removes the preInstructions string
    // if this were kept in, it would pick up banned instructions and return a failure.
    var cleanedVmProgramString = vm.programString.substring(model.preInstructions.length + 1);

    for (var bannedInstr in model.bannedInstructions) {
      if (cleanedVmProgramString.toLowerCase().contains(bannedInstr.toLowerCase())) {
        return Result.failure("The instruction '$bannedInstr' is not allowed for this exercise.");
      }
    }

    for (var instr in model.instructionConditions) {
      if (!cleanedVmProgramString.toLowerCase().contains(instr.toLowerCase())) {
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