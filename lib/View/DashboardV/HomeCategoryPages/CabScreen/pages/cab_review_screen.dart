import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trip_go/View/DashboardV/HomeCategoryPages/CabScreen/widgets/cab_traveller_details_card.dart';
import 'package:trip_go/View/DashboardV/HomeCategoryPages/CabScreen/widgets/trip_details_card.dart';
import 'package:trip_go/View/DashboardV/HomeCategoryPages/FlightScreen/FlightWidgets/gst_bottom_sheet.dart';
import 'package:trip_go/View/DashboardV/HomeCategoryPages/HotelScreen/hotel_promo_section.dart';
import 'package:trip_go/constants.dart';
import '../../../../../Model/CabM/cab_search_model.dart';
import '../../../../../ViewM/CabVM/cab_book_view_model.dart';
import '../../FlightScreen/common_widget/bottom_bar.dart';
import '../widgets/payment_option_card.dart';
import 'package:intl/intl.dart';

import 'cab_booking_success_page.dart';
import 'cab_payment_gateway.dart';

class CabReviewScreen extends StatefulWidget {
  final CabModel cab;
  final String pickup;
  final String drop;
  final String date;
  final String pickupState;
  final String dropState;
  final DateTime? pickupDate;
  final DateTime? dropDate;

  const CabReviewScreen({super.key,required this.cab,required this.date, required this.pickup, required this.drop, required this.dropState, required this.pickupState, required this.pickupDate, required this.dropDate});

  @override
  State<CabReviewScreen> createState() =>
      _CabReviewScreenState();
}

class _CabReviewScreenState extends State<CabReviewScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController pickupController = TextEditingController();
  final TextEditingController dropController = TextEditingController();
  bool? isInsuranceSelected; // null by default, or use `true` for preselection
  bool isChecked = false;
  bool isCheckedGst = false;
  String? errorMessage;
  String? companyName;
  String? regNo;

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
            "Cab Review & Traveler",
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
      child: FormField<bool>(
        initialValue: isChecked,
        validator: (value) {
          if (!isChecked) return 'Please accept T&C and Privacy Policy';
          return null;
        },
        builder: (formFieldState) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Checkbox(
                    value: isChecked,
                    onChanged: (val) {
                      setState(() {
                        isChecked = val!;
                        formFieldState.didChange(val);
                      });
                    },
                  ),
                  Expanded(
                    child: RichText(
                      text: TextSpan(
                        style: GoogleFonts.poppins(color: Colors.black),
                        children: const [
                          TextSpan(text: "I Accept "),
                          TextSpan(
                            text: "T&C ",
                            style: TextStyle(color: Colors.blue),
                          ),
                          TextSpan(text: "and "),
                          TextSpan(
                            text: "Privacy Policy",
                            style: TextStyle(color: Colors.blue),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              if (formFieldState.hasError)
                Padding(
                  padding: const EdgeInsets.only(left: 12, top: 4),
                  child: Text(
                    formFieldState.errorText!,
                    style: TextStyle(
                      color: Colors.red.shade700,
                      fontSize: 12,
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }

  bool showDetails = false;

  @override
  Widget build(BuildContext context) {
    CabBookViewModel cabBookVM = CabBookViewModel();

    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: buildBottomBar(
        context,
            () async {
              if (!_formKey.currentState!.validate()) {
                return; // Don't proceed
              }

          final Map<String, dynamic> requestData = {
            "UserEmail": emailController.text,
            "UserPhone": phoneController.text,
            "Type": "app",
            "type": "Airport Transfer",
            "pickup": widget.pickup,
            "plat": "28.6434",
            "plng": "77.2220",
            "drop": widget.drop,
            "dlat": "28.5562",
            "dlng": "77.1000",
            "start_date": widget.pickupDate != null
                ? DateFormat("yyyy-MM-dd").format(widget.pickupDate!)
                : "",
            "start_time": widget.pickupDate != null
                ? DateFormat("HH:mm").format(widget.pickupDate!)
                : "",
            "end_date": widget.dropDate != null
                ? DateFormat("yyyy-MM-dd").format(widget.dropDate!)
                : "",
            "end_time": widget.dropDate != null
                ? DateFormat("HH:mm").format(widget.dropDate!)
                : "",
            "cab_id": widget.cab.id,
            "name": "${firstNameController.text} ${lastNameController.text}",
            "email": emailController.text,
            "phone": phoneController.text,
            "phone_code": 91,
            "mrp": widget.cab.mrp,
            "price": widget.cab.price,
            "discount": "${widget.cab.discount}",
          };

          print("DATA TO SEND: $requestData");

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => CabPaymentGateway(
                cabId: widget.cab.id.toString(),
                amount: widget.cab.price, // in rupees
                email: emailController.text,
                phone: phoneController.text,
                bookingPayload: requestData,
              ),
            ),
          );
        },
        price: widget.cab.price,
      ),

      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
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
                    CabTravellerDetailsCard(
                      firstNameController: firstNameController,
                      lastNameController: lastNameController,
                      emailController: emailController,
                      phoneController: phoneController,
                    ),
                    const SizedBox(height: 12),
                    TripDetailsCard(
                      pickupController: pickupController,
                      dropController: dropController,
                    ),
                    const SizedBox(height: 12),
                    PaymentOptionCard(),
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
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.7, // ✅ Optional: constrain width
                    child: Text(
                      '${widget.pickup} To ${widget.drop}',
                      style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Text(
                    'Pickup : ${widget.date}',
                    style: GoogleFonts.poppins(
                      fontSize: 13,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 10),
          Divider(),
          Row(
            children: [
              Container(
                width: 120,
                height: 80,
                padding: const EdgeInsets.all(4),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Image.network(
                    widget.cab.image,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) =>
                        Icon(Icons.directions_car, size: 40),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              // Flexible/Expanded to avoid overflow
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.cab.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      softWrap: true,
                      style: const TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'poppins',
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "1 Unit | ${widget.cab.totalSeats} Seat | ${widget.cab.distance} Km",
                      style: const TextStyle(
                        fontSize: 10,
                        fontFamily: 'poppins',
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          Divider(),
          _buildCabDetailsList()
        ],
      ),
    );
  }

  Widget _buildCabDetailsList() {
    List<String> _parseDescription(String html) {
      if (html.isEmpty) return [];

      // Remove outer div or ul tags (if they exist)
      final cleanedHtml = html.replaceAll(RegExp(r'<(div|ul)[^>]*>|<\/(div|ul)>'), '');

      // Match all <li>...</li> content
      final regex = RegExp(r'<li[^>]*>(.*?)<\/li>', caseSensitive: false, multiLine: true);
      final matches = regex.allMatches(cleanedHtml);

      final items = matches.map((m) {
        final text = m.group(1)!
            .replaceAll(RegExp(r'<[^>]+>'), '') // remove any nested tags
            .replaceAll('&nbsp;', ' ')
            .trim();
        print(">>> Parsed list item: $text"); // DEBUG PRINT
        return text;
      }).toList();

      print(">>> Total parsed items: ${items.length}");
      return items;
    }

    final description = widget.cab.description;
    print(">>> CAB DESCRIPTION inside buildCabDetailsList: $description");

    final descriptionPoints = _parseDescription(description);

    if (descriptionPoints.isEmpty) {
      return Text(
        "No cab description found.",
        style: TextStyle(fontSize: 12, color: Colors.red),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: descriptionPoints.map((point) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 6),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.circle, size: 6, color: Colors.black54),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  point,
                  style: const TextStyle(
                    fontSize: 12,
                    fontFamily: 'poppins',
                  ),
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildInlineInfoRow({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(icon, size: 20, color: Colors.grey[800]),
          const SizedBox(width: 10),
          Expanded(
            flex: 2,
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 8,
                fontWeight: FontWeight.w500,
                fontFamily: 'poppins',
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: const TextStyle(
                fontSize: 8,
                color: Colors.black87,
                fontFamily: 'poppins',
              ),
            ),
          ),
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

  @override
  Widget build(BuildContext context) {
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
          ),
          const SizedBox(height: 10),

          Row(
            children: [
              Expanded(
                child: _labelledTextField("Last Name", "Enter Last Name"),
              ),
              const SizedBox(width: 12),
              Expanded(child: _labelledTextField("Age", "Enter Age")),
            ],
          ),
        ],
      ),
    );
  }

  Widget _genderButton(String text) {
    final bool isSelected = selectedGender == text;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedGender = text;
        });
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

  Widget _labelledTextField(String label, String hint) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: GoogleFonts.poppins(fontSize: 13)),
        const SizedBox(height: 6),
        TextField(
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: GoogleFonts.poppins(fontSize: 13),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 14,
            ),
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
