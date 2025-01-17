import 'package:flutter/material.dart';
import 'package:wisteria/ui/wisteria_box.dart';
import 'package:wisteria/ui/wisteria_icon_button.dart';
import 'package:wisteria/utils/app_theme.dart';

class WisteriaWindow extends StatefulWidget {
  const WisteriaWindow({
    super.key,
    required this.child,
    required this.width,
    required this.height,
    this.showCloseButton = true
  });

  final Widget child;
  final double width;
  final double height;
  final bool showCloseButton;

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
          backgroundColor: AppTheme.backgroundColor,
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
        if (widget.showCloseButton) windowMenu(),
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