import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../Model/FlightM/flight_search_model.dart';
import '../../../../ViewM/FlightVM/flight_search_view_model.dart';
import 'flight_list_screen.dart';
import 'flight_routes_data.dart';

class FlightRoutesView extends StatefulWidget {
  const FlightRoutesView({super.key});

  @override
  State<FlightRoutesView> createState() => _FlightRoutesViewState();
}

class _FlightRoutesViewState extends State<FlightRoutesView> {
  int selectedTab = 0; // 0 for Domestic, 1 for International

  String _extractCityNameFromTitle(String title) {
    return title.replaceAll(' Flights', '').trim();
  }

  List<String> _extractCityListFromSubtitle(String subtitle) {
    final regex = RegExp(r'(To|From): (.+)');
    final match = regex.firstMatch(subtitle);
    if (match != null) {
      final citiesString = match.group(2) ?? '';
      return citiesString.split('·').map((c) => c.trim()).toList();
    }
    return [];
  }

  void _handleCityTap(String from, String to) {
    if (from == to) {
      setState(() {
        // show some error
      });
      return;
    }

    final fromCity = {'city': from, 'code': _getCityCode(from)};
    final toCity = {'city': to, 'code': _getCityCode(to)};

    final formattedDepartureDate = DateTime.now().add(const Duration(days: 1)).toString().split(' ')[0];

    final request = FlightSearchRequest(
      origin: fromCity['code'],
      destination: toCity['code'],
      departureDate: formattedDepartureDate,
      adult: 1,
      child: 0,
      infant: 0,
      type: 1,
      cabin: 1,
      tboToken: '',
      partocrsSession: '',
    );

    final viewModel = Provider.of<FlightSearchViewModel>(context, listen: false);
    viewModel.searchFlights(request).then((_) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => FlightListScreen(
            adultCount: 1,
            flightSearchResponse: viewModel.flightSearchResponse!,
            departureDate: DateTime.now().add(const Duration(days: 1)),
            fromCity: fromCity['city']!,
            toCity: toCity['city']!,
          ),
        ),
      );
    });
  }


// Dummy city code lookup
  String _getCityCode(String cityName) {
    const Map<String, String> cityCodeMap = {
      'Mumbai': 'BOM',
      'Delhi': 'DEL',
      'Goa': 'GOI',
      'Bangalore': 'BLR',
      'Hyderabad': 'HYD',
      'Kolkata': 'CCU',
      'Chennai': 'MAA',
      'Ahmedabad': 'AMD',
      'Dubai': 'DXB',
      'Bangkok': 'BKK',
      'Singapore': 'SIN',
      'London': 'LHR',
      'Melbourne': 'MEL',
      'Kathmandu': 'KTM',
      'Varanasi': 'VNS',
      'Jaipur': 'JAI',
      'Chandigarh': 'IXC',
      'Madurai': 'IXM',
      'Coimbatore': 'CJB',
      'Bhubaneswar': 'BBI',
      'Guwahati': 'GAU',
      'Sydney': 'SYD',
      'Perth': 'PER',
    };

    return cityCodeMap[cityName] ?? 'XXX';
  }

  void _handleSubtitleTap(String title, String subtitle) {
    // Extract cities
    final fromCityName = _extractCityNameFromTitle(title);
    final toCityNames = _extractCityListFromSubtitle(subtitle);

    if (toCityNames.isEmpty) return;

    // Example: choose first destination city for this route
    final toCityName = toCityNames.first;

    if (fromCityName == toCityName) {
      setState(() {
        // Show error UI
      });
      return;
    }

    final fromCity = {'city': fromCityName, 'code': _getCityCode(fromCityName)};
    final toCity = {'city': toCityName, 'code': _getCityCode(toCityName)};

    final formattedDepartureDate = DateTime.now().add(const Duration(days: 1)).toString().split(' ')[0];

    final request = FlightSearchRequest(
      origin: fromCity['code'],
      destination: toCity['code'],
      departureDate: formattedDepartureDate,
      adult: 1,
      child: 0,
      infant: 0,
      type: 1,
      cabin: 1,
      tboToken: '',
      partocrsSession: '',
    );

    final viewModel = Provider.of<FlightSearchViewModel>(context, listen: false);
    viewModel.searchFlights(request).then((_) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => FlightListScreen(
            adultCount: 1,
            flightSearchResponse: viewModel.flightSearchResponse!,
            departureDate: DateTime.now().add(const Duration(days: 1)),
            fromCity: fromCity['city']!,
            toCity: toCity['city']!,
          ),
        ),
      );
    });
  }

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
        final fromCity = _extractCityNameFromTitle(route['title']);
        final toCities = _extractCityListFromSubtitle(route['subtitle']);

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
                      color: Colors.grey.shade300,
                      child: const Icon(Icons.image_not_supported, color: Colors.grey),
                    );
                  },
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
                        route['title'],
                        style: const TextStyle(
                          fontSize: 14,
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
                                fontSize: 10,
                                color: Colors.black,
                                fontFamily: 'poppins',
                              ),
                            ),
                            ...toCities.map((city) {
                              return TextSpan(
                                text: '$city   ',
                                style: const TextStyle(
                                  fontSize: 10,
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
      }).toList(),
    );
  }

}