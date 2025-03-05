import 'package:flutter/material.dart';
import 'package:wisteria/app/widgets/wisteria_icon.dart';
import 'package:wisteria/vm/vm.dart';

import '../../widgets/wisteria_box.dart';
import '../../widgets/wisteria_text.dart';
import '../../constants.dart';

class StdoutBox extends StatefulWidget {
  const StdoutBox({
    super.key, 
    required this.screen, 
    required this.vm,
    this.isExercise = false,
  });

  final Size screen;
  final VirtualMachine vm;
  final bool isExercise;

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

  Widget exerciseBoxVariant() {
    return Padding(
      padding: const EdgeInsets.all(boxPadding),
      child: WisteriaBox(
        header: "standard output",
        width: widget.screen.width / widthFactor - boxPadding * 2,
        height: 60,
        color: primaryWhite,
        showBorder: true,
        borderColor: primaryGrey,
        child: Padding(
          padding: const EdgeInsets.only(left: boxPadding, top: boxPadding),
          child: Scrollbar(
            controller: _scrollController,
            child: SingleChildScrollView(
              controller: _scrollController,
              scrollDirection: Axis.vertical,
              child: WisteriaText(
                text: widget.vm.stdout.join("\n"),
                color: Colors.black,
                size: 12,
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return widget.isExercise ? exerciseBoxVariant() : Padding(
      padding: const EdgeInsets.all(boxPadding),
      child: WisteriaBox(
        header: "standard output",
        width: widget.screen.width / widthFactor - boxPadding * 2,
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
