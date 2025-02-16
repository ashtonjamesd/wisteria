import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wisteria/app/utils/auth/models/wisteria_user.dart';
import 'package:wisteria/app/views/exercises/models/exercise_model.dart';

final class DbService {
  final _users = FirebaseFirestore.instance.collection("users");
  final _exercises = FirebaseFirestore.instance.collection("exercises");

  Future<List<ExerciseModel>> getExercises() async {
    try {
      final querySnapshot = await _exercises.get();
      final exerciseModels = querySnapshot.docs
        .map((x) => ExerciseModel.fromMap(x.data()))
        .toList();

      return exerciseModels;

    } catch (e) {
      print("Error fetching user: $e");
      return [];
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
    final user = WisteriaUser(
      uid: uid, 
      username: username, 
      email: email,
      exercisesComplete: exercisesComplete,
      createdAt: DateTime.now()
    );

    await _users.doc(uid).set(user.toMap());
  }
}