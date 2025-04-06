import 'package:flutter/widgets.dart';
import 'package:wisteria/app/auth/models/wisteria_user.dart';
import '../../../auth/auth_service.dart';
import '../../../utils/result.dart';

final class ProfileViewController {
  final authService = AuthService();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final usernameController = TextEditingController();

  void cleanup() {
    emailController.clear();
    passwordController.clear();
    usernameController.clear();
  }

  Future<Result<bool>> registerUser() async {
    final result = await authService.register(
      usernameController.text, 
      emailController.text, 
      passwordController.text
    );

    return result;
  }

  Future<Result<WisteriaUser?>> loginUser() async {
    final result = await authService.login(
      emailController.text, 
      passwordController.text
    );
    
    return result;
  }

  bool isValidEmail(String email) {
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