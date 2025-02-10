import 'package:flutter/material.dart';
import 'package:wisteria/app/common/wisteria_box.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: homeView(),
    );
  }

  Widget homeView() {
    return Column(
      children: [
        Row(
          children: [
            processorInterface(),
            memoryBox()
          ],
        ),

        vmConsole()
      ],
    );
  }

  Widget processorInterface() {
    return WisteriaBox(
      width: 600,
      height: 500,
      child: SizedBox()
    );
  }

  Widget vmConsole() {
    return WisteriaBox(
      width: 800,
      height: 200,
      child: SizedBox()
    );
  }

  Widget memoryBox() {
    return WisteriaBox(
      width: 200,
      height: 500,
      child: SizedBox()
    );
  }
}