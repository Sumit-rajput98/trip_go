import 'package:flutter/material.dart';

import '../bus_enums.dart';

class BusFilterHeader extends StatelessWidget {
  final double screenWidth;
  final double screenHeight;
  final Function(BusSortType) onSortSelected;
  final BusSortType selectedSortType;
  final SortOrder sortOrder;

  const BusFilterHeader({
    super.key,
    required this.screenWidth,
    required this.screenHeight,
    required this.onSortSelected,
    required this.selectedSortType,
    required this.sortOrder,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: BusSortType.values.map((type) {
          final isSelected = selectedSortType == type;
          return GestureDetector(
            onTap: () => onSortSelected(type),
            child: Container(
              margin: const EdgeInsets.only(right: 8),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                color: isSelected ? Colors.blue : Colors.grey.shade200,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                _getSortTypeText(type),
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontFamily: 'poppins',
                  fontSize: 13,
                  color: isSelected ? Colors.white : Colors.black87,
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  String _getSortTypeText(BusSortType type) {
    switch (type) {
      case BusSortType.departure:
        return "Departure";
      case BusSortType.duration:
        return "Duration";
      case BusSortType.price:
        return "Price";
      default:
        return "Sort";
    }
  }
}
