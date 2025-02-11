import 'package:flutter/material.dart';
import 'package:wisteria/app/common/wisteria_box.dart';
import 'package:wisteria/app/common/wisteria_button.dart';
import 'package:wisteria/app/common/wisteria_text.dart';
import 'package:wisteria/app/constants.dart';
import 'package:wisteria/vm/vm.dart';

import '../vm/assembler/assembler.dart';
import '../vm/parser/lexer.dart';
import 'code_editor.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final codeController = TextEditingController();
  late VirtualMachine vm;

  @override
  void initState() {
    super.initState();
    vm = VirtualMachine(program: []);
  }

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
          color: primaryGrey,
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
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              executeButton(),
              codeEditorButton()
            ],
          ),


          machineCodeBox()
        ],
      )
    );
  }

  Widget executeButton() {
    return Padding(
      padding: const EdgeInsets.only(
        left: boxPadding * 2,
        right: boxPadding,
        bottom: boxPadding * 2,
        top: boxPadding
      ),
      child: WisteriaButton(
        width: 80,
        color: primaryGrey,
        text: "execute",
        onTap: () {
          final lexer = Lexer(program: """
mov rax 11

start:
  dec rax
  cmp 1 rax

  out rax
  jne start
""");
          final tokens = lexer.tokenize();
      
          final assembler = Assembler(tokens: tokens);
          final program = assembler.assemble();

          print(program.join(" "));
      
          vm = VirtualMachine(program: program);
          vm.run(() {
            setState(() {});
          });
        }
      ),
    );
  }

  Widget codeEditorButton() {
    return Padding(
      padding: const EdgeInsets.only(
        left: boxPadding * 2,
        right: boxPadding,
        bottom: boxPadding * 2,
        top: boxPadding
      ),
      child: WisteriaButton(
        width: 80,
        color: primaryGrey,
        text: "edit code",
        onTap: () {
          showDialog(context: context, builder: (context) {
            return StackCodeEditor(
              controller: codeController
            );
          });
        }
      ),
    );
  }

  Widget machineCodeBox() {
    return Padding(
      padding: const EdgeInsets.only(
        left: boxPadding / 2,
        right: boxPadding,
        bottom: boxPadding,
        top: boxPadding
      ),
      child: WisteriaBox(
        width: 200,
        height: 70,
        color: primaryGrey,
        child: Padding(
          padding: const EdgeInsets.all(boxPadding),
          child: WisteriaText(
            text: vm.program.map((e) => e.toRadixString(2).padLeft(8, '0')).join(" "),
            color: primaryWhite,
          ),
        )
      ),
    );
  }

  Widget memoryBox(Size screen) {
    return WisteriaBox(
      width: screen.width / memoryWidthRatio,
      height: cpuInterfaceHeight,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 8,
            crossAxisSpacing: 4.0,
            mainAxisSpacing: 4.0,
            childAspectRatio: 1.0,
          ),
          itemCount: vm.memory.length,
          itemBuilder: (context, index) {
            return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4.0),
                color: primaryGrey,
              ),
              alignment: Alignment.center,
              child: Text(
                "0x${vm.memory[index].toRadixString(16).padLeft(2, '0').toUpperCase()}",
                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            );
          },
        ),
      ),
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