import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trip_go/Model/FlightM/fare_rules_model.dart';
import 'package:trip_go/View/DashboardV/HomeCategoryPages/FlightScreen/FlightReviewScreen/promo_section/promo_section.dart';
import 'package:trip_go/View/DashboardV/HomeCategoryPages/FlightScreen/FlightReviewScreen/traveller_details.dart';
import 'package:intl/intl.dart';
import 'package:trip_go/constants.dart';
import '../FareRules/show_fare_rules_bottom_sheet.dart';
import '../common_widget/bottom_bar.dart';

class FlightReviewScreen extends StatefulWidget {
  final Map<String, dynamic> fare;
  final bool? isInternational;
  final String flightName;
  final String flightName2;
  final bool isLcc;
  final String originCity;
  final String destinationCity;
  final String departure;
  final String arrival;
  final String duration;
  final String originTerminalNo;
  final String destinationTerminalNo;
  final int publishedFare;
  final String supplierFareClass;
  final String supplierFareClass2;
  final String resultIndex;
  final String? traceId;
  final String? layoverCity;
  final String? layoverDuration;
  final String? originAirportCode;
  final String? destinationAirportCode;
  final String? layoverCityCode;
  final String? layoverArr;
  final String? layoverDep;
  final String durationA;
  final String? layoverTerminalNo;
  final String? layoverTerminalNo2;
  final String airlineName;
  final int? adultCount;
  final int? childrenCount;
  final int? infantCount;

  const FlightReviewScreen({
    super.key,
    this.isInternational,
    required this.fare,
    required this.originCity,
    required this.isLcc,
    required this.destinationCity,
    required this.departure,
    required this.arrival,
    required this.duration,
    required this.originTerminalNo,
    required this.destinationTerminalNo,
    required this.publishedFare,
    required this.supplierFareClass,
    required this.resultIndex,
    this.traceId,
    this.layoverCity,
    this.layoverDuration,
    this.originAirportCode,
    this.destinationAirportCode,
    this.layoverCityCode,
    required this.flightName,
    this.layoverArr,
    this.layoverDep,
    required this.durationA,
    this.layoverTerminalNo,
    this.layoverTerminalNo2,
    required this.flightName2,
    required this.supplierFareClass2,
    required this.airlineName,
    this.adultCount,
    this.childrenCount,
    this.infantCount,
  });

  @override
  State<FlightReviewScreen> createState() => _FlightReviewScreenState();
}

class _FlightReviewScreenState extends State<FlightReviewScreen> {
  @override
  void initState() {
    super.initState();
    print("@@ - ${widget.traceId}");
    print("isLLC - ${widget.isLcc}, child - ${widget.childrenCount}, infant - ${widget.infantCount}");
  }
  @override
  Widget build(BuildContext context) {
    print("isInternational : ${widget.isInternational}");
    String formatFullDateTime(String timeStr) {
      try {
        final dateTime = DateTime.parse(timeStr);
        return DateFormat(
          'dd MMM yyyy, HH:mm',
        ).format(dateTime); // e.g., "16 May 2025, 23:00"
      } catch (e) {
        return timeStr; // fallback
      }
    }

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              height: 130,
              decoration: const BoxDecoration(
                color: Color(0xFF341f97),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(28),
                  bottomRight: Radius.circular(28),
                ),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 36),
              alignment: Alignment.topLeft,
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(Icons.arrow_back, color: Colors.white),
                  ),
                  const SizedBox(width: 16),
                  Text(
                    "Flight Review",
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 90, 20, 0),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          offset: Offset(0, 3),
                          blurRadius: 8,
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${widget.originCity}–${widget.destinationCity}",
                          style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Text(
                              formatFullDateTime(widget.departure),
                              style: GoogleFonts.poppins(color: Colors.grey),
                            ),
                            const SizedBox(width: 5),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.blue.shade50,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                "Depart",
                                style: GoogleFonts.poppins(
                                  color: Color(0xff006DFF),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const Divider(),
                        buildFlightTile(
                          widget.flightName,
                          widget.supplierFareClass,
                          widget.originAirportCode!,
                          widget.departure,
                          widget.layoverCity != null
                              ? widget.layoverCityCode!
                              : widget.destinationAirportCode!,
                          widget.layoverCity != null
                              ? widget.layoverArr ?? ''
                              : widget.arrival,
                          widget.originTerminalNo,
                          widget.layoverCity != null
                              ? widget.layoverTerminalNo ?? ''
                              : widget.destinationTerminalNo,
                          widget.duration,
                          widget.originCity,
                          widget.layoverCity != null
                              ? widget.layoverCity!
                              : widget.destinationCity,
                        ),

                        if (widget.layoverCity != null &&
                            widget.layoverDuration != null) ...[
                          buildLayover("${widget.layoverDuration} "),
                          buildFlightTile(
                            widget.flightName2,
                            widget.supplierFareClass2,
                            widget.layoverCityCode!,
                            widget.layoverDep!,
                            widget.destinationAirportCode!,
                            widget.arrival,
                            widget.layoverTerminalNo2 ?? '',
                            widget.destinationTerminalNo,
                            widget.durationA,
                            widget.layoverCity!,
                            widget.destinationCity,
                          ),
                        ],
                        Divider(),
                        TextButton(
                          onPressed: () {
                            final request = FareRulesRequest(
                              traceId: widget.traceId!,
                              resultIndex: widget.resultIndex,
                            );
                            showFareRuleBottomSheet(context, request);
                          },
                          child: Text(
                            "Fare Rules",
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w700,
                              color: constants.themeColor1,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  TravelInsuranceAndPromo(),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: buildBottomBar(context, () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder:
                (context) => TravellerDetails(
              isInternational: widget.isInternational,
              originCity: widget.originCity,
              destinationCity: widget.destinationCity,
              departureTime:widget.departure,
              arrivalTime: widget.arrival,
              airlineName: widget.airlineName,
              duration:widget.duration ,
              resultIndex: widget.resultIndex,
              traceId: widget.traceId!,
              adultCount: widget.adultCount,
              childrenCount: widget.childrenCount,
              infantCount: widget.infantCount,
              price:widget.publishedFare, fare: widget.fare,
              isLcc: widget.isLcc,
              flightName: widget.flightName,
            ),
          ),
        );
      },price: widget.publishedFare),
    );
  }

  // Widget buildFlightReviewCard() {
  Widget buildFlightTile(
      String flight,
      String fare,
      String fromCode,
      String depTime,
      String toCode,
      String arrTime,
      String depTerminal,
      String arrTerminal,
      String duration,
      String depCity,
      String arrCity,
      ) {
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

    String formatTime(String timeStr) {
      try {
        final dateTime = DateTime.parse(timeStr);
        return DateFormat.Hm().format(dateTime); // e.g., "23:00"
      } catch (e) {
        return timeStr; // fallback if format fails
      }
    }

    String formattedDepTime = formatTime(depTime);
    String formattedArrTime = formatTime(arrTime);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            CircleAvatar(
              radius: 15,
              backgroundImage: NetworkImage(getAirlineLogo(widget.airlineName)),
            ),
            const SizedBox(width: 6),

            /// Wrap `Text` in `Flexible` so it doesn't overflow
            Flexible(
              child: Text(
                flight,
                style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),

            const Spacer(),

            /// Wrap Container in Flexible if space is still tight (optional)
            Flexible(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.green.shade100,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  "Refundable",
                  style: GoogleFonts.poppins(
                    color: Colors.green,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 8, 8, 4),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            decoration: BoxDecoration(
              color: Colors.grey.shade50,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              fare,
              style: GoogleFonts.poppins(
                color: const Color(0xff000000),
                fontWeight: FontWeight.w500,
                fontSize: 10,
              ),
            ),
          ),
        ),
        const SizedBox(height: 4),
        Container(
          margin: const EdgeInsets.only(top: 4),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(12),
            color: Colors.grey.shade50,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              buildFlightTimeArrival(
                fromCode,
                formattedDepTime,
                depCity,
                depTerminal,
                depTime,
              ),
              buildDuration(duration),
              buildFlightTimeDeparture(
                toCode,
                formattedArrTime,
                arrCity,
                arrTerminal,
                arrTime,
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
      ],
    );
  }

  Widget buildLayover(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.amber),
          borderRadius: BorderRadius.circular(8),
          color: Colors.amber.shade50,
        ),
        padding: const EdgeInsets.symmetric(vertical: 6),
        alignment: Alignment.center,
        child: Text(
          text,
          style: GoogleFonts.poppins(
            color: Colors.orange,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  String formatDateLabel(String timeStr) {
    try {
      final dateTime = DateTime.parse(timeStr);
      return DateFormat('E–dd MMM yyyy').format(dateTime); // Tue–15May2025
    } catch (_) {
      return '';
    }
  }

  Widget buildFlightTimeArrival(
      String code,
      String time,
      String city,
      String terminal,
      String departureDate,
      ) {
    return Column(
      children: [
        Text(
          formatDateLabel(departureDate),
          style: GoogleFonts.poppins(fontSize: 10),
        ),
        Text(
          "$code $time",
          style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        Text(city, style: GoogleFonts.poppins()),
        Text("Terminal - $terminal", style: GoogleFonts.poppins(fontSize: 10)),
      ],
    );
  }

  Widget buildFlightTimeDeparture(
      String code,
      String time,
      String city,
      String terminal,
      String arrivalDate,
      ) {
    return Column(
      children: [
        Text(
          formatDateLabel(arrivalDate),
          style: GoogleFonts.poppins(fontSize: 10),
        ),
        Text(
          "$code $time",
          style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        Text(city, style: GoogleFonts.poppins()),
        Text("Terminal - $terminal", style: GoogleFonts.poppins(fontSize: 10)),
      ],
    );
  }

  Widget buildDuration(String duration) {
    return Column(
      children: [
        const Icon(Icons.more_horiz, size: 16),
        Text(
          duration,
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            fontSize: 12,
            color: Colors.grey,
          ),
        ),
        const Icon(Icons.more_horiz, size: 16),
      ],
    );
  }
}

class TravelInsuranceAndPromo extends StatelessWidget {
  const TravelInsuranceAndPromo({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        buildInsuranceSection(),
        const SizedBox(height: 12),
        PromoSection(),
        const SizedBox(height: 12),
        buildEaseMyTripReasons(),
      ],
    );
  }

  Widget buildInsuranceSection() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text(
                "Travel Insurance",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const Spacer(),
              Image.network(
                'https://flight.easemytrip.com/Content/img/acko-logo.png',
                height: 24,
              ),
            ],
          ),
          Divider(),
          const Text(
            "Secure your trip with ACKO Travel Insurance at just Rs199/- per traveller",
          ),
          const SizedBox(height: 6),
          const Text("View T&C", style: TextStyle(color: Colors.blue)),
          const SizedBox(height: 8),
          Column(
            children: [
              RadioListTile(
                value: true,
                groupValue: true,
                onChanged: (_) {},
                title: const Text("Yes Secure My Trip"),
                subtitle: const Text(
                  "More than 36% of our customer choose to secure their trip.",
                ),
              ),
              RadioListTile(
                value: false,
                groupValue: true,
                onChanged: (_) {},
                title: const Text("I am willing to risk my trip"),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildEaseMyTripReasons() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: Text(
            "Why book with TripGo?",
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 140, // Ensure height accommodates all tiles
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 5),
            children: [
              buildReasonTile(
                Icons.support_agent,
                "24/7 Customer Support",
                "We’re here to help whenever you need us",
              ),
              buildReasonTile(
                Icons.security,
                "Secure Booking",
                "Your privacy is our top priority",
              ),
              buildReasonTile(
                Icons.thumb_up,
                "Trusted by Millions",
                "Millions of users trust EaseMyTrip",
              ),
              buildReasonTile(
                Icons.airplanemode_active,
                "Best Deals",
                "Get the lowest prices on flights",
              ),
              buildReasonTile(
                Icons.wallet,
                "No Convenience Fee",
                "Book tickets without extra charges",
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildReasonTile(IconData icon, String title, String subtitle) {
    return Container(
      width: 160, // Fixed width to avoid overflow
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.blue.shade50,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: Colors.blue, size: 28),
          const SizedBox(height: 8),
          Text(
            title,
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w600,
              fontSize: 13,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(fontSize: 11),
          ),
        ],
      ),
    );
  }
}