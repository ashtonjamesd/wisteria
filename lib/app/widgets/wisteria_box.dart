import 'package:flutter/material.dart';

import '../constants.dart';
import 'wisteria_text.dart';

class WisteriaBox extends StatelessWidget {
  const WisteriaBox({
    super.key,
    required this.width,
    required this.height,
    this.header,
    this.showBorder = false,
    this.color = primaryWhite,
    this.borderColor = primaryTextColor,
    required this.child
  });

  final double width;
  final double height;
  final Color color;
  final String? header;
  final bool showBorder;
  final Widget child;
  final Color borderColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(boxPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (header != null) 
            WisteriaText(
              text: header!,
              color: primaryGrey,
              size: 12,
            ),

          Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(boxBorderRadius),
              border: showBorder ? Border.all(color: borderColor) : null,
            ),
            child: child,
          ),
        ],
      ),
    );
  }
}