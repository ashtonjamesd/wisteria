import 'package:flutter/material.dart';

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
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4)
      ),
      child: child,
    );
  }
}