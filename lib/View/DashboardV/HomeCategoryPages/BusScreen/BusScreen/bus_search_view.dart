import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../BusWidgets/bus_enums.dart';
import 'package:trip_go/View/DashboardV/HomeCategoryPages/BusScreen/AddOn/bus_add_on_page.dart';
import 'package:trip_go/View/DashboardV/HomeCategoryPages/BusScreen/BusWidgets/bus_star_sheet_filter.dart';
import 'package:trip_go/View/DashboardV/HomeCategoryPages/BusScreen/bus_review_and_travellers_page.dart';
import '../../../../../AppManager/Api/api_service/BusService/bus_search_service.dart';
import '../../../../../Model/BusM/bus_search_model.dart';
import '../../../../../ViewM/BusVM/bus_search_view_model.dart';
import '../BusWidgets/BusFilters/bus_price_filter.dart';
import '../BusWidgets/BusFilters/bus_seat_sheet_model.dart';
import '../BusWidgets/BusFilters/bus_sort_filter_sheet.dart';
import '../BusWidgets/bus_app_bar.dart';
import '../BusWidgets/bus_card.dart';
import '../BusWidgets/bus_enums.dart';
import '../BusWidgets/bus_filter_bottom_sheet.dart';
import '../BusWidgets/bus_filter_header.dart';
import '../BusWidgets/bus_sort_type.dart' as sort;
import 'bus_name_search_page.dart';
import 'bus_search_card.dart';

class BusSearchView extends StatefulWidget {
  final String fromCity;
  final String toCity;
  final String originId;
  final String destinationId;
  final DateTime travelDate;
  final bool? onBack;
 
  const BusSearchView({
    super.key,
    required this.fromCity,
    required this.toCity,
    required this.travelDate,
    required this.destinationId,
    required this.originId,
    this.onBack,
  });

  @override
  State<BusSearchView> createState() => _BusSearchViewState();
}

class _BusSearchViewState extends State<BusSearchView> {
  String formatDate(DateTime date) {
    return DateFormat('E, dd MMM').format(date);
  }

  Set<String> activeFilters = {};
  String? selectedPriceRange;

  sort.BusSortType selectedSortType = sort.BusSortType.departure;
  sort.SortOrder sortOrder = sort.SortOrder.ascending;

  BusSearchModel? searchData;
  bool isLoading = true;
  String? errorMessage;

  late BusSearchViewModel viewModel;

  @override
  void initState() {
    super.initState();

    final formattedDate = DateFormat('yyyy/MM/dd').format(widget.travelDate);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      viewModel = Provider.of<BusSearchViewModel>(context, listen: false);
      viewModel.searchBuses(
        dateOfJourney: formattedDate,
        originId: widget.originId,
        destinationId: widget.destinationId,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    String _calculateDuration(String start, String end) {
      final startTime = DateTime.parse(start);
      final endTime = DateTime.parse(end);
      final duration = endTime.difference(startTime);

      final hours = duration.inHours;
      final minutes = duration.inMinutes.remainder(60);
      return "${hours}h ${minutes}m";
    }

    final filters = ["6pm-12am", "AC", "Non-AC"];
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: BusAppBar(
        title: "${widget.fromCity} - ${widget.toCity}",
        subline: formatDate(widget.travelDate),
        onBack: () => Navigator.pop(context),
        onSearchTap: () {
          final busResults = viewModel.searchResult?.busResults ?? [];
          if (busResults.isNotEmpty) {
            final origin = viewModel.searchResult?.origin;
            final destination = viewModel.searchResult?.destination;
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => BusNameSearchPage(busList: busResults, origin: origin, destination: destination,),
                settings: RouteSettings(arguments: viewModel.searchResult?.traceId),
              ),
            );
          }
        },

        onEditTap: () {
          showGeneralDialog(
            context: context,
            barrierDismissible: true,
            barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
            barrierColor: Colors.black.withOpacity(0.4),
            transitionDuration: const Duration(milliseconds: 300),
            pageBuilder: (context, animation, secondaryAnimation) {
              return Align(
                alignment: Alignment.topCenter,
                child: Material(
                  color: Colors.transparent,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.vertical(bottom: Radius.circular(16)),
                    ),
                    constraints: const BoxConstraints(
                      maxHeight: 530,
                      minHeight: 300,
                    ),
                    child: BusSearchCard2(
                      fromCity: widget.fromCity,
                      toCity: widget.toCity,
                      originId: widget.originId,
                      destinationId: widget.destinationId,
                      travelDate: widget.travelDate,
                      onBack: true,
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
      body: Consumer<BusSearchViewModel>(
        builder: (context, viewModel, _) {
          final filters = ["6pm-12am", "AC", "Non-AC"];

          List<BusResult> busResults = sort.BusSortHelper.getSortedBusResults(
            results: viewModel.searchResult?.busResults ?? [],
            sortType: selectedSortType,
            sortOrder: sortOrder,
          );

          if (selectedPriceRange != null) {
            busResults = busResults.where((bus) {
              final price = bus.busPrice.basePrice ?? 0;

              switch (selectedPriceRange) {
                case "₹ 1 – ₹ 2,000":
                  return price >= 1 && price <= 2000;
                case "₹ 2,001 – ₹ 4,000":
                  return price > 2000 && price <= 4000;
                case "₹ 4,001 – ₹ 8,000":
                  return price > 4000 && price <= 8000;
                case "₹ 8,001 – ₹ 20,000":
                  return price > 8000 && price <= 20000;
                case "₹ 20,001 – ₹ 30,000":
                  return price > 20000 && price <= 30000;
                case "Above ₹ 30,000":
                  return price > 30000;
                default:
                  return true;
              }
            }).toList();
          }

          if (activeFilters.contains("6pm-12am")) {
            busResults = busResults.where((bus) {
              final departureHour = DateTime.parse(bus.departureTime).hour;
              return departureHour >= 18 && departureHour < 24;
            }).toList();
          }


          if (viewModel.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (viewModel.error != null) {
            return Center(child: Text(viewModel.error!));
          }

          return Column(
            children: [
              // Top Filters
              BusFilterHeader(
                screenWidth: MediaQuery.of(context).size.width,
                screenHeight: MediaQuery.of(context).size.height,
                onSortSelected: (type) {
                  setState(() {
                    selectedSortType = type;
                    sortOrder = sortOrder == sort.SortOrder.ascending
                        ? sort.SortOrder.descending
                        : sort.SortOrder.ascending;
                  });
                },
                selectedSortType: selectedSortType,
                sortOrder: sortOrder,
              ),

              // Recommended Toggle & Bus Count
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "${busResults.length} Buses Found",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        fontFamily: 'poppins',
                      ),
                    ),
                    const Row(
                      children: [
                        Text("Recommended",
                            style: TextStyle(fontSize: 12, fontFamily: 'poppins')),
                        Switch(value: false, onChanged: null),
                      ],
                    ),
                  ],
                ),
              ),

              // Quick Filters
              SizedBox(
                height: 40,
                child: ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (_, index) {
                    final filter = filters[index];
                    final isSelected = activeFilters.contains(filter);
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          if (isSelected) {
                            activeFilters.remove(filter);
                          } else {
                            activeFilters.add(filter);
                          }
                        });
                      },
                      child: Chip(
                        label: Text(
                          filter,
                          style: TextStyle(
                            fontFamily: 'poppins',
                            color: isSelected ? Colors.white : Colors.black,
                          ),
                        ),
                        backgroundColor: isSelected ? Colors.red : Colors.grey.shade200,
                      ),
                    );
                  },
                  separatorBuilder: (_, __) => const SizedBox(width: 8),
                  itemCount: filters.length,
                ),
              ),

              const Divider(),

              // Bus Card List
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(12),
                  itemCount: busResults.length,
                  itemBuilder: (context, index) {
                    final bus = busResults[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12.0),
                      child: GestureDetector(
                        onTap: () {
                          final traceId = viewModel.searchResult?.traceId;
                          final origin = viewModel.searchResult?.origin;
                          final destination = viewModel.searchResult?.destination;
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => BusAddOnPage(
                              travelName: bus.travelName,
                              traceId: traceId ?? '', resultIndex: bus.resultIndex.toString(), isDropPointMandatory: bus.isDropPointMandatory, busResults: busResults, origin: origin, destination : destination,
                              arrival: DateFormat('E, MMM dd, yyyy').format(DateTime.parse(bus.departureTime))
                            )),
                          );
                          // DateFormat('E, MMM dd, yyyy').format(DateTime.parse(selectedBus.departureTime)),
                        },
                        child: BusCard(
                          name: bus.travelName,
                          busType: bus.resultIndex.toString(),
                          availableSeats: bus.availableSeats.toString(),
                          departure: DateFormat.Hm()
                              .format(DateTime.parse(bus.departureTime)),
                          arrival: DateFormat.Hm()
                              .format(DateTime.parse(bus.arrivalTime)),
                          duration: _calculateDuration(
                              bus.departureTime, bus.arrivalTime),
                          rating: "4.0", // Placeholder
                          price: "₹${bus.busPrice.basePrice?.toStringAsFixed(2) ?? '0.00'}",
                          features: [
                            "MTicket: ${bus.mTicketEnabled ? 'Available' : 'Not-Available'}"
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(18)),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 6,
                offset: Offset(0, -1),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildBusBottomTab(context: context, icon: Icons.filter_alt, label: "FILTER"),
              _buildBusBottomTab(context: context, icon: Icons.star_border, label: "RATING"),
              _buildBusBottomTab(context: context, icon: Icons.currency_rupee, label: "PRICE"),
              _buildBusBottomTab(context: context, icon: Icons.event_seat, label: "SEAT TYPE"),
              _buildBusBottomTab(context: context, icon: Icons.sort, label: "SORT", showDot: true),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBusBottomTab({
    required BuildContext context,
    required IconData icon,
    required String label,
    bool showDot = false,
  }) {
    return GestureDetector(
      onTap: () {
        if (label == "FILTER") {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            builder: (context) => const BusFilterBottomSheet(),
          );
        }
        else if(label == "RATING"){
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            builder: (context) => const BusStarFilterSheet(),
          );
        }
        else if (label == "PRICE") {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            builder: (context) => const BusPriceFilterSheet(),
          ).then((result) {
            if (result != null && result is Map && result['price'] != null) {
              setState(() {
                selectedPriceRange = result['price'];
              });
            }
          });
        }
        else if(label == "SEAT TYPE"){
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            builder: (context) => BusSeatFilterSheet(),
          );
        }
        else if (label == "SORT") {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            builder: (context) => const BusSortFilterSheet(),
          ).then((selectedOption) {
            if (selectedOption != null && selectedOption is String) {
              setState(() {
                switch (selectedOption) {
                  case "Price: Low to High":
                    selectedSortType = sort.BusSortType.price;
                    sortOrder = sort.SortOrder.ascending;
                    break;
                  case "Price: High to Low":
                    selectedSortType = sort.BusSortType.price;
                    sortOrder = sort.SortOrder.descending;
                    break;
                  case "Departure: Earliest First":
                    selectedSortType = sort.BusSortType.departure;
                    sortOrder = sort.SortOrder.ascending;
                    break;
                  case "Departure: Latest First":
                    selectedSortType = sort.BusSortType.departure;
                    sortOrder = sort.SortOrder.descending;
                    break;
                  case "Duration: Shortest First":
                    selectedSortType = sort.BusSortType.duration;
                    sortOrder = sort.SortOrder.ascending;
                    break;
                  case "Duration: Longest First":
                    selectedSortType = sort.BusSortType.duration;
                    sortOrder = sort.SortOrder.descending;
                    break;
                  // case "Rating: High to Low":
                  //   selectedSortType = sort.BusSortType.rating;
                  //   sortOrder = sort.SortOrder.descending;
                  //   break;
                  default:
                    selectedSortType = sort.BusSortType.departure;
                    sortOrder = sort.SortOrder.ascending;
                }
              });
            }
          });
        }
        // Add other label checks if needed like "PRICE", "RATING", etc.
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Icon(icon, color: const Color(0xFF4A5568), size: 26),
              if (showDot)
                Positioned(
                  top: -2,
                  right: -2,
                  child: Container(
                    height: 8,
                    width: 8,
                    decoration: const BoxDecoration(
                      color: Color(0xffF73130),
                      shape: BoxShape.circle,
                    ),
                  ),
                )
            ],
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(
              fontSize: 11,
              color: Color(0xFF4A5568),
              fontWeight: FontWeight.w500,
            ),
          )
        ],
      ),
    );
  }
}


