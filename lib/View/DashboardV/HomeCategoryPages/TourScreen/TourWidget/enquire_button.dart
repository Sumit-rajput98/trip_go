import 'package:flutter/material.dart';
import 'package:trip_go/constants.dart';

class AnimatedEnquireButton extends StatefulWidget {
  @override
  State<AnimatedEnquireButton> createState() => _AnimatedEnquireButtonState();
}

class _AnimatedEnquireButtonState extends State<AnimatedEnquireButton> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Color?> _borderColor;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    _borderColor = ColorTween(
      begin: constants.themeColor1,
      end: constants.themeColor2,
    ).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _borderColor,
      builder: (context, child) {
        return GestureDetector(
          onTap: () {
            // Add your action here
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Enquire Now clicked!')),
            );
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              border: Border.all(
                color: _borderColor.value ?? Colors.orangeAccent,
                width: 2,
              ),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: _borderColor.value!.withOpacity(0.4),
                  blurRadius: 8,
                  offset: const Offset(0, 3),
                )
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  "assets/icons/live_chat.png",
                  width: 20,
                  height: 20,
                ),
                const SizedBox(width: 8),
                const Text(
                  'Enquire Now',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                    fontSize: 12,
                    fontFamily: 'poppins',
                  ),
                ),
              ],
            ),
          )
        );
      },
    );
  }
}
