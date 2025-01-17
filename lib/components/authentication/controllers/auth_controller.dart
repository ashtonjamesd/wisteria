import 'package:wisteria/components/authentication/models/wisteria_user.dart';
import 'package:wisteria/utils/result.dart';

import '../services/auth_service.dart';

final class AuthController {
  final _auth = AuthService();

  Future<Result<bool?>> registerUser(String username, String email, String password) async {
    var userExists = await _auth.checkUserExists(email, password);
    if (userExists) {
      return Result.err("A user with those credentials already exists.");
    }

    var result = await _auth.registerUser(username, email, password);
    return result;
  }

  Future<Result<WisteriaUser?>> loginUser(String email, String password) async {
    var result = await _auth.loginUser(email, password);

    return result;
  }
}