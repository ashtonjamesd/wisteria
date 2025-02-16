import 'package:wisteria/app/utils/db/db_service.dart';
import 'package:wisteria/app/views/exercises/models/exercise_model.dart';

final class ExerciseViewController {
  final _db = DbService();

  Future<List<ExerciseModel>> getExercises() async {
    final exercises = await _db.getExercises();

    return exercises;
  }
}