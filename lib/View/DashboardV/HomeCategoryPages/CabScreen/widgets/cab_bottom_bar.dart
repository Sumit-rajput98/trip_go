import 'package:flutter/material.dart';

class CabFilterBottomSheet extends StatelessWidget {
  final VoidCallback onFilterTap;
  final VoidCallback onSortTap;
  final bool showSortNotification;

  const CabFilterBottomSheet({
    super.key,
    required this.onFilterTap,
    required this.onSortTap,
    this.showSortNotification = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(18)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildTab(
              icon: Icons.filter_list,
              label: "FILTER",
              onTap: onFilterTap
          ),
          _buildTab(
            icon: Icons.sort,
            label: "SORT",
            onTap: onSortTap,
            showDot: showSortNotification,
          ),
        ],
      ),
    );
  }

  Widget _buildTab({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    bool showDot = false
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Icon(icon, color: const Color(0xFF4A5568), size: 26),
              if (showDot)
                Positioned(
                  top: -2,
                  right: -2,
                  child: Container(
                    height: 8,
                    width: 8,
                    decoration: BoxDecoration(
                      color: const Color(0xffF73130),
                      shape: BoxShape.circle,
                    ),
                  ),
                )
            ],
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(
              fontSize: 11,
              color: Color(0xFF4A5568),
              fontWeight: FontWeight.w500,
            ),
          )
        ],
      ),
    );
  }
}