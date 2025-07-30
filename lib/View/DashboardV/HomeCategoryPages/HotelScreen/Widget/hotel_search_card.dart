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

class HotelSearchCard extends StatefulWidget {
  const HotelSearchCard({super.key});

  @override
  State<HotelSearchCard> createState() => _HotelSearchCardState();
}

class _HotelSearchCardState extends State<HotelSearchCard> {
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
    checkInDay = DateFormat('MM/dd/yyyy').format(today);
    checkInController.text = checkInDay!;
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
    return Column(
      children: [
        const SizedBox(height: 10),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          //margin: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: [Colors.white, Color(0xFFFFEBEE), Color(0xFFFFF5F6)],
            ),

            // borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// City Picker
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
                        final result =
                            await Navigator.push<Map<String, DateTime?>>(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (_) => HotelDateRangePage(
                                      initialCheckIn:
                                          checkInDay != null
                                              ? DateFormat(
                                                'MM/dd/yyyy',
                                              ).parse(checkInDay!)
                                              : null,
                                      initialCheckOut:
                                          checkOutDay != null
                                              ? DateFormat(
                                                'MM/dd/yyyy',
                                              ).parse(checkOutDay!)
                                              : null,
                                    ),
                              ),
                            );

                        if (result != null) {
                          final checkIn = result['checkIn'];
                          final checkOut = result['checkOut'];

                          setState(() {
                            if (checkIn != null) {
                              checkInDay = DateFormat(
                                'MM/dd/yyyy',
                              ).format(checkIn);
                              checkInController.text = checkInDay!;
                            }
                            if (checkOut != null) {
                              checkOutDay = DateFormat(
                                'MM/dd/yyyy',
                              ).format(checkOut);
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
                        final result =
                            await Navigator.push<Map<String, DateTime?>>(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (_) => HotelDateRangePage(
                                      initialCheckIn:
                                          checkInDay != null
                                              ? DateFormat(
                                                'MM/dd/yyyy',
                                              ).parse(checkInDay!)
                                              : null,
                                      initialCheckOut:
                                          checkOutDay != null
                                              ? DateFormat(
                                                'MM/dd/yyyy',
                                              ).parse(checkOutDay!)
                                              : null,
                                    ),
                              ),
                            );

                        if (result != null) {
                          final checkIn = result['checkIn'];
                          final checkOut = result['checkOut'];

                          setState(() {
                            if (checkIn != null) {
                              checkInDay = DateFormat(
                                'MM/dd/yyyy',
                              ).format(checkIn);
                              checkInController.text = checkInDay!;
                            }
                            if (checkOut != null) {
                              checkOutDay = DateFormat(
                                'MM/dd/yyyy',
                              ).format(checkOut);
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
