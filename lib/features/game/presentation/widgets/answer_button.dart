import 'package:flutter/material.dart';

enum AnswerButtonState { normal, correct, incorrect }

class AnswerButton extends StatelessWidget {
  const AnswerButton({
    super.key,
    required this.value,
    required this.state,
    required this.onTap,
  });

  final int value;
  final AnswerButtonState state;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    Color bgColor;
    Color fgColor;
    IconData? icon;

    switch (state) {
      case AnswerButtonState.normal:
        bgColor = cs.primaryContainer;
        fgColor = cs.onPrimaryContainer;
      case AnswerButtonState.correct:
        bgColor = Colors.green;
        fgColor = Colors.white;
        icon = Icons.check;
      case AnswerButtonState.incorrect:
        bgColor = Colors.red;
        fgColor = Colors.white;
        icon = Icons.close;
    }

    return SizedBox(
      height: 64,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: bgColor,
          foregroundColor: fgColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '$value',
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            if (icon != null) ...[
              const SizedBox(width: 8),
              Icon(icon, size: 24),
            ],
          ],
        ),
      ),
    );
  }
}
