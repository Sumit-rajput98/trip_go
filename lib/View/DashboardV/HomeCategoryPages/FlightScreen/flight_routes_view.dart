import 'package:flutter/material.dart';
import 'flight_routes_data.dart';

class FlightRoutesView extends StatefulWidget {
  const FlightRoutesView({super.key});

  @override
  State<FlightRoutesView> createState() => _FlightRoutesViewState();
}

class _FlightRoutesViewState extends State<FlightRoutesView> {
  int selectedTab = 0; // 0 for Domestic, 1 for International

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10,),
            const Text(
              "Popular Flight Routes",
              style: TextStyle(
                  fontSize: 18, fontFamily: 'poppins', fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 12),

            /// Toggle Buttons for Domestic / International
            Row(
              children: [
                _buildToggleBox("Domestic Flights", 0),
                const SizedBox(width: 12),
                _buildToggleBox("International Flights", 1),
              ],
            ),
            const SizedBox(height: 16),
            /// Cards View
            if (selectedTab == 0) _buildCardList(domesticRoutes),
            if (selectedTab == 1) _buildCardList(internationalRoutes),
          ],
        ),
      ),
    );
  }

  Widget _buildToggleBox(String title, int index) {
    final isSelected = selectedTab == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => selectedTab = index),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            border: Border.all(color: isSelected ? Colors.blue : Colors.grey.shade300,),
            color: isSelected ? Colors.blue.shade50 : Colors.transparent,
            borderRadius: BorderRadius.circular(5),
          ),
          alignment: Alignment.center,
          child: Text(
            title,
            style: TextStyle(
              color: isSelected ? Colors.blue : Colors.grey,
              fontWeight: FontWeight.w500,
              fontFamily: 'poppins',
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCardList(List<Map<String, dynamic>> routes) {
    return Column(
      children: routes.map((route) {
        return Card(
          color: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          margin: const EdgeInsets.symmetric(vertical: 5),
          elevation: 2,
          child: Row(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(5),
                  bottomLeft: Radius.circular(5),
                ),
                child: Image.network(
                  route['image'],
                  height: 70,
                  width: 60,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      height: 70,
                      width: 60,
                      color: Colors.grey.shade300, // Greyish background
                      child: const Icon(Icons.image_not_supported, color: Colors.grey), // Optional: Icon inside
                    );
                  },
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8), // Reduced vertical padding
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        route['title'],
                        style: const TextStyle(
                          fontSize: 14,  // Reduced font size
                          fontWeight: FontWeight.bold,
                          fontFamily: 'poppins',
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        route['subtitle'],
                        style: const TextStyle(
                          fontSize: 10,  // Reduced font size
                          color: Colors.blue,
                          fontFamily: 'poppins',
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        );
      }).toList(),
    );
  }
}