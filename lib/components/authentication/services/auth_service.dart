// import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:wisteria/components/authentication/models/wisteria_user.dart';
import 'package:wisteria/components/db/db.dart';

import '../../../utils/result.dart';

final class AuthService {
  final _db = DbService();

  Future<Result<bool?>> registerUser(String username, String email, String password) async {
    try {
      final credentials = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);

      if (credentials.user == null) {
        return Result.err("Unable to create user. Please try again later.");
      }

      final isSuccess = await _db.createUser(credentials.user!.uid, username, email, password);
      if (!isSuccess) {
        return Result.err("Unable to create user. Please try again later.");
      }

      return Result.ok(true);
    } catch (exception) {
      return Result.err("An unexpected error has occurred while registering a new user.");
    }
  }

  Future<Result<WisteriaUser?>> loginUser(String emailOrUsername, String password) async {
    try {
      var user = await _db.getUserFromUsername(emailOrUsername);
      user ??= await _db.getUserFromEmail(emailOrUsername);

      if (user == null) {
        return Result.err("Invalid login credentials");
      }

      if (user.password != password) {
        return Result.err("Invalid login credentials");
      }

      return Result.ok(user);
    } catch (exception) {
      return Result.err("An unexpected error has occurred while logging in a user.");
    }
  }

  Future<bool> checkUserExists(String usernameOrEmail) async {
    try {
      var user = await _db.getUserFromEmail(usernameOrEmail);
      user ??= await _db.getUserFromUsername(usernameOrEmail);

      return user != null;

    } catch (exception) {
      return false;
    }
  }
}