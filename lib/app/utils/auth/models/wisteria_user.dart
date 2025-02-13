final class WisteriaUser {
  final String uid;
  final String username;
  final String email;

  WisteriaUser({
    required this.uid,
    required this.username,
    required this.email
  });

  factory WisteriaUser.fromMap(Map<String, dynamic> map) {
    return WisteriaUser(
      uid: map['uid'] ?? '',
      username: map['username'] ?? '',
      email: map['email'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'username': username,
      'email': email,
    };
  }
}