import 'package:flutter/material.dart';

class DrawerHeaderCloseButton extends StatelessWidget {
  const DrawerHeaderCloseButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: IconButton(
        icon: const Icon(Icons.close, size: 25, color: Colors.black),
        onPressed: () => Navigator.pop(context),
      ),
    );
  }
}
