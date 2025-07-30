import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:trip_go/Model/HotelM/hotel_detail_data.dart';
import 'package:trip_go/View/DashboardV/HomeCategoryPages/FlightScreen/FlightWidgets/gst_bottom_sheet.dart';
import 'package:trip_go/View/DashboardV/HomeCategoryPages/FlightScreen/common_widget/bottom_bar.dart';
import 'package:trip_go/View/DashboardV/HomeCategoryPages/HotelScreen/HotelSection/travellers_detail_card.dart';
import 'package:trip_go/View/DashboardV/HomeCategoryPages/HotelScreen/hotel_booking_status_screen.dart';
import 'package:trip_go/View/DashboardV/HomeCategoryPages/HotelScreen/hotel_payment_gateway.dart';
import 'package:trip_go/View/DashboardV/HomeCategoryPages/HotelScreen/hotel_promo_section.dart';
import 'package:trip_go/ViewM/HotelVM/hotel_booking_view_model.dart';
import 'package:trip_go/constants.dart';
import '../../../../Model/HotelM/hotek_booking_model.dart';
import 'package:intl/intl.dart';

class HotelReviewScreen extends StatefulWidget {
  final String hid;
  final String batchKey;
  final List<RoomDetail> rooms;
  final Hotel1 hotel;
  final String city;
  final String cin;
  final String cout;
  final String room;
  final String pax;
  final int totalGuests;

  const HotelReviewScreen({
    super.key,
    required this.hotel,
    required this.city,
    required this.cin,
    required this.cout,
    required this.room,
    required this.pax,
    required this.totalGuests,
    required this.hid,
    required this.batchKey,
    required this.rooms,
  });

  @override
  State<HotelReviewScreen> createState() => _HotelReviewScreenState();
}

class _HotelReviewScreenState extends State<HotelReviewScreen> {
  final GlobalKey<TravellerDetailsCardState> _travellerCardKey =
      GlobalKey<TravellerDetailsCardState>();

  int price = 0;
  bool isChecked = false;
  bool isCheckedGst = false;
  String? errorMessage;
  String? companyName;
  String? regNo;
  final GlobalKey<FormState> _travellerFormKey = GlobalKey<FormState>();
  Map<String, dynamic>? _passengerData; // Ensure this is declared

  @override
  void initState() {
    super.initState();
    _initBooking();
    print(widget.pax);
    print("check in - ${widget.cin}");
    print("check out - ${widget.cout}");
  }

  void _initBooking() {
    Future.delayed(Duration.zero, () {
      final bookingCode =
          widget.rooms.isNotEmpty ? widget.rooms.first.bookingCode : null;
      final request = {
        "BookingCode": bookingCode,
        "hid": widget.hid,
        "BatchKey": widget.batchKey,
        "Rooms": widget.rooms.map((e) => e.toJson()).toList(),
      };
      Provider.of<HotelPreBookingViewModel>(
        context,
        listen: false,
      ).bookHotel(request);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Consumer<HotelPreBookingViewModel>(
        builder: (context, bookingVM, _) {
          if (bookingVM.isLoading) {
            return Stack(
              children: [
                _buildHeader(context),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 90, 16, 20),
                  child: _buildShimmerLayout(),
                ),
              ],
            );
          }

          if (bookingVM.bookingResult == null ||
              bookingVM.bookingResult!.data == null) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  bookingVM.errorMessage ?? "Failed to load booking details",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(fontSize: 16),
                ),
              ),
            );
          }

          final roomList = bookingVM.bookingResult!.data!.dataRooms;
          final detail = bookingVM.bookingResult!.data!.detail;

          price =
              roomList?.first.totalFare?.toInt() ??
              0 + roomList!.first.totalTax!.toInt();

          if (roomList == null || roomList.isEmpty) {
            return const Center(child: Text("No room details available"));
          }

          final room = roomList.first;

          return SingleChildScrollView(
            child: Stack(
              children: [
                _buildHeader(context),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 90, 16, 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _HotelCard(
                        detail: detail,
                        cin: widget.cin,
                        cout: widget.cout,
                        totalGuests: widget.totalGuests,
                        roomCount: widget.room,
                        roomName: room.name!.last,
                        mealType:
                            room.inclusion?.isNotEmpty == true
                                ? room.inclusion!
                                : "Breakfast not included",
                      ),
                      const SizedBox(height: 16),
                      _PriceBreakupCard(room: room),
                      const SizedBox(height: 16),
                      TravellerDetailsCard(
                        key: _travellerCardKey, // ✅ Here you set the key
                        formKey: _travellerFormKey,
                        onDataReady: (data) {
                          _passengerData = data;
                        },
                      ),
                      const SizedBox(height: 16),
                      const HotelPromoSection(),
                      const SizedBox(height: 16),
                      _buildGstSection(),
                      _buildTermsSection(),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: Consumer<HotelPreBookingViewModel>(
        builder: (context, bookingVM, _) {
          if(bookingVM.isLoading && bookingVM.errorMessage != null){return SizedBox.shrink();}
          final amount =
              bookingVM
                  .bookingResult
                  ?.data
                  ?.hotelResult
                  ?.first
                  .rooms
                  ?.first
                  .netAmount ??
              0;
          final bookingCode =
              widget.rooms.isNotEmpty ? widget.rooms.first.bookingCode : null;

          return buildBottomBar(context, () {
            if (!isChecked) {
              Get.rawSnackbar(
                message: "Please accept Terms & Conditions and Privacy Policy",
                duration: const Duration(seconds: 2),
                backgroundColor: Colors.redAccent,
                margin: const EdgeInsets.all(12),
                borderRadius: 8,
              );
              return;
            }
            // Submit main guest form
            _travellerCardKey.currentState?.submitIfValid();

            if (_travellerFormKey.currentState == null ||
                !_travellerFormKey.currentState!.validate()) {
              Get.rawSnackbar(
                message: "Please complete the traveller details",
                duration: const Duration(seconds: 2),
                backgroundColor: Colors.black87,
                margin: const EdgeInsets.all(12),
                borderRadius: 8,
              );
              return;
            }

            final mainGuest =
                _travellerCardKey.currentState?.getMainPassenger();
            final allGuests =
                _travellerCardKey.currentState?.getAllGuestData() ?? [];

            if (mainGuest == null ||
                mainGuest['FirstName'] == "" ||
                mainGuest['Phoneno'] == "" ||
                mainGuest['Email'] == "") {
              Get.rawSnackbar(
                message: "Passenger data not captured yet",
                duration: const Duration(seconds: 2),
                backgroundColor: Colors.black87,
                margin: const EdgeInsets.all(12),
                borderRadius: 8,
              );
              return;
            }

            // ✅ Step 1: Parse pax string (e.g. "2_1_3")
            final paxParts =
                widget.pax.split('_').map((e) => int.tryParse(e) ?? 0).toList();
            final roomCount = int.tryParse(widget.room.toString()) ?? 1;

            final adultsPerRoom = paxParts.isNotEmpty ? paxParts[0] : 0;
            final childrenPerRoom = paxParts.length > 1 ? paxParts[1] : 0;
            final childAges = paxParts.length > 2 ? paxParts.sublist(2) : [];

            // ✅ Step 2: Create HotelRoomsDetails with guest mapping
            int guestIndex = 0;
            List<Map<String, dynamic>> hotelRoomsDetails = [];

            for (int room = 0; room < roomCount; room++) {
              List<Map<String, dynamic>> hotelPassengers = [];

              // Add Adults
              for (int i = 0; i < adultsPerRoom; i++) {
                if (guestIndex < allGuests.length) {
                  Map<String, dynamic> guest = Map<String, dynamic>.from(
                    allGuests[guestIndex],
                  );
                  guest['PaxType'] = 1;
                  guest['Age'] = 0;
                  guest['LeadPassenger'] =
                      (room == 0 && i == 0); // first guest of first room
                  hotelPassengers.add(guest);
                  guestIndex++;
                }
              }

              // Add Children
              for (int i = 0; i < childrenPerRoom; i++) {
                if (guestIndex < allGuests.length) {
                  Map<String, dynamic> guest = Map<String, dynamic>.from(
                    allGuests[guestIndex],
                  );
                  guest['PaxType'] = 2;
                  guest['Age'] = i < childAges.length ? childAges[i] : 0;
                  guest['LeadPassenger'] = false;
                  hotelPassengers.add(guest);
                  guestIndex++;
                }
              }

              hotelRoomsDetails.add({"HotelPassenger": hotelPassengers});
            }

            // ✅ Step 3: Validate guest count
            int totalExpectedGuests =
                roomCount * (adultsPerRoom + childrenPerRoom);
            int totalProvidedGuests = allGuests.length;

            if (totalProvidedGuests != totalExpectedGuests) {
              Get.rawSnackbar(
                message:
                    "Filled $totalProvidedGuests guest(s), but $totalExpectedGuests required.\nPlease fill all guest details.",
                duration: const Duration(seconds: 3),
                backgroundColor: Colors.redAccent,
                margin: const EdgeInsets.all(12),
                borderRadius: 8,
              );
              return;
            }

            // ✅ Step 4: Prepare and send final request
            final request = {
              "UserEmail": mainGuest['Email'],
              "UserPhone": mainGuest['Phoneno'],
              "Type": "app",
              "CheckIn": widget.cin,
              "CheckOut": widget.cout,
              "BatchKey": widget.batchKey,
              "BookingCode": bookingCode,
              "NetAmount": amount.round(),
              "HotelCode": widget.hid,
              "HotelRoomsDetails": hotelRoomsDetails,
              "CityCode": bookingVM.bookingResult?.data?.detail?.cityCode,
            };

            final bookingData = bookingVM.bookingResult!.data!;
            final bookingCode1 = widget.rooms.isNotEmpty ? widget.rooms.first.bookingCode ?? '' : '';
            final amount1 =
                bookingVM
                    .bookingResult
                    ?.data
                    ?.hotelResult
                    ?.first
                    .rooms
                    ?.first
                    .netAmount ??
                    0;

            // Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //     builder:
            //         (context) => HotelBookingStatusScreen(request: request),
            //   ),
            // );
            Navigator.push(
              context,
              MaterialPageRoute(
                builder:
                    (context) => HotelPaymentGateway(amount: amount1.toInt(), bookingCode: bookingCode1, email: "user@email.com", phone: "9876543210", bookingRequest: request),
              ),
            );
          }, price: amount.toInt());
        },
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      height: 130,
      decoration: BoxDecoration(
        color: constants.themeColor1,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(28),
          bottomRight: Radius.circular(28),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 36),
      alignment: Alignment.topLeft,
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: const Icon(Icons.arrow_back, color: Colors.white),
          ),
          const SizedBox(width: 16),
          Text(
            "Hotel Review",
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _HotelCard({
    required Detail? detail,
    required String cin,
    required String cout,
    required int totalGuests,
    required String roomCount,
    required String? roomName,
    required String? mealType,
  }) {
    String _formatDate(String dateStr) {
      try {
        final date = DateFormat("yyyy-MM-dd").parse(dateStr);
        return DateFormat("dd MMMM yyyy").format(date); // 11 July 2025
      } catch (_) {
        return dateStr; // fallback
      }
    }

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Hotel Name and Stars (Top row only)
          Row(
            children: [
              Expanded(
                child: Text(
                  detail?.name ?? "Hotel Name",
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
              ),
              Row(
                children: List.generate(
                  int.tryParse(detail?.starRating.toString() ?? '') ?? 0,
                  (index) =>
                      Icon(Icons.star, size: 16, color: constants.themeColor1),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),

          /// Address
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(
                Icons.location_on_outlined,
                size: 14,
                color: Colors.grey,
              ),
              const SizedBox(width: 4),
              Expanded(
                child: Text(
                  detail?.address ?? 'Address not available',
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: Colors.grey[700],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          /// Room Name & Meal Info + Image aligned right
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      roomName ?? "Room Type",
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      mealType != null && mealType.toLowerCase() != "none"
                          ? "$mealType included"
                          : "Breakfast not included",
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: Colors.grey[700],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  detail!.images ??
                      'https://media.easemytrip.com/media/Hotel/SHL-18112610137123/Hotel/Hotelpt5gts.png',
                  height: 60,
                  width: 60,
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          /// Travel Info
          Text(
            "Travel Dates & Guests",
            style: GoogleFonts.poppins(
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            "${_getNights(cin, cout)} Nights ${_getDays(cin, cout)} Days • $roomCount Room • $totalGuests Guest${totalGuests > 1 ? 's' : ''}",
            style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey[700]),
          ),

          const SizedBox(height: 12),

          /// Check-In / Nights / Check-Out
          Row(
            children: [
              Expanded(
                child: _styledCheckTile(
                  "Check-In",
                  _formatDate(cin),
                  "03:00 PM",
                ),
              ),
              const SizedBox(width: 8),

              /// Center Circle
              Container(
                padding: const EdgeInsets.all(8),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFFE8F0FB),
                ),
                child: Column(
                  children: [
                    const Icon(
                      Icons.night_shelter,
                      size: 16,
                      color: Color(0xFF1B499F),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      "${_getNights(cin, cout)}N",
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1B499F),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 8),
              Expanded(
                child: _styledCheckTile(
                  "Check-Out",
                  _formatDate(cout),
                  "12:00 PM",
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          /// Inclusions | Cancellation Policy
          //   Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //     children: [
          //       TextButton(
          //         onPressed: () {},
          //         style: TextButton.styleFrom(padding: EdgeInsets.zero),
          //         child: Text(
          //           "Inclusions",
          //           style: GoogleFonts.poppins(
          //             fontSize: 12,
          //             color: Colors.blue[800],
          //             fontWeight: FontWeight.w500,
          //           ),
          //         ),
          //       ),
          //       Container(height: 12, width: 1, color: Colors.grey[300]),
          //       TextButton(
          //         onPressed: () {},
          //         style: TextButton.styleFrom(padding: EdgeInsets.zero),
          //         child: Text(
          //           "Cancellation Policy",
          //           style: GoogleFonts.poppins(
          //             fontSize: 12,
          //             color: Colors.blue[800],
          //             fontWeight: FontWeight.w500,
          //           ),
          //         ),
          //       ),
          //     ],
          //   ),
        ],
      ),
    );
  }

  Widget _styledCheckTile(String title, String date, String time) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.calendar_today_outlined,
            size: 16,
            color: Colors.grey,
          ),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: GoogleFonts.poppins(
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                date,
                style: GoogleFonts.poppins(fontSize: 10, color: Colors.black87),
              ),
              Text(
                time,
                style: GoogleFonts.poppins(fontSize: 10, color: Colors.black87),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildShimmerLayout() {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _shimmerBox(height: 180), // Hotel Card
          const SizedBox(height: 16),
          _shimmerBox(height: 130), // Price Summary
          const SizedBox(height: 16),
          _shimmerBox(height: 160), // Traveller Details
          const SizedBox(height: 16),
          _shimmerBox(height: 80), // Promo Section
          const SizedBox(height: 16),
          _shimmerBox(height: 100), // GST Section
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _shimmerBox({required double height}) {
    return Container(
      width: double.infinity,
      height: height,
      margin: const EdgeInsets.symmetric(vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }

  int _getNights(String cin, String cout) {
    final inDate = DateTime.tryParse(cin);
    final outDate = DateTime.tryParse(cout);
    if (inDate != null && outDate != null) {
      return outDate.difference(inDate).inDays;
    }
    return 1;
  }

  int _getDays(String cin, String cout) {
    return _getNights(cin, cout) + 1;
  }

  Widget _PriceBreakupCard({required RoomElement room}) {
    final roomRate = (room.totalFare ?? 0) - (room.totalTax ?? 0);
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: _boxDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Price Summary",
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
          const Divider(height: 20),
          _priceRow("Room Rate", roomRate),
          _priceRow("Taxes & Fees", room.totalTax),
          const Divider(height: 20),
          _priceRow("Total Amount", room.totalFare, isBold: true),
        ],
      ),
    );
  }

  Widget _priceRow(String label, double? amount, {bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: isBold ? FontWeight.w600 : FontWeight.w400,
            ),
          ),
          Text(
            amount != null ? "₹ ${amount.toStringAsFixed(2)}" : "--",
            style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: isBold ? FontWeight.w600 : FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }

  Widget _inputField(String hint, {IconData? icon}) {
    return TextFormField(
      decoration: InputDecoration(
        hintText: hint,
        prefixIcon: icon != null ? Icon(icon, size: 18) : null,
        hintStyle: GoogleFonts.poppins(fontSize: 13),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 10,
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  Widget _buildGstSection() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
        border: Border.all(color: Colors.grey.withOpacity(.4)),
      ),
      child: Row(
        children: [
          Checkbox(
            value: isCheckedGst,
            onChanged: (val) async {
              setState(() {
                isCheckedGst = val!;
              });
              if (val == true) {
                final result = await showModalBottomSheet<Map<String, String>>(
                  context: context,
                  isScrollControlled: true,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(5),
                    ),
                  ),
                  builder:
                      (context) => const Padding(
                        padding: EdgeInsets.only(
                          bottom: 20,
                          top: 20,
                          left: 16,
                          right: 16,
                        ),
                        child: GstBottomSheet(),
                      ),
                );
                if (result != null) {
                  companyName = result['companyName'];
                  regNo = result['registrationNo'];
                }
              }
            },
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Use GST for this booking (OPTIONAL)",
                  style: GoogleFonts.poppins(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  "To claim credit of GST charged by hotels/TripGo, please enter your company's GST number.",
                  style: GoogleFonts.poppins(
                    fontSize: 13,
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTermsSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      child: Row(
        children: [
          Checkbox(
            value: isChecked,
            onChanged: (val) {
              setState(() {
                isChecked = val!;
              });
            },
          ),
          RichText(
            text: TextSpan(
              style: GoogleFonts.poppins(color: Colors.black),
              children: [
                const TextSpan(text: "I Accept "),
                TextSpan(
                  text: "T&C ",
                  style: const TextStyle(color: Colors.blue),
                ),
                const TextSpan(text: "and "),
                TextSpan(
                  text: "Privacy Policy",
                  style: const TextStyle(color: Colors.blue),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  BoxDecoration _boxDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.grey[300]!),
    );
  }
}
