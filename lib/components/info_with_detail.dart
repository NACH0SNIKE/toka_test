import 'package:flutter/material.dart';

class InfoWithDetail extends StatelessWidget {
  final String info;
  final String detail;

  InfoWithDetail({
    super.key,
    required this.info,
    required this.detail,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: TextStyle(
          color: Colors.grey[600],
        ),
        children: [
          TextSpan(
            text: info,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16.0,
            ),
          ),
          TextSpan(
            text: detail,
          ),
        ],
      ),
    );
  }
}
