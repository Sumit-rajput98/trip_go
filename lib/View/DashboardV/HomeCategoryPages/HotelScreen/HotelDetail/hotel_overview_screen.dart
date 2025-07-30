import 'dart:convert';
import 'package:html/parser.dart' as html_parser;
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../Model/HotelM/hotel_detail_data.dart';

class HotelOverviewScreen extends StatefulWidget {
  final Hotel1 hotel;
  final GlobalKey? k;

  const HotelOverviewScreen({
    super.key,
    required this.hotel, this.k,
  });

  @override
  State<HotelOverviewScreen> createState() => _HotelOverviewScreenState();
}

class _HotelOverviewScreenState extends State<HotelOverviewScreen> {
  bool isExpanded = false;

  static const Color themeColor1 = Color(0xff1B499F);
  List<Map<String, String>> parsedAmenities = [];
  List<Map<String, String>> dynamicLandmarks = [];

  bool _isSimilar(String a, String b) {
    a = a.toLowerCase();
    b = b.toLowerCase();

    // Remove punctuation and compare if similarity > 0.6
    a = a.replaceAll(RegExp(r'[^a-z0-9 ]'), '');
    b = b.replaceAll(RegExp(r'[^a-z0-9 ]'), '');

    final aWords = a.split(' ');
    final bWords = b.split(' ');

    int matches = aWords.where((word) => bWords.contains(word)).length;

    double similarity = matches / ((aWords.length + bWords.length) / 2);

    return similarity > 0.5;
  }


  @override
  void initState() {
    super.initState();

    try {
      final decoded = widget.hotel.ameneties ?? [];
      if (decoded is List) {
        final List<String> amenityNames = decoded.map((e) => e.toString().toLowerCase()).toList();

        parsedAmenities = _amenities.where((a) {
          final amenityName = a['name']!.toLowerCase();
          return amenityNames.any((entry) =>
          entry.contains(amenityName) ||
              amenityName.contains(entry) ||
              _isSimilar(entry, amenityName));
        }).toList();
      }
    } catch (_) {
      parsedAmenities = [];
    }

    try {
      final rawAttractions = widget.hotel.attractions ?? '';
      final decoded = jsonDecode(rawAttractions);

      if (decoded is Map) {
        final content = decoded.values.first.toString();

        // Remove all HTML tags
        final plainText = content.replaceAll(RegExp(r'<[^>]*>'), '');

        // Split by "<br />" or just new lines
        final lines = plainText.split(RegExp(r'(?:\\n|<br\s*/?>)')).expand((line) => line.split('<br />')).toList();

        for (final line in lines) {
          final trimmed = line.trim();
          if (trimmed.contains('-')) {
            final parts = trimmed.split('-');
            if (parts.length >= 2) {
              dynamicLandmarks.add({
                'name': parts[0].trim(),
                'distance': parts[1].trim(),
              });
            }
          }
        }
      }
    } catch (_) {
      dynamicLandmarks = [];
    }
  }


  @override
  Widget build(BuildContext context) {
    final titleStyle = GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w600);
    final contentStyle = GoogleFonts.poppins(fontSize: 13);
    final linkStyle = GoogleFonts.poppins(color: themeColor1, fontSize: 13, fontWeight: FontWeight.w500);

    String cleanDescription = html_parser.parse(widget.hotel.description ?? '').body?.text ?? '';

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Hotel Overview
          _buildCard(
            title: "Hotel Overview",
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  isExpanded
                      ? cleanDescription
                      : (cleanDescription.length > 200 ? cleanDescription.substring(0, 200) + '...' : cleanDescription),
                  style: contentStyle,
                ),
                const SizedBox(height: 8),
                if (cleanDescription.length > 200)
                  GestureDetector(
                    onTap: () => setState(() => isExpanded = !isExpanded),
                    child: Text(isExpanded ? "View Less" : "View More...", style: linkStyle),
                  ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          /// Amenities
          if (parsedAmenities.isNotEmpty)
            _buildCard(
              title: "Amenities",
              child: Column(
                children: List.generate(
                  (parsedAmenities.length / 2).ceil(),
                      (rowIndex) {
                    final start = rowIndex * 2;
                    final end = (start + 2).clamp(0, parsedAmenities.length);
                    final rowItems = parsedAmenities.sublist(start, end);

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: Row(
                        children: rowItems.map((item) {
                          return Expanded(
                            child: Column(
                              children: [
                                SvgPicture.network(
                                  item['icon']!,
                                  height: 26,
                                  color: themeColor1,
                                  placeholderBuilder: (_) =>
                                  const CircularProgressIndicator(strokeWidth: 1),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  item['name']!,
                                  style: GoogleFonts.poppins(fontSize: 11),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    );
                  },
                ),
              ),
            ),

          const SizedBox(height: 16),

          /// Location & Landmarks
          _buildCard(
            k: widget.k,
            title: "Location",
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    "https://www.google.com/maps/d/thumbnail?mid=1zGPJKJUKmNwkwKaOFlItglzDkcc",
                    height: 180,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(
                      height: 180,
                      color: Colors.grey.shade300,
                      child: const Icon(Icons.map, size: 40, color: Colors.grey),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Text("Key Landmarks", style: titleStyle),
                const SizedBox(height: 8),

                /// Dynamically parsed landmarks from API
                SizedBox(
                  height: 220,
                  child: ListView.builder(
                    itemCount: dynamicLandmarks.length,
                    itemBuilder: (context, index) {
                      final landmark = dynamicLandmarks[index];

                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Icon(Icons.location_on, size: 16, color: Colors.grey),
                            const SizedBox(width: 6),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    landmark['name'] ?? '',
                                    style: contentStyle,
                                    softWrap: true,
                                    overflow: TextOverflow.visible,
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    landmark['distance'] ?? '',
                                    style: GoogleFonts.poppins(
                                      color: themeColor1,
                                      fontSize: 13,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),

        ],
      ),
    );
  }

  Widget _buildCard({required String title, required Widget child, GlobalKey? k}) {
    return Container(
      key: k,
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.05),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w600)),
          const SizedBox(height: 10),
          child,
        ],
      ),
    );
  }
}

/// Amenity List with Icons
final List<Map<String, String>> _amenities = [
  {"name": "Coffee Shop", "icon": "https://www.easemytrip.com/hotels/img/amenities/Coffee-Shop.svg"},
  {"name": "Restaurant", "icon": "https://www.easemytrip.com/hotels/img/amenities/Restaurant.svg"},
  {"name": "Conference Hall", "icon": "https://www.easemytrip.com/hotels/img/amenities/Conference-Hall.svg"},
  {"name": "Front Desk", "icon": "https://www.easemytrip.com/hotels/img/amenities/Front-Desk.svg"},
  {"name": "Newspaper in Lobby", "icon": "https://www.easemytrip.com/hotels/img/amenities/Newspaper-in%20lobby.svg"},
  {"name": "Wake-up Service", "icon": "https://www.easemytrip.com/hotels/img/amenities/Wake-up-service.svg"},
  {"name": "Central AC", "icon": "https://www.easemytrip.com/hotels/img/amenities/Central-AC.svg"},
  {"name": "Laundry", "icon": "https://www.easemytrip.com/hotels/img/amenities/Laundry.svg"},
  {"name": "Free Toiletries", "icon": "https://www.easemytrip.com/hotels/img/amenities/Free-Toiletries.svg"},
  {"name": "24 Hrs Backup", "icon": "https://www.easemytrip.com/hotels/img/amenities/24-Hrs%20Electricity%20Backup.svg"},
];

/// Sample Landmarks
final List<Map<String, String>> _landmarks = [
  {"name": "Jantar Mantar", "distance": "0.94 Km"},
  {"name": "Shankars International Dolls Museum", "distance": "1.51 Km"},
  {"name": "India Gate", "distance": "1.84 Km"},
  {"name": "National Museum", "distance": "2.08 Km"},
  {"name": "National Gandhi Museum", "distance": "2.26 Km"},
  {"name": "National Crafts Museum", "distance": "2.42 Km"},
];
