import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PopularAddOnsSection extends StatefulWidget {
  const PopularAddOnsSection({super.key});

  @override
  State<PopularAddOnsSection> createState() => _PopularAddOnsSectionState();
}

class _PopularAddOnsSectionState extends State<PopularAddOnsSection> {
  List<bool> isSelected = [false, false];

  final List<Map<String, dynamic>> cardData = [
    {
      'title': 'Xpress Ahead',
      'route': 'DEL-BOM',
      'description':
      'Priority Check-in + Priority Boarding + Priority Baggage ₹ 450 / Guest',
      'icon': Icons.flight_takeoff,
      'image':
      'https://flight.easemytrip.com/Content/AirlineLogon/IX.png',
    },
    {
      'title': 'Free Medical Refund Policy',
      'route': null,
      'description':
      'Get full airline refund, if you cancel tickets due to illness or sickness.',
      'icon': Icons.medical_services,
      'image':
      'https://cdn-icons-png.flaticon.com/512/3209/3209265.png',
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(cardData.length, (index) {
        final String title = cardData[index]['title'] as String;
        final String? route = cardData[index]['route'] as String?;
        final String description = cardData[index]['description'] as String;
        final IconData icon = cardData[index]['icon'] as IconData;
        final String image = cardData[index]['image'] as String;

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Container(
            decoration: BoxDecoration(
              color: Color(0xFFEAF6FF),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.blue.shade100),
            ),
            padding: EdgeInsets.all(12),
            child: Row(
              children: [
                // Left text block
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (route != null)
                        Text(
                          route,
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Colors.blue.shade900,
                          ),
                        ),
                      Row(
                        children: [
                          Icon(icon, color: Colors.blue, size: 20),
                          SizedBox(width: 6),
                          Text(
                            title,
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 4),
                      Text(
                        description,
                        style: GoogleFonts.poppins(fontSize: 13),
                      ),
                      SizedBox(height: 8),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            isSelected[index] = !isSelected[index];
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: isSelected[index]
                              ? Colors.red
                              : Colors.blue,
                          backgroundColor: Colors.white,
                          side: BorderSide(
                            color: isSelected[index]
                                ? Colors.red
                                : Colors.blue,
                          ),
                          padding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 6),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          elevation: 0,
                        ),
                        child: Text(
                          isSelected[index] ? 'Remove' : 'Add',
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // Right image
                Image.network(
                  image,
                  width: 60,
                  height: 60,
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
