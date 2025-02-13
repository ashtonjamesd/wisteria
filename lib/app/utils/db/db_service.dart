import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wisteria/app/utils/auth/models/wisteria_user.dart';

final class DbService {
  final CollectionReference users = FirebaseFirestore.instance.collection("users");

  Future<WisteriaUser?> getUser(String email) async {
    try {
      final querySnapshot = await users
        .where("email", isEqualTo: email)
        .limit(1).get();
      
      if (querySnapshot.docs.isNotEmpty) {
        final data = querySnapshot.docs.first.data() as Map<String, dynamic>;
        return WisteriaUser.fromMap(data);
      }
    } catch (e) {
      print("Error fetching user: $e");
    }
    
    return null;
  }

  Future<void> createUser(String uid, String username, String email) async {
    final user = WisteriaUser(uid: uid, username: username, email: email);
    await users.doc(uid).set(user.toMap());
  }
}