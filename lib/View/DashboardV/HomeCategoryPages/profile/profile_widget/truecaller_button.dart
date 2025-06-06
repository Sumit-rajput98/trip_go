import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TruecallerButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;

  const TruecallerButton({
    Key? key,
    required this.onPressed,
    this.text = 'Continue with Truecaller',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return SizedBox(
      width: screenWidth,
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: Icon(
          CupertinoIcons.phone, // Replace with Truecaller icon if available
          color: Colors.white,
          size: screenWidth * 0.05,
        ),
        label: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF0CAAFF), // Truecaller Blue
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          elevation: 3,
        ),
      ),
    );
  }
}
