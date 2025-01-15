import 'package:wisteria/utils/result.dart';

import '../services/auth_service.dart';

final class AuthController {
  final _auth = AuthService();

  Future<Result<bool?>> registerUser(String email, String password) async {
    var result = await _auth.registerUser(email, password);

    return result;
  }
}