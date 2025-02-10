import 'package:flutter/material.dart';
import 'package:wisteria/app/common/wisteria_box.dart';
import 'package:wisteria/app/constants.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.sizeOf(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: homeView(screen),
    );
  }

  Widget homeView(Size screen) {
    return Center(
      child: Container(
        width: (screen.width / memoryWidthRatio + screen.width / cpuInterfaceWidthRatio) + boxPadding * 6,
        height: (cpuInterfaceHeight + consoleHeight) + boxPadding * 6,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(boxBorderRadius),
          color: Colors.grey,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                processorInterface(screen),
                memoryBox(screen)
              ],
            ),
        
            vmConsole(screen)
          ],
        ),
      ),
    );
  }

  Widget processorInterface(Size screen) {
    return WisteriaBox(
      width: screen.width / cpuInterfaceWidthRatio,
      height: cpuInterfaceHeight,
      child: SizedBox()
    );
  }

  Widget memoryBox(Size screen) {
    return WisteriaBox(
      width: screen.width / memoryWidthRatio,
      height: cpuInterfaceHeight,
      child: SizedBox()
    );
  }

  Widget vmConsole(Size screen) {
    return WisteriaBox(
      width: (screen.width / memoryWidthRatio + screen.width / cpuInterfaceWidthRatio) + boxPadding * 2,
      height: consoleHeight,
      child: SizedBox()
    );
  }
}