import 'package:firebase_auth/firebase_auth.dart';
import '../result.dart';

final class AuthService {
  final _auth = FirebaseAuth.instance;

  Result<bool> login(String email, String password) {
    final credential = _auth.signInWithEmailAndPassword(
      email: email, password: password
    );


    return Result.success(true);
  }

  Result<bool> register(String username, String email, String password) {
    final credential = _auth.createUserWithEmailAndPassword(
      email: email, password: password
    );

    

    return Result.success(true);
  }
}