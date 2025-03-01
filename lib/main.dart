import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wisteria/app/constants.dart';
import 'package:wisteria/app/utils/preferences.dart';
import 'package:wisteria/app/utils/app_controller.dart';
import 'package:wisteria/app/utils/auth/auth_service.dart';
import 'package:wisteria/app/views/welcome/welcome_view.dart';
import 'package:wisteria/app/app_view.dart';
import 'firebase_options.dart';

void main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();

    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp
    ]);

    runApp(const App());
  } catch (exception) {
    print(exception);
  }
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  final authService = AuthService();

  bool isLoading = true;

  @override
  void initState() {
    tryLogin();
    initPreferences();
    super.initState();
  }

  Future<void> initPreferences() async {
    var showDialog = await AppController.instance.getPreference(showHelpDialoguesPref);
    AppController.instance.settings.showInfoDialogs = showDialog?.toString() == "true";

    var simulateVmDelays = await AppController.instance.getPreference(simulateVmDelaysPref);
    AppController.instance.settings.simulateVmDelays = simulateVmDelays?.toString() == "true";
  }

  Future<void> tryLogin() async {
    setState(() {});

    final email = await AppController.instance.getPreference("email");
    final password = await AppController.instance.getPreference("password");

    if (email == null || password == null) {
      setState(() {
        isLoading = false;
      });
      return;
    }

    await authService.login(
      email, password
    );

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: isLoading ? loadingPage() : app()
    );
  }

  Widget loadingPage() {
    return Scaffold(
      backgroundColor: primaryWhite,
    );
  }

  Widget app() {
    return AppController.instance.user == null ? WelcomeView() : AppView();
  }
}
