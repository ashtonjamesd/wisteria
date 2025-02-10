import 'package:flutter/material.dart';

import '../constants.dart';

class WisteriaBox extends StatelessWidget {
  const WisteriaBox({
    super.key, 
    required this.width, 
    required this.height, 
    required this.child
  });

  final double width;
  final double height;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(boxPadding),
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(boxBorderRadius)
        ),
        child: child,
      ),
    );
  }
}