import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../constants.dart';

class SearchCabCityView extends StatefulWidget {
  const SearchCabCityView({super.key});

  @override
  State<SearchCabCityView> createState() => _SearchCabCityViewState();
}

class _SearchCabCityViewState extends State<SearchCabCityView> {
  final TextEditingController _searchController = TextEditingController();

  final List<Map<String, String>> allCities = [
    {'city': 'New Delhi Railway Station', 'state': 'Delhi', 'code': 'NDLS'},
    {'city': 'Mumbai', 'state': 'Maharashtra', 'code': 'BOM'},
    {'city': 'Bangalore', 'state': 'Karnataka', 'code': 'BLR'},
    {'city': 'Hyderabad', 'state': 'Telangana', 'code': 'HYD'},
    {'city': 'Chennai', 'state': 'Tamil Nadu', 'code': 'MAA'},
    {'city': 'Pune', 'state': 'Maharashtra', 'code': 'PNQ'},
    {'city': 'Goa', 'state': 'Goa', 'code': 'GOI'},
    {'city': 'Jaipur', 'state': 'Rajasthan', 'code': 'JAI'},
    {'city': 'Kolkata', 'state': 'West Bengal', 'code': 'CCU'},
    {'city': 'Lucknow', 'state': 'Uttar Pradesh', 'code': 'LKO'},
    {'city': 'Indira Gandhi International Airport', 'state': 'Delhi', 'code': 'DEL'},
    {'city': 'Manali', 'state': 'Himachal Pradesh', 'code': 'MAN'},
    {'city': 'Amritsar', 'state': 'Punjab', 'code': 'ATQ'},
    {'city': 'Chandigarh', 'state': 'Punjab', 'code': 'IXC'},
    {'city': 'Bhopal', 'state': 'Madhya Pradesh', 'code': 'BHO'},
    {'city': 'Indore', 'state': 'Madhya Pradesh', 'code': 'IDR'},
    {'city': 'Nagpur', 'state': 'Maharashtra', 'code': 'NAG'},
    {'city': 'Coimbatore', 'state': 'Tamil Nadu', 'code': 'CJB'},
    {'city': 'Tirupati', 'state': 'Andhra Pradesh', 'code': 'TIR'},
    {'city': 'Patna', 'state': 'Bihar', 'code': 'PAT'},
  ];

  final List<Map<String, String>> domesticCities = [
    {'city': 'New Delhi Railway Station', 'state': 'Delhi', 'code': 'NDLS'},
    {'city': 'Indira Gandhi International Airport', 'state': 'Delhi', 'code': 'DEL'},
    {'city': 'Noida Sector 62', 'state': 'Uttar Pradesh', 'code': 'ND62'},
    {'city': 'Gurgaon Cyber City', 'state': 'Haryana', 'code': 'GGC'},
  ];

  final List<Map<String, String>> internationalCities = [
    {'city': 'IGI Terminal 3', 'state': 'Delhi', 'code': 'T3'},
    {'city': 'Delhi Airport Metro', 'state': 'Delhi', 'code': 'DAM'},
    {'city': 'Ambience Mall Gurgaon', 'state': 'Haryana', 'code': 'AMG'},
    {'city': 'Connaught Place', 'state': 'Delhi', 'code': 'CP'},
  ];

  List<Map<String, String>> filteredCities = [];

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_filterCities);
  }

  void _filterCities() {
    String query = _searchController.text.toLowerCase();
    setState(() {
      if (query.isEmpty) {
        filteredCities = [];
      } else {
        filteredCities = allCities.where((city) {
          return (city['city']!.toLowerCase().contains(query) ||
              city['state']!.toLowerCase().contains(query));
        }).toList();
      }
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Widget _buildCityChip(Map<String, String> city) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
      child: ActionChip(
        label: Text(
          city['city']!,
          style: TextStyle(fontSize: 10, fontFamily: 'poppins', color: constants.themeColor1),
        ),
        onPressed: () => Navigator.pop(context, city),
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: BorderSide(color: constants.themeColor1), // 🔵 Blue border added here
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          /// Header + Search Field
          Container(
            padding: const EdgeInsets.only(top: 50, left: 16, right: 16, bottom: 24),
            decoration: const BoxDecoration(
              color: Color(0xFF2d3290),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Back + Title
                Row(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(Icons.arrow_back, color: Colors.white),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      "Select Cab Location",
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                /// Search Field
                TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: 'Enter city or airport',
                    hintStyle: GoogleFonts.poppins(fontSize: 14, color: Colors.grey),
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

          /// City List or Popular Chips
          Expanded(
            child: _searchController.text.isEmpty || _searchController.text.length < 3
                ? SingleChildScrollView(
              padding: const EdgeInsets.all(12),
              child: Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Popular Search In Domestic",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                          fontFamily: 'poppins',
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Wrap(
                        children: domesticCities.map(_buildCityChip).toList(),
                      ),
                      const Divider(height: 30),
                      const Text(
                        "Popular Search In International",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                          fontFamily: 'poppins',
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Wrap(
                        children: internationalCities.map(_buildCityChip).toList(),
                      ),
                    ],
                  ),
                ),
              ),
            )
                : ListView.builder(
              itemCount: filteredCities.length,
              itemBuilder: (context, index) {
                final city = filteredCities[index];
                return ListTile(
                  contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                  title: Text(
                    "${city['city']}, ${city['state']}",
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                    ),
                  ),
                  subtitle: Text(
                    city['state']!,
                    style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey),
                  ),
                  trailing: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade400,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      city['code']!,
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  onTap: () => Navigator.pop(context, city),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
