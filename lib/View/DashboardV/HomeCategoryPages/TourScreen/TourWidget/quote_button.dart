import 'package:flutter/material.dart';

import '../../../../../constants.dart';

class GetQuotesButton extends StatelessWidget {
  final VoidCallback onPressed;

  const GetQuotesButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 32,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          minimumSize: const Size(0, 32),
          side: BorderSide(color: constants.themeColor1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Text(
          "Get Quotes",
          style: TextStyle(
            fontSize: 13,
            color: constants.themeColor1,
            fontFamily: 'poppins',
          ),
        ),
      ),
    );
  }
}

class ViewDetailsButton extends StatelessWidget {
  final VoidCallback onPressed;

  const ViewDetailsButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 32,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          gradient: LinearGradient(
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
            colors: [constants.themeColor1, constants.themeColor2],
          ),
        ),
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            minimumSize: const Size(0, 32),
            foregroundColor: Colors.white,
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: Text(
            "View Details",
            style: TextStyle(
              fontSize: 13,
              fontFamily: 'poppins',
            ),
          ),
        ),
      ),
    );
  }
}
