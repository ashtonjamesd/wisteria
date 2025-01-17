import 'package:flutter/material.dart';
import 'package:wisteria/ui/wisteria_box.dart';
import 'package:wisteria/ui/wisteria_icon_button.dart';

class WisteriaWindow extends StatefulWidget {
  const WisteriaWindow({
    super.key,
    required this.child,
    required this.width,
    required this.height
  });

  final Widget child;
  final double width;
  final double height;

  @override
  State<WisteriaWindow> createState() => _WisteriaWindowState();
}

class _WisteriaWindowState extends State<WisteriaWindow> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: WisteriaBox(
          width: widget.width,
          height: widget.height,
          child: child()
        ),
      ),
    );
  }

  Widget child() {
    return Column(
      children: [
        windowMenu(),
        widget.child
      ],
    );
  }

  Widget windowMenu() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        WisteriaIconButton(
          icon: Icons.close,
          onTap: () {
            Navigator.pop(context);
          }
        )
      ],
    );
  }
}