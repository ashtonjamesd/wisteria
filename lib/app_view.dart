import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wisteria/app/utils/auth/auth_service.dart';

import 'app/constants.dart';
import 'app/views/exercises/views/exercises_view.dart';
import 'app/views/profile/views/profile_view.dart';
import 'app/views/settings/settings_view.dart';
import 'app/views/vm/vm_view.dart';

class AppView extends StatefulWidget {
  const AppView({super.key});

  @override
  State<AppView> createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  final authService = AuthService();

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
    return Scaffold(
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