import 'package:cloud_firestore/cloud_firestore.dart';

final class WisteriaUser {
  final String uid;
  final String username;
  final String email;
  final int exercisesComplete;
  final DateTime? createdAt;

  WisteriaUser({
    required this.uid,
    required this.username,
    required this.email,
    required this.exercisesComplete,
    required this.createdAt
  });

  factory WisteriaUser.fromMap(Map<String, dynamic> map) {
    return WisteriaUser(
      uid: map['uid'] ?? '',
      username: map['username'] ?? '',
      email: map['email'] ?? '',
      exercisesComplete: map['exercisesComplete'] ?? -1,
      createdAt: (map['createdAt'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'username': username,
      'email': email,
      'exercisesComplete': exercisesComplete,
      'createdAt': createdAt
    };
  }
}