import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:wisteria/app/views/exercises/exercises_view.dart';
import 'package:wisteria/app/views/profile/profile_view.dart';
import 'package:wisteria/app/views/settings/settings_view.dart';
import 'package:wisteria/app/views/vm/vm_view.dart';
import 'app/constants.dart';
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
          height: 90,
          color: const Color.fromARGB(255, 245, 245, 245),
          shape: const CircularNotchedRectangle(),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildBottomNavItem(0, Icons.code, "vm"),
              _buildBottomNavItem(1, Icons.extension, "exercises"),
              _buildBottomNavItem(2, Icons.person, "profile"),
              _buildBottomNavItem(3, Icons.settings, "settings"),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBottomNavItem(int index, IconData icon, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          icon: Icon(
            icon,
            color: _selectedIndex == index ? selectedIconColor : Colors.grey,
          ),
          onPressed: () => _onItemTapped(index),
        ),
        Text(
          label,
          style: TextStyle(
            color: _selectedIndex == index ? selectedIconColor : Colors.grey,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}
