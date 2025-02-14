import 'package:firebase_auth/firebase_auth.dart';
import 'package:wisteria/app/utils/auth/models/wisteria_user.dart';
import 'package:wisteria/app/utils/db/db_service.dart';
import '../result.dart';

final class AuthService {
  final _db = DbService();
  final _auth = FirebaseAuth.instance;

  Future<Result<WisteriaUser?>> login(String email, String password) async {
    final credential = await _auth.signInWithEmailAndPassword(
      email: email, password: password
    );

    if (credential.user == null) {
      return Result.success(null);
    }

    final user = await _db.getUser(email);

    // the user is authenticated but does not have a firestore record..
    if (user == null) {
      return Result.failure(false);
    }

    return Result.success(user);
  }

  Future<Result<bool>> register(String username, String email, String password) async {
    final credential = await _auth.createUserWithEmailAndPassword(
      email: email, password: password
    );


    if (credential.user == null) {
      return Result.success(false);
    }

    await _db.createUser(credential.user!.uid, username, email, 0);
    return Result.success(true);
  }
}