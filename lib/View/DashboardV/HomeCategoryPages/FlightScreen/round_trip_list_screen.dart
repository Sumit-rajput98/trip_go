import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:trip_go/Model/FlightM/round_trip_flight_search_model.dart';
import 'package:trip_go/View/DashboardV/HomeCategoryPages/FlightScreen/FlightReviewScreen/round_trip_flight_review_screen.dart';
import 'package:trip_go/View/DashboardV/HomeCategoryPages/FlightScreen/common_widget/bottom_bar.dart';
import 'package:intl/intl.dart';
import '../../../../Model/FlightM/flight_quote_model.dart';
import '../../../../ViewM/FlightVM/flight_quote_view_model.dart';
import '../../../../constants.dart';
import 'FlightWidgets/responsive_app_bar.dart';
import 'common_widget/bottom_sgeets.dart';
import 'common_widget/filter_bootom_sheet/airline_bottom_sheet.dart';
import 'common_widget/filter_bootom_sheet/filter_bottom_sheet.dart';
import 'common_widget/filter_bootom_sheet/sort_by_bottom_sheet.dart';
import 'common_widget/filter_bootom_sheet/time_bootom_sheet.dart';
import 'common_widget/loading_screen.dart';
import 'flight_list_screen.dart';

class RoundTripListScreen extends StatefulWidget {
  final RoundTripFlightSearchModel flightSearchResponse;
  final DateTime departureDate;
  final int adultCount;
  final String fromCity;
  final String toCity;
  const RoundTripListScreen({
    super.key,
    required this.flightSearchResponse,
    required this.departureDate,
    required this.adultCount,
    required this.fromCity,
    required this.toCity,
  });

  @override
  State<RoundTripListScreen> createState() => _RoundTripListScreenState();
}

class _RoundTripListScreenState extends State<RoundTripListScreen> {

  RangeValues selectedPriceRange = const RangeValues(0, 100000);
  List<String> selectedDelTimes = [];

  bool isNonStop = true;
  Set<String> selectedAirlines = {};
  List<SearchResult> allFlights = [];
  List<SearchResult> filteredFlights = [];

  void _applyFilters({
    required bool nonStop,
    required bool oneStop,
    required RangeValues delPrice,
    required List<String> selectedDelTimes,
    required List<String> selectedAirlinesList,
  }) {
    List<SearchResult> filter(List<SearchResult> flightsList) {
      return flightsList.where((flight) {
        final stops = flight.segments![0].length - 1;
        final matchesStop =
            (!nonStop && !oneStop) ||
            (nonStop && stops == 0) ||
            (oneStop && stops == 1);

        final price = flight.fare!.publishedFare!;
        final matchesPrice = price >= delPrice.start && price <= delPrice.end;

        final hour =
            DateTime.parse(
              flight.segments![0][0].origin!.depTime!.toString(),
            ).hour;
        final matchesTime =
            selectedDelTimes.isEmpty ||
            selectedDelTimes.any((slot) => _matchTimeSlot(slot, hour));

        final airline = flight.segments![0][0].airline!.airlineName!;
        final matchesAirline =
            selectedAirlinesList.isEmpty ||
            selectedAirlinesList.contains(airline);

        return matchesStop && matchesPrice && matchesTime && matchesAirline;
      }).toList();
    }
    setState(() {
      filteredFlights = filter(allFlights);
      flights = List.from(filteredFlights);

      if (widget.flightSearchResponse.data!.searchResult!.length > 1) {
        flights2 = filter(widget.flightSearchResponse.data!.searchResult![1]);
      }
    });
  }

  void _openFilterSheet() async {
    final filters = await showFilterSheet(context, false);
    if (filters != null) {
      setState(() {
        isNonStop = filters['nonStop'];
        selectedAirlines = Set.from(filters['selectedAirlines']);
      });

      _applyFilters(
        nonStop: filters['nonStop'],
        oneStop: filters['oneStop'],
        delPrice: filters['delPrice'],
        selectedDelTimes: filters['selectedDelTimes'],
        selectedAirlinesList: filters['selectedAirlines'],
      );
    }
  }

  bool _matchTimeSlot(String slot, int hour) {
    switch (slot) {
      case "Early Morning":
        return hour < 6;
      case "Morning":
        return hour >= 6 && hour < 12;
      case "Mid Day":
        return hour >= 12 && hour < 18;
      case "Night":
        return hour >= 18;
      default:
        return false;
    }
  }

  void _openTimeFilterSheet() async {
    final filters = await showModalBottomSheet<Map<String, Set<String>>>(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => TimeBottomSheet(isOneWay: false),
    );

    if (filters != null) {
      final fromTimes = filters['fromTimes'] ?? {};
      final combinedTimeSlots = fromTimes.toList();

      _applyFilters(
        nonStop: isNonStop,
        oneStop: true, // or add a toggle if you have
        delPrice: RangeValues(
          0,
          100000,
        ), // you might want to keep track of this in state
        selectedDelTimes: combinedTimeSlots,
        selectedAirlinesList: selectedAirlines.toList(),
      );
    }
  }

  void _onNonStopChanged(bool value) {
    setState(() {
      isNonStop = value;

      filteredFlights =
          allFlights.where((flight) {
            final int stops = flight.segments![0].length - 1;

            // true = 0 stop, false = 1 stop
            return isNonStop ? stops == 0 : stops == 1;
          }).toList();

      flights = List.from(filteredFlights);
    });
  }

  void _openAirlineFilterSheet() async {
    final filters = await showModalBottomSheet<Set<String>>(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder:
          (context) =>
              AirlineBottomSheet(initiallySelectedAirlines: selectedAirlines),
    );

    if (filters != null) {
      setState(() {
        selectedAirlines = filters;
      });

      _applyFilters(
        nonStop: isNonStop,
        oneStop: true,
        delPrice: RangeValues(0, 100000), // track actual value
        selectedDelTimes: [],
        selectedAirlinesList: selectedAirlines.toList(),
      );
    }
  }

  void applySort(String? selectedSort) {
    setState(() {
      if (selectedSort != null) {
        int compare(SearchResult a, SearchResult b) {
          if (selectedSort == "Smart") {
            final departureA =
                DateTime.parse(
                  a.segments![0][0].origin!.depTime!.toString(),
                ).millisecondsSinceEpoch;
            final durationA = a.segments![0][0].duration!;
            final priceA = a.fare!.publishedFare!;

            final departureB =
                DateTime.parse(
                  b.segments![0][0].origin!.depTime!.toString(),
                ).millisecondsSinceEpoch;
            final durationB = b.segments![0][0].duration!;
            final priceB = b.fare!.publishedFare!;

            final scoreA = departureA + durationA * 1000 + priceA * 10;
            final scoreB = departureB + durationB * 1000 + priceB * 10;

            return scoreA.compareTo(scoreB);
          } else {
            switch (selectedSort) {
              case "Price":
                return a.fare!.publishedFare!.compareTo(b.fare!.publishedFare!);
              case "Departure":
                return DateTime.parse(
                  a.segments![0][0].origin!.depTime!.toString(),
                ).compareTo(
                  DateTime.parse(b.segments![0][0].origin!.depTime!.toString()),
                );
              case "Fastest":
                return a.segments![0][0].duration!.compareTo(
                  b.segments![0][0].duration!,
                );
              default:
                return 0;
            }
          }
        }

        filteredFlights.sort(compare);
        flights = List.from(filteredFlights);

        if (flights2.isNotEmpty) {
          flights2.sort(compare);
        }
      }
    });
  }

  void _navigatorFunc(int? price) {
    final viewModel = Provider.of<FlightQuoteViewModel>(context, listen: false);

    // Show loading
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const LoadingScreen()),
    );

    // Prepare request
    final request1 = FlightQuoteRequest(
      traceId: widget.flightSearchResponse.data!.traceId!,
      resultIndex: flights[selectedOnwardIndex!].resultIndex!,
    );
    final request2 = FlightQuoteRequest(
      traceId: widget.flightSearchResponse.data!.traceId!,
      resultIndex: flights2[selectedReturnIndex!].resultIndex!,
    );

    viewModel.fetchQuoteRT(request1, request2).then((_) {
      Navigator.pop(context);
      print('✅ Flight search completed');

      final response = viewModel.flightQuoteRes1;
      final responseReturn = viewModel.flightQuoteRes2;
      if (response != null) {
        final segments = response.data!.results!.segments!;
        final hasLayover = segments[0].length > 1;

        final firstSegment = segments[0][0];
        final lastSegment = hasLayover ? segments[0][1] : segments[0][0];
        //final segment = response.result.segments[0][0]; // First segment, first flight
        print("hii");
        // final firstSegment = response.data!.results!.segments![0][0];
        print("Origin City: ${firstSegment.origin?.airport?.cityName}");
        print(
          "Destination City: ${firstSegment.destination?.airport?.cityName}",
        );
        print("Dep Time: ${firstSegment.origin?.depTime}");
        print("Arr Time: ${firstSegment.destination?.arrTime}");
        print("Duration: ${firstSegment.duration}");
        print("Fare Class: ${firstSegment.airline?.fareClass}");
        print("Published Fare: ${response.data!.results!.fare?.publishedFare}");

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
          final layoverArrival = firstSegment.destination!.arrTime!;
          final layoverDeparture = lastSegment.origin!.depTime!;

          final layoverCityName = firstSegment.destination!.airport!.cityName!;
          final layoverCityAirportCode =
              firstSegment.destination!.airport!.airportCode!;

          final layoverMinutes =
              layoverDeparture.difference(layoverArrival).inMinutes;
          final layoverHours = layoverMinutes ~/ 60;
          final layoverRemainingMinutes = layoverMinutes % 60;

          layoverCity = layoverCityName;
          layoverCityCode = layoverCityAirportCode;
          layoverDuration =
              "${layoverHours}h ${layoverRemainingMinutes}m layover in $layoverCity";

          final originToLayoverMinutes = firstSegment.duration!;
          final layoverToDestination = lastSegment.duration!;
          final totalFlightHours = originToLayoverMinutes ~/ 60;
          final totalFlightRemainingMinutes = originToLayoverMinutes % 60;
          duration = "${totalFlightHours}h ${totalFlightRemainingMinutes}m";
          final totalFlightHoursA = layoverToDestination ~/ 60;
          final totalFlightRemMin = layoverToDestination % 60;
          durationA = "${totalFlightHoursA}h ${totalFlightRemMin}m";
        } else {
          final totalFlightMinutes = firstSegment.duration!;
          final hours = totalFlightMinutes ~/ 60;
          final minutes = totalFlightMinutes % 60;
          duration = "${hours}h ${minutes}m";
          durationA = '';
        }
        final returnSegments = responseReturn!.data!.results!.segments;
        final hasReturnLayover = returnSegments![0].length > 1;

        final firstReturnSegment = returnSegments[0][0];
        final lastReturnSegment =
            hasReturnLayover ? returnSegments[0][1] : returnSegments[0][0];

        String? returnLayoverCity;
        String? returnLayoverCityCode;
        String? returnLayoverDuration;
        String returnDuration;
        String returnDurationA;
        String returnFlightName =
            "${firstReturnSegment.airline!.airlineName!} | ${firstReturnSegment.airline!.flightNumber!}";
        String returnFlightName2 =
            "${lastReturnSegment.airline!.airlineName!} | ${lastReturnSegment.airline!.flightNumber!}";

        if (hasReturnLayover) {
          final returnLayoverArrival = firstReturnSegment.destination!.arrTime!;
          final returnLayoverDeparture = lastReturnSegment.origin!.depTime!;

          final layoverCityName =
              firstReturnSegment.destination!.airport!.cityName!;
          final layoverCityCodeTemp =
              firstReturnSegment.destination!.airport!.airportCode!;

          final layoverMinutes =
              returnLayoverDeparture.difference(returnLayoverArrival).inMinutes;
          final layoverHours = layoverMinutes ~/ 60;
          final layoverRemainingMinutes = layoverMinutes % 60;

          returnLayoverCity = layoverCityName;
          returnLayoverCityCode = layoverCityCodeTemp;
          returnLayoverDuration =
              "${layoverHours}h ${layoverRemainingMinutes}m layover in $returnLayoverCity";

          final originToLayoverDuration = firstReturnSegment.duration!;
          final layoverToDestination = lastReturnSegment.duration!;
          returnDuration =
              "${originToLayoverDuration ~/ 60}h ${originToLayoverDuration % 60}m";
          returnDurationA =
              "${layoverToDestination ~/ 60}h ${layoverToDestination % 60}m";
        } else {
          final totalReturnDuration = firstReturnSegment.duration!;
          returnDuration =
              "${totalReturnDuration ~/ 60}h ${totalReturnDuration % 60}m";
          returnDurationA = '';
        }

        Navigator.push(
          context,
          MaterialPageRoute(
            builder:
                (context) => RoundTripFlightReviewScreen(
                  selectedOnwardResultIndex: flights[selectedOnwardIndex!].resultIndex!,
                  selectedReturnResultIndex: flights2[selectedReturnIndex!].resultIndex!,
                  isLcc: response.data!.results!.isLcc!,
                  price:price,
                  originCity: firstSegment.origin!.airport!.cityName!,
                  destinationCity: lastSegment.destination!.airport!.cityName!,
                  originAirportCode: firstSegment.origin!.airport!.airportCode!,
                  destinationAirportCode:
                      lastSegment.destination!.airport!.airportCode!,
                  departure: firstSegment.origin!.depTime!.toString(),
                  arrival: lastSegment.destination!.arrTime!.toString(),
                  layoverArr: firstSegment.destination!.arrTime!.toString(),
                  layoverDep: lastSegment.origin!.depTime!.toString(),
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
                      firstSegment.destination!.airport!.terminal!,
                  layoverTerminalNo2: lastSegment.origin!.airport!.terminal!,
                  destinationTerminalNo:
                      lastSegment.destination!.airport!.terminal!,
                  publishedFare:
                      response.data!.results!.fare!.publishedFare!.toString(),
                  supplierFareClass: firstSegment.airline!.fareClass!,
                  supplierFareClass2: lastSegment.airline!.fareClass!,
                  resultIndex: response.data!.results!.resultIndex!,
                  traceId: response.data!.traceId,
                  layoverCity: layoverCity,
                  layoverCityCode: layoverCityCode,
                  layoverDuration: layoverDuration,
                  flightName: flightName,
                  flightName2: flightName2,
                  airlineName: firstSegment.airline!.airlineName!,
                  returnOriginCity:
                      firstReturnSegment.origin!.airport!.cityName!,
                  returnDestinationCity:
                      lastReturnSegment.destination!.airport!.cityName!,
                  returnOriginAirportCode:
                      firstReturnSegment.origin!.airport!.airportCode!,
                  returnDestinationAirportCode:
                      lastReturnSegment.destination!.airport!.airportCode!,
                  returnDeparture:
                      firstReturnSegment.origin!.depTime!.toString(),
                  returnArrival:
                      lastReturnSegment.destination!.arrTime!.toString(),
                  returnLayoverArr:
                      firstReturnSegment.destination!.arrTime!.toString(),
                  returnLayoverDep:
                      lastReturnSegment.origin!.depTime!.toString(),
                  returnDuration: returnDuration,
                  returnDurationA: returnDurationA,
                  returnOriginTerminalNo:
                      firstReturnSegment.origin!.airport!.terminal!,
                  returnLayoverTerminalNo:
                      firstReturnSegment.destination!.airport!.terminal!,
                  returnLayoverTerminalNo2:
                      lastReturnSegment.origin!.airport!.terminal!,
                  returnDestinationTerminalNo:
                      lastReturnSegment.destination!.airport!.terminal!,
                  returnPublishedFare:
                      responseReturn.data!.results!.fare!.publishedFare!
                          .toString(),
                  returnSupplierFareClass:
                      firstReturnSegment.airline!.fareClass!,
                  returnSupplierFareClass2:
                      lastReturnSegment.airline!.fareClass!,
                  returnResultIndex: responseReturn.data!.results!.resultIndex!,
                  returnTraceId: responseReturn.data!.traceId,
                  returnLayoverCity: returnLayoverCity,
                  returnLayoverCityCode: returnLayoverCityCode,
                  returnLayoverDuration: returnLayoverDuration,
                  returnFlightName: returnFlightName,
                  returnFlightName2: returnFlightName2,
                  returnAirlineName: firstReturnSegment.airline!.airlineName!,
                    fare:  response.data!.results!.fare!.toJson(),
                    fare2: responseReturn.data!.results!.fare!.toJson(), adultCount: widget.adultCount,
                ),
          ),
        );
      }
    });

    //Navigator.push(context, MaterialPageRoute(builder: (context)=>RoundTripFlightReviewScreen()));
  }

  void _openSortSheet() async {
    final result = await showModalBottomSheet<Map<String, String>>(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => const SortBottomSheet(),
    );

    if (result != null && result.containsKey('sortOption')) {
      applySort(result['sortOption']);
    }
  }

  int? selectedOnwardIndex;
  int? selectedReturnIndex;
  late List<SearchResult> flights;
  late List<SearchResult> flights2;

  final ScrollController _scrollController1 = ScrollController();
  final ScrollController _scrollController2 = ScrollController();
  Timer? _scrollStopTimer;
  bool _isScrolling = false;
  FlightSortType selectedSortType = FlightSortType.departure;
  SortOrder sortOrder = SortOrder.ascending;
  void _sortFlights() {
    int direction = sortOrder == SortOrder.ascending ? 1 : -1;
    void sortFlightList(List<SearchResult> listToSort) {
      switch (selectedSortType) {
        case FlightSortType.departure:
          listToSort.sort(
            (a, b) =>
                direction *
                DateTime.parse(
                  a.segments![0][0].origin!.depTime!.toString(),
                ).compareTo(
                  DateTime.parse(b.segments![0][0].origin!.depTime!.toString()),
                ),
          );
          break;
        case FlightSortType.duration:
          listToSort.sort(
            (a, b) =>
                direction *
                a.segments![0][0].duration!.compareTo(
                  b.segments![0][0].duration!,
                ),
          );
          break;
        case FlightSortType.price:
          listToSort.sort(
            (a, b) =>
                direction *
                a.fare!.publishedFare!.compareTo(b.fare!.publishedFare!),
          );
          break;
      }
    }

    sortFlightList(flights);
    sortFlightList(flights2);
  }

  @override
  void initState() {
    super.initState();

    final all = widget.flightSearchResponse.data!.searchResult!;
    allFlights = all.expand((e) => e).toList(); // One flat list of all flights

    flights = List.from(allFlights); // Initially show all
    flights2 = all[1]; // still used for round trip
    _scrollController1.addListener(_onScroll);
    _scrollController2.addListener(_onScroll);
  }

  void _onScroll() {
    if (!_isScrolling) {
      setState(() => _isScrolling = true);
    }

    _scrollStopTimer?.cancel();
    _scrollStopTimer = Timer(const Duration(milliseconds: 300), () {
      setState(() => _isScrolling = false);
    });
  }

  @override
  void dispose() {
    _scrollController1.dispose();
    _scrollController2.dispose();
    _scrollStopTimer?.cancel();
    super.dispose();
  }

  bool get _isFlightSelected =>
      selectedOnwardIndex != null && selectedReturnIndex != null;

  @override
  Widget build(BuildContext context) {
    final price = flights[selectedOnwardIndex ?? 0].fare!.publishedFare!.floor() + flights2[selectedReturnIndex ?? 0].fare!.publishedFare!.floor();
    bool isNonStop = true;
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          ResponsiveAppBar(
            title: "${widget.fromCity} to ${widget.toCity}",
            subtitle:
                "${DateFormat('EEE dd MMM').format(widget.departureDate)} | ${widget.adultCount} Adult",
            onFilter: () {},
            onMore: () {},
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            color: Colors.grey.shade200,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Left section (DEL - BOM)
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 10, 0, 5),
                    child: Column(
                      children: [
                        Text(
                          "${widget.fromCity} - ${widget.toCity}",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),

                // Full height vertical divider
                Container(
                  width: 2,
                  height: 40, // Match height of the tallest content
                  color: Colors.black26,
                  margin: const EdgeInsets.symmetric(horizontal: 12),
                ),

                // Right section (BOM - DEL)
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 10, 0, 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "${widget.toCity} - ${widget.fromCity}",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 8),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          FilterHeader(
            screenWidth: screenWidth,
            screenHeight: screenHeight,
            selectedSortType: selectedSortType,
            sortOrder: sortOrder,
            onSortSelected: (FlightSortType sortType) {
              setState(() {
                if (selectedSortType == sortType) {
                  sortOrder =
                      sortOrder == SortOrder.ascending
                          ? SortOrder.descending
                          : SortOrder.ascending;
                } else {
                  selectedSortType = sortType;
                  sortOrder = SortOrder.ascending;
                }
                _sortFlights(); // Make sure this sorts BOTH departure and return flights if round trip
              });
            },
          ),

          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: ListView.separated(
                    controller: _scrollController1,
                    padding: EdgeInsets.zero,
                    itemCount: flights.length,
                    separatorBuilder:
                        (_, __) => Divider(thickness: 2, height: 0),
                    itemBuilder: (context, index) {
                      final flight = flights[index];
                      final isSelected = selectedOnwardIndex == index;
                      return GestureDetector(
                        onTap:
                            () => setState(() {
                              selectedOnwardIndex =
                                  selectedOnwardIndex == index ? null : index;
                            }),
                        child: FlightContainer(
                          flight: flight,
                          selected: isSelected,
                          screenWidth: MediaQuery.of(context).size.width,
                        ),
                      );
                    },
                  ),
                ),
                VerticalDivider(thickness: 2, width: 2),
                Expanded(
                  child: ListView.separated(
                    controller: _scrollController2,
                    padding: EdgeInsets.zero,
                    itemCount: flights2.length,
                    separatorBuilder:
                        (_, __) => Divider(thickness: 2, height: 0),
                    itemBuilder: (context, index) {
                      final flight = flights2[index];
                      final isSelected = selectedReturnIndex == index;
                      return GestureDetector(
                        onTap:
                            () => setState(() {
                              selectedReturnIndex =
                                  selectedReturnIndex == index ? null : index;
                            }),
                        child: FlightContainer(
                          flight: flight,
                          selected: isSelected,
                          screenWidth: MediaQuery.of(context).size.width,
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),

      bottomSheet:
          _isFlightSelected
              ? buildBottomBar(context, (){
                _navigatorFunc(price);
          },price: price)
              : (_isScrolling
                  ? null
                  : FlightFilterBottomSheet(
                    onFilterTap: _openFilterSheet,
                    onNonStopChanged: _onNonStopChanged,
                    onTimeTap: _openTimeFilterSheet,
                    onAirlineTap: _openAirlineFilterSheet,
                    onSortTap: _openSortSheet,
                  )),
    );
  }
}
/*
enum SortOrder { ascending, descending }
enum FlightSortType { departure, duration, price }
*/

class FlightContainer extends StatelessWidget {
  final SearchResult flight;
  final bool selected;
  final double screenWidth;

  const FlightContainer({
    required this.flight,
    required this.selected,
    required this.screenWidth,
    Key? key,
  }) : super(key: key);

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
                  color: Colors.redAccent,
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

enum SortOrder { ascending, descending }

enum FlightSortType { departure, duration, price }

class FilterHeader extends StatelessWidget {
  final double screenWidth;
  final double screenHeight;
  final Function(FlightSortType) onSortSelected;
  final FlightSortType selectedSortType;
  final SortOrder sortOrder;

  const FilterHeader({
    required this.screenWidth,
    required this.screenHeight,
    required this.onSortSelected,
    required this.selectedSortType,
    required this.sortOrder,
  });

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> sortOptions = [
      {"label": "DEPARTURE", "type": FlightSortType.departure},
      {"label": "DURATION", "type": FlightSortType.duration},
      {"label": "PRICE", "type": FlightSortType.price},
    ];

    return Container(
      color: constants.ultraLightThemeColor1,
      height: screenHeight * 0.09,
      child: Row(
        children:
            sortOptions.map((option) {
              final label = option["label"];
              final type = option["type"];
              final bool isSelected = selectedSortType == type;
              final IconData arrowIcon =
                  isSelected
                      ? (sortOrder == SortOrder.ascending
                          ? Icons.arrow_upward
                          : Icons.arrow_downward)
                      : Icons.unfold_more;

              return Expanded(
                child: GestureDetector(
                  onTap: () => onSortSelected(type),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color:
                              isSelected
                                  ? constants.themeColor1
                                  : Colors.transparent,
                          width: 2,
                        ),
                      ),
                    ),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            label,
                            style: TextStyle(
                              fontSize: screenWidth * 0.035,
                              color:
                                  isSelected
                                      ? constants.themeColor1
                                      : constants.lightThemeColor1,
                              fontWeight:
                                  isSelected
                                      ? FontWeight.bold
                                      : FontWeight.w600,
                            ),
                          ),
                          const SizedBox(width: 4),
                          Icon(
                            arrowIcon,
                            size: 16,
                            color: constants.themeColor1,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
      ),
    );
  }
}
