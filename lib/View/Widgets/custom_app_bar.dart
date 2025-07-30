import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback? onBack;
  final Color backgroundColor;
  final double elevation;
  final Color titleColor;
  final TextStyle titleStyle;

  const CustomAppBar({
    super.key,
    required this.title,
    this.onBack,
    this.backgroundColor = Colors.white,
    this.elevation = 0,
    this.titleColor = Colors.black,
    this.titleStyle = const TextStyle(
        fontSize: 16.0,
          fontFamily: 'poppins',
          fontWeight: FontWeight.w500,
    )
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      scrolledUnderElevation:0,
      backgroundColor: backgroundColor,
      elevation: elevation,
      toolbarHeight: 40.0,
      centerTitle: false,
      titleSpacing: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_circle_left_outlined, size: 30),
        padding: EdgeInsets.zero,
        constraints: const BoxConstraints(),
        onPressed: onBack ?? () => Navigator.pop(context),
      ),
      title: Text(
        title,
        style: titleStyle.copyWith(color: titleColor),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(40.0);
}
