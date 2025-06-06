import 'package:flutter/material.dart';
import 'package:trip_go/View/DashboardV/HomeCategoryPages/FlightScreen/FlightReviewScreen/flight_review_screen.dart';
import 'package:trip_go/View/DashboardV/HomeCategoryPages/FlightScreen/FlightReviewScreen/multi_trip_fligh_review_screen.dart';
import 'package:trip_go/View/DashboardV/HomeCategoryPages/FlightScreen/FlightWidgets/responsive_app_bar.dart';
import 'package:trip_go/View/DashboardV/HomeCategoryPages/FlightScreen/flight_list_screen.dart';
import 'package:google_fonts/google_fonts.dart';

import '../FlightReviewScreen/round_trip_flight_review_screen.dart';

class MultiCityFlightListScreen extends StatefulWidget {
  const MultiCityFlightListScreen({super.key});

  @override
  State<MultiCityFlightListScreen> createState() =>
      _MultiCityFlightListScreenState();
}

class _MultiCityFlightListScreenState extends State<MultiCityFlightListScreen> {

  bool _isDepartureSelected = false;
  bool _isDurationSelected = false;
  bool _isPriceSelected = false;
  List<Map<String, dynamic>> sortedFlights = [];
  final List<Map<String, dynamic>> flightList = [
    {
      "price": "₹9,934",
      "departDate": "Wed 14-May-2025",
      "segments": [
        {
          "logo": "https://flight.easemytrip.com/Content/AirlineLogon/6E.png",
          "airline": "IndiGo",
          "flightNo": "6E 853",
          "from": "DEL",
          "fromTime": "01:45",
          "fromDate": "14 May, Wed",
          "to": "BOM",
          "toTime": "04:15",
          "toDate": "14 May, Wed",
          "duration": "02h 30m",
          "stops": "Nonstop",
        },
        {
          "logo": "https://flight.easemytrip.com/Content/AirlineLogon/6E.png",
          "airline": "IndiGo",
          "flightNo": "6E 5326",
          "from": "BOM",
          "fromTime": "19:45",
          "fromDate": "10 Jun, Tue",
          "to": "HYD",
          "toTime": "21:25",
          "toDate": "10 Jun, Tue",
          "duration": "01h 40m",
          "stops": "Nonstop",
        },
      ],
    },
    {
      "price": "₹9,934",
      "departDate": "Wed 14-May-2025",
      "segments": [
        {
          "logo": "https://flight.easemytrip.com/Content/AirlineLogon/6E.png",
          "airline": "IndiGo",
          "flightNo": "6E 853",
          "from": "DEL",
          "fromTime": "01:45",
          "fromDate": "14 May, Wed",
          "to": "BOM",
          "toTime": "04:15",
          "toDate": "14 May, Wed",
          "duration": "02h 30m",
          "stops": "Nonstop",
        },
        {
          "logo": "https://flight.easemytrip.com/Content/AirlineLogon/6E.png",
          "airline": "IndiGo",
          "flightNo": "6E 5056",
          "from": "BOM",
          "fromTime": "21:20",
          "fromDate": "10 Jun, Tue",
          "to": "HYD",
          "toTime": "23:00",
          "toDate": "10 Jun, Tue",
          "duration": "01h 40m",
          "stops": "Nonstop",
        },
      ],
    },
    {
      "price": "₹10,014",
      "departDate": "Wed 14-May-2025",
      "segments": [
        {
          "logo": "https://flight.easemytrip.com/Content/AirlineLogon/AI.png",
          "airline": "Air India",
          "flightNo": "AI 2975",
          "from": "DEL",
          "fromTime": "05:55",
          "fromDate": "14 May, Wed",
          "to": "BOM",
          "toTime": "08:20",
          "toDate": "14 May, Wed",
          "duration": "02h 25m",
          "stops": "Nonstop",
        },
        {
          "logo": "https://flight.easemytrip.com/Content/AirlineLogon/6E.png",
          "airline": "IndiGo",
          "flightNo": "6E 5012",
          "from": "BOM",
          "fromTime": "05:45",
          "fromDate": "10 Jun, Tue",
          "to": "HYD",
          "toTime": "07:10",
          "toDate": "10 Jun, Tue",
          "duration": "01h 25m",
          "stops": "Nonstop",
        },
      ],
    },
    {
      "price": "₹10,014",
      "departDate": "Wed 14-May-2025",
      "segments": [
        {
          "logo": "https://flight.easemytrip.com/Content/AirlineLogon/AI.png",
          "airline": "Air India",
          "flightNo": "AI 2975",
          "from": "DEL",
          "fromTime": "05:55",
          "fromDate": "14 May, Wed",
          "to": "BOM",
          "toTime": "08:20",
          "toDate": "14 May, Wed",
          "duration": "02h 25m",
          "stops": "Nonstop",
        },
        {
          "logo": "https://flight.easemytrip.com/Content/AirlineLogon/6E.png",
          "airline": "IndiGo",
          "flightNo": "6E 5246",
          "from": "BOM",
          "fromTime": "07:20",
          "fromDate": "10 Jun, Tue",
          "to": "HYD",
          "toTime": "08:50",
          "toDate": "10 Jun, Tue",
          "duration": "01h 30m",
          "stops": "Nonstop",
        },
      ],
    },
    // Add 6 more entries by duplicating with slight changes:
    {
      "price": "₹9,888",
      "departDate": "Wed 14-May-2025",
      "segments": [
        {
          "logo": "https://flight.easemytrip.com/Content/AirlineLogon/AI.png",
          "airline": "AirIndia",
          "flightNo": "AI 1234",
          "from": "DEL",
          "fromTime": "06:10",
          "fromDate": "14 May, Wed",
          "to": "BOM",
          "toTime": "08:50",
          "toDate": "14 May, Wed",
          "duration": "02h 40m",
          "stops": "Nonstop",
        },
        {
          "logo": "https://flight.easemytrip.com/Content/AirlineLogon/6E.png",
          "airline": "IndiGo",
          "flightNo": "6E 1111",
          "from": "BOM",
          "fromTime": "06:00",
          "fromDate": "10 Jun, Tue",
          "to": "HYD",
          "toTime": "07:40",
          "toDate": "10 Jun, Tue",
          "duration": "01h 40m",
          "stops": "Nonstop",
        },
      ],
    },
    {
      "price": "₹10,014",
      "departDate": "Wed 14-May-2025",
      "segments": [
        {
          "logo": "https://flight.easemytrip.com/Content/AirlineLogon/UK.png",
          "airline": "Vistara",
          "flightNo": "UK 918",
          "from": "DEL",
          "fromTime": "10:00",
          "fromDate": "14 May, Wed",
          "to": "BOM",
          "toTime": "12:20",
          "toDate": "14 May, Wed",
          "duration": "02h 20m",
          "stops": "Nonstop",
        },
        {
          "logo": "https://flight.easemytrip.com/Content/AirlineLogon/6E.png",
          "airline": "IndiGo",
          "flightNo": "6E 1000",
          "from": "BOM",
          "fromTime": "09:10",
          "fromDate": "10 Jun, Tue",
          "to": "HYD",
          "toTime": "10:40",
          "toDate": "10 Jun, Tue",
          "duration": "01h 30m",
          "stops": "Nonstop",
        },
      ],
    },
    {
      "price": "₹9,780",
      "departDate": "Wed 14-May-2025",
      "segments": [
        {
          "logo": "https://flight.easemytrip.com/Content/AirlineLogon/6E.png",
          "airline": "IndiGo",
          "flightNo": "6E 901",
          "from": "DEL",
          "fromTime": "03:30",
          "fromDate": "14 May, Wed",
          "to": "BOM",
          "toTime": "06:10",
          "toDate": "14 May, Wed",
          "duration": "02h 40m",
          "stops": "Nonstop",
        },
        {
          "logo": "https://flight.easemytrip.com/Content/AirlineLogon/6E.png",
          "airline": "IndiGo",
          "flightNo": "6E 902",
          "from": "BOM",
          "fromTime": "10:10",
          "fromDate": "10 Jun, Tue",
          "to": "HYD",
          "toTime": "11:40",
          "toDate": "10 Jun, Tue",
          "duration": "01h 30m",
          "stops": "Nonstop",
        },
      ],
    },
    {
      "price": "₹10,105",
      "departDate": "Wed 14-May-2025",
      "segments": [
        {
          "logo": "https://flight.easemytrip.com/Content/AirlineLogon/I5.png",
          "airline": "AirAsia",
          "flightNo": "I5 512",
          "from": "DEL",
          "fromTime": "07:45",
          "fromDate": "14 May, Wed",
          "to": "BOM",
          "toTime": "10:00",
          "toDate": "14 May, Wed",
          "duration": "02h 15m",
          "stops": "Nonstop",
        },
        {
          "logo": "https://flight.easemytrip.com/Content/AirlineLogon/I5.png",
          "airline": "AirAsia",
          "flightNo": "I5 313",
          "from": "BOM",
          "fromTime": "08:00",
          "fromDate": "10 Jun, Tue",
          "to": "HYD",
          "toTime": "09:30",
          "toDate": "10 Jun, Tue",
          "duration": "01h 30m",
          "stops": "Nonstop",
        },
      ],
    },
  ];

  @override
  void initState() {
    super.initState();
    sortedFlights = List.from(flightList);
  }

  void _sortFlightsByPrice() {
    sortedFlights.sort((a, b) {
      // Remove currency symbols and commas, convert to integer
      final priceA = int.parse(a['price'].replaceAll(RegExp(r'[^0-9]'), ''));
      final priceB = int.parse(b['price'].replaceAll(RegExp(r'[^0-9]'), ''));

      return _isPriceSelected ? priceB.compareTo(priceA) : priceA.compareTo(priceB);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ResponsiveAppBar(
              title: "Delhi to Mumbai",
              subtitle: "Thu 15 May | 1 Adult",
              onSwap: () {
                // your swap logic
              },
              onFilter: () {
                // your filter logic
              },
              onMore: () {
                // your more options logic
              },
            ),
            Divider(),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(16),
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
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            setState(() {
                              _isDepartureSelected = !_isDepartureSelected;
                            });
                          },
                          child: Row(
                            children: [
                              Text(
                                "Departure",
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 14,
                                ),
                              ),
                              SizedBox(width: 2),
                              Icon(_isDepartureSelected
                                  ? Icons.arrow_upward
                                  : Icons.arrow_downward),
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              _isDurationSelected = !_isDurationSelected;
                            });
                          },
                          child: Row(
                            children: [
                              Text(
                                "Duration",
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 14,
                                ),
                              ),
                              SizedBox(width: 2),
                              Icon(_isDurationSelected
                                  ? Icons.arrow_upward
                                  : Icons.arrow_downward),
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              _isPriceSelected = !_isPriceSelected;
                              _sortFlightsByPrice();
                            });
                          },
                          child: Row(
                            children: [
                              Text(
                                "Price",
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 14,
                                ),
                              ),
                              SizedBox(width: 2),
                              Icon(_isPriceSelected
                                  ? Icons.arrow_upward
                                  : Icons.arrow_downward,
                                  size: 24),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16),
                  ListView.builder(
                    padding: EdgeInsets.zero,
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: flightList.length,
                    itemBuilder: (context, index) {
                      return _flightCard(
                        price: sortedFlights[index]["price"],
                        departureDate: sortedFlights[index]["departDate"],
                        segmentList: sortedFlights[index]["segments"],
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
class _flightCard extends StatelessWidget {
  final String price;
  final String departureDate;
  final List<Map<String, String>> segmentList;
  const _flightCard({
    super.key,
    required this.price,
    required this.departureDate,
    required this.segmentList,
  });

  @override
  Widget build(BuildContext context) {
    print(segmentList[0]);
    print(segmentList[1]);

    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 16, 0, 16),
      child: GestureDetector(
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>MultiTripFlighReviewScreen()));
        },
        child: Container(
          padding: const EdgeInsets.all(14),
          /*margin: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 8,
          ),*/
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                offset: Offset(0, 3),
                blurRadius: 6,
              ),
            ],
          ),
          child: Column(
            children: [
              // Top Row: Depart + Price
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Depart",
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    price,
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              // Date
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  departureDate,
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Container(
                width: double.infinity,
                height: 1,
                color: Colors.grey[400],
                margin: const EdgeInsets.symmetric(vertical: 4),
              ),
              const SizedBox(height: 10),
              // Flight Segment 1
              _buildFlightSegment(
                logoUrl: segmentList[0]["logo"].toString(),
                airlineName: segmentList[0]["airline"].toString(),
                flightNumber: segmentList[0]["flightNo"].toString(),
                fromCode: segmentList[0]["from"].toString(),
                fromTime: segmentList[0]["fromTime"].toString(),
                fromDate: segmentList[0]["fromDate"].toString(),
                toCode: segmentList[0]["to"].toString(),
                toTime: segmentList[0]["toTime"].toString(),
                toDate: segmentList[0]["toDate"].toString(),
                duration: segmentList[0]["duration"].toString(),
                stops: segmentList[0]["stops"].toString(),
                context: context
              ),
              const SizedBox(height: 12),
              // Flight Segment 2
              _buildFlightSegment(
                logoUrl: segmentList[1]["logo"].toString(),
                airlineName: segmentList[1]["airline"].toString(),
                flightNumber: segmentList[1]["flightNo"].toString(),
                fromCode: segmentList[1]["from"].toString(),
                fromTime: segmentList[1]["fromTime"].toString(),
                fromDate: segmentList[1]["fromDate"].toString(),
                toCode: segmentList[1]["to"].toString(),
                toTime: segmentList[1]["toTime"].toString(),
                toDate: segmentList[1]["toDate"].toString(),
                duration: segmentList[1]["duration"].toString(),
                stops: segmentList[1]["stops"].toString(), context: context,
              ),
        
              const SizedBox(height: 14),
              Container(
                width: double.infinity,
                height: 1,
                color: Colors.grey[400],
                margin: const EdgeInsets.symmetric(vertical: 4),
              ),
              const SizedBox(height: 10),
              // Refundable
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.green.shade100,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    "Refundable",
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      color: Colors.green.shade700,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
Widget _buildFlightSegment({
  required String logoUrl,
  required String airlineName,
  required String flightNumber,
  required String fromCode,
  required String fromTime,
  required String fromDate,
  required String toCode,
  required String toTime,
  required String toDate,
  required String duration,
  required String stops,
  required BuildContext context
}) {
  final screenWidth = MediaQuery.of(context).size.width;

  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Airline Info Section (Fixed Width)
        SizedBox(
          width: screenWidth * 0.28,
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: Image.network(
                  logoUrl,
                  width: 28,
                  height: 28,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 6),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      airlineName,
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Colors.blue.shade900,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                    Text(
                      flightNumber,
                      style: GoogleFonts.poppins(
                        fontSize: 9,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        // Flight Details Section
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              border: Border.all(color: Colors.grey.shade200),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // From Section
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        fromDate,
                        style: GoogleFonts.poppins(
                          fontSize: 9,
                          color: Colors.grey.shade700,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Row(
                        children: [
                          Text(
                            fromCode,
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w700,
                              fontSize: 12,
                            ),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            fromTime,
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              color: Colors.blue.shade800,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // Duration & Icon
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: Column(
                    children: [
                      Text(
                        duration,
                        style: GoogleFonts.poppins(
                          fontSize: 10,
                          color: Colors.grey.shade800,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Icon(
                        Icons.flight,
                        size: 16,
                        color: Colors.blue.shade800,
                      ),
                      const SizedBox(height: 2),
                      Text(
                        stops,
                        style: GoogleFonts.poppins(
                          fontSize: 9,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ),

                // To Section
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        toDate,
                        style: GoogleFonts.poppins(
                          fontSize: 9,
                          color: Colors.grey.shade700,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            toCode,
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w700,
                              fontSize: 12,
                            ),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            toTime,
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              color: Colors.blue.shade800,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}
/*class AlignedFlightSegment extends StatelessWidget {
  final String logoUrl;
  final String airlineName;
  final String flightNumber;
  final String fromCode;
  final String fromTime;
  final String fromDate;
  final String toCode;
  final String toTime;
  final String toDate;
  final String duration;
  final String stops;

  const AlignedFlightSegment({
    super.key,
    required this.logoUrl,
    required this.airlineName,
    required this.flightNumber,
    required this.fromCode,
    required this.fromTime,
    required this.fromDate,
    required this.toCode,
    required this.toTime,
    required this.toDate,
    required this.duration,
    required this.stops,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final sectionWidth = screenWidth / 4.2;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Airline Logo and Name
          SizedBox(
            width: 40,
            child: Column(
              children: [
                CircleAvatar(radius: 14, backgroundImage: NetworkImage(logoUrl)),
                const SizedBox(height: 4),
                Text(
                  airlineName,
                  style: GoogleFonts.poppins(fontSize: 10, fontWeight: FontWeight.w500),
                  textAlign: TextAlign.center,
                ),
                Text(
                  flightNumber,
                  style: GoogleFonts.poppins(fontSize: 10, color: Colors.grey),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),

          const SizedBox(width: 6),

          // FROM
          SizedBox(
            width: sectionWidth,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(fromDate, style: _grayTextStyle()),
                Text('$fromCode $fromTime', style: _boldTextStyle()),
              ],
            ),
          ),

          // DURATION
          SizedBox(
            width: sectionWidth,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(duration, style: _grayTextStyle()),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 4),
                  height: 1,
                  color: Colors.grey.shade400,
                  width: 40,
                ),
                Text(stops, style: _grayTextStyle()),
              ],
            ),
          ),

          // TO
          SizedBox(
            width: sectionWidth,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(toDate, style: _grayTextStyle()),
                Text('$toCode $toTime', style: _boldTextStyle()),
              ],
            ),
          ),
        ],
      ),
    );
  }

  TextStyle _grayTextStyle() => GoogleFonts.poppins(
    fontSize: 10,
    color: Colors.grey,
    fontWeight: FontWeight.w400,
  );

  TextStyle _boldTextStyle() => GoogleFonts.poppins(
    fontSize: 12,
    fontWeight: FontWeight.w600,
  );
}*/
