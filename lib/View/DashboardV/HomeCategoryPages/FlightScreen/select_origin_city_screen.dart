import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:trip_go/Model/FlightM/search_city_model.dart';
import '../../../../ViewM/FlightVM/select_city_view_model.dart';

class SelectOriginCityScreen extends StatefulWidget {
  const SelectOriginCityScreen({super.key});

  @override
  State<SelectOriginCityScreen> createState() => _SelectOriginCityScreenState();
}

class _SelectOriginCityScreenState extends State<SelectOriginCityScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> filteredCities = [];

  @override
  void initState() {
    super.initState();
    // Load cities when screen initializes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<SelectCityViewModel>().loadCities();
    });
    _searchController.addListener(_filterCities);
  }

  void _filterCities() {
    final vm = context.read<SelectCityViewModel>();
    String query = _searchController.text.toLowerCase();

    setState(() {
      if (query.isEmpty) {
        filteredCities = [];
      } else {
        filteredCities = (vm.cities as List<Datum>)
            .where((city) {
          return (city.cityname?.toLowerCase().contains(query) ?? false) ||
              (city.countryname?.toLowerCase().contains(query) ?? false) ||
              (city.airportcode.toLowerCase().contains(query));
        })
            .map((city) {
          return {
            'city': city.cityname ?? '',
            'country': city.countryname ?? '',
            'code': city.airportcode,
          };
        })
            .toList();
      }
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
      body: Consumer<SelectCityViewModel>(
        builder: (context, vm, _) {
          // Handle loading state
          if (vm.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          // Handle error state
          if (vm.error != null) {
            return Center(child: Text(vm.error!));
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header with Search
              Container(
                padding: const EdgeInsets.only(
                  top: 50,
                  left: 16,
                  right: 16,
                  bottom: 24,
                ),
                decoration: BoxDecoration(color: const Color(0xFF2d3290)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () => Navigator.pop(context),
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
                        prefixIcon: const Icon(
                          Icons.search,
                          color: Colors.grey,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Show results only when there's a search query
              if (_searchController.text.isNotEmpty)
                Expanded(
                  child: ListView.builder(
                    itemCount: filteredCities.length,
                    itemBuilder: (context, index) {
                      final city = filteredCities[index];
                      return ListTile(
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 2,
                        ),
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
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
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
                        onTap: () => Navigator.pop(context, city),
                      );
                    },
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
