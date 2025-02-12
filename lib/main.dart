import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:wisteria/app/views/exercises/exercises_view.dart';
import 'package:wisteria/app/views/profile/profile_view.dart';
import 'package:wisteria/app/views/settings/settings_view.dart';
import 'package:wisteria/app/views/vm/vm_view.dart';
import 'firebase_options.dart';

void main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();

    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

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
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const VmView(),
    const ExercisesView(),
    const ProfileView(),
    const SettingsView(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: _pages[_selectedIndex],
        bottomNavigationBar: BottomAppBar(
          color: Colors.white,
          shape: const CircularNotchedRectangle(),
          notchMargin: 6.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                icon: const Icon(Icons.code),
                onPressed: () => _onItemTapped(0),
              ),
              IconButton(
                icon: const Icon(Icons.extension),
                onPressed: () => _onItemTapped(1),
              ),
              IconButton(
                icon: const Icon(Icons.person),
                onPressed: () => _onItemTapped(2),
              ),
              IconButton(
                icon: const Icon(Icons.settings),
                onPressed: () => _onItemTapped(3),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
