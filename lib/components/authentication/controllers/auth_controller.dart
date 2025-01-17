import 'package:wisteria/components/authentication/models/wisteria_user.dart';
import 'package:wisteria/utils/result.dart';

import '../services/auth_service.dart';

final class AuthController {
  final _auth = AuthService();

  String authMessage = "";

  Future<Result<bool?>> registerUser(String username, String email, String password) async {
    var emailIsTaken = await _auth.checkUserExists(email);
    var usernameIsTaken = await _auth.checkUserExists(username);

    if (emailIsTaken) {
      return Result.err("A user with that email already exists.");
    }

    if (usernameIsTaken) {
      return Result.err("A user with that username already exists.");
    }

    var result = await _auth.registerUser(username, email, password);
    return result;
  }

  Future<Result<WisteriaUser?>> loginUser(String email, String password) async {
    var result = await _auth.loginUser(email, password);

    return result;
  }
}