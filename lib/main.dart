import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wisteria/app/constants.dart';
import 'package:wisteria/app/utils/app_controller.dart';
import 'package:wisteria/app/utils/auth/auth_service.dart';
import 'package:wisteria/app/views/welcome/welcome_view.dart';
import 'package:wisteria/app_view.dart';
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

  bool isLoading = false;

  @override
  void initState() {
    tryLogin();
    super.initState();
  }

  Future<void> tryLogin() async {
    setState(() {
      isLoading = true;
    });

    final preferences = await SharedPreferences.getInstance();
    
    final email = preferences.get("email");
    final password = preferences.get("password");

    if (email == null || password == null) {
      setState(() {
        isLoading = false;
      });
      return;
    }

    await authService.login(
      email as String, 
      password as String
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
