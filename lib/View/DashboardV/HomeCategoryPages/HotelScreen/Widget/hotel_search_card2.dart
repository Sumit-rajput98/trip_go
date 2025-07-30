import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:trip_go/View/DashboardV/HomeCategoryPages/HotelScreen/Widget/city_search_page.dart';
import 'package:trip_go/View/DashboardV/HomeCategoryPages/HotelScreen/Widget/hotel_date_range_picker.dart';
import 'package:trip_go/View/DashboardV/HomeCategoryPages/HotelScreen/Widget/room_guest_selector_page.dart';
import 'package:trip_go/View/DashboardV/HomeCategoryPages/HotelScreen/HotelDetail/hotel_detail_page.dart';
import 'package:trip_go/View/DashboardV/HomeCategoryPages/HotelScreen/hotel_search_view.dart';
import 'package:trip_go/View/DashboardV/HomeCategoryPages/TourScreen/TourWidget/custom_calender_dialog.dart';
import '../../../../Widgets/gradient_button.dart';
import 'package:trip_go/constants.dart';

class HotelSearchCard2 extends StatefulWidget {
  final String? city;
  final String? checkIn;
  final String? checkOut;
  final int? rooms;
  final int? adults;
  final int? children;
  final List<int>? childAges;
  final bool? onBack;

  const HotelSearchCard2({
    super.key,
     this.city,
    this.checkIn,
    this.checkOut,
     this.rooms,
    this.adults,
    this.children,
    this.childAges,
    this.onBack
  });

  @override
  State<HotelSearchCard2> createState() => _HotelSearchCard2State();
}

class _HotelSearchCard2State extends State<HotelSearchCard2> {
  final TextEditingController checkInController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController checkOutController = TextEditingController();

  int rooms = 1;
  int adults = 1;
  int children = 0;
  List<int> childAges = [];

  String? checkInDay;
  String? checkOutDay;

  bool enabled = false;

  @override
  void initState() {
    super.initState();
    final today = DateTime.now();

    cityController.text = widget.city ?? '';
    checkInDay = widget.checkIn ?? DateFormat('MM/dd/yyyy').format(today);
    checkOutDay = widget.checkOut ?? '';
    checkInController.text = checkInDay!;
    checkOutController.text = checkOutDay ?? '';

    rooms = widget.rooms ?? 1;
    adults = widget.adults ?? 1;
    children = widget.children ?? 0;
    childAges = widget.childAges ?? [];

  }

  @override
  Widget build(BuildContext context) {
    String _buildPaxString(int adults, int children, List<int> childAges) {
      if (children > 0 && childAges.isNotEmpty) {
        return "$adults" + "_$children" + "_" + childAges.join("_");
      } else {
        return "$adults" + "_$children";
      }
    }
    return SafeArea(
      child: Column(
        children: [
          if(widget.onBack == true)  ...[
            Container(
              height: 60,
              color: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, size: 28, color: Colors.black),
                    onPressed: () => Navigator.pop(context),
                  ),
                  const SizedBox(width: 4),
                  const Text(
                    'Modify Search',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontFamily: 'poppins',
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
      ],
          // Custom AppBar

          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            //margin: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                // colors: [Colors.white, Color(0xFFFFEBEE), Color(0xFFFFF5F6)],
                colors: [Color(0xFFF4F5F9), Color(0xFFF0F2F8)],
              ),
      
              // borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                
                GestureDetector(
                  onTap: () async {
                    final selectedCity = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CitySearchPage(),
                      ),
                    );
                    if (selectedCity != null) {
                      setState(() {
                        cityController.text = selectedCity;
                      });
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 12,
                      horizontal: 12,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Enter City name, Location or Specific hotel',
                          style: TextStyle(fontSize: 12, fontFamily: 'poppins'),
                        ),
                        const SizedBox(height: 4),
                        AbsorbPointer(
                          child: TextFormField(
                            controller: cityController,
                            readOnly: true,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'poppins',
                            ),
                            decoration: const InputDecoration(
                              hintText: 'Enter City/Hotel Name',
                              hintStyle: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'poppins',
                              ),
                              border: InputBorder.none,
                              isDense: true,
                              contentPadding: EdgeInsets.zero,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
      
                /// Date Picker Row
                Row(
                  children: [
                    /// Check-in
                    Expanded(
                      child: GestureDetector(
                        onTap: () async {
                          final result = await Navigator.push<Map<String, DateTime?>>(
                            context,
                            MaterialPageRoute(
                              builder: (_) => HotelDateRangePage(
                                initialCheckIn: (checkInDay != null && checkInDay!.isNotEmpty)
                                    ? DateFormat('MM/dd/yyyy').parse(checkInDay!)
                                    : null,
                                initialCheckOut: (checkOutDay != null && checkOutDay!.isNotEmpty)
                                    ? DateFormat('MM/dd/yyyy').parse(checkOutDay!)
                                    : null,
                              ),
                            ),
                          );

                          if (result != null) {
                            final checkIn = result['checkIn'];
                            final checkOut = result['checkOut'];

                            setState(() {
                              if (checkIn != null) {
                                checkInDay = DateFormat('MM/dd/yyyy').format(checkIn);
                                checkInController.text = checkInDay!;
                              }
                              if (checkOut != null) {
                                checkOutDay = DateFormat('MM/dd/yyyy').format(checkOut);
                                checkOutController.text = checkOutDay!;
                                enabled = true;
                              }
                            });
                          }
                        },

                        child: _buildDateFieldTile(
                          title: 'CHECK-IN',
                          date: checkInDay,
                          enabled: true,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
      
                    /// Check-out
                    Expanded(
                      child: GestureDetector(
                        onTap: () async {
                          DateTime? parsedCheckIn;
                          DateTime? parsedCheckOut;

                          if (checkInDay != null && checkInDay!.isNotEmpty) {
                            try {
                              parsedCheckIn = DateFormat('MM/dd/yyyy').parse(checkInDay!);
                            } catch (e) {
                              debugPrint("Invalid check-in date: $checkInDay");
                            }
                          }

                          if (checkOutDay != null && checkOutDay!.isNotEmpty) {
                            try {
                              parsedCheckOut = DateFormat('MM/dd/yyyy').parse(checkOutDay!);
                            } catch (e) {
                              debugPrint("Invalid check-out date: $checkOutDay");
                            }
                          }

                          final result = await Navigator.push<Map<String, DateTime?>>(
                            context,
                            MaterialPageRoute(
                              builder: (_) => HotelDateRangePage(
                                initialCheckIn: parsedCheckIn,
                                initialCheckOut: parsedCheckOut,
                              ),
                            ),
                          );

                          if (result != null) {
                            final checkIn = result['checkIn'];
                            final checkOut = result['checkOut'];

                            setState(() {
                              if (checkIn != null) {
                                checkInDay = DateFormat('MM/dd/yyyy').format(checkIn);
                                checkInController.text = checkInDay!;
                              }
                              if (checkOut != null) {
                                checkOutDay = DateFormat('MM/dd/yyyy').format(checkOut);
                                checkOutController.text = checkOutDay!;
                                enabled = true;
                              }
                            });
                          }
                        },

                        child: _buildDateFieldTile(
                          title: 'CHECK-OUT',
                          date: checkOutDay,
                          enabled: enabled,
                          onClear: () {
                            setState(() {
                              checkOutDay = null;
                              checkOutController.clear();
                              enabled = false;
                            });
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
      
                /// Guest & Room Picker
                GestureDetector(
                  onTap: () async {
                    final result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const RoomGuestSelectorPage(),
                      ),
                    );
                    if (result != null) {
                      setState(() {
                        rooms = result['rooms'] ?? 1;
                        adults = result['adults'] ?? 1;
                        children = result['children'] ?? 0;
                        childAges = List<int>.from(result['childAges'] ?? []);
                      });
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 12,
                      horizontal: 12,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Guest and Room",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontFamily: 'poppins',
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                "$rooms Room${rooms > 1 ? 's' : ''}, $adults Adult${adults > 1 ? 's' : ''}, $children Child${children > 1 ? 'ren' : ''}",
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  fontFamily: 'poppins',
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Icon(
                          Icons.add_circle_outline,
                          color: Colors.black54,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
      
                /// Search Button
                SizedBox(
                  width: double.infinity,
                  child: GradientButton(
                    label: 'SEARCH',
                    onPressed: () {
                      if (cityController.text.isEmpty ||
                          checkInDay == null ||
                          checkOutDay == null ||
                          rooms == 0 ||
                          adults == 0) {
                        Fluttertoast.showToast(
                          msg: "Please fill out all fields",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                        );
                        return;
                      }
      
                      final inputFormat = DateFormat('MM/dd/yyyy');
                      final outputFormat = DateFormat('yyyy-MM-dd');
      
                      final formattedCin = outputFormat.format(inputFormat.parse(checkInDay!));
                      final formattedCout = outputFormat.format(inputFormat.parse(checkOutDay!));
      
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HotelSearchResultPage(
                            city: cityController.text,
                            cin: formattedCin,
                            cout: formattedCout,
                            rooms: rooms.toString(),
                            pax: _buildPaxString(adults, children, childAges), // ✅ here
                            totalGuests: adults,
                          ),
                        ),
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDateFieldTile({
    required String title,
    required String? date,
    required bool enabled,
    VoidCallback? onClear,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
      decoration: BoxDecoration(
        color: enabled ? Colors.white : Colors.grey.shade100,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w600,
              color: enabled ? Colors.black87 : Colors.grey,
              fontFamily: 'poppins',
            ),
          ),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.calendar_today,
                    size: 16,
                    color: Colors.black54,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    date ?? " ",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'poppins',
                      color: enabled ? Colors.black : Colors.grey,
                    ),
                  ),
                ],
              ),
              if (date != null && onClear != null)
                InkWell(
                  onTap: onClear,
                  child: const CircleAvatar(
                    radius: 12,
                    backgroundColor: Colors.grey,
                    child: Icon(Icons.close, size: 14, color: Colors.white),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
