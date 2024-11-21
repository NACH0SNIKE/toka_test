import 'package:flutter/material.dart';
import 'package:toka_test/screens/contacts_screen.dart';

class LongButton extends StatelessWidget {
  final String msg;
  final Color buttonColor;
  final Color textColor;
  final VoidCallback onPressed;

  LongButton({
    super.key,
    required this.msg,
    required this.buttonColor,
    required this.textColor,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: FilledButton(
        onPressed: onPressed,
        style: FilledButton.styleFrom(
          backgroundColor: buttonColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          padding: const EdgeInsets.symmetric(vertical: 16),
        ),
        child: Text(
          msg,
          style: TextStyle(
            color: textColor,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
