// import 'package:firebase_auth/firebase_auth.dart';
import '../../utils/result.dart';

final class AuthService {
  Future<Result<bool?>> registerUser(String email, String password) async {
    try {
      // var user = await FirebaseAuth.instance
      //   .createUserWithEmailAndPassword(email: email, password: password);

      return Result.ok(true);
    } catch (exception) {
      return Result.err("an unexpected error has occurred while registering a new user.");
    }
  }

  Future<Result<bool>> loginUser(String email, String password) async {
    try {



      return Result.ok(true);
    } catch (exception) {
      return Result.err("an unexpected error has occurred while logging in a user.");
    }
  }
}