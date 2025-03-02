import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wisteria/app/utils/auth/models/wisteria_user.dart';
import 'package:wisteria/vm/vm.dart';

import '../views/settings/utils/settings_controller.dart';

class AppController {
  AppController._();

  static final AppController _instance = AppController._();
  static AppController get instance => _instance;

  final settings = SettingsController();
  final codeController = TextEditingController();

  WisteriaUser? user;

  int pageIndex = 0;

  Future<void> resetPreferences() async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.clear();
  }

  Future<void> setPreference(String key, String value) async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.setString(key, value);
  }

  Future<String?> getPreference(String key) async {
    final preferences = await SharedPreferences.getInstance();
    
    final preference = preferences.get(key);
    return preference?.toString();
  }
}