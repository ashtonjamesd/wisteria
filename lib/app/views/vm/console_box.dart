import 'package:flutter/material.dart';
import 'package:wisteria/app/views/vm/utils/vm_view_controller.dart';
import 'package:wisteria/vm/vm.dart';

import '../../constants.dart';
import '../../widgets/wisteria_box.dart';
import '../../widgets/wisteria_text.dart';

class ConsoleBox extends StatefulWidget {
  const ConsoleBox({
    super.key, 
    required this.vm,
    required this.width, 
    required this.showBorder
  });

  final VirtualMachine vm;
  final double width;
  final bool showBorder;

  @override
  State<ConsoleBox> createState() => _ConsoleBoxState();
}

class _ConsoleBoxState extends State<ConsoleBox> {
  final _scrollController = ScrollController();

  @override
  void didUpdateWidget(covariant ConsoleBox oldWidget) {
    super.didUpdateWidget(oldWidget);
    WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
    }
  }

  @override
  Widget build(BuildContext context) {
    return WisteriaBox(
      width: widget.width,
      height: consoleHeight,
      showBorder: widget.showBorder,
      borderColor: primaryGrey,
      child: Padding(
        padding: const EdgeInsets.all(boxPadding),
        child: Scrollbar(
          controller: _scrollController,
          child: SingleChildScrollView(
            controller: _scrollController,
            scrollDirection: Axis.vertical,
            child: WisteriaText(
              text: widget.vm.consoleOutput.join("\n"),
              color: const Color.fromARGB(255, 52, 52, 52),
              size: 12,
            ),
          ),
        ),
      )
    );
  }
}