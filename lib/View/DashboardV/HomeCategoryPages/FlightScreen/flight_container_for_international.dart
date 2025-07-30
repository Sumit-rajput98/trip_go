import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../Model/FlightM/round_trip_flight_search_model.dart';
import 'package:google_fonts/google_fonts.dart';

  class FlightContainerForInternational extends StatelessWidget {
    final SearchResult flight;
    final bool selected;
    final double screenWidth;

    const FlightContainerForInternational({
      super.key,
      required this.flight,
      required this.selected,
      required this.screenWidth,
    });

  String getAirlineLogo(String name) {
    final Map<String, String> logos = {
      "Air India": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS-QO8gVe353NPaAV3wid57LAtWqIdet-EVMA&s",
      "Air India Express": "https://flight.easemytrip.com/Content/AirlineLogon/IX.png",
      "Indigo": "https://flight.easemytrip.com/Content/AirlineLogon/6E.png",
      "Vistara": "https://flight.easemytrip.com/Content/AirlineLogon/UK.png",
      "SpiceJet": "https://flight.easemytrip.com/Content/AirlineLogon/SG.png",
      "GoAir": "https://flight.easemytrip.com/Content/AirlineLogon/G8.png",
    };

    return logos.entries
        .firstWhere((e) => e.key.toLowerCase() == name.toLowerCase(),
        orElse: () => const MapEntry("default", "https://via.placeholder.com/50"))
        .value;
  }

  String getDuration(SearchResult flight) {
      final segments = flight.segments;
      if (segments == null || segments.isEmpty || segments[0].isEmpty) return "--";

      int totalMinutes = 0;

      for (var segment in segments[0]) {
        totalMinutes += segment.duration ?? 0;
      }

      final hours = totalMinutes ~/ 60;
      final minutes = totalMinutes % 60;
      return "${hours}h ${minutes}m";
    }

    String getStops(SearchResult flight) {
      final segments = flight.segments;
      if (segments == null || segments.isEmpty || segments[0].isEmpty) return "--";
      int stops = segments[0].length - 1;
      if (stops == 0) return "Non-stop";
      return "$stops Stop${stops > 1 ? 's' : ''}";
    }

  String formatTime(DateTime? time) {
    if (time == null) return "--:--";
    return DateFormat.Hm().format(time);
  }

    Widget buildFlightRow({
      required String? logoUrl,
      required DateTime? depTime,
      required String? depCode,
      required String? depCity,
      required String? depCountry,
      required DateTime? arrTime,
      required String? arrCode,
      required String? arrCity,
      required String? arrCountry,
    }) {
      return Row(
        children: [
          Column(
            children: [
              Image.network(
                logoUrl ?? '',
                height: 24,
                width: 24,
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(Icons.flight, size: 24, color: Colors.grey);
                },
              ),
              const SizedBox(height: 4),
              Text(
                formatTime(depTime),
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(width: 6),
          Column(
            children: [
              Text(
                getDuration(flight),
                style: GoogleFonts.poppins(
                  fontSize: screenWidth * 0.035,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: screenWidth * 0.01),
              Container(
                height: 2,
                width: screenWidth * 0.6,
                color: Colors.grey.shade400,
              ),
              SizedBox(height: screenWidth * 0.01),
              Text(
                getStops(flight),
                style: GoogleFonts.poppins(fontSize: screenWidth * 0.035),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                formatTime(arrTime),
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                arrCode ?? '--',
                style: const TextStyle(fontSize: 12),
              ),
            ],
          ),
        ],
      );
    }


    Widget buildAirportDetails(String? code, String? city, String? country) {
      return Flexible(
        child: Text(
          "$city, $country ($code)",
          style: const TextStyle(fontSize: 12, color: Colors.black54),
          softWrap: true,
          overflow: TextOverflow.visible,
        ),
      );
    }

  @override
  Widget build(BuildContext context) {
    final id = "${flight.segments?[0][0].origin?.airport?.airportCode}-${flight.segments?[0][0].destination?.airport?.airportCode}";

    // if (!_printedFlights.contains(id)) {
    //   print("International Flights: $id");
    //   _printedFlights.add(id);
    // }
    print("International Flights");
    final onwardSegment = flight.segments?[0][0];
    final returnSegment = flight.segments?.length == 2 ? flight.segments![1][0] : null;

    return Container(
      decoration: BoxDecoration(
        color: selected ? Colors.blue.shade50 : Colors.white,
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(10),
      ),
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Onward | Return | Price
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Onward Column
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Onward", style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  Text(onwardSegment?.airline?.airlineName ?? "--",
                      style: const TextStyle(fontSize: 12)),
                  Text("${onwardSegment?.airline?.airlineCode}-${onwardSegment?.airline?.flightNumber}",
                      style: const TextStyle(fontSize: 12)),
                ],
              ),

              /// Return Column
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Return", style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  Text(returnSegment?.airline?.airlineName ?? "--",
                      style: const TextStyle(fontSize: 12)),
                  Text("${returnSegment?.airline?.airlineCode}-${returnSegment?.airline?.flightNumber}",
                      style: const TextStyle(fontSize: 12)),
                ],
              ),

              /// Price
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text("₹ ${flight.fare?.publishedFare?.floor() ?? 0}",
                      style: const TextStyle(
                          color: Colors.blue, fontWeight: FontWeight.bold, fontSize: 16)),
                ],
              ),
            ],
          ),


          const SizedBox(height: 12),

          /// Onward Flight Info
          buildFlightRow(
            logoUrl: getAirlineLogo(onwardSegment?.airline?.airlineName ?? ''),
            depTime: onwardSegment?.origin?.depTime,
            depCode: onwardSegment?.origin?.airport?.airportCode,
            depCity: onwardSegment?.origin?.airport?.cityName,
            depCountry: onwardSegment?.origin?.airport?.countryName,
            arrTime: onwardSegment?.destination?.arrTime,
            arrCode: onwardSegment?.destination?.airport?.airportCode,
            arrCity: onwardSegment?.destination?.airport?.cityName,
            arrCountry: onwardSegment?.destination?.airport?.countryName,
          ),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              buildAirportDetails(
                onwardSegment?.origin?.airport?.airportCode,
                onwardSegment?.origin?.airport?.cityName,
                onwardSegment?.origin?.airport?.countryName,
              ),
              buildAirportDetails(
                onwardSegment?.destination?.airport?.airportCode,
                onwardSegment?.destination?.airport?.cityName,
                onwardSegment?.destination?.airport?.countryName,
              ),
            ],
          ),

          const SizedBox(height: 14),

          /// Return Flight Info
          buildFlightRow(
            logoUrl: getAirlineLogo(returnSegment?.airline?.airlineName ?? ''),
            depTime: returnSegment?.origin?.depTime,
            depCode: returnSegment?.origin?.airport?.airportCode,
            depCity: returnSegment?.origin?.airport?.cityName,
            depCountry: returnSegment?.origin?.airport?.countryName,
            arrTime: returnSegment?.destination?.arrTime,
            arrCode: returnSegment?.destination?.airport?.airportCode,
            arrCity: returnSegment?.destination?.airport?.cityName,
            arrCountry: returnSegment?.destination?.airport?.countryName,
          ),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              buildAirportDetails(
                returnSegment?.origin?.airport?.airportCode,
                returnSegment?.origin?.airport?.cityName,
                returnSegment?.origin?.airport?.countryName,
              ),
              buildAirportDetails(
                returnSegment?.destination?.airport?.airportCode,
                returnSegment?.destination?.airport?.cityName,
                returnSegment?.destination?.airport?.countryName,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
