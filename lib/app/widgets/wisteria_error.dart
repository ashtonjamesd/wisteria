import 'package:flutter/material.dart';

import 'wisteria_text.dart';

class WisteriaError extends StatelessWidget {
  const WisteriaError({super.key, required this.error});

  final String error;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.red.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.redAccent, width: 1.5),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, color: Colors.redAccent, size: 28),
          const SizedBox(width: 12),
          Expanded(
            child: WisteriaText(
              text: error,
              size: 16,
              color: Colors.redAccent,
            ),
          ),
        ],
      ),
    );
  }
}