import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trip_go/ViewM/HotelVM/hotel_city_search_view_model.dart';
import 'package:trip_go/Model/HotelM/hotel_city_search_model.dart';

class CitySearchPage extends StatefulWidget {
  const CitySearchPage({super.key});

  @override
  State<CitySearchPage> createState() => _CitySearchPageState();
}

class _CitySearchPageState extends State<CitySearchPage> {
  final TextEditingController _controller = TextEditingController();
  Timer? _debounce;

  final List<String> domesticCities = [
    "Delhi",
    "Pune",
    "Ahmedabad",
    "Mumbai",
    "Bangalore",
    "Jaipur",
    "Agra",
    "Hyderabad",
  ];

  final List<String> internationalCities = [
    "Dubai",
    "Abu Dhabi",
    "Singapore",
    "Bangkok",
  ];

  @override
  void dispose() {
    _debounce?.cancel();
    _controller.dispose();
    super.dispose();
  }

  void _onSearchChanged(BuildContext context, String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 400), () {
      if (query.length >= 3) {
        Provider.of<HotelCitySearchViewModel>(
          context,
          listen: false,
        ).searchCity(query);
      }
      // Do not call API if less than 3 chars, and do not call with empty string
    });
  }

  Widget _buildResultTile(Datum datum) {
    String type = "city";
    IconData icon = Icons.location_city;
    Color accent = const Color(0xFF1B499F);
    if ((datum.cityName ?? "").toLowerCase().contains("station") ||
        (datum.cityName ?? "").toLowerCase().contains("airport")) {
      type = "poi";
      icon = Icons.place_outlined;
      accent = Colors.deepPurple;
    } else if ((datum.cityName ?? "").toLowerCase().contains("road") ||
        (datum.cityName ?? "").toLowerCase().contains("nagar") ||
        (datum.cityName ?? "").toLowerCase().contains("area")) {
      type = "area";
      icon = Icons.map_outlined;
      accent = Colors.orange;
    }
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
        border: Border(left: BorderSide(color: accent, width: 5)),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 16,
        ),
        leading: Container(
          decoration: BoxDecoration(
            color: accent.withOpacity(0.13),
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.all(8),
          child: Icon(icon, color: accent, size: 28),
        ),
        title: Row(
          children: [
            Expanded(
              child: Text(
                datum.cityName ?? '',
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: accent.withOpacity(0.09),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                type,
                style: TextStyle(
                  fontSize: 11,
                  color: accent,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.2,
                ),
              ),
            ),
          ],
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (datum.countryName != null && datum.countryName!.isNotEmpty)
              Text(
                datum.countryName! +
                    (datum.countryCode != null ? ", ${datum.countryCode}" : ""),
                style: const TextStyle(fontSize: 13, color: Colors.black54),
              ),
          ],
        ),
        onTap: () {
          Navigator.pop(context, datum.cityName ?? '');
        },
      ),
    );
  }

  Widget _buildCityChip(String name) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 6),
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          side: const BorderSide(color: Color(0xFF1B499F)),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        ),
        onPressed: () {
          Navigator.pop(context, name);
        },
        child: Text(
          name,
          style: const TextStyle(
            color: Color(0xFF1B499F),
            fontFamily: 'poppins',
            fontSize: 13,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => HotelCitySearchViewModel(),
      child: Consumer<HotelCitySearchViewModel>(
        builder: (context, vm, _) {
          final isSearching = _controller.text.length >= 3;
          final isEmpty = _controller.text.isEmpty;
          return Scaffold(
            backgroundColor: const Color(0xFFEFF7FF),
            body: Column(
              children: [
                // Top blue area with elevated white text field
                Container(
                  width: double.infinity,
                  color: const Color(0xFF1B499F),
                  padding: const EdgeInsets.only(
                    left: 12,
                    right: 12,
                    top: 40,
                    bottom: 16,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Row(
                      children: [
                        const Icon(Icons.location_on, color: Color(0xFF1B499F)),
                        const SizedBox(width: 8),
                        Expanded(
                          child: TextField(
                            controller: _controller,
                            onChanged: (q) => _onSearchChanged(context, q),
                            style: const TextStyle(color: Colors.black),
                            decoration: const InputDecoration(
                              hintText: "Enter City/Location/Hotel Name",
                              hintStyle: TextStyle(color: Colors.black54),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        if (_controller.text.isNotEmpty)
                          IconButton(
                            icon: const Icon(
                              Icons.clear,
                              color: Colors.black45,
                            ),
                            onPressed: () {
                              _controller.clear();
                              // Do not call API with empty string
                              setState(() {});
                            },
                          ),
                      ],
                    ),
                  ),
                ),
                // Content section
                Expanded(
                  child:
                      isEmpty || _controller.text.length < 3
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
                                      children:
                                          domesticCities
                                              .map(_buildCityChip)
                                              .toList(),
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
                                      children:
                                          internationalCities
                                              .map(_buildCityChip)
                                              .toList(),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                          : (vm.isLoading
                              ? const Center(child: CircularProgressIndicator())
                              : (vm.result != null &&
                                      vm.result!.data != null &&
                                      vm.result!.data!.isNotEmpty
                                  ? ListView.builder(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 8,
                                      horizontal: 8,
                                    ),
                                    itemCount: vm.result!.data!.length,
                                    itemBuilder:
                                        (_, index) => _buildResultTile(
                                          vm.result!.data![index],
                                        ),
                                  )
                                  : Center(
                                    child: Text(
                                      vm.error != null && vm.error!.isNotEmpty
                                          ? 'Error: ${vm.error}'
                                          : 'No results found',
                                      style: const TextStyle(
                                        fontSize: 16,
                                        color: Colors.black54,
                                      ),
                                    ),
                                  ))),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
