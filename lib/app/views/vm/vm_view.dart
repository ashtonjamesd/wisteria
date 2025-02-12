import 'package:flutter/material.dart';
import 'package:wisteria/app/common/wisteria_box.dart';
import 'package:wisteria/app/common/wisteria_button.dart';
import 'package:wisteria/app/common/wisteria_text.dart';
import 'package:wisteria/app/constants.dart';
import 'package:wisteria/app/views/vm/help_button.dart';
import 'package:wisteria/app/views/vm/stdout_box.dart';
import 'package:wisteria/vm/vm.dart';
import 'code_editor.dart';

class VmView extends StatefulWidget {
  const VmView({super.key});

  @override
  State<VmView> createState() => _VmViewState();
}

class _VmViewState extends State<VmView> {
  final codeController = TextEditingController();
  late VirtualMachine vm;

  int selectedMemoryIdx = -1;

  @override
  void initState() {
    super.initState();
    vm = VirtualMachine(() {}, programString: "");
  }

  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.sizeOf(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [          
          Row(
            children: [
              title(),

              const Spacer(),

              Padding(
                padding: const EdgeInsets.only(right: 24, bottom: 8),
                child: HelpButton(),
              ),
            ],
          ),


          homeView(screen),
        ],
      ),
    );
  }

  Widget title() {
    return Padding(
      padding: const EdgeInsets.only(left: 24),
      child: WisteriaText(
        text: "virtual machine",
        color: primaryGrey, 
        size: 18
      ),
    );
  }

  Widget homeView(Size screen) {
    return Center(
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          width: (screen.width / widthFactor) + boxPadding * 6,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(boxBorderRadius),
            color: primaryGrey,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              userInterface(screen),
              vmConsole(screen),
              cpuInterface(screen)
            ],
          ),
        ),
      ),
    );
  }

  Widget userInterface(Size screen) {
    return Padding(
      padding: const EdgeInsets.only(
        top: boxPadding,
        left: boxPadding,
        right: boxPadding
      ),
      child: WisteriaBox(
        width: screen.width,
        height: userInterfaceHeight,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            StdoutBox(screen: screen, vm: vm),
        
            Row(
              children: [
                executeButton(),
                codeEditorButton(),
              ],
            ),

            
            // programCounter(),
      
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.end,
            //   crossAxisAlignment: CrossAxisAlignment.end,
            //   children: [
            //     Column(
            //       mainAxisAlignment: MainAxisAlignment.end,
            //       children: [
            //         vmRegister("rax", vm.rax, 50, 32),
            //         vmRegister("rbx", vm.rbx, 50, 32),
            //       ],
            //     ),
            //     Column(
            //       mainAxisAlignment: MainAxisAlignment.end,
            //       children: [
            //         vmRegister("rcx", vm.rcx, 50, 32),
            //         vmRegister("rdx", vm.rdx, 50, 32),
            //       ],
            //     ),
            //   ],
            // )
          ],
        )
      ),
    );
  }

  Widget programCounter() {
    return Padding(
      padding: const EdgeInsets.only(bottom: boxPadding),
      child: WisteriaBox(
        width: 60, 
        height: 32,
        color: primaryGrey,
        child: Row(
          children: [
            const SizedBox(width: 8),
            WisteriaText(
              text: "pc", 
              color: primaryWhite, 
              size: 14
            ),

            const SizedBox(width: 4),
            WisteriaText(
              text: vm.pc.toString(), 
              color: primaryWhite, 
              size: 14
            ),
          ],
        )
      ),
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
          codeController.text = """
mov rax 10 
start:
  out rax
  dec rax
  cmp 0 rax
  jne start
          """;
          

          vm = VirtualMachine(() {
            setState(() {});
          },
            programString: codeController.text
          );

          // print(vm.program.map((e) => e.toRadixString(16).padLeft(2, '0').toUpperCase()).join(""));

          vm.run();
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

  Widget asmBox() {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Padding(
        padding: const EdgeInsets.only(
          left: boxPadding,
          bottom: boxPadding,
          top: boxPadding
        ),
        child: WisteriaBox(
          header: "assembly",
          width: asmBoxWidth,
          height: 70,
          color: primaryGrey,
          child: Padding(
            padding: const EdgeInsets.all(boxPadding),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: WisteriaText(
                text: codeController.text,
                color: primaryWhite,
                size: 12,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget machineCodeBox(Size screen) {
    return Padding(
      padding: const EdgeInsets.only(
        right: boxPadding,
        bottom: boxPadding,
        top: boxPadding
      ),
      child: WisteriaBox(
        header: "machine code",
        width: (screen.width / widthFactor - asmBoxWidth) - boxPadding * 4,
        height: 70,
        color: primaryGrey,
        child: Padding(
          padding: const EdgeInsets.all(boxPadding),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: WisteriaText(
              text: vm.program.map((e) => e.toRadixString(2).padLeft(8, '0')).join(" "),
              color: primaryWhite,
              size: 12,
            ),
          ),
        )
      ),
    );
  }

  Widget vmRegister(String name, int val, double width, double height) {
    return Padding(
      padding: const EdgeInsets.only(bottom: boxPadding),
      child: WisteriaBox(
        width: width,
        height: height,
        color: primaryGrey,
        child: Row(
          children: [
            const SizedBox(width: 8),
            WisteriaText(
              text: name,
              color: Colors.white,
              size: 14,
            ),
      
            const Spacer(),
            WisteriaText(
              text: val.toString(),
              color: Colors.white,
              size: 12,
            ),
            const SizedBox(width: 8),
          ],
        )
      ),
    );
  }

  Widget memoryBox(Size screen) {
    return Padding(
      padding: const EdgeInsets.only(top: boxPadding),
      child: WisteriaBox(
        width: 160,
        height: 120,
        header: "memory",
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              crossAxisSpacing: 4.0,
              mainAxisSpacing: 4.0,
              childAspectRatio: 1.0,
            ),
            itemCount: vm.memory.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedMemoryIdx = index;
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4.0),
                    border: selectedMemoryIdx != index ? null : Border.all(color: const Color.fromARGB(255, 138, 138, 138)),
                    color: primaryGrey,
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    "0x${vm.memory[index].toRadixString(16).padLeft(2, '0').toUpperCase()}",
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget vmConsole(Size screen) {
    return WisteriaBox(
      width: (screen.width / widthFactor) + boxPadding * 2,
      height: consoleHeight,
      child: Padding(
        padding: const EdgeInsets.all(boxPadding),
        child: WisteriaText(
          text: vm.consoleOutput.join("\n"),
          color: const Color.fromARGB(255, 52, 52, 52),
          size: 12,
        ),
      )
    );
  }

  Widget cpuInterface(Size screen) {
    return Padding(
      padding: const EdgeInsets.only(bottom: boxPadding),
      child: WisteriaBox(
        width: (screen.width / widthFactor) + boxPadding * 2,
        height: cpuInterfaceHeight,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                asmBox(),
                machineCodeBox(screen),
              ],
            ),
      
            memoryBox(screen)
          ],
        ),
      ),
    );
  }
}