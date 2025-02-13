import 'package:flutter/material.dart';

void pop(BuildContext context) {
  Navigator.pop(context);
}

void push(BuildContext context, Widget page) {
  Navigator.push(
    context, 
    MaterialPageRoute(builder: (context) => page)
  );
}