import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../constants.dart';

class SelectOriginCityScreen extends StatefulWidget {
  const SelectOriginCityScreen({super.key});

  @override
  State<SelectOriginCityScreen> createState() => _SelectOriginCityScreenState();
}

class _SelectOriginCityScreenState extends State<SelectOriginCityScreen> {


  final TextEditingController _searchController = TextEditingController();

  List<Map<String, String>> allCities = [
    {'city': 'Mumbai', 'country': 'India', 'code': 'BOM'},
    {'city': 'Delhi', 'country': 'India', 'code': 'DEL'},
    {'city': 'Bangalore', 'country': 'India', 'code': 'BLR'},
    {'city': 'New York', 'country': 'USA', 'code': 'NYC'},
    {'city': 'London', 'country': 'UK', 'code': 'LON'},
    {'city': 'Tokyo', 'country': 'Japan', 'code': 'TYO'},
    {'city': 'Paris', 'country': 'France', 'code': 'PAR'},
    {'city': 'Dubai', 'country': 'UAE', 'code': 'DXB'},
  ];

  List<Map<String, String>> filteredCities = [];

  @override
  void initState() {
    super.initState();
    filteredCities = [];
    _searchController.addListener(_filterCities);
  }

  void _filterCities() {
    String query = _searchController.text.toLowerCase();
    setState(() {
      filteredCities = allCities.where((city) {
        return city['city']!.toLowerCase().contains(query) ||
            city['country']!.toLowerCase().contains(query);
      }).toList();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with Search
          Container(
            padding: const EdgeInsets.only(top: 50, left: 16, right: 16, bottom: 24),
            decoration: BoxDecoration(
              color: constants.themeColor1,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      "Select Origin City",
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: 'Enter city or airport name',
                    hintStyle: GoogleFonts.poppins(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                    prefixIcon: const Icon(Icons.search, color: Colors.grey),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Popular Cities Label
          Container(
            width: double.infinity,
            color: Color(0xFFE2E1FA),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Text(
              "POPULAR CITIES",
              style: GoogleFonts.poppins(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
                letterSpacing: 1,
              ),
            ),
          ),

          // List of Cities
          Expanded(
            child: ListView.builder(
              itemCount: filteredCities.length,
              itemBuilder: (context, index) {
                final city = filteredCities[index];
                return ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
                  title: Text(
                    '${city['city']}, ${city['country']}',
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  subtitle: Text(
                    city['city'] ?? '',
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),
                  trailing: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade400,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      city['code'] ?? '',
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  onTap: () {
                    Navigator.pop(context, city);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
