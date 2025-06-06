import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:trip_go/Model/FlightM/flight_SSR_model_lcc.dart';
import 'package:trip_go/View/DashboardV/HomeCategoryPages/FlightScreen/AddOnsView/ssr_no_resut_screen.dart';
import 'package:trip_go/View/DashboardV/HomeCategoryPages/FlightScreen/AddOnsView/top_add_one.dart';
import 'package:trip_go/View/DashboardV/HomeCategoryPages/FlightScreen/FlightReviewScreen/promo_section/widgets/add_traveller_widget.dart';
import 'package:trip_go/ViewM/FlightVM/flight_ssr_lcc_view_model.dart';
import '../../../../../Model/FlightM/add_traveller_model.dart';
import '../../../../../constants.dart';
import '../FlightWidgets/gst_bottom_sheet.dart';
import '../common_widget/bottom_bar.dart';
import '../common_widget/loading_screen.dart';

class TravellerDetails extends StatefulWidget {
  final Map<String, dynamic> fare;
  final String traceId;
  final String resultIndex;
  final int? adultCount;
  final int price;
  final bool isLcc;
  const TravellerDetails({super.key,required this.fare, required this.traceId, required this.resultIndex, this.adultCount, required this.price, required this.isLcc});

  @override
  State<TravellerDetails> createState() => _TravellerDetailsState();
}

class _TravellerDetailsState extends State<TravellerDetails> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  bool isChecked = false;
  bool isCheckedGst = false;
  String? errorMessage;
  String? emailError;
  String? countErrorMessage;
  String? companyName;
  String? regNo;

  List<Traveller> travellers = [];
  void _navigatorFunc() {
    setState(() {
      emailError = null;
      errorMessage = null;
    });

    bool hasError = false;

    if (emailController.text.trim().isEmpty) {
      setState(() {
        emailError = "Email address is required";
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

    final viewModel = Provider.of<FlightSsrLccViewModel>(
      context,
      listen: false,
    );

    // Show loading
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const LoadingScreen(),
      ),
    );

    final request = FlightSsrLccRequest(
        traceId: widget.traceId,
        resultIndex: widget.resultIndex,
        fare: widget.fare
    );

    viewModel.fetchSsrLcc(request).then((_){
      Navigator.pop(context);
      print("### ${widget.traceId}");

      final response = viewModel.flightSsrLccRes;
      print('done');

      if (response?.data == null) {
        // Handle the null case: show an error or don't navigate
        Navigator.push(context, MaterialPageRoute(builder: (context)=> SsrNoResultScreen()));
        return; // stop further navigation
      }

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AddOnsPage(
            flightSsrLccRes: response!.data,
            adultCount: widget.adultCount,
            rt: false,
            price: widget.price,
            resultIndex: widget.resultIndex,
            traceId: widget.traceId,
            fare: widget.fare,
            travellers: travellers, // << pass the travellers list here
            isLcc: widget.isLcc, email: emailController.text,
            companyName: companyName, regNo: regNo,
          ),
        ),
      );

    });
  }

  @override
  void initState() {
    super.initState();
    emailController.addListener(() {
      if (emailError != null && emailController.text.trim().isNotEmpty) {
        setState(() {
          emailError = null;
        });
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

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
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 90, 10, 0),
                  child: Column(
                    children: [
                      _buildFlightInfoCard(),
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
                                      builder: (context) => const Padding(
                                        padding: EdgeInsets.only(bottom: 20, top: 20, left: 16, right: 16),
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
                  ),
                )
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: buildBottomBar(context, _navigatorFunc,price: widget.price),
    );
  }

  Widget _buildFlightInfoCard() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
        height: 110,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.grey.withOpacity(.4)),
        ),
        child: Row(
          children: [
            const Padding(
              padding: EdgeInsets.all(15),
              child: CircleAvatar(
                backgroundImage: NetworkImage(
                    "https://flight.easemytrip.com/Content/AirlineLogon/SG.png"),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                Text(
                  constants.titleOne,
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  constants.subTitleOne,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
                Text(
                  constants.descriptionOne,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            const Spacer(),
            const Icon(Icons.keyboard_arrow_down, color: Colors.black),
            const SizedBox(width: 10),
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
                      count: travellers.length.toString(),
                      label: "ADULT",
                      iconUrl:
                      "https://flight.easemytrip.com/M_Content/img/adult-nw-icon.png"),
                  const SizedBox(width: 10),
                  _travellerType(
                      count: "0",
                      label: "CHILDREN",
                      iconUrl:
                      "https://flight.easemytrip.com/M_Content/img/adult-nw-icon.png"),
                  const SizedBox(width: 10),
                  _travellerType(
                      count: "0",
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