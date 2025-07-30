import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CancelledFlightsPage extends StatelessWidget {
  final List<Map<String, String>> airlines = [
    {"name": "Air India", "logo": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS-QO8gVe353NPaAV3wid57LAtWqIdet-EVMA&s"},
    {"name": "Air India Express", "logo": "https://flight.easemytrip.com/Content/AirlineLogon/IX.png"},
    {"name": "Indigo", "logo": "https://flight.easemytrip.com/Content/AirlineLogon/6E.png"},
    {"name": "Vistara", "logo": "https://flight.easemytrip.com/Content/AirlineLogon/UK.png"},
    {"name": "SpiceJet", "logo": "https://flight.easemytrip.com/Content/AirlineLogon/SG.png"},
    {"name": "GoAir", "logo": "https://flight.easemytrip.com/Content/AirlineLogon/G8.png"},
    {"name": "Flynas", "logo": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR44aavq2U0IVMa98wKAQpI47r3nQ_-Q-O0GHi3PRnXyvwc571_m14YaLdk5GBcUjFPVgA&usqp=CAU"},
  ];

  final List<Map<String, String>> cancelledFlights = [
    {
      'airline': 'Vistara',
      'flightNumber': 'UK 789',
      'from': 'Delhi (DEL)',
      'to': 'Pune (PNQ)',
      'date': '25 May 2025',
      'time': '8:00 AM',
      'status': 'Cancelled',
    },
    {
      'airline': 'GoAir',
      'flightNumber': 'G8 543',
      'from': 'Mumbai (BOM)',
      'to': 'Goa (GOI)',
      'date': '27 May 2025',
      'time': '1:45 PM',
      'status': 'Cancelled',
    },
  ];

   CancelledFlightsPage({super.key});

  String? _getAirlineLogo(String airlineName) {
    final match = airlines.firstWhere(
          (airline) => airline['name']!.toLowerCase() == airlineName.toLowerCase(),
      orElse: () => {},
    );
    return match['logo'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: cancelledFlights.isEmpty
            ? Center(
          child: Text(
            "No cancelled flights",
            style: GoogleFonts.poppins(fontSize: 16, color: Colors.grey),
          ),
        )
            : ListView.builder(
          itemCount: cancelledFlights.length,
          itemBuilder: (context, index) {
            final flight = cancelledFlights[index];
            final logoUrl = _getAirlineLogo(flight['airline'] ?? '');

            return Card(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              elevation: 4,
              margin: const EdgeInsets.only(bottom: 20),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            if (logoUrl != null && logoUrl.isNotEmpty)
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.network(
                                  logoUrl,
                                  width: 25,
                                  height: 25,
                                  errorBuilder: (context, error, stackTrace) =>
                                      Icon(Icons.flight, size: 40),
                                ),
                              )
                            else
                              Icon(Icons.flight, size: 40, color: Colors.red.shade700),
                            SizedBox(width: 12),
                            Text(
                              '${flight['airline']} (${flight['flightNumber']})',
                              style: GoogleFonts.poppins(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.red.shade900,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.red, width: 1.5),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            flight['status'] ?? 'N/A',
                            style: GoogleFonts.poppins(
                              color: Colors.red,
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 12),
                    Row(
                      children: [
                        Icon(Icons.location_on,
                            color: Colors.green.shade700, size: 18),
                        SizedBox(width: 6),
                        Expanded(
                          child: Text(
                            '${flight['from']} → ${flight['to']}',
                            style: GoogleFonts.poppins(fontSize: 12),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 12),
                    Row(
                      children: [
                        Icon(Icons.calendar_today,
                            size: 15, color: Colors.grey.shade600),
                        SizedBox(width: 6),
                        Text(
                          '${flight['date']}',
                          style: GoogleFonts.poppins(
                              fontSize: 12, color: Colors.grey.shade700),
                        ),
                        SizedBox(width: 20),
                        Icon(Icons.access_time,
                            size: 15, color: Colors.grey.shade600),
                        SizedBox(width: 6),
                        Text(
                          '${flight['time']}',
                          style: GoogleFonts.poppins(
                              fontSize: 12, color: Colors.grey.shade700),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
