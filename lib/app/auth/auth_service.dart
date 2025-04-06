import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wisteria/app/auth/models/wisteria_user.dart';
import 'package:wisteria/app/db/db_service.dart';
import '../app_controller.dart';
import '../utils/result.dart';

final class AuthService {
  final _db = DbService();
  final _auth = FirebaseAuth.instance;

  Future<Result<WisteriaUser?>> login(String email, String password) async {
    try {
      final credential = await _auth.signInWithEmailAndPassword(
        email: email, password: password
      );

      if (credential.user == null) {
        return Result.success(null);
      }

      final user = await _db.getUser(email);

      // the user is authenticated but does not have a firestore record..
      if (user == null) {
        return Result.failure("");
      }

      AppController.instance.user = user;
      await _saveLoginDetails(email, password);

      return Result.success(user);
    } on FirebaseException catch (error) {
      return switch (error.code) {
        "invalid-email"          => Result.failure("The email you entered is invalid."),
        "user-disabled"          => Result.failure("The account you are trying to log in to has been disabled."),
        "too-many-requests"      => Result.failure("An internal error occurred. Error code 1"),
        "user-token-expired"     => Result.failure("An internal error occurred. Error code 2"),
        "network-request-failed" => Result.failure("A network error occurred. Please check your internet connection"),
        "operation-not-allowed"  => Result.failure("An internal error occurred. Error code 0"),
        "invalid-credential"     => Result.failure("An internal error occurred. Error code 6"),
        _                        => Result.failure("An internal error occurred. Error code 4")
      };
    } catch (error) {
      return Result.failure("An internal error occurred. Error code 5");
    }
  }

  Future<Result<bool>> register(String username, String email, String password) async {
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
        email: email, password: password
      );

      if (credential.user == null) {
        return Result.success(false);
      }

      await _db.createUser(credential.user!.uid, username, email, 0);
      return Result.success(true);

    } on FirebaseAuthException catch (error) {
      return switch (error.code) {
        "email-already-in-use"   => Result.failure("An account with that email is already in use"),
        "invalid-email"          => Result.failure("The email you entered is invalid."),
        "operation-not-allowed"  => Result.failure("An internal error occurred. Error code 0"),
        "weak-password"          => Result.failure("The password you entered was too weak."),
        "too-many-requests"      => Result.failure("An internal error occurred. Error code 1"),
        "user-token-expired"     => Result.failure("An internal error occurred. Error code 2"),
        "network-request-failed" => Result.failure("A network error occurred. Please check your internet connection"),
        _                        => Result.failure("An internal error occurred. Error code 4")
      };
    } catch (error) {
      return Result.failure("An internal error occurred. Error code 5");
    }
  }

  Future<void> logout() async {
    final preferences = await SharedPreferences.getInstance();

    await preferences.remove("email");
    await preferences.remove("password");

    AppController.instance.user = null;
  }

  Future<void> _saveLoginDetails(String email, String password) async {
    await AppController.instance.setPreference("email", email);
    await AppController.instance.setPreference("password", password);
  }
}