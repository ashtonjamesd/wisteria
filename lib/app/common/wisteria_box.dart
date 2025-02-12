import 'package:flutter/material.dart';

import '../constants.dart';
import 'wisteria_text.dart';

class WisteriaBox extends StatelessWidget {
  const WisteriaBox({
    super.key,
    required this.width,
    required this.height,
    this.header,
    this.color = primaryWhite,
    required this.child
  });

  final double width;
  final double height;
  final Color color;
  final String? header;
  final Widget child;

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
              borderRadius: BorderRadius.circular(boxBorderRadius)
            ),
            child: child,
          ),
        ],
      ),
    );
  }
}