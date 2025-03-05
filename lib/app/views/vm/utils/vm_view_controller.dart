import 'package:flutter/material.dart';
import 'package:wisteria/app/app_controller.dart';

import '../../../../vm/constants.dart';
import '../../../../vm/vm.dart';

final class VmViewController {
  late VirtualMachine vm;

  int selectedMemoryIdx = -1;
  String selectedComponentName = "";
  bool programCounterSelected = false;

  // the reset button can be pressed many times in quick succession.
  // this will build up messages in the terminal which is not desirable.
  // to prevent this, this flag is set to true until the reset process has finished,
  // during which the user cannot press reset again.
  //
  // finally, it is set to false to allow the user to tap the reset button again.
  bool resetIsPressed = false;
  
  Widget infoWidget = const SizedBox();

  bool shouldShowDialogue = AppController.instance.settings.showInfoDialogs;

  int getRegisterValue(String name) {
    return switch (name) {
      R1_NAME => vm.ra,
      R2_NAME => vm.rb,
      R3_NAME => vm.rc,
      R4_NAME => vm.rd,
      _ => -1
    };
  }

  int getFlagValue(String name) {
    return switch (name) {
      "zf" => vm.zf ? 1 : 0,
      "sf" => vm.sf ? 1 : 0,
      _ => -1
    };
  }

  Future<void> onHalt() async {
    if (!vm.isRunning) return;

    vm.isRunning = false;

    vm.output("virtual machine forcibly halted. all processes stopped.");
    await vm.delay(500);
  }

  String decimalToHex(int decimal) {
    return "0x${decimal.toRadixString(16).padLeft(2, '0').toUpperCase()}";
  }

  Future<void> onReset(Function setState) async {
    if (resetIsPressed) return;
    resetIsPressed = true;

    vm.output("virtual machine reset. resetting all processes.");
    await vm.delay(1000);

    vm = VirtualMachine(() {
      setState(() {});
    },
      programString: AppController.instance.codeController.text
    );

    initVm();

    resetIsPressed = false;
  }

  Future<void> onExecute(Function setState) async {
    vm = VirtualMachine(() {
      setState(() {});
    },
      hasDelays: AppController.instance.settings.simulateVmDelays,
      programString: AppController.instance.codeController.text
    );

    vm.run();
  }

  Future<void> onPause() async {
    vm.isPaused = !vm.isPaused;
  }

  Future<void> initVm() async {
    await vm.delay(250);
    vm.output("initialised virtual machine");
  }

  void resetSelectedItems() {
    selectedMemoryIdx = -1;
    selectedComponentName = "";
    programCounterSelected = false;
  }

  void onMemoryCellClicked(int index) {
    if (selectedMemoryIdx == index) {
      infoWidget = const SizedBox();
      selectedMemoryIdx = -1;
      return;
    }

    resetSelectedItems();

    selectedMemoryIdx = index;
  }

  void onComponentTapped(String name) {
    if (selectedComponentName == name) {
      infoWidget = const SizedBox();
      selectedComponentName = "";
      return;
    }

    resetSelectedItems();
    
    selectedComponentName = name;
  }

  void onProgramCounterTapped() {
    if (programCounterSelected) {
      infoWidget = const SizedBox();
      programCounterSelected = false;
      return;
    }

    resetSelectedItems();

    programCounterSelected = true;
  }
}