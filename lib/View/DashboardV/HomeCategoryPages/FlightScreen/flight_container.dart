import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../Model/FlightM/round_trip_flight_search_model.dart';

class FlightContainer extends StatelessWidget {
  final SearchResult flight;
  final bool selected;
  final double screenWidth;

  const FlightContainer({
    required this.flight,
    required this.selected,
    required this.screenWidth,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    String formatDuration(int minutes) {
      final hours = minutes ~/ 60;
      final mins = minutes % 60;
      return '${hours}h ${mins}m';
    }

    final List<Map<String, String>> airlines = [
      {
        "name": "Air India",
        "logo":
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS-QO8gVe353NPaAV3wid57LAtWqIdet-EVMA&s",
      },
      {
        "name": "Air India Express",
        "logo": "https://flight.easemytrip.com/Content/AirlineLogon/IX.png",
      },
      {
        "name": "Indigo",
        "logo": "https://flight.easemytrip.com/Content/AirlineLogon/6E.png",
      },
      {
        "name": "Vistara",
        "logo": "https://flight.easemytrip.com/Content/AirlineLogon/UK.png",
      },
      {
        "name": "SpiceJet",
        "logo": "https://flight.easemytrip.com/Content/AirlineLogon/SG.png",
      },
      {
        "name": "GoAir",
        "logo": "https://flight.easemytrip.com/Content/AirlineLogon/G8.png",
      },
    ];

    String getAirlineLogo(String airlineName) {
      final airline = airlines.firstWhere(
            (airline) =>
        airline['name']!.toLowerCase() == airlineName.toLowerCase(),
        orElse:
            () => {"logo": "https://via.placeholder.com/50"}, // fallback image
      );
      return airline['logo']!;
    }

    String formatFlightTime(String timeString) {
      final dateTime = DateTime.parse(timeString);
      final formattedTime = DateFormat.Hm().format(
        dateTime,
      ); // 24-hour format e.g., 23:00
      return formattedTime;
    }

    return Container(
      padding: EdgeInsets.all(screenWidth * 0.03),
      color: selected ? Colors.blue.shade50 : Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Image.network(
                getAirlineLogo(flight.segments![0][0].airline!.airlineName!),
                height: 24,
                width: 24,
              ),
              SizedBox(width: 8),
              Text(
                "${flight.segments![0][0].airline!.airlineCode!}-${flight.segments![0][0].airline!.flightNumber!}",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
              ),
              Spacer(),
              Text(
                "₹ ${flight.fare!.publishedFare!.floor()}",
                style: TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                formatFlightTime(
                  flight.segments![0][0].origin!.depTime!.toString(),
                ),
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
              ),
              Column(
                children: [
                  Text(
                    formatDuration(flight.segments![0][0].duration!),
                    style: TextStyle(fontSize: 12, color: Colors.black87),
                  ),
                  Container(height: 2, color: Colors.black),
                  Text(
                    "${flight.segments![0].length - 1} stop(s)",
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
              Text(
                formatFlightTime(
                  flight.segments![0][0].destination!.arrTime!.toString(),
                ),
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ],
      ),
    );
  }
}