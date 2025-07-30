import 'dart:async';
import 'package:flutter/material.dart';
import 'package:trip_go/Splash/splash_screen.dart';

class LogoIntroScreen extends StatefulWidget {
  const LogoIntroScreen({super.key});

  @override
  State<LogoIntroScreen> createState() => _LogoIntroScreenState();
}

class _LogoIntroScreenState extends State<LogoIntroScreen> {
  double _scale = 0.0;
  double _opacity = 0.0;
  bool navigating = false;

  @override
  void initState() {
    super.initState();
    _startAnimation();
  }

  void _startAnimation() async {
    await Future.delayed(const Duration(milliseconds: 300));
    setState(() {
      _scale = 1.0;
      _opacity = 1.0;
    });

    await Future.delayed(const Duration(milliseconds: 1800));
    if (mounted && !navigating) {
      navigating = true;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const TripGoSplash()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: AnimatedOpacity(
          duration: const Duration(milliseconds: 1000),
          opacity: _opacity,
          child: AnimatedScale(
            scale: _scale,
            duration: const Duration(milliseconds: 900),
            curve: Curves.elasticOut,
            child: Image.asset(
              'assets/images/trip_go.png',
              height: 80,
            ),
          ),
        ),
      ),
    );
  }
}
