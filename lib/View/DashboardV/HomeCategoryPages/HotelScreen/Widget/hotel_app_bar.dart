import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HotelAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final String? subline;
  final VoidCallback? onBack;
  final VoidCallback? onSearchTap; // <-- New
  final VoidCallback? onEditTap;   // <-- New
  final Color backgroundColor;
  final double elevation;
  final Color titleColor;
  final Color sublineColor;

  const HotelAppBar({
    super.key,
    required this.title,
    this.subline,
    this.onBack,
    this.onSearchTap,
    this.onEditTap,
    this.backgroundColor = Colors.white,
    this.elevation = 0,
    this.titleColor = Colors.black,
    this.sublineColor = Colors.grey,
  });

  @override
  Widget build(BuildContext context) {
    String capitalizeWords(String text) {
      return text.split(' ').map((word) {
        if (word.isEmpty) return '';
        return word[0].toUpperCase() + word.substring(1).toLowerCase();
      }).join(' ');
    }
    return AppBar(
      backgroundColor: backgroundColor,
      elevation: elevation,
      toolbarHeight: subline != null ? 56.0 : 40.0,
      centerTitle: false,
      titleSpacing: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_circle_left_outlined, size: 30),
        padding: EdgeInsets.zero,
        constraints: const BoxConstraints(),
        onPressed: onBack ?? () => Navigator.pop(context),
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Title and Subline
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                capitalizeWords(title),
                style: TextStyle(
                  fontSize: 16.0,
                  fontFamily: 'poppins',
                  fontWeight: FontWeight.w500,
                  color: titleColor,
                ),
              ),
              if (subline != null)
                Text(
                  subline!,
                  style: TextStyle(
                    fontSize: 10.0,
                    fontFamily: 'poppins',
                    fontWeight: FontWeight.w400,
                    color: sublineColor,
                  ),
                ),
            ],
          ),

          // Search and Edit Icons
          Row(
            children: [
              GestureDetector(
                onTap: onSearchTap,
                child: SvgPicture.network(
                  'https://www.easemytrip.com/hotel-new/images/mobile/search.svg',
                  width: 20,
                  height: 20,
                ),
              ),
              const SizedBox(width: 15),
              GestureDetector(
                onTap: onEditTap,
                child: SvgPicture.network(
                  'https://www.easemytrip.com/hotel-new/images/mobile/icon_edit.svg',
                  width: 16,
                  height: 16,
                ),
              ),
              const SizedBox(width: 25),
            ],
          )
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(subline != null ? 56.0 : 40.0);
}