import 'package:flutter/material.dart';
import 'package:trip_go/constants.dart';

class SpecialOffersScrollWidget extends StatelessWidget {
  final Function(String) onOfferTapped;
  final String selectedOffer;

  const SpecialOffersScrollWidget({super.key, required this.onOfferTapped, required this.selectedOffer});

  @override
  Widget build(BuildContext context) {
    final List<String> offersLabels = [
      'Top Offers',
      'Flights',
      'Hotels',
      'Buses',
    ];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(offersLabels.length, (index) {
          bool isSelected = offersLabels[index] == selectedOffer; // Check if it's the selected offer
          return GestureDetector(
            onTap: () => onOfferTapped(offersLabels[index]), // Pass the tapped offer to the parent
            child: Container(
              width: 100,
              height: 50,
              margin: const EdgeInsets.only(right: 12),
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: Colors.white, // Highlight selected box
                border: Border.all(
                  color: isSelected ? constants.themeColor1: Colors.grey.shade200, // Change border color for selected
                  width: 1.5,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text(
                  offersLabels[index],
                  style: TextStyle(
                    fontSize: 12,
                    color: isSelected ? constants.themeColor1: Colors.black, // Change text color for selected
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Poppins',
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
