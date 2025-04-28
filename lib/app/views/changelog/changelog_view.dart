import 'package:flutter/material.dart';

import '../../constants.dart';
import '../../utils/globals.dart';
import '../../widgets/wisteria_button.dart';
import '../../widgets/wisteria_text.dart';

class ChangelogView extends StatefulWidget {
  const ChangelogView({super.key});

  @override
  State<ChangelogView> createState() => _ChangelogViewState();
}

class _ChangelogViewState extends State<ChangelogView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryWhite,
      body: changelogsView(),
    );
  }

  Widget changelogsView() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 40),
      
          Padding(
            padding: const EdgeInsets.only(left: 32),
            child: Row(
              children: [
                WisteriaText(
                  text: "changelog", 
                  color: primaryTextColor,
                  size: 24,
                ),

                const Spacer(),
                Padding(
                  padding: const EdgeInsets.only(top: 16, right: 16),
                  child: WisteriaButton(
                    width: 100,
                    color: primaryGrey,
                    text: "back", 
                    onTap: () {
                      pop(context);
                    }
                  ),
                )
              ],
            ),
          ),
      
          const SizedBox(height: 40),

          const SizedBox(height: 24),
          changelogVersion("1.0.0"),
          changelogs([
            "Initial release of Wisteria.",
            "Virtual machine with custom assembly instruction set.",
            "Exercise system with progress tracking",
            "Assembly language documentation guide"
          ]),
        ]
      )
    );
  }

  Widget changelogVersion(String version) {
    return Padding(
      padding: const EdgeInsets.only(left: 16),
      child: WisteriaText(
        text: "v$version",
        size: 24,
        isBold: true,
      ),
    );
  }

  Widget changelogs(List<String> logs) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (var log in logs)
          Padding(
            padding: const EdgeInsets.only(left: 32),
            child: WisteriaText(
              text: "- $log"
            ),
          )
      ],
    );
  }
}