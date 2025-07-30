import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:trip_go/Model/FlightM/round_trip_flight_search_model.dart';
import 'package:trip_go/View/DashboardV/HomeCategoryPages/FlightScreen/FlightReviewScreen/round_trip_flight_review_screen.dart';
import 'package:trip_go/View/DashboardV/HomeCategoryPages/FlightScreen/common_widget/bottom_bar.dart';
import 'package:intl/intl.dart';
import 'package:trip_go/ViewM/FlightVM/flight_quote_round_view_model.dart';
import '../../../../Model/FlightM/flight_quote_model.dart';
import '../../../../Model/FlightM/flight_quote_round_model.dart';
import '../../../../Model/FlightM/selected_upsell_class.dart';
import '../../../../Model/FlightM/upsell_model.dart';
import '../../../../ViewM/FlightVM/flight_quote_view_model.dart';
import '../../../../ViewM/FlightVM/upsell_view_model.dart';
import '../../../../constants.dart';
import 'FlightReviewScreen/flight_review_screen.dart';
import 'FlightWidgets/responsive_app_bar.dart';
import 'FlightWidgets/upsell_bottom_sheet.dart';
import 'common_widget/bottom_sgeets.dart';
import 'common_widget/filter_bootom_sheet/airline_bottom_sheet.dart';
import 'common_widget/filter_bootom_sheet/filter_bottom_sheet.dart';
import 'common_widget/filter_bootom_sheet/sort_by_bottom_sheet.dart';
import 'common_widget/filter_bootom_sheet/time_bootom_sheet.dart';
import 'common_widget/loading_screen.dart';
import 'flight_container.dart';
import 'flight_container_for_international.dart';
import 'flight_list_screen.dart';

class RoundTripListScreen extends StatefulWidget {
  final RoundTripFlightSearchModel flightSearchResponse;
  final DateTime departureDate;
  final int adultCount;
  final int? childrenCount;
  final int? infantsCount;
  final String fromCity;
  final String toCity;
  const RoundTripListScreen({
    super.key,
    required this.flightSearchResponse,
    required this.departureDate,
    required this.adultCount,
    this.childrenCount,
    this.infantsCount,
    required this.fromCity,
    required this.toCity,
  });

  @override
  State<RoundTripListScreen> createState() => _RoundTripListScreenState();
}

class _RoundTripListScreenState extends State<RoundTripListScreen> {

  RangeValues selectedPriceRange = const RangeValues(0, 100000);
  List<String> selectedDelTimes = [];
  Result? selectedFareFromUpsell;
  bool isNonStop = true;
  Set<String> selectedAirlines = {};
  List<SearchResult> allFlights = [];
  List<SearchResult> filteredFlights = [];
  int? selectedFareFromUpsellPrice;

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

  void _navigatorFunc(int? price) async {
    bool isInternationalTripFromUpsell(Result result) {
      final firstSegment = result.segments?[0][0];
      final lastSegment = result.segments?.last.last;

      final originCountry = firstSegment?.origin?.airport?.countryName;
      final destinationCountry = lastSegment?.destination?.airport?.countryName;

      return originCountry != null &&
          destinationCountry != null &&
          originCountry.toLowerCase() != destinationCountry.toLowerCase();
    }

    final viewModel = Provider.of<FlightQuoteRoundViewModel>(context, listen: false);
    final viewModel2 = Provider.of<FlightQuoteViewModel>(context, listen: false);

    final selectedFlight = selectedFareFromUpsell ?? flights[selectedOnwardIndex!];

    final isInternational = selectedFlight is SearchResult
        ? isInternationalTrip(selectedFlight)
        : isInternationalTripFromUpsell(selectedFlight as Result);

    final resultIndex = selectedFlight is SearchResult
        ? (selectedFlight as SearchResult).resultIndex
        : (selectedFlight as Result).resultIndex;

    if (resultIndex == null) {
      debugPrint("Error: resultIndex is null");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Something went wrong. Please try again.')),
      );
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const LoadingScreen()),
    );

    if (isInternational || selectedFareFromUpsell != null) {
      // 🔹 Handle INTERNATIONAL or one-way upsell quote
      final request = FlightQuoteRequest(
        traceId: widget.flightSearchResponse.data!.traceId!,
        resultIndex: resultIndex,
      );

      await viewModel2.fetchQuote(request);
      Navigator.pop(context); // Dismiss loading

      final response = viewModel2.flightQuoteModel;
      if (response != null) {
        final segments = response.data!.results!.segments!;
        final firstSegment = segments[0][0];
        final hasLayover = segments[0].length > 1;
        final lastSegment = hasLayover ? segments[0][1] : segments[0][0];

        String? layoverCity, layoverCityCode, layoverDuration;
        String duration, durationA = '';

        if (hasLayover) {
          final layoverArrival = firstSegment.destination!.arrTime!;
          final layoverDeparture = lastSegment.origin!.depTime!;
          final layoverMinutes = layoverDeparture.difference(layoverArrival).inMinutes;

          layoverCity = firstSegment.destination!.airport!.cityName!;
          layoverCityCode = firstSegment.destination!.airport!.airportCode!;
          layoverDuration = "${layoverMinutes ~/ 60}h ${layoverMinutes % 60}m layover in $layoverCity";

          final originDur = firstSegment.duration!;
          final layoverDur = lastSegment.duration!;
          duration = "${originDur ~/ 60}h ${originDur % 60}m";
          durationA = "${layoverDur ~/ 60}h ${layoverDur % 60}m";
        } else {
          final totalDur = firstSegment.duration!;
          duration = "${totalDur ~/ 60}h ${totalDur % 60}m";
        }

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => FlightReviewScreen(
              isInternational: isInternational,
              childrenCount: widget.childrenCount,
              infantCount: widget.infantsCount,
              adultCount: widget.adultCount,
              originCity: firstSegment.origin!.airport!.cityName!,
              destinationCity: lastSegment.destination!.airport!.cityName!,
              originAirportCode: firstSegment.origin!.airport!.airportCode!,
              destinationAirportCode: lastSegment.destination!.airport!.airportCode!,
              departure: firstSegment.origin!.depTime!.toString(),
              arrival: lastSegment.destination!.arrTime!.toString(),
              layoverArr: firstSegment.destination!.arrTime!.toString(),
              layoverDep: lastSegment.origin!.depTime!.toString(),
              duration: duration,
              durationA: durationA,
              originTerminalNo: firstSegment.origin!.airport!.terminal!,
              layoverTerminalNo: firstSegment.destination!.airport!.terminal!,
              layoverTerminalNo2: lastSegment.origin!.airport!.terminal!,
              destinationTerminalNo: lastSegment.destination!.airport!.terminal!,
              publishedFare: response.data!.results!.fare!.publishedFare!.floor(),
              supplierFareClass: firstSegment.airline!.fareClass!,
              supplierFareClass2: lastSegment.airline!.fareClass!,
              resultIndex: response.data!.results!.resultIndex!,
              traceId: response.data!.traceId!,
              layoverCity: layoverCity,
              layoverCityCode: layoverCityCode,
              layoverDuration: layoverDuration,
              flightName: "${firstSegment.airline!.airlineName!} | ${firstSegment.airline!.flightNumber!}",
              flightName2: "${lastSegment.airline!.airlineName!} | ${lastSegment.airline!.flightNumber!}",
              airlineName: firstSegment.airline!.airlineName!,
              fare: response.data!.results!.fare!.toJson(),
              isLcc: response.data!.results!.isLcc!,
            ),
          ),
        );
      }
    } else {
      // 🔹 DOMESTIC round-trip flow
      if (selectedReturnIndex == null || selectedReturnIndex! >= flights2.length) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please select a return flight')),
        );
        return;
      }

      final request = FlightQuoteRoundRequest(
        traceId: widget.flightSearchResponse.data!.traceId!,
        resultIndex: flights[selectedOnwardIndex!].resultIndex!,
        resultIndexIB: flights2[selectedReturnIndex!].resultIndex!,
      );

      await viewModel.fetchQuoteRoundRT(request);
      Navigator.pop(context); // Dismiss loading

      final response = viewModel.flightQuoteRoundRes1;
      if (response != null) {
        final seg = response.data!.results!.segments!;
        final inboundSeg = response.data!.inbound!.results!.segments!;
        final firstSeg = seg[0][0];
        final lastSeg = seg[0].length > 1 ? seg[0][1] : seg[0][0];

        final firstRet = inboundSeg[0][0];
        final lastRet = inboundSeg[0].length > 1 ? inboundSeg[0][1] : inboundSeg[0][0];

        // Calculate durations and layovers
        String duration = "${firstSeg.duration! ~/ 60}h ${firstSeg.duration! % 60}m";
        String durationA = seg[0].length > 1 ? "${lastSeg.duration! ~/ 60}h ${lastSeg.duration! % 60}m" : '';
        String returnDuration = "${firstRet.duration! ~/ 60}h ${firstRet.duration! % 60}m";
        String returnDurationA = inboundSeg[0].length > 1 ? "${lastRet.duration! ~/ 60}h ${lastRet.duration! % 60}m" : '';

        String? layoverCity, layoverCityCode, layoverDuration;
        if (seg[0].length > 1) {
          final layoverMinutes = lastSeg.origin!.depTime!.difference(firstSeg.destination!.arrTime!).inMinutes;
          layoverCity = firstSeg.destination!.airport!.cityName!;
          layoverCityCode = firstSeg.destination!.airport!.airportCode!;
          layoverDuration = "${layoverMinutes ~/ 60}h ${layoverMinutes % 60}m layover in $layoverCity";
        }

        String? returnLayoverCity, returnLayoverCityCode, returnLayoverDuration;
        if (inboundSeg[0].length > 1) {
          final retLayoverMinutes = lastRet.origin!.depTime!.difference(firstRet.destination!.arrTime!).inMinutes;
          returnLayoverCity = firstRet.destination!.airport!.cityName!;
          returnLayoverCityCode = firstRet.destination!.airport!.airportCode!;
          returnLayoverDuration = "${retLayoverMinutes ~/ 60}h ${retLayoverMinutes % 60}m layover in $returnLayoverCity";
        }

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => RoundTripFlightReviewScreen(
              childrenCount: widget.childrenCount,
              infantsCount: widget.infantsCount,
              selectedOnwardResultIndex: flights[selectedOnwardIndex!].resultIndex!,
              selectedReturnResultIndex: flights2[selectedReturnIndex!].resultIndex!,
              isLcc: response.data!.results!.isLcc!,
              isLccIb : flights2[selectedReturnIndex!].isLcc!,
              price: price,
              originCity: firstSeg.origin!.airport!.cityName!,
              destinationCity: lastSeg.destination!.airport!.cityName!,
              originAirportCode: firstSeg.origin!.airport!.airportCode!,
              destinationAirportCode: lastSeg.destination!.airport!.airportCode!,
              departure: firstSeg.origin!.depTime!.toString(),
              arrival: lastSeg.destination!.arrTime!.toString(),
              layoverArr: firstSeg.destination!.arrTime!.toString(),
              layoverDep: lastSeg.origin!.depTime!.toString(),
              duration: duration,
              durationA: durationA,
              originTerminalNo: firstSeg.origin!.airport!.terminal!,
              layoverTerminalNo: firstSeg.destination!.airport!.terminal!,
              layoverTerminalNo2: lastSeg.origin!.airport!.terminal!,
              destinationTerminalNo: lastSeg.destination!.airport!.terminal!,
              publishedFare: response.data!.results!.fare!.publishedFare!.toString(),
              supplierFareClass: firstSeg.airline!.fareClass!,
              supplierFareClass2: lastSeg.airline!.fareClass!,
              resultIndex: response.data!.results!.resultIndex!,
              traceId: response.data!.traceId,
              layoverCity: layoverCity,
              layoverCityCode: layoverCityCode,
              layoverDuration: layoverDuration,
              flightName: "${firstSeg.airline!.airlineName!} | ${firstSeg.airline!.flightNumber!}",
              flightName2: "${lastSeg.airline!.airlineName!} | ${lastSeg.airline!.flightNumber!}",
              airlineName: firstSeg.airline!.airlineName!,
              returnOriginCity: firstRet.origin!.airport!.cityName!,
              returnDestinationCity: lastRet.destination!.airport!.cityName!,
              returnOriginAirportCode: firstRet.origin!.airport!.airportCode!,
              returnDestinationAirportCode: lastRet.destination!.airport!.airportCode!,
              returnDeparture: firstRet.origin!.depTime!.toString(),
              returnArrival: lastRet.destination!.arrTime!.toString(),
              returnLayoverArr: firstRet.destination!.arrTime!.toString(),
              returnLayoverDep: lastRet.origin!.depTime!.toString(),
              returnDuration: returnDuration,
              returnDurationA: returnDurationA,
              returnOriginTerminalNo: firstRet.origin!.airport!.terminal!,
              returnLayoverTerminalNo: firstRet.destination!.airport!.terminal!,
              returnLayoverTerminalNo2: lastRet.origin!.airport!.terminal!,
              returnDestinationTerminalNo: lastRet.destination!.airport!.terminal!,
              returnPublishedFare: response.data!.inbound!.results!.fare!.publishedFare!.toString(),
              returnSupplierFareClass: firstRet.airline!.fareClass!,
              returnSupplierFareClass2: lastRet.airline!.fareClass!,
              returnResultIndex: response.data!.inbound!.results!.resultIndex!,
              returnTraceId: response.data!.traceId,
              returnLayoverCity: returnLayoverCity,
              returnLayoverCityCode: returnLayoverCityCode,
              returnLayoverDuration: returnLayoverDuration,
              returnFlightName: "${firstRet.airline!.airlineName!} | ${firstRet.airline!.flightNumber!}",
              returnFlightName2: "${lastRet.airline!.airlineName!} | ${lastRet.airline!.flightNumber!}",
              returnAirlineName: firstRet.airline!.airlineName!,
              fare: response.data!.results!.fare!.toJson(),
              fare2: response.data!.inbound!.results!.fare!.toJson(),
              adultCount: widget.adultCount,
            ),
          ),
        );
      }
    }
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
          listToSort.sort((a, b) {
            final aTime = _getDepTimeSafe(a);
            final bTime = _getDepTimeSafe(b);
            return direction * aTime.compareTo(bTime);
          });
          break;

        case FlightSortType.duration:
          listToSort.sort((a, b) {
            final aDuration = _getDurationSafe(a);
            final bDuration = _getDurationSafe(b);
            return direction * aDuration.compareTo(bDuration);
          });
          break;

        case FlightSortType.price:
          listToSort.sort((a, b) {
            final aPrice = a.fare?.publishedFare ?? double.infinity;
            final bPrice = b.fare?.publishedFare ?? double.infinity;
            return direction * aPrice.compareTo(bPrice);
          });
          break;
      }
    }

    sortFlightList(flights);
    sortFlightList(flights2);
  }

// === Safe helper methods ===
  DateTime _getDepTimeSafe(SearchResult result) {
    try {
      return DateTime.parse(
          result.segments?[0][0].origin?.depTime?.toString() ?? '');
    } catch (_) {
      return DateTime.fromMillisecondsSinceEpoch(0); // fallback time
    }
  }

  int _getDurationSafe(SearchResult result) {
    try {
      return result.segments?[0][0].duration ?? 999999;
    } catch (_) {
      return 999999;
    }
  }

  @override
  void initState() {
    super.initState();

    final all = widget.flightSearchResponse.data?.searchResult ?? [];

    allFlights = all.expand((e) => e).toList(); // Flatten

    flights = List.from(allFlights);

    if (all.length > 1) {
      flights2 = all[1]; // Return flights
    } else {
      flights2 = [];
      print("! Only one direction of flight data found. Return flights missing.");
    }

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

  bool get _isFlightSelected {
    final isInternational = flights.isNotEmpty && isInternationalTrip(flights[0]);
    if (selectedFareFromUpsell != null) return true;

    return isInternational
        ? selectedOnwardIndex != null
        : selectedOnwardIndex != null && selectedReturnIndex != null;
  }

  @override
  Widget build(BuildContext context) {
    double price = 0;
    bool isInternational = false;
    if (flights.isNotEmpty) {
      isInternational = isInternationalTrip(flights[0]);
    } else if (flights2.isNotEmpty) {
      isInternational = isInternationalTrip(flights2[0]);
    }

    if (selectedFareFromUpsell != null) {
      price = selectedFareFromUpsell!.fare?.publishedFare?.floorToDouble() ?? 0;
    } else if (flights.isNotEmpty && selectedOnwardIndex != null) {
      price = flights[selectedOnwardIndex!].fare!.publishedFare!.floorToDouble();
    }

    if (flights2.isNotEmpty && selectedReturnIndex != null) {
      price += flights2[selectedReturnIndex!].fare!.publishedFare!.floorToDouble();
    }

    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          ResponsiveAppBar(
            title: "${widget.fromCity} to ${widget.toCity}",
            subtitle: "${DateFormat('EEE dd MMM').format(widget.departureDate)} | ${widget.adultCount} Adult",
            onFilter: () {},
            onMore: () {},
          ),

          // Header with from-to
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            color: Colors.grey.shade200,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                Container(
                  width: 2,
                  height: 40,
                  color: Colors.black26,
                  margin: const EdgeInsets.symmetric(horizontal: 12),
                ),
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

          // Sort/filter header
          FilterHeader(
            screenWidth: screenWidth,
            screenHeight: screenHeight,
            selectedSortType: selectedSortType,
            sortOrder: sortOrder,
            onSortSelected: (FlightSortType sortType) {
              setState(() {
                if (selectedSortType == sortType) {
                  sortOrder = sortOrder == SortOrder.ascending
                      ? SortOrder.descending
                      : SortOrder.ascending;
                } else {
                  selectedSortType = sortType;
                  sortOrder = SortOrder.ascending;
                }
                _sortFlights();
              });
            },
          ),

          Expanded(
            child: isInternational
                ? buildFlightList(
              flights,
              selectedOnwardIndex,
              _scrollController1,
                  (index) {
                setState(() {
                  selectedOnwardIndex =
                  selectedOnwardIndex == index ? null : index;
                  // Clear return selection for international
                  selectedReturnIndex = null;
                });
              },
            )
                : (flights2.isEmpty
                ? buildFlightList(
              flights,
              selectedOnwardIndex,
              _scrollController1,
                  (index) {
                setState(() {
                  selectedOnwardIndex =
                  selectedOnwardIndex == index ? null : index;
                });
              },
            )
                : Row(
              children: [
                Expanded(
                  child: buildFlightList(
                    flights,
                    selectedOnwardIndex,
                    _scrollController1,
                        (index) {
                      setState(() {
                        selectedOnwardIndex =
                        selectedOnwardIndex == index ? null : index;
                      });
                    },
                  ),
                ),
                const VerticalDivider(thickness: 2, width: 2),
                Expanded(
                  child: buildFlightList(
                    flights2,
                    selectedReturnIndex,
                    _scrollController2,
                        (index) {
                      setState(() {
                        selectedReturnIndex =
                        selectedReturnIndex == index ? null : index;
                      });
                    },
                  ),
                ),
              ],
            )),
          )
        ],
      ),

      // Bottom bar
      bottomSheet: _isFlightSelected
          ? buildBottomBar(
        context,
            () {
          _navigatorFunc(price.toInt());
        },
        price: price.toInt(),
      )
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

  Widget buildFlightList(
      List<SearchResult> flightList,
      int? selectedIndex,
      ScrollController controller,
      Function(int) onTap,
      ) {
    // Check if any flight is international
    final hasInternational = flightList.any((flight) => isInternationalTrip(flight));

    return ListView.separated(
      controller: controller,
      padding: EdgeInsets.zero,
      itemCount: flightList.length,
      separatorBuilder: (_, __) => const Divider(thickness: 2, height: 0),
      itemBuilder: (context, index) {
        final flight = flightList[index];
        final isSelected = selectedIndex == index;

        // Use only one type of container based on list type
        return GestureDetector(
          onTap: () async {
            setState(() {
              onTap(index); // Visually select
              selectedOnwardIndex = index;
              if (isInternationalTrip(flight)) {
                selectedReturnIndex = null;
              }
            });

            if (hasInternational) {
              selectedFareFromUpsell = null;

              final upsellVM = Provider.of<UpsellViewModel>(context, listen: false);
              final body = {
                "TraceId": widget.flightSearchResponse.data?.traceId ?? "",
                "ResultIndex": flights[selectedOnwardIndex!].resultIndex ?? "",
              };

              await upsellVM.fetchUpsellDetails(body);

              if (!context.mounted) return;

              if (upsellVM.upsellModel?.data?.results?.isNotEmpty ?? false) {
                final SelectedUpsellData? selectedUpsell = await showModalBottomSheet<SelectedUpsellData>(
                  context: context,
                  isScrollControlled: true,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                  ),
                  builder: (context) => FractionallySizedBox(
                    heightFactor: 0.7, // Show 70% of the screen
                    child: UpsellBottomSheet(
                      traceId: widget.flightSearchResponse.data?.traceId ?? "",
                      resultIndex: flights[selectedOnwardIndex!].resultIndex ?? "",
                    ),
                  ),
                );
                print("⏎ Returned from bottom sheet: $selectedUpsell");
                if (selectedUpsell != null) {
                  setState(() {
                    selectedFareFromUpsell = selectedUpsell.result;
                    selectedFareFromUpsellPrice = selectedUpsell.price;
                  });

                  print("✅ Fare set: ₹${selectedUpsell.price}");
                }
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("No alternate fares available.")),
                );
              }
            }
          },
          child: hasInternational
              ? FlightContainerForInternational(
            flight: flight,
            selected: selectedOnwardIndex == index,
            screenWidth: MediaQuery.of(context).size.width,
          )
              : FlightContainer(
            flight: flight,
            selected: isSelected,
            screenWidth: MediaQuery.of(context).size.width,
          ),
        );

      },
    );
  }

  bool isInternationalTrip(SearchResult flight) {
    final onwardSegment = flight.segments?[0][0];
    final returnSegment = flight.segments?.length == 2 ? flight.segments![1][0] : null;

    final onwardOrigin = onwardSegment?.origin?.airport?.countryCode;
    final onwardDest = onwardSegment?.destination?.airport?.countryCode;

    final returnOrigin = returnSegment?.origin?.airport?.countryCode;
    final returnDest = returnSegment?.destination?.airport?.countryCode;

    bool isOnwardInternational = onwardOrigin != null &&
        onwardDest != null &&
        onwardOrigin.toUpperCase() != onwardDest.toUpperCase();

    bool isReturnInternational = returnOrigin != null &&
        returnDest != null &&
        returnOrigin.toUpperCase() != returnDest.toUpperCase();

    return isOnwardInternational || isReturnInternational;
  }

}
/*
enum SortOrder { ascending, descending }
enum FlightSortType { departure, duration, price }
*/



enum SortOrder { ascending, descending }

enum FlightSortType { departure, duration, price }

class FilterHeader extends StatelessWidget {
  final double screenWidth;
  final double screenHeight;
  final Function(FlightSortType) onSortSelected;
  final FlightSortType selectedSortType;
  final SortOrder sortOrder;

  const FilterHeader({super.key, 
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


