import 'package:flutter/widgets.dart';

import '../../../utils/auth/auth_service.dart';
import '../../../utils/result.dart';

final class ProfileViewController {
  final authService = AuthService();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final usernameController = TextEditingController();

  Future<Result<bool>> registerUser() async {
    try {
      final result = await authService.register(
        usernameController.text, 
        emailController.text, 
        passwordController.text
      );

      return result;
    } catch (exception) {
      print(exception);
      return Result.failure(false);
    }
  }

  Future<Result<bool>> loginUser() async {
    try {
      final result = await authService.login(
        emailController.text, 
        passwordController.text
      );

      return result;
    } catch (exception) {
      print(exception);
      return Result.failure(false);
    }
  }

  bool isValidateEmail(String email) {
    // i hate regex so much ew
    final bool emailValid = 
      RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);

    return emailValid;
  }

  bool isValidPassword(String password) {
    return password.length >= 8;
  }

  bool isValidUsername(String username) {
    return username.length >= 3;
  }
}