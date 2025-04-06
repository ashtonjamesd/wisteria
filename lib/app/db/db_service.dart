import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wisteria/app/auth/models/wisteria_user.dart';
import 'package:wisteria/app/views/exercises/models/exercise_model.dart';
import 'package:wisteria/app/views/exercises/models/submission_model.dart';

import '../utils/result.dart';

final class DbService {
  final _users = FirebaseFirestore.instance.collection("users");
  final _exercises = FirebaseFirestore.instance.collection("exercises");

  Future<Result<List<ExerciseModel>>> getExercises() async {
    try {
      final querySnapshot = await _exercises.get();
      final exerciseModels = querySnapshot.docs
        .map((x) => ExerciseModel.fromMap(x.data(), x.id)) 
        .toList();

      return Result.success(exerciseModels);

    } catch (e) {
      print("Error fetching user: $e");
      return Result.failure("");
    }
  }

  Future<WisteriaUser?> getUser(String email) async {
    try {
      final querySnapshot = await _users
        .where("email", isEqualTo: email)
        .limit(1).get();
      
      if (querySnapshot.docs.isNotEmpty) {
        final data = querySnapshot.docs.first.data();
        return WisteriaUser.fromMap(data);
      }
    } catch (e) {
      print("Error fetching user: $e");
    }
    
    return null;
  }

  Future<void> createUser(String uid, String username, String email, int exercisesComplete) async {
    try {
      final user = WisteriaUser(
        uid: uid, 
        username: username, 
        email: email,
        exercisesComplete: exercisesComplete,
        createdAt: DateTime.now()
      );

      await _users.doc(uid).set(user.toMap());
    } catch (e) {
      print("Error fetching user: $e");
    }
  }

  Future<void> createSubmission(String uid, String exerciseId, String code, DateTime createdAt) async {
    try {
      final submissionRef = _users.doc(uid)
        .collection("submissions").doc();

      final exercise = SubmissionModel(
        exerciseId: exerciseId,
        code: code,
        createdAt: createdAt,
      );

      await submissionRef.set(exercise.toMap());
    } catch (e) {
      print("Error creating submission: $e");
    }
  }

  Future<List<SubmissionModel>> getSubmissions(String uid) async {
    try {
      final querySnapshot = await _users.doc(uid)
        .collection("submissions")
        .get();

      final submissionModels = querySnapshot.docs
        .map((x) => SubmissionModel.fromMap(x.data()))
        .toList();

      return submissionModels;
    } catch (e) {
      print("Error fetching submissions: $e");
      return [];
    }
  }
}