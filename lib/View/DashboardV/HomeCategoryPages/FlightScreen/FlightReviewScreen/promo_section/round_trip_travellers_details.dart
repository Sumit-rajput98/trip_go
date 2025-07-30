import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:trip_go/View/DashboardV/HomeCategoryPages/FlightScreen/FlightReviewScreen/promo_section/widgets/add_traveller_widget.dart';
// import 'package:trip_go/View/DashboardV/HomeCategoryPages/FlightScreen/FlightReviewScreen/promo_section/widgets/add_traveller_widget.dart';
import '../../../../../../Model/FlightM/add_traveller_model.dart';
import '../../../../../../Model/FlightM/flight_SSR_round_model.dart';
import '../../../../../../ViewM/FlightVM/flight_ssr_lcc_round_view_model.dart';
import '../../../../../../constants.dart';
import '../../AddOnsView/top_add_one_round.dart';
import '../../FlightWidgets/gst_bottom_sheet.dart';
import '../../common_widget/bottom_bar.dart';
import '../../common_widget/loading_screen.dart';
import 'package:intl/intl.dart';

class RoundTripTravellersDetails extends StatefulWidget {
  final String resultIndex;
  final int adultCount;
  final int? childrenCount;
  final int? infantsCount;
  final String selectedOnwardResultIndex;
  final String selectedReturnResultIndex;
  final String traceId;
  final String returnResultIndex;
  final String returnTraceId;
  final int? price;
  final String currentCity;
  final String returnOriginCity;
  final String returnDestinationCity;
  final String destinationCity;
  final bool isLcc;
  final bool isLccIb;
  final Map<String, dynamic> fare;
  final Map<String, dynamic> fare2;
  final String departure;
final String arrival;
final String duration;
final String flightName;
final String flightNumber;

final String returnDeparture;
final String returnArrival;
final String returnDuration;
final String returnFlightName;
final String returnFlightNumber;


  const RoundTripTravellersDetails({super.key,
    required this.isLcc,
    required this.isLccIb,
    required this.fare,
    required this.fare2,
    required this.currentCity,
    required this.returnOriginCity,
    required this.returnDestinationCity,
    required this.destinationCity,
    required this.selectedOnwardResultIndex,
    required this.selectedReturnResultIndex,
    required this.adultCount,
    this.childrenCount,
    this.infantsCount,
    required this.resultIndex, required this.traceId, required this.returnResultIndex, required this.returnTraceId, this.price, 
    required this.departure,
  required this.arrival,
  required this.duration,
  required this.flightName,
  required this.flightNumber,
  required this.returnDeparture,
  required this.returnArrival,
  required this.returnDuration,
  required this.returnFlightName,
  required this.returnFlightNumber,});

  @override
  State<RoundTripTravellersDetails> createState() => _TravellerDetailsState();
}

class _TravellerDetailsState extends State<RoundTripTravellersDetails> {
   final TextEditingController emailController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
   List<Traveller> travellers = [];
   bool isChecked = false;
   bool isCheckedGst = false;
   String? errorMessage;
   String? emailError;
   String? phoneError;
   String? countErrorMessage;
   String? companyName;
   String? regNo;

  @override
  Widget build(BuildContext context) {
    String formatTime(String timeStr) {
      try {
        final dateTime = DateTime.parse(timeStr);
        return DateFormat.Hm().format(dateTime); // e.g., "23:00"
      } catch (e) {
        return timeStr; // fallback if format fails
      }
    }
    String formatToDayMonth(String dateTimeString) {
  DateTime parsedDate = DateTime.parse(dateTimeString);
  return DateFormat('d MMMM').format(parsedDate); // '20 June'
}
    final width = MediaQuery.of(context).size.width;
    final request1 = FlightSsrLccRoundRequest(traceId: widget.traceId, resultIndex: widget.resultIndex, fare: {}, resultIndexIb: widget.selectedReturnResultIndex);

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: 130,
                  decoration: const BoxDecoration(
                    color: Color(0xFF341f97),
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
                      Text("Travellers Details",
                          style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
                Padding(padding: const EdgeInsets.fromLTRB(10, 90, 10, 0),child: Column(
                  children: [
                    _buildFlightInfoCard(
  title: "${widget.currentCity} → ${widget.destinationCity}",
  subtitle: "${formatToDayMonth(widget.departure)} |  ${formatTime(widget.departure)} - ${formatTime(widget.arrival)}",
  desc: "${widget.duration}  |  ${widget.flightName}",
  airlineName:widget.flightName,
),

                    _buildFlightInfoCard(
  title: "${widget.returnOriginCity} → ${widget.returnDestinationCity}",
  subtitle: "${formatToDayMonth(widget.returnDeparture)} | ${formatTime(widget.returnDeparture)} - ${formatTime(widget.returnArrival)}",
  desc: "${widget.returnDuration} |${widget.returnFlightName}",
 airlineName:  widget.returnFlightName,
),

                    _buildTravellerSection(),
                    _buildContactDetails(),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Container(
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
                                  setState(() {
                                    isCheckedGst = val!;
                                  });
                                  final result = await showModalBottomSheet<Map<String, String>>(
                                    context: context,
                                    isScrollControlled: true,
                                    shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.vertical(top: Radius.circular(5)),
                                    ),
                                    builder: (context) => Padding(
                                      padding: const EdgeInsets.only(bottom: 20, top: 20, left: 16, right: 16),
                                      child: GstBottomSheet(),
                                    ),
                                  );

                                  if (result != null) {
                                    final companyName = result['companyName'];
                                    final regNo = result['registrationNo'];

                                    print('Company Name: $companyName');
                                    print('Registration No.: $regNo');
                                  }
                                }
                              },
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Use GST for this booking (OPTIONAL)", style:GoogleFonts.poppins(
                                      fontSize: 13,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w700
                                  ),),
                                  Text("To claim credit of GST charged by airlines/TripGo, please enter your company's GST number.",style:  GoogleFonts.poppins(
                                    fontSize: 13,
                                    color: Colors.grey.shade600,
                                  ),)
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    // Terms & Conditions
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                      child: Column(
                        children: [
                          Row(
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
                          if (errorMessage != null)
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Text(
                                errorMessage!,
                                style: const TextStyle(color: Colors.red, fontSize: 14, fontFamily: 'poppins'),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),)
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: buildBottomBar(context,(){
        final viewModel = Provider.of<FlightSsrLccRoundViewModel>(
          context,
          listen: false,
        );

        setState(() {
          emailError = null;
          errorMessage = null;
          phoneError = null;
        });

        bool hasError = false;

        if (emailController.text.trim().isEmpty) {
          setState(() {
            emailError = "Email address is required";
          });
          hasError = true;
        }

        if (mobileController.text.trim().isEmpty) {
          setState(() {
            phoneError = "Mobile No. is required";
          });
          hasError = true;
        }

        if (!isChecked) {
          setState(() {
            errorMessage = "Please accept T&C and Privacy Policy";
          });
          hasError = true;
        } else if ((widget.adultCount ?? 0) > travellers.length) {
          setState(() {
            countErrorMessage = "Total no. of Adults must be: ${widget.adultCount}";
          });
          hasError = true;
        }

        if (hasError) return;
        // Show loading
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const LoadingScreen(),
          ),
        );
        viewModel.fetchSsrLccRoundRT(request1).then((_){
          Navigator.pop(context);
          final response1 = viewModel.flightSsrLccRoundRes1!;
          print('done');

          Navigator.push(context, MaterialPageRoute(builder: (context)=>AddOnsPageRound(
            resultIndex: widget.resultIndex,
            isLcc: widget.isLcc,
            isLccIb: widget.isLccIb,
            traceId: widget.traceId,
            travellers: travellers,
            flightSsrLccRes1: response1.data1,
            flightSsrLccRes2: response1.data1?.inbound,
            adultCount: widget.adultCount,
            childrenCount: widget.childrenCount,
            infantsCount: widget.infantsCount,
            rt: true,price: widget.price,
            fare2: widget.fare2,
            phone: mobileController.text,
            fare: widget.fare, email: emailController.text, selectedOnwardResultIndex: widget.selectedOnwardResultIndex, selectedReturnResultIndex: widget.selectedReturnResultIndex,
          )));
        });
      },price: widget.price),
    );
  }
Widget _buildFlightInfoCard({
  required String title,
  required String subtitle,
  required String desc,
  required String airlineName,
}) {
  final List<Map<String, String>> airlines = [
    {
      "name": "Air India",
      "logo": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS-QO8gVe353NPaAV3wid57LAtWqIdet-EVMA&s",
    },
    {
      "name": "Air India Express",
      "logo": "https://flight.easemytrip.com/Content/AirlineLogon/IX.png",
    },
    {
      "name": "Indigo",
      "logo": "https://flight.easemytrip.com/Content/AirlineLogon/6E.png",
    },
    {
      "name": "Vistara",
      "logo": "https://flight.easemytrip.com/Content/AirlineLogon/UK.png",
    },
    {
      "name": "SpiceJet",
      "logo": "https://flight.easemytrip.com/Content/AirlineLogon/SG.png",
    },
    {
      "name": "GoAir",
      "logo": "https://flight.easemytrip.com/Content/AirlineLogon/G8.png",
    },
  ];
  String extractAirlineName(String rawName) {
    return rawName.split('|').first.trim();
  }

  String getAirlineLogo(String rawName) {
    final cleanName = extractAirlineName(rawName);

    final airline = airlines.firstWhere(
      (airline) => airline['name']!.toLowerCase() == cleanName.toLowerCase(),
      orElse: () => {
        "logo": "https://talentclick.com/wp-content/uploads/2021/08/placeholder-image.png"
      },
    );
    return airline['logo']!;
  }

  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
    child: Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.withOpacity(0.2)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.08),
            spreadRadius: 2,
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 22,
            backgroundColor: Colors.grey.shade100,
            backgroundImage: NetworkImage(getAirlineLogo(airlineName)),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title, // e.g., "Delhi → Mumbai"
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle, // e.g., "06:00 AM → 08:10 AM"
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.poppins(
                    fontSize: 13,
                    color: Colors.grey.shade700,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  desc, // e.g., "2h 10m | Flight No: AI203"
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.poppins(
                    fontSize: 13,
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          const Icon(Icons.keyboard_arrow_down_outlined, color: Colors.black54),
        ],
      ),
    ),
  );
}

  Widget _buildTravellerSection() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.grey.withOpacity(.4)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    "Travellers",
                    style: GoogleFonts.poppins(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  _travellerType(
                      count: widget.adultCount.toString(),
                      label: "ADULT",
                      iconUrl:
                      "https://flight.easemytrip.com/M_Content/img/adult-nw-icon.png"),
                  const SizedBox(width: 10),
                  _travellerType(
                      count: widget.childrenCount.toString(),
                      label: "CHILDREN",
                      iconUrl:
                      "https://flight.easemytrip.com/M_Content/img/adult-nw-icon.png"),
                  const SizedBox(width: 10),
                  _travellerType(
                      count: widget.infantsCount.toString(),
                      label: "INFANT(S)",
                      iconUrl:
                      "https://www.easemytrip.com/M_Content/img/infant-nw-icon.png"),
                ],
              ),
              const SizedBox(height: 15),
              Divider(color: Colors.grey.withOpacity(.2)),
              const SizedBox(height: 15),
              Container(
                color: constants.ultraLightThemeColor1,
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: [
                    Image.network(
                      "https://flight.easemytrip.com/M_Content/img/g-id-icon.png",
                      height: 25,
                      color: constants.themeColor1,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        "Name should be same as in Government ID proof",
                        style: GoogleFonts.poppins(
                          color: constants.themeColor1,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              if (countErrorMessage != null)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    countErrorMessage!,
                    style: const TextStyle(color: Colors.red, fontSize: 14, fontFamily: 'poppins'),
                  ),
                ),
              const SizedBox(height: 15),
              if (travellers.isNotEmpty)
                ...travellers.asMap().entries.map((entry) {
                  int index = entry.key;
                  var traveller = entry.value;
                  return Column(
                    children: [
                      Row(
                        children: [
                          Checkbox(
                            value: traveller.isSelected,  // ✅ access via property
                            onChanged: (val) {
                              setState(() {
                                travellers[index].isSelected = val!;
                              });
                            },
                          ),
                          const SizedBox(width: 5),
                          Text(
                            traveller.name,  // ✅ access via property
                            style: GoogleFonts.poppins(fontSize: 16),
                          ),
                          const Spacer(),
                          IconButton(
                            icon: const Icon(Icons.edit, color: Colors.grey),
                            onPressed: () async {
                              final editedTraveller = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => AddTravellerWidget(
                                    existingTraveller: traveller,
                                  ),
                                ),
                              );
                              if (editedTraveller != null && editedTraveller is Traveller) {
                                setState(() {
                                  travellers[index] = editedTraveller;
                                });
                              }
                            },
                          )
                        ],
                      ),
                      const Divider()
                    ],
                  );
                }),
              Divider(color: Colors.grey.withOpacity(.2)),
              const SizedBox(height: 5),
              Align(
                alignment: Alignment.centerRight,
                child: InkWell(
                  onTap: () async {
                    final newTraveller = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AddTravellerWidget(),
                      ),
                    );
                    if (newTraveller != null && newTraveller is Traveller) {
                      setState(() {
                        travellers.add(newTraveller);
                      });
                    }
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.add, size: 20, color: constants.themeColor1,),
                      const SizedBox(width: 5),
                      Text(
                        "ADD ADULT",
                        style: TextStyle(
                          fontSize: 16,
                          color: constants.themeColor1,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  /*Widget buildBottomBar(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF1F1F1F), Color(0xFF2C2C2C)],
        ),
        borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Left Section - Grand Total
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Grand Total",
                  style: GoogleFonts.poppins(
                    color: Colors.white70,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Text(
                      "₹5,501",
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(width: 4),
                    const Icon(Icons.info_outline, size: 16, color: Colors.white70),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          // Right Section - Continue Button
          ElevatedButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=>AddOnsPage()));
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orange,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            child: Text(
              "Continue Booking",
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }*/

  Widget _travellerType({required String count, required String label, required String iconUrl}) {
    return Column(
      children: [
        Image.network(iconUrl, height: 15),
        const SizedBox(height: 2),
        Text(count, style: GoogleFonts.poppins(fontSize: 15)),
        Text(label, style: GoogleFonts.poppins(fontSize: 10)),
      ],
    );
  }

  Widget _buildContactDetails() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.grey.withOpacity(.4)),
        ),
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Contact Information",
              style: GoogleFonts.poppins(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "Your mobile number will be used only for flight related communication",
              style: GoogleFonts.poppins(
                fontSize: 13,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                hintText: "Please enter your email address",
                hintStyle: GoogleFonts.poppins(),
                errorText: emailError,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
              style: GoogleFonts.poppins(),
            ),
            const SizedBox(height: 15),
            Row(
              children: [
                Container(
                  width: 55,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.withOpacity(.4)),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    "91",
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: TextField(
                    controller: mobileController,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      hintText: "Enter Mobile No",
                      errorText: phoneError,
                      hintStyle: GoogleFonts.poppins(),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                    style: GoogleFonts.poppins(),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
