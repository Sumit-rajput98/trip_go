import 'package:flutter/material.dart';
import 'package:trip_go/constants.dart';

class StatusTabs extends StatelessWidget {
  final List<String> tabs;
  final int selectedIndex;
  final Function(int) onTabSelected;

  const StatusTabs({
    super.key,
    required this.tabs,
    required this.selectedIndex,
    required this.onTabSelected,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: List.generate(tabs.length, (index) {
          bool isSelected = selectedIndex == index;
          return GestureDetector(
            onTap: () => onTabSelected(index),
            child: Container(
              margin: EdgeInsets.only(right: 10, top: 10),
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              decoration: BoxDecoration(
                color: isSelected
                    ? constants.ultraLightThemeColor1
                    : Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: isSelected
                      ? constants.themeColor1
                      : Colors.grey.shade300,
                  width: 1,
                ),
              ),
              child: Text(
                tabs[index],
                style: TextStyle(
                  fontSize: 13,
                  fontFamily: 'poppins',
                  fontWeight: FontWeight.w500,
                  color: isSelected ? constants.themeColor1 : Colors.black,
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
