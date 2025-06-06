import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:trip_go/View/DashboardV/HomeCategoryPages/FlightScreen/common_widget/bottom_sgeets.dart';
import 'package:trip_go/View/DashboardV/HomeCategoryPages/FlightScreen/common_widget/filter_bootom_sheet/filter_bottom_sheet.dart';
import 'package:trip_go/View/DashboardV/HomeCategoryPages/FlightScreen/responsive_fare_option_section.dart';
import 'package:trip_go/View/DashboardV/HomeCategoryPages/FlightScreen/responsive_flight_card.dart';
import 'package:trip_go/constants.dart';
import '../../../../Model/FlightM/flight_search_model.dart';
import '../../../../ViewM/FlightVM/flight_search_view_model.dart';
import 'package:intl/intl.dart';
import 'FlightWidgets/responsive_app_bar.dart';
import 'common_widget/filter_bootom_sheet/airline_bottom_sheet.dart';
import 'common_widget/filter_bootom_sheet/sort_by_bottom_sheet.dart';
import 'common_widget/filter_bootom_sheet/time_bootom_sheet.dart';

class FlightListScreen extends StatefulWidget {
  final FlightSearchResponse flightSearchResponse;
  final DateTime departureDate;
  final int adultCount;
  final String fromCity;
  final String toCity;

  const FlightListScreen({
    Key? key,
    required this.flightSearchResponse,
    required this.departureDate,
    required this.adultCount,
    required this.fromCity,
    required this.toCity,
  }) : super(key: key);

  @override
  _FlightListScreenState createState() => _FlightListScreenState();

}

class _FlightListScreenState extends State<FlightListScreen> {
  int selectedDateIndex = 1;
  bool isNonStop = true;
  late ScrollController _scrollController;
  bool _showBottomSheet = true;
  int? selectedFlightIndex;
  late List<FlightResult> flights;
  late List<Map<String, String>> dates;
  FlightSortType selectedSortType = FlightSortType.departure;
  SortOrder sortOrder = SortOrder.ascending;
  bool isLoading = false;
  Set<String> selectedAirlines = {};
  List<FlightResult> allFlights = [];
  List<FlightResult> filteredFlights = [];

  @override
  void initState() {
    super.initState();
    DateTime searchDate = widget.departureDate;
    generateDateList(searchDate);
    initializeSelectedDateIndex(searchDate);
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      if (_scrollController.position.userScrollDirection == ScrollDirection.reverse) {
        if (_showBottomSheet) {
          setState(() {
            _showBottomSheet = false;
          });
        }
      } else if (_scrollController.position.userScrollDirection == ScrollDirection.forward) {
        if (!_showBottomSheet) {
          setState(() {
            _showBottomSheet = true;
          });
        }
      }
    });
    allFlights = widget.flightSearchResponse.results.expand((e) => e).toList();
    filteredFlights = List.from(allFlights);  // initially all flights shown
    flights = List.from(filteredFlights);
    flights = widget.flightSearchResponse.results.expand((e) => e).toList();
    generateDateList(widget.departureDate);
    // fetchFlightsForDate(widget.departureDate);
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

  void _openAirlineFilterSheet() async {
    final filters = await showModalBottomSheet<Set<String>>(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => AirlineBottomSheet(
        initiallySelectedAirlines: selectedAirlines,
      ),
    );

    if (filters != null) {
      setState(() {
        selectedAirlines = filters;
        _applyFilters();
      });
    }
  }

  void _applyFilters() {
    if (selectedAirlines.isEmpty) {
      filteredFlights = List.from(allFlights);
    } else {
      filteredFlights = allFlights.where((flight) {
        final airlineName = flight.segments[0][0].airline.airlineName;
        return selectedAirlines.contains(airlineName);
      }).toList();
    }
    setState(() {
      flights = List.from(filteredFlights);  // update the displayed flights list
    });
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
      applySort(result['sortOption']); // 🔥 Apply the selected sort option here
    }
  }

  void applySort(String? selectedSort) {
    setState(() {
      if (selectedSort != null) {
        if (selectedSort == "Smart") {
          filteredFlights.sort((a, b) {
            // Get values for A
            final departureA = DateTime.parse(a.segments[0][0].departureTime).millisecondsSinceEpoch;
            final durationA = a.segments[0][0].duration;
            final priceA = a.fare.publishedFare;

            // Get values for B
            final departureB = DateTime.parse(b.segments[0][0].departureTime).millisecondsSinceEpoch;
            final durationB = b.segments[0][0].duration;
            final priceB = b.fare.publishedFare;

            // Create a score: lower is better
            final scoreA = departureA + durationA * 1000 + priceA * 10;
            final scoreB = departureB + durationB * 1000 + priceB * 10;

            return scoreA.compareTo(scoreB);
          });
        } else {
          filteredFlights.sort((a, b) {
            switch (selectedSort) {
              case "Price":
                return a.fare.publishedFare.compareTo(b.fare.publishedFare);
              case "Departure":
                return DateTime.parse(a.segments[0][0].departureTime)
                    .compareTo(DateTime.parse(b.segments[0][0].departureTime));
              case "Fastest":
                return a.segments[0][0].duration.compareTo(b.segments[0][0].duration);
              default:
                return 0;
            }
          });
        }

        // Update the flights list shown in the UI
        flights = List.from(filteredFlights);
      }
    });
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
      final toTimes = filters['toTimes'] ?? {};

      setState(() {
        // Apply time slot filter to flights
        flights = widget.flightSearchResponse.results
            .expand((e) => e)
            .where((flight) {
          final departureTime = DateTime.parse(flight.segments[0][0].departureTime).hour;
          return fromTimes.any((slot) => _matchTimeSlot(slot, departureTime));
        }).toList();
      });
    }
  }

  void _onNonStopChanged(bool value) {
    setState(() {
      isNonStop = value;

      filteredFlights = allFlights.where((flight) {
        final int stops = flight.segments[0].length - 1;

        // true = 0 stop, false = 1 stop
        return isNonStop ? stops == 0 : stops == 1;
      }).toList();

      flights = List.from(filteredFlights);
    });
  }

  void _openFilterSheet() async {
    final filters = await showFilterSheet(context, false); // or true if roundtrip
    if (filters != null) {
      setState(() {
        isNonStop = filters['nonStop'];
        flights = widget.flightSearchResponse.results
            .expand((e) => e)
            .where((flight) {
          final bool filterNonStop = filters['nonStop'];
          final bool filterOneStop = filters['oneStop'];
          print("Filter NonStop: $filterNonStop, OneStop: $filterOneStop");
          final int stops = flight.segments[0].length - 1;

          final double price = flight.fare.publishedFare; // Adjust this based on your actual data
          final RangeValues priceRange = filters['delPrice'];
          final bool matchesPrice = price >= priceRange.start && price <= priceRange.end;

          final bool matchesStop;
          if (!filterNonStop && !filterOneStop) {
            matchesStop = true; // or false depending on your design
          } else {
            matchesStop = (filterNonStop && stops == 0) || (filterOneStop && stops == 1);
          }

          final String departureTimeStr = flight.segments[0][0].departureTime; // example: "2025-05-20T05:30:00"
          final DateTime departureTime = DateTime.parse(departureTimeStr);
          final int hour = departureTime.hour;
          final selectedDelTimes = filters['selectedDelTimes'] as List<String>;
          bool matchesTime = selectedDelTimes.isEmpty ||
              selectedDelTimes.any((slot) {
                if (slot == "Early Morning") return hour < 6;
                if (slot == "Morning") return hour >= 6 && hour < 12;
                if (slot == "Mid Day") return hour >= 12 && hour < 18;
                if (slot == "Night") return hour >= 18;
                return false;
              });

          final airlineName = flight.segments[0][0].airline.airlineName;
          final selectedAirlines = filters['selectedAirlines'] as List<String>;
          final bool matchesAirline = selectedAirlines.isEmpty || selectedAirlines.contains(airlineName);

          return matchesStop && matchesPrice && matchesTime && matchesAirline;
        })
            .toList();
      });
    }
  }

  void _sortFlights() {
    int direction = sortOrder == SortOrder.ascending ? 1 : -1;
    switch (selectedSortType) {
      case FlightSortType.departure:
        flights.sort((a, b) =>
        direction * DateTime.parse(a.segments[0][0].departureTime)
            .compareTo(DateTime.parse(b.segments[0][0].departureTime)));
        break;
      case FlightSortType.duration:
        flights.sort((a, b) =>
        direction * a.segments[0][0].duration.compareTo(b.segments[0][0].duration));
        break;
      case FlightSortType.price:
        flights.sort((a, b) =>
        direction * a.fare.publishedFare.compareTo(b.fare.publishedFare));
        break;
    }
  }

  void fetchFlightsForDate(DateTime selectedDate) async {
    setState(() {
      isLoading = true;  // Start loading
    });
    final viewModel = Provider.of<FlightSearchViewModel>(context, listen: false);
    final formattedDepartureDate = DateFormat('yyyy-MM-dd').format(selectedDate);
    final request = FlightSearchRequest(
      origin: widget.flightSearchResponse.origin,
      destination: widget.flightSearchResponse.destination,
      departureDate: formattedDepartureDate ?? "",
      adult: widget.adultCount ?? 1,
      child: 0,
      infant: 0,
      type: 1,
      cabin: 1,
      tboToken: "",
      partocrsSession: "",
    );

    await viewModel.searchFlights(request);

    setState(() {
      isLoading = false;  // Stop loading after response
    });

    if (viewModel.flightSearchResponse != null) {
      setState(() {
        flights = viewModel.flightSearchResponse!.results.expand((e) => e).toList();
        _sortFlights();
      });
    }
  }

  void generateDateList(DateTime baseDate) {
    final DateTime today = DateTime.now();
    final DateTime todayOnly = DateTime(today.year, today.month, today.day);

    dates = List.generate(5, (index) {
      DateTime date = baseDate.subtract(const Duration(days: 1)).add(Duration(days: index));
      DateTime dateOnly = DateTime(date.year, date.month, date.day);

      // Skip past dates
      if (dateOnly.isBefore(todayOnly)) return null;

      String formattedDate = DateFormat("MMM d").format(date);
      String price = "₹--";

      try {
        double fare = flights.first.fare.publishedFare;
        price = "₹${fare.toStringAsFixed(0)}";
      } catch (e) {
        price = "₹--";
      }

      return {
        "date": date.toIso8601String(),
        "formattedDate": formattedDate,
        "price": price,
      };
    }).whereType<Map<String, String>>().toList();
  }

  void initializeSelectedDateIndex(DateTime searchDate) {
    DateTime search = DateTime(searchDate.year, searchDate.month, searchDate.day);

    for (int i = 0; i < dates.length; i++) {
      DateTime date = DateTime.parse(dates[i]["date"]!);
      DateTime dateOnly = DateTime(date.year, date.month, date.day);

      if (dateOnly == search) {
        selectedDateIndex = i;
        return;
      }
    }

    // If not found, default to 0
    selectedDateIndex = 0;
  }

  final List<Map<String, String>> airlines = [
    {"name": "Air India", "logo": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS-QO8gVe353NPaAV3wid57LAtWqIdet-EVMA&s"},
    {"name": "Air India Express", "logo": "https://flight.easemytrip.com/Content/AirlineLogon/IX.png"},
    {"name": "Indigo", "logo": "https://flight.easemytrip.com/Content/AirlineLogon/6E.png"},
    {"name": "Vistara", "logo": "https://flight.easemytrip.com/Content/AirlineLogon/UK.png"},
    {"name": "SpiceJet", "logo": "https://flight.easemytrip.com/Content/AirlineLogon/SG.png"},
    {"name": "GoAir", "logo": "https://flight.easemytrip.com/Content/AirlineLogon/G8.png"},
    {"name": "Flynas", "logo": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR44aavq2U0IVMa98wKAQpI47r3nQ_-Q-O0GHi3PRnXyvwc571_m14YaLdk5GBcUjFPVgA&usqp=CAU"},
  ];

  String getAirlineLogo(String airlineName) {
    final airline = airlines.firstWhere(
          (airline) => airline['name']!.toLowerCase() == airlineName.toLowerCase(),
      orElse: () => {"logo": "https://via.placeholder.com/50"}, // fallback image
    );
    return airline['logo']!;
  }

  String formatDuration(int minutes) {
    final hours = minutes ~/ 60;
    final mins = minutes % 60;
    return '${hours}h ${mins}m';
  }

  String formatFlightTime(String timeString) {
    final dateTime = DateTime.parse(timeString);
    final formattedTime = DateFormat.Hm().format(dateTime); // 24-hour format e.g., 23:00
    return formattedTime;
  }

  void toggleFareOptions(int index) {
    setState(() {
      if (selectedFlightIndex == index) {
        selectedFlightIndex = null;
      } else {
        selectedFlightIndex = index;
      }
    });
  }

  @override
  Widget build(BuildContext context)  {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isSmallScreen = screenWidth < 600;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ResponsiveAppBar(
              title: "${widget.fromCity} to ${widget.toCity}",
              subtitle: "${DateFormat('EEE dd MMM').format(widget.departureDate)} | ${widget.adultCount} Adult",
              onFilter: () {},
              onMore: () {},
            ),
            const Divider(height: 1),
            // Horizontal date selector
            Container(
              color: Colors.white,
              height: screenHeight * 0.08,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: dates.length,
                itemBuilder: (context, index) {
                  final dateInfo = dates[index];
                  DateTime itemDate = DateTime.parse(dateInfo["date"]!);

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedDateIndex = index;
                        fetchFlightsForDate(itemDate);
                      });
                    },
                    child: Container(
                      width: screenWidth * 0.22,
                      margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.015),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: selectedDateIndex == index ? Colors.blueAccent : Colors.transparent,
                            width: 2,
                          ),
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            dateInfo["formattedDate"] ?? '',
                            style: TextStyle(
                              fontSize: screenWidth * 0.035,
                              color: selectedDateIndex == index ? constants.themeColor1 : Colors.black,
                              fontWeight: selectedDateIndex == index ? FontWeight.bold : FontWeight.normal,
                            ),
                          ),
                          SizedBox(height: screenHeight * 0.005),
                          Text(
                            dateInfo["price"] ?? '',
                            style: TextStyle(
                              fontSize: screenWidth * 0.035,
                              color: constants.themeColor2,
                              fontWeight: selectedDateIndex == index ? FontWeight.bold : FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
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
                    // Toggle sort order
                    sortOrder = sortOrder == SortOrder.ascending
                        ? SortOrder.descending
                        : SortOrder.ascending;
                  } else {
                    // New sort type selected, reset to ascending
                    selectedSortType = sortType;
                    sortOrder = SortOrder.ascending;
                  }
                  _sortFlights();
                });
              },
            ),

            if (isLoading)
              Padding(
                padding: const EdgeInsets.only(top: 180),
                child: Center(child: Text("Fetching Data...", style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                  fontFamily: 'poppins',
                  fontWeight: FontWeight.w500,
                ),)),
              ),

            if (!isLoading)

              Flexible(
                child: ListView.builder(
                  controller: _scrollController,
                  padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                  itemCount: flights.length,
                  itemBuilder: (context, index) {
                    final flight = flights[index];
                    return GestureDetector(
                      onTap: () => toggleFareOptions(index),
                      child: Column(
                        children: [
                          ResponsiveFlightCard(
                            arrivalDate: flight.segments[0][0].arrivalTime,
                            departureDate: flight.segments[0][0].departureTime,
                            departure: formatFlightTime(flight.segments[0][0].departureTime), // adjust formatting
                            duration: formatDuration(flight.segments[0][0].duration),            // define helper function if needed
                            arrival: formatFlightTime(flight.segments[0].last.arrivalTime),   // last segment's arrival
                            stops: "${flight.segments[0].length - 1} stop(s)",
                            flightNo: "${flight.segments[0][0].airline.airlineCode}-${flight.segments[0][0].airline.flightNumber}",
                            price: "Avg ₹ ${flight.fare.publishedFare.floor()}",
                            publishedFare: "₹ ${flight.fare.publishedFare.floor()}",
                            airlineName: flight.segments[0][0].airline.airlineName,
                            screenWidth: screenWidth,
                            // img: getAirlineLogo(flight.segments[0][0].airline.airlineCode), // optional helper
                            img: getAirlineLogo(flight.segments[0][0].airline.airlineName),
                          ),
                          if (selectedFlightIndex == index)
                            ResponsiveFareOptionsSection(
                              screenWidth: screenWidth,
                              flightSearchResponse: widget.flightSearchResponse,
                              publishedFare: flight.fare.publishedFare.floor(),
                              baseFare: flight.fare.baseFare.toString(),
                              supplierFareClass: flight.segments[0][0].supplierFareClass,
                              cabinBaggage: flight.segments[0][0].cabinBaggage,
                              baggage: flight.segments[0][0].baggage,
                              originCity: flight.segments[0][0].originCityName,
                              destinationCity: flight.segments[0][0].destinationCityName,
                              originCountry: flight.segments[0][0].originCountryCode,
                              destinationCountry: flight.segments[0][0].destinationCountryCode,
                              arrival: flight.segments[0][0].arrivalTime,
                              departure: flight.segments[0][0].departureTime,
                              originTerminalNo: flight.segments[0][0].originTerminal,
                              destinationTerminalNo: flight.segments[0][0].destinationTerminal,
                              duration: flight.segments[0][0].duration.toString(), resultIndex:flight.resultIndex,
                              traceId:widget.flightSearchResponse.traceId,
                              adultCount:widget.adultCount
                            ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            if (isLoading)
              Spacer(),
            if (_showBottomSheet)
              FlightFilterBottomSheet(
                onNonStopChanged: _onNonStopChanged,
                onFilterTap: () => _openFilterSheet(),
                onTimeTap: () => _openTimeFilterSheet(),
                onAirlineTap: () => _openAirlineFilterSheet(),
                onSortTap: () =>_openSortSheet(),
                showSortNotification: true,
              ),
          ],
        ),
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
      height: screenHeight * 0.06,
      child: Row(
        children: sortOptions.map((option) {
          final label = option["label"];
          final type = option["type"];
          final bool isSelected = selectedSortType == type;
          final IconData arrowIcon = isSelected
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
                      color: isSelected ? constants.themeColor1 : Colors.transparent,
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
                          color: isSelected ? constants.themeColor1 : constants.lightThemeColor1,
                          fontWeight: isSelected ? FontWeight.bold : FontWeight.w600,
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