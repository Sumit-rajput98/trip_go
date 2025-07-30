import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../AppManager/Api/api_service/BusService/bus_city_service.dart';
import '../../../../../Model/BusM/bus_city_model.dart';
import '../../../../../constants.dart';

class SearchBusCityView extends StatefulWidget {
  const SearchBusCityView({super.key});

  @override
  State<SearchBusCityView> createState() => _SearchBusCityViewState();
}

class _SearchBusCityViewState extends State<SearchBusCityView> {
  final TextEditingController _searchController = TextEditingController();

  List<BusCity> allCities = [];
  List<BusCity> filteredCities = [];

  bool isLoading = true;

  final List<String> domesticCities = [
    'Hyderabad', 'Bangalore', 'Chennai', 'Delhi', 'Mumbai', 'Goa'
  ];

  final List<String> internationalCities = [
    'Dubai', 'Singapore', 'Bangkok', 'London', 'New York'
  ];

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_filterCities);
    _fetchCities();
  }

  Future<void> _fetchCities() async {
    try {
      final cities = await BusCityService().fetchBusCities();
      setState(() {
        allCities = cities;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      // Handle error appropriately
    }
  }

  void _filterCities() {
    String query = _searchController.text.toLowerCase();
    setState(() {
      if (query.isEmpty) {
        filteredCities = [];
      } else {
        filteredCities = allCities.where((city) {
          return city.cityName.toLowerCase().contains(query);
        }).toList();

        filteredCities.sort((a, b) {
          final aName = a.cityName.toLowerCase();
          final bName = b.cityName.toLowerCase();

          final aStarts = aName.startsWith(query);
          final bStarts = bName.startsWith(query);

          if (aStarts && !bStarts) return -1;
          if (!aStarts && bStarts) return 1;

          return aName.compareTo(bName);
        });
      }
    });
  }

  Widget _buildCityChip(String cityName) {
    return InkWell(
      onTap: () {
        final matchedCity = allCities.firstWhere(
              (city) => city.cityName.toLowerCase() == cityName.toLowerCase(),
        );
        Navigator.pop(context, matchedCity);
      },
      child: Chip(
        backgroundColor: const Color(0xFFF6F6F6),
        label: Text(
          cityName,
          style: const TextStyle(
            fontFamily: 'poppins',
            fontSize: 13,
            color: Colors.black87,
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
          side: BorderSide(
            color: constants.themeColor1,
            width: 1.2,
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F6F6),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
        children: [
          // Header + Search Field
          Container(
            padding: const EdgeInsets.only(top: 50, left: 16, right: 16, bottom: 24),
            decoration: const BoxDecoration(
              color: Color(0xFF2d3290),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Back + Title
                Row(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(Icons.arrow_back, color: Colors.white),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      "Select Bus City",
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // Search Field
                TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: 'Enter city name',
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

          // Content Area
          Expanded(
            child: _searchController.text.isNotEmpty
                ? filteredCities.isEmpty
                ? const Center(child: Text("No cities found"))
                : ListView.builder(
              itemCount: filteredCities.length,
              itemBuilder: (context, index) {
                final city = filteredCities[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                  child: InkWell(
                    onTap: () => Navigator.pop(context, city),
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.15),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                      child: Row(
                        children: [
                          const Icon(Icons.location_city, color: Colors.grey),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Text(
                              city.cityName,
                              style: GoogleFonts.poppins(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            )
                : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Popular Stations",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        fontFamily: 'poppins',
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: domesticCities.map(_buildCityChip).toList(),
                    ),
                    const Divider(height: 30),
                    // const Text(
                    //   "Popular Search In International",
                    //   style: TextStyle(
                    //     fontWeight: FontWeight.w600,
                    //     fontSize: 14,
                    //     fontFamily: 'poppins',
                    //     color: Colors.black87,
                    //   ),
                    // ),
                    // const SizedBox(height: 10),
                    // Wrap(
                    //   spacing: 8,
                    //   runSpacing: 8,
                    //   children: internationalCities.map(_buildCityChip).toList(),
                    // ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
