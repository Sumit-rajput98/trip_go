import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:trip_go/View/DashboardV/HomeCategoryPages/FlightScreen/common_widget/bottom_bar.dart';
import 'package:trip_go/View/DashboardV/HomeCategoryPages/HotelScreen/HotelDetail/guest_review_section.dart';
import 'package:trip_go/View/DashboardV/HomeCategoryPages/HotelScreen/HotelDetail/hotel_detail_tab.dart';
import 'package:trip_go/View/DashboardV/HomeCategoryPages/HotelScreen/HotelDetail/hotel_overview_screen.dart';
import 'package:trip_go/View/DashboardV/HomeCategoryPages/HotelScreen/hotel_review_screen.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../../Model/HotelM/hotel_detail_data.dart';
import '../../../../../Model/HotelM/hotel_search_model.dart';
import '../../../../../ViewM/HotelVM/hotel_detail_view_model.dart';
import 'hotel_info_card.dart';
import 'room_list_section.dart';

const themeColor1 = Color(0xff1B499F);
const themeColor2 = Color(0xffF73130);

class HotelDetailPage extends StatefulWidget {
  final String hid;
  final String batchKey;
  final List<Room1> rooms;
  final String city;
  final String cin;
  final String cout;
  final String room;
  final String pax;
  final int totalGuests;

  const HotelDetailPage({
    super.key,
    required this.hid,
    required this.batchKey,
    required this.rooms,
    required this.city,
    required this.cin,
    required this.cout,
    required this.room,
    required this.pax,
    required this.totalGuests,
  });

  @override
  State<HotelDetailPage> createState() => _HotelDetailPageState();
}

class _HotelDetailPageState extends State<HotelDetailPage> {
  final GlobalKey mapKey = GlobalKey();
  final _pageController = PageController();
  int _selectedTab = 0;
  RoomDetail? _selectedRoom;

  final List<String> _tabs = ['Rooms', 'Overview', 'Details'];
  final List<String> _images = [
    'https://media.easemytrip.com/media/Hotel/SHL-18112610137123/Hotel/Hotelpt5gts.png',
    'https://media.easemytrip.com/media/Hotel/SHL-18112610137123/Hotel/HotelibPZDW.png',
    'https://media.easemytrip.com/media/Hotel/SHL-18112610137123/Hotel/Hotel6Lu3DU.png'
  ];

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      final viewModel = Provider.of<HotelDetailViewModel>(context, listen: false);
      final roomsJson = widget.rooms.map((e) => e.toJson()).toList();
      viewModel.getHotelDetail(
        hid: widget.hid,
        batchKey: widget.batchKey,
        roomsJson: roomsJson,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<HotelDetailViewModel>(context);
    final hotelData = viewModel.hotelDetailData?.data;
    final hotel = hotelData?.detail;
    final rooms = hotelData?.rooms ?? [];

    if (viewModel.isLoading || hotel == null) {
      return _buildShimmerLoader();
    }

    return Scaffold(
      backgroundColor: Colors.grey[100],
      bottomNavigationBar: buildBottomBar(
        context,
        () {
          if (_selectedRoom == null) return;
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => HotelReviewScreen(
                hid: widget.hid,
                batchKey: widget.batchKey,
                rooms: [_selectedRoom!],
                hotel: hotel,
                city: widget.city,
                cin: widget.cin,
                cout: widget.cout,
                room: widget.room,
                pax: widget.pax,
                totalGuests: widget.totalGuests,
              ),
            ),
          );
        },
        price: _selectedRoom?.totalFare?.toInt() ?? 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildImageCarousel(hotel),
            Transform.translate(
              offset: const Offset(0, -20),
              child: HotelInfoCard(
                selectedTab: _selectedTab,
                onTabChange: (index) => setState(() => _selectedTab = index),
                tabs: _tabs,
                hotel: hotel,
                rooms: rooms,
                city: widget.city,
                cin: widget.cin,
                cout: widget.cout,
                room: widget.room,
                pax: widget.pax,
                totalGuests: widget.totalGuests,
                mapKey: mapKey,
              ),
            ),
            const SizedBox(height: 12),
            Padding(padding: const EdgeInsets.symmetric(horizontal: 16), child: _buildTabs()),
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  _buildTabContent(hotel, rooms, k: mapKey),
                ],
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildImageCarousel(Hotel1? hotel) {
    return Stack(
      children: [
        Container(
          height: 280,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.black45,
                Colors.transparent,
                Colors.transparent,
                Colors.black26,
              ],
            ),
          ),
        ),
        ClipRRect(
          borderRadius: const BorderRadius.vertical(bottom: Radius.circular(10)),
          child: SizedBox(
            height: 280,
            width: double.infinity,
            child: PageView.builder(
              controller: _pageController,
              itemCount: _images.length,
              itemBuilder: (context, index) {
                return Image.network(
                  _images[index],
                  fit: BoxFit.cover,
                  width: double.infinity,
                );
              },
            ),
          ),
        ),
        Positioned(
          top: 40,
          left: 16,
          right: 16,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(Icons.arrow_back_ios, color: Colors.white, size: 18),
                  const SizedBox(width: 8),
                  Text(
                    hotel?.city ?? "Hotel",
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              const Icon(Icons.share_outlined, color: Colors.white),
            ],
          ),
        ),
        Positioned(
          bottom: 25,
          left: 0,
          right: 0,
          child: Center(
            child: SmoothPageIndicator(
              controller: _pageController,
              count: _images.length,
              effect: const WormEffect(
                dotColor: Colors.white70,
                activeDotColor: Colors.white,
                dotHeight: 8,
                dotWidth: 8,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTabs() {
    return Container(
      height: 46,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: themeColor1),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(_tabs.length, (index) {
          final isSelected = index == _selectedTab;
          return GestureDetector(
            onTap: () => setState(() => _selectedTab = index),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
              decoration: BoxDecoration(
                color: isSelected ? themeColor1 : Colors.transparent,
                borderRadius: BorderRadius.circular(24),
              ),
              child: Text(
                _tabs[index],
                style: GoogleFonts.poppins(
                  color: isSelected ? Colors.white : themeColor1,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildTabContent(Hotel1? hotel, List<RoomDetail> rooms, {GlobalKey? k}) {
    if (_selectedTab == 0) {
      return RoomListSection(
        rooms: rooms,
        onRoomSelected: (room) {
          setState(() {
            _selectedRoom = room;
          });
        },
      );
    } else if (_selectedTab == 1) {
      return HotelOverviewScreen(hotel: hotel!, k: k);
    } else {
      return HotelDetailsScreen(
        name: hotel?.name ?? "",
        address: hotel?.address ?? "",
        phone: hotel?.phone ?? "",
        amenities: hotel?.ameneties?.join(', ') ?? '',
      );
    }
  }

  Widget _buildShimmerLoader() {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Top Image
            Shimmer.fromColors(
              baseColor: Colors.grey.shade300,
              highlightColor: Colors.grey.shade100,
              child: Container(height: 280, width: double.infinity, color: Colors.white),
            ),
            const SizedBox(height: 16),

            // Info Card
            Transform.translate(
              offset: const Offset(0, -20),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Shimmer.fromColors(
                  baseColor: Colors.grey.shade300,
                  highlightColor: Colors.grey.shade100,
                  child: Container(height: 160, decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12))),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Tab bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Shimmer.fromColors(
                baseColor: Colors.grey.shade300,
                highlightColor: Colors.grey.shade100,
                child: Container(height: 46, decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(24))),
              ),
            ),
            const SizedBox(height: 16),

            // Room list/Overview shimmer
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: List.generate(3, (index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Shimmer.fromColors(
                      baseColor: Colors.grey.shade300,
                      highlightColor: Colors.grey.shade100,
                      child: Container(height: 100, decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12))),
                    ),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
