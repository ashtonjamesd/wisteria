import 'package:flutter/material.dart';
import 'package:wisteria/app/constants.dart';
import 'package:wisteria/app/utils/globals.dart';
import 'package:wisteria/app/app_view.dart';
import 'package:wisteria/app/widgets/wisteria_button.dart';
import 'package:wisteria/app/widgets/wisteria_icon.dart';
import 'package:wisteria/app/widgets/wisteria_text.dart';

class WelcomeView extends StatefulWidget {
  const WelcomeView({super.key});

  @override
  State<WelcomeView> createState() => _WelcomeViewState();
}

class _WelcomeViewState extends State<WelcomeView> {
  final _pageController = PageController();
  int _currentPage = 0;

  static const double titleSize = 28;
  static const double textSize = 16;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryWhite,
      body: Column(
        children: [
          Expanded(
            child: PageView(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                });
              },
              children: [
                buildPage(
                  "Learn Assembly Code",
                  "Understand low-level programming with an interactive approach.",
                  Icons.code
                ),
                buildPage(
                  "Interactive Virtual Machine",
                  "Simulate a CPU and see your code in action in real-time.",
                  Icons.computer
                ),
                buildPage(
                  "Programming Exercises",
                  "Solve challenges and improve your assembly programming skills.",
                  Icons.terminal
                ),
              ],
            ),
          ),
          
          pageCircleSymbols(),
          const SizedBox(height: 40),
          letsGoButton(),
          const SizedBox(height: 80),
        ],
      ),
    );
  }

  Widget pageCircleSymbols() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(3, (index) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 5),
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: _currentPage == index ? Colors.black : Colors.grey,
          ),
        );
      }),
    );
  }

  Widget buildPage(String title, String desc, IconData icon) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        WisteriaIcon(
          icon: icon,
          size: 60,
        ),
        const SizedBox(height: 40),
        WisteriaText(
          text: title,
          size: titleSize,
          isBold: true,
        ),
        const SizedBox(height: 16),

        SizedBox(
          width: 280,
          child: WisteriaText(
            text: desc,
            size: textSize,
            align: TextAlign.center,
          ),
        ),
      ],
    );
  }

  Widget letsGoButton() {
    return WisteriaButton(
      width: MediaQuery.sizeOf(context).width - 60,
      height: 40,
      color: primaryGrey,
      text: "Let's Go!",
      textSize: 18,
      onTap: () {
        push(context, AppView());
      },
    );
  }
}
