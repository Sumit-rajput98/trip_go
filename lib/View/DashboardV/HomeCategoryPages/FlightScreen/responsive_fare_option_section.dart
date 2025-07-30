import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:trip_go/Model/FlightM/flight_quote_model.dart';
import 'package:trip_go/View/DashboardV/HomeCategoryPages/FlightScreen/common_widget/loading_screen.dart';
import 'package:trip_go/ViewM/FlightVM/flight_quote_view_model.dart';
import '../../../../Model/FlightM/flight_search_model.dart';
import '../../../../ViewM/FlightVM/upsell_view_model.dart';
import '../../../../constants.dart';
import 'FlightReviewScreen/flight_review_screen.dart';

class ResponsiveFareOptionsSection extends StatefulWidget {
  final String supplierFareClass;
  final double screenWidth;
  final String baseFare;
  final FlightSearchResponse flightSearchResponse;
  final String cabinBaggage;
  final String baggage;
  final int publishedFare;
  final String originCity;
  final String destinationCity;
  final String originCountry;
  final String destinationCountry;
  final String arrival;
  final String departure;
  final String originTerminalNo;
  final String destinationTerminalNo;
  final String duration;
  final String? traceId;
  final String resultIndex;
  final int? adultCount;
  final int? childrenCount;
  final int? infantCount;
  const ResponsiveFareOptionsSection({
    super.key,
    required this.screenWidth,
    required this.publishedFare,
    required this.baseFare,
    required this.flightSearchResponse,
    required this.supplierFareClass,
    required this.cabinBaggage,
    required this.baggage,
    required this.originCity,
    required this.destinationCity,
    required this.originCountry,
    required this.destinationCountry,
    required this.arrival,
    required this.departure,
    required this.originTerminalNo,
    required this.destinationTerminalNo,
    required this.duration,
    this.traceId,
    required this.resultIndex, this.adultCount,
    this.childrenCount,
    this.infantCount
  });

  @override
  State<ResponsiveFareOptionsSection> createState() =>
      _ResponsiveFareOptionsSectionState();
}

class _ResponsiveFareOptionsSectionState
    extends State<ResponsiveFareOptionsSection> {
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      final upsellVM = Provider.of<UpsellViewModel>(context, listen: false);
      final body = {
        "TraceId": widget.traceId,
        "ResultIndex": widget.resultIndex,
      };
      upsellVM.fetchUpsellDetails(body);
    });
  }

  @override
  Widget build(BuildContext context) {
    final upsellVM = Provider.of<UpsellViewModel>(context);


    // Add this guard to wait for loading
    if (upsellVM.isLoading) {
      return Padding(
        padding: EdgeInsets.all(widget.screenWidth * 0.03),
        child: Column(
          children: List.generate(3, (index) {
            return Container(
              margin: EdgeInsets.only(bottom: widget.screenWidth * 0.03),
              padding: EdgeInsets.all(widget.screenWidth * 0.03),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Shimmer.fromColors(
                baseColor: Colors.grey.shade300,
                highlightColor: Colors.grey.shade100,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Radio Placeholder
                    Container(
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                    ),
                    SizedBox(width: widget.screenWidth * 0.02),

                    // Text and rows
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: double.infinity,
                            height: 16,
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          SizedBox(
                            width: 150,
                            height: 12,
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                          ),
                          SizedBox(height: 8),
                          SizedBox(
                            width: 100,
                            height: 12,
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(width: widget.screenWidth * 0.02),

                    // Fare + Button placeholder
                    Column(
                      children: [
                        SizedBox(
                          width: 60,
                          height: 16,
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        SizedBox(
                          width: 80,
                          height: 30,
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(6),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            );
          }),
        ),
      );
    }

    // Optional: show error message if API failed
    // if (upsellVM.errorMessage != null) {
    //   return Center(child: Text(upsellVM.errorMessage!));
    // }

    // Guard for null or empty results
    final resultList = upsellVM.upsellModel?.data?.results;
    if (resultList == null || resultList.isEmpty) {
      return const SizedBox.shrink(); // Show nothing
    }
    return Container(
      padding: EdgeInsets.all(widget.screenWidth * 0.03),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blue.shade50, Colors.purple.shade50],
        ),
      ),
      child: Column(
        children: List.generate(resultList?.length ?? 0, (index) {
          final result = resultList![index];
          final segmentList = result.segments;
          final firstSegment = segmentList != null && segmentList.isNotEmpty ? segmentList[0][0] : null;

          if (firstSegment == null) return const SizedBox();

          return Container(
            margin: EdgeInsets.only(bottom: widget.screenWidth * 0.03),
            padding: EdgeInsets.all(widget.screenWidth * 0.03),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: selectedIndex == index ? constants.themeColor2 : Colors.grey.shade300,
                width: selectedIndex == index ? 1.8 : 1,
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Radio<int>(
                  value: index,
                  groupValue: selectedIndex,
                  onChanged: (value) => setState(() => selectedIndex = value!),
                  activeColor: Colors.deepOrange,
                ),
                SizedBox(width: widget.screenWidth * 0.02),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        firstSegment.supplierFareClass?.toString() ?? 'Standard Fare',
                        style: TextStyle(
                          fontSize: widget.screenWidth * 0.04,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: widget.screenWidth * 0.015),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildFeatureRow(
                            Icons.work_outline,
                            'Cabin Bag: ${firstSegment.cabinBaggage ?? '-'}',
                          ),
                          _buildFeatureRow(
                            Icons.luggage,
                            'Check In: ${firstSegment.baggage ?? '-'}',
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    // if (flight.originalPrice != null &&
                    //     flight.originalPrice != flight.price)
                    //   Text(
                    //     '₹${flight.fare.}',
                    //     style: TextStyle(
                    //       fontSize: widget.screenWidth * 0.033,
                    //       decoration: TextDecoration.lineThrough,
                    //     ),
                    //   ),
                    Text(
                      '₹${result.fare?.publishedFare?.floor() ?? 0}',
                      style: TextStyle(
                        fontSize: widget.screenWidth * 0.045,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: widget.screenWidth * 0.02),
                    ElevatedButton(
                      onPressed: () {
                        final viewModel = Provider.of<FlightQuoteViewModel>(
                          context,
                          listen: false,
                        );

                        // Show loading
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoadingScreen(),
                          ),
                        );

                        // Prepare request
                        final request = FlightQuoteRequest(
                          traceId: upsellVM.upsellModel!.data!.traceId!,
                          resultIndex: result.resultIndex!,
                        );

                        viewModel.fetchQuote(request).then((_) {
                          Navigator.pop(context); // Close loading screen
                          print('✅ Flight search completed');

                          final response = viewModel.flightQuoteModel;

                          if (response != null) {
                            final segments = response.data!.results!.segments!;
                            final hasLayover = segments[0].length > 1;

                            final firstSegment = segments[0][0];
                            final lastSegment =
                            hasLayover ? segments[0][1] : segments[0][0];

                            final fare = response.data?.results?.fare;
                            if (fare != null) {
                              const JsonEncoder encoder = JsonEncoder.withIndent('  ');
                              final String prettyFare = encoder.convert(fare);
                              print("🔍 Full Fare JSON:\n\$prettyFare");
                            } else {
                              print("⚠️ Fare information is missing.");
                            }
                            //final segment = response.result.segments[0][0]; // First segment, first flight
                            print("hii");
                            print("Is LCC : ${response.data!.results!.isLcc}");
                            // final firstSegment = response.data!.results!.segments![0][0];
                            print(
                              "Origin City: ${firstSegment.origin?.airport?.cityName}",
                            );
                            print(
                              "Destination City: ${firstSegment.destination?.airport?.cityName}",
                            );
                            print("Dep Time: ${firstSegment.origin?.depTime}");
                            print(
                              "Arr Time: ${firstSegment.destination?.arrTime}",
                            );
                            print("Duration: ${firstSegment.duration}");
                            print(
                              "Fare Class: ${firstSegment.airline?.fareClass}",
                            );
                            print(
                              "Published Fare: ${response.data!.results!.fare?.publishedFare}",
                            );

                            String? layoverCity;
                            String? layoverCityCode;
                            String? layoverDuration;
                            String duration;
                            String durationA;
                            String flightName =
                                "${firstSegment.airline!.airlineName!} | ${firstSegment.airline!.flightNumber!}";
                            String flightName2 =
                                "${lastSegment.airline!.airlineName!} | ${lastSegment.airline!.flightNumber!}";

                            // Parse times for layover calculation
                            if (hasLayover) {
                              final layoverArrival =
                              firstSegment.destination!.arrTime!;
                              final layoverDeparture =
                              lastSegment.origin!.depTime!;

                              final layoverCityName =
                              firstSegment.destination!.airport!.cityName!;
                              final layoverCityAirportCode =
                              firstSegment
                                  .destination!
                                  .airport!
                                  .airportCode!;

                              final layoverMinutes =
                                  layoverDeparture
                                      .difference(layoverArrival)
                                      .inMinutes;
                              final layoverHours = layoverMinutes ~/ 60;
                              final layoverRemainingMinutes =
                                  layoverMinutes % 60;

                              layoverCity = layoverCityName;
                              layoverCityCode = layoverCityAirportCode;
                              layoverDuration =
                              "${layoverHours}h ${layoverRemainingMinutes}m layover in $layoverCity";

                              final originToLayoverMinutes =
                              firstSegment.duration!;
                              final layoverToDestination =
                              lastSegment.duration!;
                              final totalFlightHours =
                                  originToLayoverMinutes ~/ 60;
                              final totalFlightRemainingMinutes =
                                  originToLayoverMinutes % 60;
                              duration =
                              "${totalFlightHours}h ${totalFlightRemainingMinutes}m";
                              final totalFlightHoursA =
                                  layoverToDestination ~/ 60;
                              final totalFlightRemMin =
                                  layoverToDestination % 60;
                              durationA =
                              "${totalFlightHoursA}h ${totalFlightRemMin}m";
                            } else {
                              final totalFlightMinutes = firstSegment.duration!;
                              final hours = totalFlightMinutes ~/ 60;
                              final minutes = totalFlightMinutes % 60;
                              duration = "${hours}h ${minutes}m";
                              durationA = '';
                            }

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (context) => FlightReviewScreen(
                                  adultCount:widget.adultCount,
                                  originCity:
                                  firstSegment
                                      .origin!
                                      .airport!
                                      .cityName!,
                                  destinationCity:
                                  lastSegment
                                      .destination!
                                      .airport!
                                      .cityName!,
                                  originAirportCode:
                                  firstSegment
                                      .origin!
                                      .airport!
                                      .airportCode!,
                                  destinationAirportCode:
                                  lastSegment
                                      .destination!
                                      .airport!
                                      .airportCode!,
                                  departure:
                                  firstSegment.origin!.depTime!
                                      .toString(),
                                  arrival:
                                  lastSegment.destination!.arrTime!
                                      .toString(),
                                  layoverArr:
                                  firstSegment.destination!.arrTime!
                                      .toString(),
                                  layoverDep:
                                  lastSegment.origin!.depTime!
                                      .toString(),
                                  duration: duration,
                                  durationA: durationA,
                                  originTerminalNo:
                                  response
                                      .data!
                                      .results!
                                      .segments![0][0]
                                      .origin!
                                      .airport!
                                      .terminal!,
                                  layoverTerminalNo:
                                  firstSegment
                                      .destination!
                                      .airport!
                                      .terminal!,
                                  layoverTerminalNo2:
                                  lastSegment
                                      .origin!
                                      .airport!
                                      .terminal!,
                                  destinationTerminalNo:
                                  lastSegment
                                      .destination!
                                      .airport!
                                      .terminal!,
                                  publishedFare:
                                  response.data!.results!.fare!.publishedFare!.floor(),
                                  supplierFareClass:
                                  firstSegment.airline!.fareClass!,
                                  supplierFareClass2:
                                  lastSegment.airline!.fareClass!,
                                  resultIndex:
                                  response.data!.results!.resultIndex!,
                                  traceId: response.data!.traceId,
                                  layoverCity: layoverCity,
                                  layoverCityCode: layoverCityCode,
                                  layoverDuration: layoverDuration,
                                  flightName: flightName,
                                  flightName2: flightName2,
                                  airlineName:firstSegment.airline!.airlineName!,
                                  fare:  response.data!.results!.fare!.toJson(), isLcc: response.data!.results!.isLcc!,
                                  childrenCount: widget.childrenCount,
                                  infantCount: widget.infantCount,
                                ),
                              ),
                            );
                          }
                        });

                        /*Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => FlightReviewScreen(
                              originCity: widget.originCity,
                              destinationCity: widget.destinationCity,
                              departure: widget.departure,
                              arrival: widget.arrival,
                              duration: widget.duration,
                              originTerminalNo: widget.originTerminalNo,
                              destinationTerminalNo: widget.destinationTerminalNo,
                              publishedFare: widget.publishedFare,
                              supplierFareClass: widget.supplierFareClass,
                              resultIndex: widget.resultIndex,
                              traceId:widget.traceId
                            ),
                          ),
                        );*/
                      },

                      style: ElevatedButton.styleFrom(
                        backgroundColor: constants.themeColor1,
                        padding: EdgeInsets.symmetric(
                          horizontal: widget.screenWidth * 0.02,
                          vertical: widget.screenWidth * 0.012,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            widget.screenWidth * 0.02,
                          ),
                        ),
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      child: Text(
                        'Book Now',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: widget.screenWidth * 0.03,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        }),
      ),
    );
  }

  Widget _buildFeatureRow(IconData icon, String text) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: widget.screenWidth * 0.005),
      child: Row(
        children: [
          Icon(icon, size: widget.screenWidth * 0.04),
          SizedBox(width: widget.screenWidth * 0.02),
          Expanded(
            child: Text(
              text,
              style: TextStyle(fontSize: widget.screenWidth * 0.033),
            ),
          ),
        ],
      ),
    );
  }
}