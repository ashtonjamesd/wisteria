import 'package:simple_icons/simple_icons.dart';
import 'package:flutter/material.dart';
import 'package:wisteria/app/widgets/wisteria_box.dart';
import 'package:wisteria/app/widgets/wisteria_button.dart';
import 'package:wisteria/app/widgets/wisteria_text.dart';
import 'package:wisteria/app/constants.dart';
import 'package:wisteria/app/views/vm/help_button.dart';
import 'package:wisteria/app/views/vm/stdout_box.dart';
import 'package:wisteria/app/views/vm/utils/vm_view_controller.dart';
import 'package:wisteria/vm/constants.dart';
import 'package:wisteria/vm/vm.dart';
import 'code_editor.dart';

class VmView extends StatefulWidget {
  const VmView({super.key});

  @override
  State<VmView> createState() => _VmViewState();
}

class _VmViewState extends State<VmView> {
  final controller = VmViewController();

  @override
  void initState() {
    super.initState();
    controller.vm = VirtualMachine(() {}, programString: "");

    initVm();
  }

  Future<void> initVm() async {
    await controller.initVm();
    setState(() {});
  }

  void setInitialInfoWidget(Size screen) {
    // the infoWidget is by default set to a SizedBox at the beginning, therefore
    // this code will run once at the beginning.
    //
    // this is to prevent this from being set every time setState is called as
    // this method is called in build()
    if (controller.infoWidget is SizedBox) {
      controller.infoWidget = WisteriaBox(
        width: screen.width / widthFactor + 12, 
        height: infoWidgetHeight,
        color: primaryGrey,
        child: Padding(
          padding: const EdgeInsets.all(boxPadding),
          child: defaultInfoWidget(screen)
        ),
      );
    }

    if (!controller.shouldShowDialogue) {
      controller.infoWidget = const SizedBox();
    }
  }

  void setInfoWidget(Widget infoWidget) {
    final screen = MediaQuery.sizeOf(context);

    controller.infoWidget = WisteriaBox(
      width: screen.width / widthFactor + 12, 
      height: infoWidgetHeight,
      color: primaryGrey,
      child: Padding(
        padding: const EdgeInsets.all(boxPadding),
        child: infoWidget
      ),
    );

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.sizeOf(context);
    setInitialInfoWidget(screen);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 40),

          Row(
            children: [
              title(),

              const Spacer(),

              githubLinkIcon(),
              Padding(
                padding: const EdgeInsets.only(right: 24, bottom: 8),
                child: HelpButton(),
              ),
            ],
          ),
              
          const Spacer(),

          const SizedBox(height: 16),
          homeView(screen),
          const SizedBox(height: 8),
            
          const Spacer(),

          Padding(
            padding: EdgeInsets.only(left: (screen.width - (screen.width / widthFactor)) / 2 - 8),
            child: controller.infoWidget,
          )
        ],
      ),
    );
  }

  Widget defaultInfoWidget(Size screen) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(boxPadding),
        child: WisteriaText(
          text: "try tapping on a component to find out more about it", 
          color: primaryWhite, 
          size: 14
        ),
      ),
    );
  }

  Widget title() {
    return Padding(
      padding: const EdgeInsets.only(left: 24),
      child: WisteriaText(
        text: "virtual machine",
        color: textColor, 
        size: 24
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
            StdoutBox(screen: screen, vm: controller.vm),
        
            Row(
              children: [
                executeButton(),
                codeEditorButton(),
                pauseButton(),
                haltButton(),
                resetButton()
              ],
            ),
          ],
        )
      ),
    );
  }

  Widget githubLinkIcon() {
    return Row(
      children: [
        // Padding(
        //   padding: const EdgeInsets.only(
        //     bottom: boxPadding * 2, 
        //     right: boxPadding
        //   ),
        //   child: Row(
        //     children: [
        //       WisteriaText(
        //         text: "view code ", 
        //         color: textColor, 
        //         size: 12
        //       ),
        //       Icon(
        //         Icons.arrow_right_alt,
        //         size: 14,
        //       )
        //     ],
        //   ),
        // ),
        GestureDetector(
          onTap: () {
            // final Uri url = Uri.parse(githubUrl);
            
            // if (await canLaunchUrl(url)) {
            //   await launchUrl(url, mode: LaunchMode.externalApplication);
            // } else {
            //   throw 'Could not launch $githubUrl';
            // }
          },
          child: Padding(
            padding: const EdgeInsets.only(
              bottom: boxPadding * 4,
              right: boxPadding * 4
            ),
            child: Icon(
              SimpleIcons.github,
              color: textColor,
              size: 24,
            ),
          ),
        ),
      ],
    );
  }

  Widget resetButton() {
    return Padding(
      padding: const EdgeInsets.only(
        left: boxPadding * 2
      ),
      child: WisteriaButton(
        width: 78,
        color: primaryGrey,
        text: "reset",
        onTap: () async {
          controller.onReset(setState);
          setState(() {});
        }
      ),
    );
  }

  Widget haltButton() {
    return Padding(
      padding: const EdgeInsets.only(
        left: boxPadding * 2
      ),
      child: WisteriaButton(
        width: 80,
        color: primaryGrey,
        text: "halt",
        onTap: () async {
          controller.onHalt();
          setState(() {});
        }
      ),
    );
  }

  Widget pauseButton() {
    return Padding(
      padding: const EdgeInsets.only(
        left: boxPadding * 2
      ),
      child: WisteriaButton(
        width: 36,
        height: 32,
        color: primaryGrey, 
        showBorder: controller.vm.isPaused,
        icon: controller.vm.isPaused ? Icons.pause : Icons.play_arrow,
        onTap: () {
          controller.onPause();
          setState(() {});
        }
      ),
    );
  }

  Widget executeButton() {
    return Padding(
      padding: const EdgeInsets.only(
        left: boxPadding * 2
      ),
      child: WisteriaButton(
        width: 80,
        color: primaryGrey,
        text: "execute",
        onTap: () {
          controller.onExecute(setState);
          setState(() {});
        }
      ),
    );
  }

  Widget codeEditorButton() {
    return Padding(
      padding: const EdgeInsets.only(
        left: boxPadding * 2
      ),
      child: WisteriaButton(
        width: 80,
        color: primaryGrey,
        text: "edit code",
        onTap: () {
          showDialog(context: context, builder: (context) {
            return StackCodeEditor(
              controller: controller.asmCodeController
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
                text: controller.asmCodeController.text,
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
              text: controller.vm.program.map((e) => e.toRadixString(2).padLeft(8, '0')).join(" "),
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
      child: GestureDetector(
        onTap: () {
          controller.onRegisterClicked(name);
          if (controller.selectedRegisterName == "") {
            setState(() {});
            return;
          }

          setInfoWidget(registerInfoWidget());
        },
        child: WisteriaBox(
          width: width,
          height: height,
          header: name,
          showBorder: controller.selectedRegisterName == name,
          color: primaryGrey,
          child: Center(
            child: WisteriaText(
              text: val.toString(),
              color: Colors.white,
              size: 13,
            ),
          )
        ),
      ),
    );
  }

  Widget memoryBox(Size screen) {
    return Padding(
      padding: const EdgeInsets.all(boxPadding),
      child: WisteriaBox(
        width: 160,
        height: 120,
        header: "memory",
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            crossAxisSpacing: 4.0,
            mainAxisSpacing: 4.0,
            childAspectRatio: 1.0
          ),
          itemCount: controller.vm.memory.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                controller.onMemoryCellClicked(index);
                if (controller.selectedMemoryIdx == -1) {
                  setState(() {});
                  return;
                }

                setInfoWidget(memoryCellInfoWidget());
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4.0),
                  border: controller.selectedMemoryIdx != index ? null : Border.all(color: const Color.fromARGB(255, 138, 138, 138)),
                  color: primaryGrey,
                ),
                alignment: Alignment.center,
                child: Text(
                  controller.decimalToHex(controller.vm.memory[index]),
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
    );
  }

  Widget vmConsole(Size screen) {
    return WisteriaBox(
      width: (screen.width / widthFactor) + boxPadding * 2,
      height: consoleHeight,
      child: Padding(
        padding: const EdgeInsets.all(boxPadding),
        child: WisteriaText(
          text: controller.vm.consoleOutput.join("\n"),
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
      
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                programCounter(),
      
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        vmRegister(R1_NAME, controller.vm.r1, 50, 32),
                        vmRegister(R2_NAME, controller.vm.r2, 50, 32),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        vmRegister(R3_NAME, controller.vm.r3, 50, 32),
                        vmRegister(R4_NAME, controller.vm.r4, 50, 32),
                      ],
                    ),
                  ],
                ),
                
                const Spacer(),

                memoryBox(screen),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget programCounter() {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: boxPadding, 
        left: boxPadding
      ),
      child: GestureDetector(
        onTap: () {
          controller.onProgramCounterTapped();
          setInfoWidget(programCounterInfoWidget());
        },
        child: WisteriaBox(
          width: 60, 
          height: 32,
          color: primaryGrey,
          header: "pc",
          showBorder: controller.programCounterSelected,
          child: Center(
            child: WisteriaText(
              text: controller.vm.pc.toString(), 
              color: primaryWhite, 
              size: 14
            ),
          )
        ),
      ),
    );
  }

  Widget memoryCellInfoWidget() {
    final cell = controller.vm.memory[controller.selectedMemoryIdx];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        WisteriaText(
          text: "Memory Cell", 
          color: primaryWhite,
          size: 18
        ),
        const SizedBox(height: 16),

        WisteriaText(
          text: "Memory Value  ${cell.toString()} (${controller.decimalToHex(cell)})", 
          color: primaryWhite,
          size: 14
        ),
        WisteriaText(
          text: "Memory Location  ${controller.decimalToHex(controller.selectedMemoryIdx)}", 
          color: primaryWhite,
          size: 14
        ),

        const SizedBox(height: 16),
        WisteriaText(
          text: memoryDescription, 
          color: primaryWhite,
          size: 12
        ),
      ],
    );
  }

  Widget registerInfoWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        WisteriaText(
          text: "Register ${controller.selectedRegisterName}", 
          color: primaryWhite,
          size: 18
        ),
        const SizedBox(height: 16),

        WisteriaText(
          text: "Register Value ${controller.getRegisterValue(controller.selectedRegisterName)}", 
          color: primaryWhite,
          size: 14
        ),

        const SizedBox(height: 16),
        WisteriaText(
          text: registerDescription, 
          color: primaryWhite,
          size: 12
        ),
      ],
    );
  }

  Widget programCounterInfoWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        WisteriaText(
          text: "Program Counter", 
          color: primaryWhite,
          size: 18
        ),
        const SizedBox(height: 16),

        WisteriaText(
          text: "Value ${controller.vm.pc}", 
          color: primaryWhite,
          size: 14
        ),

        const SizedBox(height: 16),
        WisteriaText(
          text: programCounterDescription, 
          color: primaryWhite,
          size: 12
        ),
      ],
    );
  }
}