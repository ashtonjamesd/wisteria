import '../views/settings/utils/settings_controller.dart';

class AppController {
  AppController._();

  static final AppController _instance = AppController._();
  static AppController get instance => _instance;

  final settings = SettingsController();

  
}
