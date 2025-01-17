import 'package:wisteria/components/authentication/models/wisteria_user.dart';

final class WisteriaUserFactory {
  WisteriaUser create(Map<String, dynamic> map) {
    return WisteriaUser(
      username: map["username"],
      email: map["email"]
    );
  }
}