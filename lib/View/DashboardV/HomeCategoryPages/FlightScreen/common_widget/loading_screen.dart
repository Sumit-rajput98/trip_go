import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white, // Change if needed
      body: Center(
        child: LottieWidget(),
      ),
    );
  }
}

class LottieWidget extends StatelessWidget {
  const LottieWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Lottie.asset(
      'assets/animation/flight_loading.json',
      width: 200,
      height: 200,
      fit: BoxFit.contain,
    );
  }
}
