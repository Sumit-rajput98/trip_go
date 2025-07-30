import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:trip_go/View/DashboardV/HomeCategoryPages/HotelScreen/Filters/amenities_bottom_sheet.dart';
import 'package:trip_go/View/DashboardV/HomeCategoryPages/HotelScreen/Filters/hotel_filter_bottom_sheet.dart';
import 'package:trip_go/View/DashboardV/HomeCategoryPages/HotelScreen/Filters/price_filter_bottom-sheet.dart';
import 'package:trip_go/View/DashboardV/HomeCategoryPages/HotelScreen/Filters/ratings_filter_bottom_sheet.dart';
import 'package:trip_go/View/DashboardV/HomeCategoryPages/HotelScreen/Filters/sort_by_bottom_sheet.dart';
import 'package:trip_go/View/DashboardV/HomeCategoryPages/HotelScreen/HotelDetail/hotel_detail_page.dart';
import 'package:trip_go/View/Widgets/custom_app_bar.dart';
import 'package:trip_go/View/Widgets/gradient_button.dart';
import 'package:trip_go/ViewM/HotelVM/hotel_search_view_model.dart';
import 'package:trip_go/constants.dart';

import '../../../../Model/HotelM/hotel_search_model.dart';
import 'Widget/hotel_app_bar.dart';
import 'Widget/hotel_search_card.dart';
import 'Widget/hotel_search_card2.dart';
import 'Widget/property_search_page.dart';

class HotelSearchResultPage extends StatefulWidget {
  final String city;
  final String cin;
  final String cout;
  final String rooms;
  final String pax;
  final int totalGuests;

  const HotelSearchResultPage({
    super.key,
    required this.city,
    required this.cin,
    required this.cout,
    required this.rooms,
    required this.pax,
    required this.totalGuests,
  });

  @override
  State<HotelSearchResultPage> createState() => _HotelSearchResultPageState();
}

class _HotelSearchResultPageState extends State<HotelSearchResultPage> {
  int adults = 0;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _fetchData());
  }

  Future<void> _fetchData() async {
    final vm = Provider.of<HotelSearchViewModel>(context, listen: false);
    await vm.searchHotels({
      "city": widget.city,
      "Rooms": widget.rooms,
      "cin": widget.cin,
      "cOut": widget.cout,
      "pax": widget.pax,
    });
  }

  int _calculateNights(String cin, String cout) {
    try {
      final checkIn = DateFormat("yyyy-MM-dd").parse(cin);
      final checkOut = DateFormat("yyyy-MM-dd").parse(cout);
      return checkOut.difference(checkIn).inDays;
    } catch (_) {
      return 1;
    }
  }

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<HotelSearchViewModel>(context, listen: false);
    adults = vm.searchResult?.data?.rooms?.first.adults ?? 0;
    String formatDate(String dateStr) {
      DateTime date = DateTime.parse(dateStr);
      return DateFormat('E, dd MMM').format(date);
    }
    String _trimText(String text, [int maxLength = 20]) {
      return text.length <= maxLength ? text : '${text.substring(0, maxLength)}...';
    }
    String getHotelRatingStatus(String? starRatingStr) {
      final rating = double.tryParse(starRatingStr ?? '');
      if (rating == null) return "Unrated";
      if (rating >= 4.5) return "Excellent";
      if (rating >= 4.0) return "Very Good";
      if (rating >= 3.0) return "Good";
      if (rating >= 2.0) return "Average";
      if (rating >= 1.0) return "Poor";

      return "Unrated";
    }

    final nights = _calculateNights(widget.cin, widget.cout);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: HotelAppBar(
        title: widget.city,
        subline: "${formatDate(widget.cin)} - ${formatDate(widget.cout)} | ${widget.totalGuests} Adults | ${widget.rooms} Room",
        onBack: () => Navigator.pop(context),
          onSearchTap: () {
            List<String> paxParts = widget.pax.split("_");
            int parsedAdults = int.parse(paxParts[0]);
            int parsedChildren = paxParts.length > 1 ? int.parse(paxParts[1]) : 0;
            List<int> parsedChildAges = paxParts.length > 2
                ? paxParts.sublist(2).map(int.parse).toList()
                : [];

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
                        maxHeight: 540,
                        minHeight: 300,
                      ),
                      child: HotelSearchCard2(
                        city: widget.city,
                        checkIn: DateFormat('MM/dd/yyyy').format(DateTime.parse(widget.cin)),
                        checkOut: DateFormat('MM/dd/yyyy').format(DateTime.parse(widget.cout)),
                        rooms: int.parse(widget.rooms),
                        adults: parsedAdults,
                        children: parsedChildren,
                        childAges: parsedChildAges,
                        onBack: true,
                      ),
                    ),
                  ),
                );
              },
            );
          },
        onEditTap: () async {
          final vm = Provider.of<HotelSearchViewModel>(context, listen: false);
          final result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => PropertySearchPage(hotelList: vm.filteredHotels),
            ),
          );

          if (result != null && result is Hotel0) {
            // Do something with selected hotel
            print("Selected hotel: ${result.name}");

            // Optionally navigate to details
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => HotelDetailPage(
                  rooms: result.rooms ?? [],
                  hid: result.hotelCode ?? '',
                  batchKey: vm.searchResult?.data?.batchKey ?? '',
                  city: widget.city,
                  cin: widget.cin,
                  cout: widget.cout,
                  room: widget.rooms,
                  pax: widget.pax,
                  totalGuests: widget.totalGuests,
                ),
              ),
            );
          }
        },

      ),
      // bottomNavigationBar: _buildBottomFilterBar(context),
      body: Consumer<HotelSearchViewModel>(
        builder: (context, vm, _) {
          return Column(
            children: [
             // _buildBottomFilterBar(context),
              // _buildTopBar(),
              Expanded(
                child: RefreshIndicator(
                  onRefresh: _fetchData,
                  child: vm.isLoading
                      ? _buildShimmerList()
                      : vm.filteredHotels.isEmpty
                          ? ListView(
                              physics: const AlwaysScrollableScrollPhysics(),
                              children: [
                                const SizedBox(height: 100),
                                Center(
                                  child: Text(
                                    "No data found",
                                    style: GoogleFonts.poppins(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ],
                            )
                          : ListView.builder(
                    padding: const EdgeInsets.only(bottom: 16),
                    itemCount: vm.filteredHotels.length + 1,
                    itemBuilder: (context, index) {
                      if (index == 0) {
                        return _buildHotelCount(vm);
                      }

                      final hotel = vm.filteredHotels[index - 1];
                      final room = hotel.rooms?.isNotEmpty == true ? hotel.rooms?.first : null;

                      // ✅ Safe check for getHotelsData length
                      final data = (index - 1 < vm.getHotelsData.length)
                          ? vm.getHotelsData[index - 1]
                          : null;

                      return Padding(
                        padding: const EdgeInsets.all(12),
                        child: GestureDetector(
                          onTap: (){
                            final vm = Provider.of<HotelSearchViewModel>(context, listen: false);
                            final batchKey = vm.searchResult?.data?.batchKey ?? '';
                            final rooms = hotel.rooms ?? [];

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HotelDetailPage(
                                  rooms: rooms,
                                  hid: hotel.hotelCode.toString(),
                                  batchKey: batchKey,
                                  city: widget.city,
                                  cin: widget.cin,
                                  cout: widget.cout,
                                  room: widget.rooms,
                                  pax: widget.pax,
                                  totalGuests: widget.totalGuests,
                                ),
                              ),
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.shade300,
                                  blurRadius: 6,
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Stack(
                                  children: [
                                    ClipRRect(
                                      borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                                      child: Image.network(
                                        hotel.images ?? 'https://upload.wikimedia.org/wikipedia/commons/7/75/No_image_available.png?20161129022009',
                                        height: 180,
                                        width: double.infinity,
                                        fit: BoxFit.cover,
                                        errorBuilder: (_, __, ___) => Container(
                                          height: 180,
                                          color: Colors.grey[200],
                                          child: const Icon(Icons.hotel, size: 50),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      top: 10,
                                      left: 10,
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                        decoration: BoxDecoration(
                                          color: constants.themeColor1,
                                          borderRadius: BorderRadius.circular(4),
                                        ),
                                        child: Row(
                                          children: [
                                            const Icon(Icons.verified, size: 12, color: Colors.white),
                                            const SizedBox(width: 4),
                                            Text("TGo Preferred", style: GoogleFonts.poppins(color: Colors.white, fontSize: 10)),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(12),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          if (room?.roomPromotion != null && room!.roomPromotion!.isNotEmpty && room.mealType!.isNotEmpty)
                                            _tag(room.roomPromotion!.first, constants.themeColor1),
                                          _tag(
                                            room?.isRefundable == true ? "Refundable" : "Non-Refundable",
                                            room?.isRefundable == true ? Colors.green : constants.themeColor2,
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 10,),
                                      // Hotel name and stars
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child: Text(
                                              _trimText(hotel.name ?? "Hotel"),
                                              style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 16),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          Row(children: _buildStars(hotel.starRating)),
                                        ],
                                      ),

                                      const SizedBox(height: 2),

                                      // Location
                                      Text(
                                        "${hotel.address}",
                                        style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey[600]),
                                      ),

                                      const SizedBox(height: 6),

                                      // Price and rating row
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          // Rating
                                          Container(
                                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                                            decoration: BoxDecoration(
                                              color: Colors.green,
                                              borderRadius: BorderRadius.circular(6),
                                            ),
                                            child: Row(
                                              children: [
                                                const Icon(Icons.star, size: 12, color: Colors.white),
                                                const SizedBox(width: 4),
                                                Text(
                                                  "${hotel.starRating} ${getHotelRatingStatus(hotel.starRating)}",
                                                  style: GoogleFonts.poppins(color: Colors.white, fontSize: 10),
                                                ),
                                              ],
                                            ),
                                          ),

                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.end,
                                            children: [
                                              Text(
                                                "₹${room?.totalFare?.toStringAsFixed(0) ?? '0'}",
                                                style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold),
                                              ),
                                              Text(
                                                "+₹${room?.totalTax?.toStringAsFixed(0) ?? '0'} Taxes & fees\nPer night",
                                                style: GoogleFonts.poppins(fontSize: 10, color: Colors.grey[700]),
                                                textAlign: TextAlign.right,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),

                                      const SizedBox(height: 8),

                                      // Cancellation policy
                                      if (room?.isRefundable == true)
                                        Text(
                                          "✓ Free Cancellation",
                                          style: GoogleFonts.poppins(color: Colors.green, fontSize: 12),
                                        ),

                                      const SizedBox(height: 6),

                                      // Amenities tag (e.g., Free Wi-Fi)
                                      Wrap(
                                        spacing: 6,
                                        children: [
                                          _tag(room?.inclusion ?? '', Colors.grey.shade400),
                                          if (room?.mealType != null && room!.mealType!.isNotEmpty)
                                            _tag(room.mealType!, Colors.grey.shade400),
                                        ],
                                      ),

                                      const SizedBox(height: 10),

                                      // GradientButton(
                                      //   label: "View Room",
                                      //   onPressed: () {
                                      //     final vm = Provider.of<HotelSearchViewModel>(context, listen: false);
                                      //     final batchKey = vm.searchResult?.data?.batchKey ?? '';
                                      //     final rooms = hotel.rooms ?? [];
                                      //
                                      //     Navigator.push(
                                      //       context,
                                      //       MaterialPageRoute(
                                      //         builder: (context) => HotelDetailPage(
                                      //           rooms: rooms,
                                      //           hid: hotel.hotelCode.toString(),
                                      //           batchKey: batchKey,
                                      //           city: widget.city,
                                      //           cin: widget.cin,
                                      //           cout: widget.cout,
                                      //           room: widget.rooms,
                                      //           pax: widget.pax,
                                      //           totalGuests: widget.totalGuests,
                                      //         ),
                                      //       ),
                                      //     );
                                      //   },
                                      // ),
                                    ],
                                  ),
                                ),
                              ],
                            ),

                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          );
        },
      ),
      bottomNavigationBar: _buildBottomFilterBar(context),   
    );
  }

  Widget _buildHotelCount(HotelSearchViewModel vm) {
    final count = vm.searchResult?.data?.hotels?.length ?? 0;
    return Container(
      margin: const EdgeInsets.only(top: 6, bottom: 10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [BoxShadow(color: Colors.grey.shade300, blurRadius: 4)],
      ),
      child: Text(
        "$count Hotels Available",
        style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 14),
      ),
    );
  }

  List<Widget> _buildStars(String? rating) {
    final filled = int.tryParse(rating?.split(".").first ?? "0") ?? 0;
    return List.generate(5, (index) {
      return Icon(Icons.star, size: 18, color: index < filled ? constants.themeColor1 : Colors.grey.shade300);
    });
  }

  Widget _tag(String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(4)),
      child: Text(label, style: GoogleFonts.poppins(fontSize: 11, color: color, fontWeight: FontWeight.w500)),
    );
  }

  Widget _buildShimmerList() {
    return ListView.builder(
      itemCount: 3,
      padding: const EdgeInsets.all(12),
      itemBuilder: (_, __) => Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        child: Container(
          margin: const EdgeInsets.only(bottom: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              Container(height: 180, width: double.infinity, color: Colors.white),
              Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(height: 16, width: 150, color: Colors.white),
                    const SizedBox(height: 8),
                    Container(height: 14, width: 200, color: Colors.white),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Container(height: 20, width: 80, color: Colors.white),
                        const SizedBox(width: 10),
                        Container(height: 20, width: 100, color: Colors.white),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Container(height: 20, width: double.infinity, color: Colors.white),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(height: 16, width: 80, color: Colors.white),
                        Container(height: 16, width: 60, color: Colors.white),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Container(height: 30, width: double.infinity, color: Colors.white),
                    const SizedBox(height: 12),
                    Container(height: 40, width: double.infinity, color: Colors.white),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
Widget _buildBottomFilterBar(BuildContext context) {
  return SafeArea(
    child: HotelFilterBottomSheet(
      onFilterTap: () async {
        final result = await showModalBottomSheet<Map<String, dynamic>>(
          context: context,
          isScrollControlled: true,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          builder: (_) => const HotelMainFilterSheet(),
        );
        
        // Handle filter result...
      },
      onRatingTap: () async {
        final result = await showModalBottomSheet<int>(
          context: context,
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          builder: (_) => const RatingFilterBottomSheet(),
        );
        if (result != null) {
          Provider.of<HotelSearchViewModel>(context, listen: false).filterByRating(result);
        }
      },
      onPriceTap: () async {
        final result = await showModalBottomSheet<String?>(
          context: context,
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          builder: (_) => const PriceFilterBottomSheet(),
        );
        if (result != null) {
          Provider.of<HotelSearchViewModel>(context, listen: false).filterByPriceRange(result);
        }
      },
      onAmenitiesTap: () async {
        final result = await showModalBottomSheet<Set<String>>(
          context: context,
          isScrollControlled: true,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          builder: (_) => const AmenitiesBottomSheet(),
        );
    
        if (result != null && result.isNotEmpty) {
          Provider.of<HotelSearchViewModel>(context, listen: false)
              .filterByAmenities(result);
        }
      },
      onSortTap:() async {
        final  result = await showModalBottomSheet<String?>(
          context: context,
          isScrollControlled: true,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          builder: (_) => const SortByBottomSheet(),
        );
    
        if (result != null && result.isNotEmpty) {
          Provider.of<HotelSearchViewModel>(context, listen: false)
              .sortHotels(result);
        }
      },
      showSortNotification: true, 
    ),
  );
}
}


class HotelFilterBottomSheet extends StatelessWidget {
  final VoidCallback onFilterTap;
  final VoidCallback onRatingTap;
  final VoidCallback onPriceTap;
  final VoidCallback onAmenitiesTap;
  final VoidCallback onSortTap;
  final bool showSortNotification;

  const HotelFilterBottomSheet({
    super.key,
    required this.onFilterTap,
    required this.onRatingTap,
    required this.onPriceTap,
    required this.onAmenitiesTap,
    required this.onSortTap,
    this.showSortNotification = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(18)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildTab(
            icon: Icons.filter_list, 
            label: "FILTER", 
            onTap: onFilterTap
          ),
          _buildTab(
            icon: Icons.star, 
            label: "RATING", 
            onTap: onRatingTap
          ),
          _buildTab(
            icon: Icons.attach_money, 
            label: "PRICE", 
            onTap: onPriceTap
          ),
          _buildTab(
            icon: Icons.widgets, 
            label: "AMENITIES", 
            onTap: onAmenitiesTap
          ),
          _buildTab(
            icon: Icons.sort, 
            label: "SORT", 
            onTap: onSortTap,
            showDot: showSortNotification,
          ),
        ],
      ),
    );
  }

  Widget _buildTab({
    required IconData icon, 
    required String label, 
    required VoidCallback onTap, 
    bool showDot = false
  }) {
    return GestureDetector(
      onTap: onTap,
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
                    decoration: BoxDecoration(
                      color: const Color(0xffF73130),
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