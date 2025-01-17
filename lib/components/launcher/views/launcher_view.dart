import 'package:flutter/material.dart';
import 'package:wisteria/ui/wisteria_window.dart';

import '../controllers/launcher_controller.dart';

class LauncherView extends StatefulWidget {
  const LauncherView({super.key});

  @override
  State<LauncherView> createState() => _LauncherViewState();
}

class _LauncherViewState extends State<LauncherView> {
  final launcherController = LauncherController();

  void showWelcomeBox() {
    showDialog(context: context, builder: (context) {
      return WisteriaWindow(
        width: 400,
        height: 220,
        child: welcomeBox()
      );
    });
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showWelcomeBox();
    });
    
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
      )
    );
  }

  Widget welcomeBox() {
    return const Text("Hello, World!");
  }
}