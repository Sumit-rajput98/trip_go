import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:trip_go/AppManager/Api/api_service/api_call.dart';
import 'package:trip_go/AppManager/Api/api_service/api_constant.dart';
import '../../../../../AppManager/Api/api_service/BusService/bus_city_service.dart';
import '../../../../../Model/BusM/bus_city_model.dart';
import 'bus_search_view.dart';

class PopularBusDestinatoins extends StatefulWidget {
  const PopularBusDestinatoins({super.key});

  @override
  State<PopularBusDestinatoins> createState() => _PopularBusDestinationsState();
}

class _PopularBusDestinationsState extends State<PopularBusDestinatoins> {
  int selectedIndex = -1;
  List<BusCity> allCities = [];
  bool isLoading = true;
  bool isNavigating = false;

  final List<Map<String, String>> routes = [
    {
      "image": "https://www.easemytrip.com/images/hotel-img/mumb-sm.webp",
      "title": "Bangalore Buses",
      "subtitle": "To: Hyderabad · Mumbai · Goa · Chennai · Pune"
    },
    {
      "image": "https://www.easemytrip.com/images/hotel-img/hyd-sm.webp",
      "title": "Hyderabad Buses",
      "subtitle": "To: Bangalore · Mumbai · Goa · Chennai · Pune"
    },
    {
      "image": "https://www.easemytrip.com/images/hotel-img/pune-sm.webp",
      "title": "Pune Buses",
      "subtitle": "To: Bangalore · Goa · Indore · Nagpur · Hyderabad"
    },
    {
      "image": "https://www.easemytrip.com/images/hotel-img/chennai-sm.webp",
      "title": "Chennai Buses",
      "subtitle": "To: Bangalore · Coimbatore · Hyderabad · Madurai · Tirunelveli"
    },
    {
      "image": "https://images.emtcontent.com/hotel-img/del-sm.webp",
      "title": "Delhi Buses",
      "subtitle": "To: Manali · Jaipur · Amritsar · Lucknow · Shimla"
    },
  ];

  @override
  void initState() {
    super.initState();
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
      setState(() => isLoading = false);
      debugPrint('Error fetching cities: $e');
    }
  }

  String _extractCityNameFromTitle(String title) {
    return title.replaceAll(' Buses', '').trim();
  }

  List<String> _extractCityListFromSubtitle(String subtitle) {
    final match = RegExp(r'To: (.+)').firstMatch(subtitle);
    if (match != null) {
      return match.group(1)!.split('·').map((c) => c.trim()).toList();
    }
    return [];
  }

  void _handleCityTap(String from, String to) async {
    final fromMatch = allCities.firstWhere(
          (city) => city.cityName.toLowerCase() == from.toLowerCase(),
      orElse: () => BusCity(id: 0, cityId: '0', cityName: ''),
    );

    final toMatch = allCities.firstWhere(
          (city) => city.cityName.toLowerCase() == to.toLowerCase(),
      orElse: () => BusCity(id: 0, cityId: '0', cityName: ''),
    );

    if (fromMatch.cityId != '0' && toMatch.cityId != '0') {
      final travelDate = DateTime.now().add(const Duration(days: 1));

      setState(() => isNavigating = true); // 🔹 Show loading

      await Future.delayed(const Duration(milliseconds: 300)); // Optional: Simulate short delay

      if (mounted) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => BusSearchView(
              fromCity: from,
              toCity: to,
              originId: fromMatch.cityId,
              destinationId: toMatch.cityId,
              travelDate: travelDate,
            ),
          ),
        ).then((_) {
          // 🔹 Reset loading after navigation back
          if (mounted) setState(() => isNavigating = false);
        });
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("City ID not found")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.all(15),
          child: Text(
            "Popular Bus Routes",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              fontFamily: 'poppins',
            ),
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: routes.length,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          itemBuilder: (context, index) {
            final route = routes[index];
            final fromCity = _extractCityNameFromTitle(route['title']!);
            final toCities = _extractCityListFromSubtitle(route['subtitle']!);

            return Card(
              color: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              margin: const EdgeInsets.only(bottom: 12),
              elevation: 2,
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(8),
                      bottomLeft: Radius.circular(8),
                    ),
                    child: Image.network(
                      route['image']!,
                      height: 70,
                      width: 60,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            route['title']!,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'poppins',
                            ),
                          ),
                          const SizedBox(height: 4),
                          RichText(
                            text: TextSpan(
                              children: [
                                const TextSpan(
                                  text: "To: ",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.black,
                                    fontFamily: 'poppins',
                                  ),
                                ),
                                ...toCities.map((city) {
                                  return TextSpan(
                                    text: "$city   ",
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: Colors.blue,
                                      fontFamily: 'poppins',
                                      decoration: TextDecoration.underline,
                                    ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        _handleCityTap(fromCity, city);
                                      },
                                  );
                                }).toList(),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
