import 'package:flutter/material.dart';
import '../../../../../constants.dart';
import 'bus_sort_type.dart' as sort;

class BusFilterHeader extends StatelessWidget {
  final double screenWidth;
  final double screenHeight;
  final Function(sort.BusSortType) onSortSelected;
  final sort.BusSortType selectedSortType;
  final sort.SortOrder sortOrder;

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
    final List<Map<String, dynamic>> sortOptions = [
      {"label": "DEPARTURE", "type": sort.BusSortType.departure},
      {"label": "DURATION", "type": sort.BusSortType.duration},
      {"label": "PRICE", "type": sort.BusSortType.price},
    ];

    return Container(
      color: constants.ultraLightThemeColor1,
      height: screenHeight * 0.06,
      child: Row(
        children: sortOptions.map((option) {
          final label = option["label"];
          final type = option["type"];
          final bool isSelected = selectedSortType == type;
          final IconData arrowIcon = isSelected
              ? (sortOrder == sort.SortOrder.ascending
              ? Icons.arrow_upward
              : Icons.arrow_downward)
              : Icons.unfold_more;

          return Expanded(
            child: GestureDetector(
              onTap: () => onSortSelected(type),
              child: Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: isSelected ? constants.themeColor1 : Colors.transparent,
                      width: 2,
                    ),
                  ),
                ),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        label,
                        style: TextStyle(
                          fontSize: screenWidth * 0.035,
                          color: isSelected ? constants.themeColor1 : constants.lightThemeColor1,
                          fontWeight: isSelected ? FontWeight.bold : FontWeight.w600,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Icon(
                        arrowIcon,
                        size: 16,
                        color: constants.themeColor1,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
