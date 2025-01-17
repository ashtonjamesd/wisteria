import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wisteria/components/authentication/models/wisteria_user.dart';
import 'package:wisteria/components/authentication/factories/wisteria_user_factory.dart';

final class DbService {
  final CollectionReference _users = FirebaseFirestore.instance.collection("users");
  final _userFactory = WisteriaUserFactory();

  Future<bool> createUser(String id, String username, String email, String password) async {
    try {
      await _users.doc().set({
        "id": id,
        "email": email,
        "password": password,
        "username": username
      });

      return true;
    } catch (exception) {
      print(exception);
      return false;
    }
  }

  Future<WisteriaUser?> getUserFromUsername(String username) async {
    try {
      var query = await _users
        .where("username", isEqualTo: username)
        .get();

      if (query.docs.isNotEmpty) {
        return _userFactory.create(query.docs.first.data() as Map<String, dynamic>);
      }

      return null;
    } catch (exception) {
      print(exception);
      return null;
    }
  }

  Future<WisteriaUser?> getUserFromEmail(String email) async {
    try {
      var query = await _users
        .where("email", isEqualTo: email)
        .get();

      if (query.docs.isNotEmpty) {
        return _userFactory.create(query.docs.first.data() as Map<String, dynamic>);
      }

      return null;
    } catch (exception) {
      print(exception);
      return null;
    }
  }
}