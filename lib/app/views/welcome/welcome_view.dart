import 'package:flutter/material.dart';
import 'package:wisteria/app/constants.dart';
import 'package:wisteria/app/utils/globals.dart';
import 'package:wisteria/app/views/vm/vm_view.dart';
import 'package:wisteria/app/widgets/wisteria_box.dart';
import 'package:wisteria/app/widgets/wisteria_button.dart';
import 'package:wisteria/app/widgets/wisteria_icon.dart';
import 'package:wisteria/app/widgets/wisteria_text.dart';
import 'package:wisteria/app_view.dart';

class WelcomeView extends StatefulWidget {
  const WelcomeView({super.key});

  @override
  State<WelcomeView> createState() => _WelcomeViewState();
}

class _WelcomeViewState extends State<WelcomeView> {
  int pageIndex = 0;

  var pageMap =  {};

  @override
  void initState() {
    pageMap = {
      0: welcomePageOne(),
      1: welcomePageTwo(),
      2: welcomePageThree(),
    };

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryWhite,
      body: defaultPageWidget(pageMap[pageIndex]),
    );
  }

  Widget defaultPageWidget(Widget page) {
    return Center(
      child: Column(
        children: [
          page,
          const Spacer(),

          pageCircleSymbols(),
          const SizedBox(height: 80),

          letsGoButton(),
          const SizedBox(height: 80),
        ],
      ),
    );
  }

  Widget pageCircleSymbols() {
    return SizedBox();
  }

  Widget welcomePageOne() {
    return Column(
      children: [
        const SizedBox(height: 200),

        WisteriaIcon(
          icon: Icons.code,
          size: 60,
        ),

        const SizedBox(height: 40),

        WisteriaText(
          text: "Learn Assembly Code",
          size: 32,
          isBold: true,
        ),
        WisteriaText(
          text: "",
          size: 18,
        ),
      ],
    );
  }

  Widget welcomePageTwo() {
    return WisteriaText(text: "page 2");
  }

  Widget welcomePageThree() {
    return WisteriaText(text: "page 3");
  }

  Widget letsGoButton() {
    return WisteriaButton(
      width: MediaQuery.sizeOf(context).width - 60, 
      height: 40, 
      color: primaryGrey,
      text: "Lets Go!",
      textSize: 18,
      onTap: () {
        push(context, AppView());
      },
    );
  }
}