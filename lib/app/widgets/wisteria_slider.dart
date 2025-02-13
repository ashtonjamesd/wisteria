import 'package:flutter/material.dart';

import '../constants.dart';
import 'wisteria_text.dart';

class WisteriaSlider extends StatefulWidget {
  const WisteriaSlider({
    super.key, 
    required this.value, 
    required this.onChanged
  });

  final bool value;
  final Function(bool) onChanged;

  @override
  State<WisteriaSlider> createState() => _WisteriaSliderState();
}

class _WisteriaSliderState extends State<WisteriaSlider> {
  bool value = false;

  @override
  void initState() {
    value = widget.value;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        WisteriaText(
          text: "No", 
          color: textColor, 
          size: 14,
        ),
        Switch(
          value: value,
          onChanged: (newValue) {
            setState(() {
              value = newValue;
            });

            widget.onChanged(newValue);
          },
          activeColor: primaryWhite,
          inactiveThumbColor: primaryGrey,
          activeTrackColor: textColor,
          inactiveTrackColor: textColor,
        ),
        WisteriaText(
          text: "Yes", 
          color: textColor, 
          size: 14,
        ),
      ],
    );
  }
}