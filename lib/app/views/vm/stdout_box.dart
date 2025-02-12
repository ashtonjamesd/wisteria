import 'package:flutter/material.dart';
import 'package:wisteria/vm/vm.dart';

import '../../common/wisteria_box.dart';
import '../../common/wisteria_text.dart';
import '../../constants.dart';

class StdoutBox extends StatefulWidget {
  const StdoutBox({
    super.key, 
    required this.screen, 
    required this.vm
  });

  final Size screen;
  final VirtualMachine vm;

  @override
  State<StdoutBox> createState() => _StdoutBoxState();
}

class _StdoutBoxState extends State<StdoutBox> {
  final _scrollController = ScrollController();

  @override
  void didUpdateWidget(covariant StdoutBox oldWidget) {
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
    return Padding(
      padding: const EdgeInsets.all(boxPadding),
      child: WisteriaBox(
        header: "standard output",
        width: widget.screen.width / widthFactor -
            boxPadding * 4,
        height: 60,
        color: primaryGrey,
        child: Padding(
          padding: const EdgeInsets.only(left: boxPadding, top: boxPadding),
          child: Scrollbar(
            controller: _scrollController,
            child: SingleChildScrollView(
              controller: _scrollController,
              scrollDirection: Axis.vertical,
              child: WisteriaText(
                text: widget.vm.stdout.join("\n"),
                color: primaryWhite,
                size: 12,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
