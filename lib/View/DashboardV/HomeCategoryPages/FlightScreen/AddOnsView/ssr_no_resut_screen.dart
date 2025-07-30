import 'package:flutter/material.dart';

class SsrNoResultScreen extends StatelessWidget {
  const SsrNoResultScreen({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/noResult.png',
                fit: BoxFit.contain,
              ),
              const SizedBox(height: 16),
              const Text(
                "Oops no result found",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                  fontFamily: 'poppins',
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 120),
            ],
          ),
        ),
      ),
    );
  }
}
