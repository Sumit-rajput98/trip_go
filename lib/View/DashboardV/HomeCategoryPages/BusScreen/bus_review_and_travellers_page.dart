import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/snackbar/snackbar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:trip_go/View/DashboardV/HomeCategoryPages/FlightScreen/FlightWidgets/gst_bottom_sheet.dart';
import 'package:trip_go/View/DashboardV/HomeCategoryPages/HotelScreen/hotel_promo_section.dart';
import 'package:trip_go/constants.dart';
import 'package:intl/intl.dart';
import '../../../../Model/BusM/bus_search_model.dart';
import '../../../../ViewM/BusVM/bus_block_view_model.dart';
import '../../../../ViewM/BusVM/bus_traveller_provider.dart';
import '../FlightScreen/common_widget/bottom_bar.dart';
import '../FlightScreen/common_widget/loading_screen.dart';
import 'BusScreen/bus_seat_provider.dart';
import 'bus_book_screen.dart';
import 'bus_payment_screen.dart';

class BusReviewAndTravellerPage extends StatefulWidget {
  final int paymentPrice;
  final origin;
  final destination;
  final String traceId;
  final String resultIndex;
  final bool isDropPointMandatory;
  final int selectedSeats;
  final List<BusResult> busResults;

  const BusReviewAndTravellerPage({
    super.key,
    required this.paymentPrice,
    required this.origin,
    required this.destination,
    required this.traceId,
    required this.resultIndex,
    required this.isDropPointMandatory,
    required this.selectedSeats,
    required this.busResults,
  });

  @override
  State<BusReviewAndTravellerPage> createState() => _BusReviewAndTravellerPageState();
}

class _BusReviewAndTravellerPageState extends State<BusReviewAndTravellerPage> {
  final _formKey = GlobalKey<FormState>();
  bool? isInsuranceSelected; // null by default, or use `true` for preselection
   bool isChecked = false;
  bool isCheckedGst = false;
  String? errorMessage;
  String? companyName;
  String? regNo;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  String? _termsError;
  late BusResult selectedBus;

  bool validateTerms() {
    if (!isChecked) {
      setState(() {
        _termsError = "Please accept Terms and Conditions";
      });
      return false;
    }
    return true;
  }

  @override
  void initState() {
    super.initState();
    selectedBus = widget.busResults.firstWhere(
          (bus) => bus.resultIndex.toString() == widget.resultIndex,
      orElse: () => widget.busResults.first,
    );
  }
 Widget buildContactInfoSection() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      // Title
      Text(
        "Contact Information",
        style: GoogleFonts.poppins(
          fontWeight: FontWeight.w600,
          fontSize: 16,
        ),
      ),
      const SizedBox(height: 12),

      // Email & Mobile Card
      Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Email Field
            Text("Email ID", style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w500)),
            const SizedBox(height: 8),
            TextFormField(
              controller: _emailController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your email';
                }
                final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                if (!emailRegex.hasMatch(value)) {
                  return 'Please enter a valid email';
                }
                return null;
              },
              decoration: InputDecoration(
                hintText: "Enter Email ID",
                hintStyle: GoogleFonts.poppins(fontSize: 13, color: Colors.grey),
                contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Mobile Number
            Text("Mobile No", style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w500)),
            const SizedBox(height: 8),
            Row(
              children: [
                Container(
                  width: 64,
                  height: 48,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.grey.shade100,
                  ),
                  child: Text(
                    "+91",
                    style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w500),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: TextFormField(
                    controller: _phoneController,
                    keyboardType: TextInputType.phone,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter mobile number';
                      }
                      if (value.length != 10 || !RegExp(r'^\d{10}$').hasMatch(value)) {
                        return 'Enter a valid 10-digit mobile number';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      hintText: "Enter Mobile Number",
                      hintStyle: GoogleFonts.poppins(fontSize: 13),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: Colors.grey.shade300),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: Colors.grey.shade300),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      const SizedBox(height: 16),

      // WhatsApp Notification Banner
      Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: const Color(0xFFF1FFF5),
          border: Border.all(color: constants.themeColor1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Container(
              width: 28,
              height: 28,
              padding: const EdgeInsets.all(4),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
              child: Image.network(
                "https://e7.pngegg.com/pngimages/447/479/png-clipart-whatsapp-computer-icons-whatsapp-text-whatsapp-icon-thumbnail.png",
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) => const Icon(CupertinoIcons.chat_bubble, size: 20, color: Colors.green),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text.rich(
                TextSpan(
                  text: "Get Booking Details & Updates on ",
                  style: GoogleFonts.poppins(fontSize: 13),
                  children: [
                    TextSpan(
                      text: "WhatsApp",
                      style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 13),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 8),
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                border: Border.all(color: constants.themeColor1, width: 2),
              ),
              child: const Icon(Icons.check, size: 12, color: Colors.blue),
            ),
          ],
        ),
      ),
    ],
  );
}

Widget buildInsuranceSection() {
  return Container(
    padding: const EdgeInsets.all(16),
    margin: const EdgeInsets.only(top: 12),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(14),
      color: constants.themeColor1.withOpacity(0.04),
      border: Border.all(color: constants.themeColor1.withOpacity(0.2)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.verified_user, color: constants.themeColor1),
            const SizedBox(width: 8),
            const Text(
              "Travel Insurance",
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
            ),
            const Spacer(),
            Image.network(
              'https://flight.easemytrip.com/Content/img/acko-logo.png',
              height: 28,
            ),
          ],
        ),
        const SizedBox(height: 8),
        const Divider(height: 20),
        const Text(
          "Secure your trip with ACKO Travel Insurance at just ₹199/- per traveller",
          style: TextStyle(fontSize: 12, fontFamily: 'poppins'),
        ),
        const SizedBox(height: 6),
        const Text("View T&C", style: TextStyle(color: Colors.blue, fontSize: 12, fontFamily: 'poppins')),
        const SizedBox(height: 10),
        Column(
          children: [
            RadioListTile<bool>(
              value: true,
              groupValue: isInsuranceSelected,
              activeColor: constants.themeColor1,
              onChanged: (value) {
                setState(() {
                  isInsuranceSelected = value;
                });
              },
              title: const Text("Yes, Secure My Trip", style: TextStyle(fontFamily: 'poppins', fontSize: 14),),
              subtitle: const Text(
                "More than 36% of our customers choose to secure their trip.",
                style: TextStyle(fontSize: 10,fontFamily: 'poppins'),
              ),
            ),
            RadioListTile<bool>(
              value: false,
              groupValue: isInsuranceSelected,
              activeColor: constants.themeColor1,
              onChanged: (value) {
                setState(() {
                  isInsuranceSelected = value;
                });
              },
              title: const Text("I am willing to risk my trip", style: TextStyle(fontFamily: 'poppins', fontSize: 14)),
            ),
          ],
        ),
      ],
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
            "Bus Review",
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Checkbox(
                value: isChecked,
                onChanged: (val) {
                  setState(() {
                    isChecked = val!;
                    _termsError = null; // clear error on check
                  });
                },
              ),
              Expanded(
                child: RichText(
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
              ),
            ],
          ),
          if (_termsError != null)
            Padding(
              padding: const EdgeInsets.only(left: 12, top: 4),
              child: Text(
                _termsError!,
                style: const TextStyle(color: Colors.red, fontSize: 12),
              ),
            ),
        ],
      ),
    );
  }

  bool showDetails = false;

  @override
  Widget build(BuildContext context) {
    final selectedSeatList = context.watch<BusSeatProvider>().selectedSeatList;
    final seatProvider = Provider.of<BusSeatProvider>(context);
    return Scaffold(
        bottomNavigationBar: seatProvider.selectedSeats.isNotEmpty
            ? buildBottomBar(
          context,
              () async {
            final isFormValid = _formKey.currentState?.validate() ?? false;
            final isTermsAccepted = validateTerms();

            if (!isFormValid || !isTermsAccepted) return;

            final seatProvider = context.read<BusSeatProvider>();
            final passengerList = context.read<BusTravellerProvider>().passengerList;

            if (passengerList.length != seatProvider.selectedSeats.length) {
              Get.snackbar(
                "Incomplete Traveller Details",
                "Please fill details for all ${seatProvider.selectedSeats.length} passengers.",
                backgroundColor: Colors.red.shade50,
                colorText: Colors.red.shade900,
                snackPosition: SnackPosition.TOP,
                margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                duration: const Duration(seconds: 3),
              );
              return;
            }

            final blockPayload = {
              "UserEmail": _emailController.text.trim(),
              "UserPhone": _phoneController.text.trim(),
              "Type": "app",
              "Destination": widget.destination,
              "Origin": widget.origin,
              "TraceId": widget.traceId,
              "ResultIndex": widget.resultIndex,
              "BoardingPointId": 1,
              "DroppingPointId": 1,
              "Passenger": passengerList,
            };

            // ✅ Show loading dialog
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (_) => const LoadingScreen(),
            );

            final blockVM = context.read<BusBlockViewModel>();
            await blockVM.blockBus(blockPayload);

            // ✅ Hide loading dialog
            Navigator.pop(context);

            if (blockVM.error != null) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Error: ${blockVM.error}")),
              );
            } else {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => BusPaymentGateway(
                    amount: widget.paymentPrice,
                    traceId: widget.traceId,
                    email: _emailController.text,
                    phone: _phoneController.text,
                    blockPayload: blockPayload,
                  ),
                ),
              );
            }
          },
          price: seatProvider.totalPrice.toInt(),
        )
            : const SizedBox.shrink(),

      backgroundColor: Colors.white,
       body: Form(
         key: _formKey,
         child: SingleChildScrollView(
          child: Stack(
            children: [
             _buildHeader(context),
              Padding(
                padding: const EdgeInsets.fromLTRB(16,90,16,20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // BUS DETAIL CARD
                    _buildBusDetailCard(),
                    const SizedBox(height: 16),
                    // TRAVELLER DETAILS
                    Text(
                      "Travellar Details",
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 6, bottom: 16),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: constants.themeColor1.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: constants.themeColor1),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.info_outline,
                            size: 18,
                            color: constants.themeColor1,
                          ),
                          const SizedBox(width: 6),
                          Expanded(
                            child: Text(
                              'Name should be same as in Government ID proof',
                              style: GoogleFonts.poppins(
                                fontSize: 13,
                                color: Colors.deepPurple.shade900,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    ...selectedSeatList.asMap().entries.map((entry) {
                      final index = entry.key + 1;
                      final seat = entry.value;
                      return Column(
                        children: [
                          TravellerDetailCard(
                            index: index,
                            seat: "${seat.seatName} (${seat.isUpper ? "UL" : "SL"})",
                          ),
                          const SizedBox(height: 12),
                        ],
                      );
                    }).toList(),
                    const SizedBox(height: 12),
                    buildInsuranceSection(),
                    const SizedBox(height: 12),
                    buildContactInfoSection(),
                    const SizedBox(height: 12),
                    HotelPromoSection(),
                    const SizedBox(height: 12),
                    _buildGstSection(),
                    const SizedBox(height: 12),
                    _buildTermsSection()
                  ],
                ),
              ),
            ],
          ),
               ),
       ),
    );
  }

  Widget _buildCircle() {
    return Container(
      width: 10,
      height: 10,
      decoration: const BoxDecoration(
        color: Colors.black,
        shape: BoxShape.circle,
      ),
    );
  }

  Widget _buildDashedLine({double height = 140}) {
    return Container(
      height: height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(10, (_) {
          return Container(width: 2, height: 4, color: Colors.grey.shade400);
        }),
      ),
    );
  }

  Widget _buildBusDetailCard() {
    String formatTime(String dateTime) {
      try {
        final dt = DateTime.parse(dateTime);
        final hour = dt.hour % 12 == 0 ? 12 : dt.hour % 12;
        final minute = dt.minute.toString().padLeft(2, '0');
        final period = dt.hour >= 12 ? 'PM' : 'AM';
        return '$hour:$minute $period';
      } catch (e) {
        return "--";
      }
    }
    String calculateDuration(String start, String end) {
      try {
        final startTime = DateTime.parse(start);
        final endTime = DateTime.parse(end);
        final duration = endTime.difference(startTime);
        final hours = duration.inHours;
        final minutes = duration.inMinutes.remainder(60);
        return "${hours}h ${minutes}m";
      } catch (_) {
        return "--";
      }
    }


    final boarding = selectedBus.boardingPoints.isNotEmpty ? selectedBus.boardingPoints.first : null;
    final dropping = selectedBus.droppingPoints.isNotEmpty ? selectedBus.droppingPoints.first : null;

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title and Date
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${widget.origin ?? "Boarding"} To ${widget.destination ?? "Dropping"}',
                    style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
                  ),
                  Text(
                    DateFormat('E, MMM dd, yyyy').format(DateTime.parse(selectedBus.departureTime)),
                    style: GoogleFonts.poppins(fontSize: 13, color: Colors.grey.shade600),
                  ),
                ],
              ),
              IconButton(
                icon: Icon(showDetails ? Icons.expand_less : Icons.expand_more),
                onPressed: () => setState(() => showDetails = !showDetails),
              ),
            ],
          ),
          const SizedBox(height: 10),

          // Boarding/Dropping Time & Address section
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Boarding/Dropping Time & Address", style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
                const SizedBox(height: 12),

                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Boarding Column
                    Expanded(
                      flex: 4,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.origin ?? "--",
                            style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            formatTime(boarding?.cityPointTime ?? ""),
                            style: GoogleFonts.poppins(fontWeight: FontWeight.w700, fontSize: 16),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            boarding?.cityPointName ?? "--",
                            style: GoogleFonts.poppins(fontSize: 12, height: 1.3),
                          ),
                        ],
                      ),
                    ),

                    // Duration
                    Expanded(
                      flex: 3,
                      child: Column(
                        children: [
                          Text(
                            calculateDuration(selectedBus.departureTime, selectedBus.arrivalTime),
                            style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey[600]),
                          ),
                          const SizedBox(height: 4),
                          Icon(Icons.fiber_manual_record, size: 8, color: constants.themeColor2),
                        ],
                      ),
                    ),

                    // Dropping Column
                    Expanded(
                      flex: 4,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            widget.destination ?? "--",
                            style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            formatTime(dropping?.cityPointTime ?? ""),
                            style: GoogleFonts.poppins(fontWeight: FontWeight.w700, fontSize: 16),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            dropping?.cityPointName ?? "--",
                            textAlign: TextAlign.right,
                            style: GoogleFonts.poppins(fontSize: 12, height: 1.3),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                if (showDetails) ...[
                  const SizedBox(height: 20),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          _buildCircle(),
                          _buildDashedLine(height: 100),
                          _buildCircle(),
                        ],
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Pick up", style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
                            const SizedBox(height: 4),
                            Text(
                              "${boarding?.cityPointName ?? "--"} at ${formatTime(boarding?.cityPointTime ?? "")}",
                              style: GoogleFonts.poppins(fontSize: 13),
                            ),
                            const SizedBox(height: 14),
                            Text("Drop Point", style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
                            const SizedBox(height: 4),
                            Text(
                              "${dropping?.cityPointName ?? "--"} at ${formatTime(dropping?.cityPointTime ?? "")}",
                              style: GoogleFonts.poppins(fontSize: 13),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),

          if (showDetails) ...[
            const SizedBox(height: 20),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              decoration: BoxDecoration(
                color: constants.themeColor1.withOpacity(0.05),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: constants.themeColor1.withOpacity(0.3)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.04),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildInfoRow(Icons.directions_bus, "Bus Operator", "${selectedBus.travelName}"),
                  const SizedBox(height: 14),
                  _buildInfoRow(Icons.event_seat, "Selected Seats", "${widget.selectedSeats} Seat(s)"),
                  const SizedBox(height: 14),
                  _buildInfoRow(
                    Icons.directions,
                    "Bus Type",
                    "${selectedBus.busType}",
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: constants.themeColor1, size: 20),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: GoogleFonts.poppins(fontSize: 13, color: Colors.black54),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class TravellerDetailCard extends StatefulWidget {
  final int index;
  final String seat;

  const TravellerDetailCard({
    super.key,
    required this.index,
    required this.seat,
  });

  @override
  State<TravellerDetailCard> createState() => _TravellerDetailCardState();
}

class _TravellerDetailCardState extends State<TravellerDetailCard> {
  String selectedGender = "";
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final travellerProvider = Provider.of<BusTravellerProvider>(context, listen: false);
      travellerProvider.updatePassenger(widget.index - 1, BusPassenger(
        title: "Mr.",
        firstName: _firstNameController.text,
        lastName: _lastNameController.text,
        age: int.tryParse(_ageController.text) ?? 25,
        gender: selectedGender,
        email: _emailController.text, // You can add real input if needed
        phone: _phoneController.text,       // Same here
        isLead: false,
        seat: context.read<BusSeatProvider>().selectedSeatList[widget.index - 1].toJson(),
      ));
    });
    void _updatePassengerInProvider() {
      final travellerProvider = Provider.of<BusTravellerProvider>(context, listen: false);
      travellerProvider.updatePassenger(
        widget.index - 1,
        BusPassenger(
          title: "Mr.",
          firstName: _firstNameController.text.trim(),
          lastName: _lastNameController.text.trim(),
          age: int.tryParse(_ageController.text) ?? 25,
          gender: selectedGender,
          email: _emailController.text,
          phone: _phoneController.text,
          isLead: widget.index == 1,
          seat: context.read<BusSeatProvider>().selectedSeatList[widget.index - 1].toJson(),
        ),
      );
    }
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "ADULT ${widget.index}",
                style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.red.shade50,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  widget.seat,
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: constants.themeColor2,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),

          // Gender Selection
          Row(
            children: [
              Expanded(child: _genderButton("Male")),
              const SizedBox(width: 12),
              Expanded(child: _genderButton("Female")),
            ],
          ),

          const SizedBox(height: 10),

          // Name Fields
          _labelledTextField(
            "First Name (& Middle name if any)",
            "Enter First Name",
            _firstNameController,
                (val) => _updatePassengerInProvider(),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: _labelledTextField(
                  "Last Name",
                  "Enter Last Name",
                  _lastNameController,
                      (val) => _updatePassengerInProvider(),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _labelledTextField(
                  "Age",
                  "Enter Age",
                  _ageController,
                      (val) => _updatePassengerInProvider(),
                ),
              ),

            ],
          ),
          const SizedBox(height: 10),

          // Name Fields
          _labelledTextField(
            "Email",
            "Enter Email Address",
            _emailController,
                (val) => _updatePassengerInProvider(),
          ),

          const SizedBox(height: 10),

          // Name Fields
          _labelledTextField(
            "Phone Number",
            "Enter Phone Number",
            _phoneController,
                (val) => _updatePassengerInProvider(),
          ),
        ],
      ),
    );
  }

  Widget _genderButton(String text) {
    final bool isSelected = selectedGender == text;
    void _updatePassengerInProvider() {
      final travellerProvider = Provider.of<BusTravellerProvider>(context, listen: false);
      travellerProvider.updatePassenger(
        widget.index - 1,
        BusPassenger(
          title: "Mr.",
          firstName: _firstNameController.text.trim(),
          lastName: _lastNameController.text.trim(),
          age: int.tryParse(_ageController.text) ?? 25,
          gender: selectedGender,
          email: "example@email.com",
          phone: "01234567890",
          isLead: widget.index == 1,
          seat: context.read<BusSeatProvider>().selectedSeatList[widget.index - 1].toJson(),
        ),
      );
    }

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedGender = text;
        });
        _updatePassengerInProvider();
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color:
              isSelected
                  ? constants.themeColor1.withOpacity(0.1)
                  : Colors.transparent,
          border: Border.all(
            color: isSelected ? constants.themeColor1 : Colors.grey.shade300,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        alignment: Alignment.center,
        child: Text(
          text,
          style: GoogleFonts.poppins(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: isSelected ? constants.themeColor1 : Colors.black54,
          ),
        ),
      ),
    );
  }

  Widget _labelledTextField(String label, String hint, TextEditingController controller, Function(String) onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: GoogleFonts.poppins(fontSize: 13)),
        const SizedBox(height: 6),
        TextField(
          controller: controller,
          onChanged: onChanged,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: GoogleFonts.poppins(fontSize: 13),
            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
          ),
        ),
      ],
    );
  }

}
