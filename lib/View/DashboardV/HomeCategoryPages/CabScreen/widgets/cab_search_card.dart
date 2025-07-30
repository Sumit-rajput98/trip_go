import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:trip_go/View/DashboardV/HomeCategoryPages/CabScreen/pages/cab_result_screen.dart';
import 'package:trip_go/View/DashboardV/HomeCategoryPages/CabScreen/widgets/luggage_bottom_sheet.dart';
import 'package:trip_go/View/DashboardV/HomeCategoryPages/CabScreen/widgets/search_cab_city_view.dart';
import 'package:trip_go/View/DashboardV/HomeCategoryPages/FlightScreen/FlightWidgets/flight_widgets.dart';
import 'package:trip_go/View/DashboardV/HomeCategoryPages/FlightScreen/FlightWidgets/traveller_selection_bottom_sheet.dart';
import 'package:trip_go/View/DashboardV/HomeCategoryPages/FlightScreen/common_widget/bottom_sgeets.dart';
import 'package:trip_go/View/Widgets/gradient_button.dart';
import 'package:trip_go/constants.dart';
import 'package:intl/intl.dart';

import '../../../../../ViewM/CabVM/cab_search_view_model.dart';
import '../../FlightScreen/common_widget/loading_screen.dart';

class CabSearchCard extends StatefulWidget {
  const CabSearchCard({super.key});

  @override
  State<CabSearchCard> createState() => _CabSearchCardState();
}

class _CabSearchCardState extends State<CabSearchCard> {
  String _formatDateTime(DateTime? dt) {
    if (dt == null) return "Date & Time";
    return DateFormat('dd MMM yyyy, hh:mm a').format(dt);
  }

  int adultsCount = 0;
  int childrenCount = 0;
  int infantsCount = 0;
  int travellerCount = 0;
  String? selectedPickupState;
  String? selectedDropState;

  int cabinCount = 0;
  int checkedInCount = 0;
  int totalLuggageCount = 0;

  DateTime? selectedPickupDateTime;
  DateTime? selectedReturnDateTime;

  final TextEditingController originController = TextEditingController();
  final TextEditingController destinationController = TextEditingController();

  final TextEditingController originControllerOutStation =
      TextEditingController();
  final TextEditingController destinationControllerOutStation =
      TextEditingController();

  final TextEditingController originControllerHourly = TextEditingController();

  int tripTypeIndex = 0; // 0: Airport, 1: Outstation, 2: Hourly
  int selectedAirportTab = 0; // 0: Pickup, 1: Drop
  String pickUpText = "Pick Up Location";
  bool isOverseas = false;
  bool showReturnField = false;
  int selectedHour = 1;

  @override
  Widget build(BuildContext context) {
    void swapCities() {
      print("Pressed");

      setState(() {
        final temp = originController.text;
        originController.text = destinationController.text;
        destinationController.text = temp;
      });
    }
    return Column(
      children: [
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              // colors: [Colors.white, Color(0xFFFFEBEE), Color(0xFFFFF5F6)],
              colors: [Color(0xFFF4F5F9), Color(0xFFF0F2F8)],
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                const SizedBox(height: 10),

                /// Tabs
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    gradient: const LinearGradient(
                      colors: [Colors.red, Colors.blue],
                    ),
                  ),
                  padding: const EdgeInsets.all(4),
                  child: TripSelector(
                    types: ['AIRPORT', 'OUTSTATION', 'HOURLY'],
                    tripTypeIndex: tripTypeIndex,
                    onChanged: (index) => setState(() => tripTypeIndex = index),
                  ),
                ),

                const SizedBox(height: 12),

                /// Sub-tab only for AIRPORT
                if (tripTypeIndex == 0)
                  Row(
                    children: [
                      _buildSubTab("Airport Pickup", 0),
                      const SizedBox(width: 8),
                      _buildSubTab("Airport Drop", 1),
                    ],
                  ),

                const SizedBox(height: 16),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Column(
                        children: [
                          _buildLocationInput("Pickup Location", originController, Icons.circle),
                          if (tripTypeIndex != 2)
                          Divider(),
                          if (tripTypeIndex != 2)
                            _buildLocationInput("Drop Location", destinationController, Icons.pin_drop),
                        ],
                      ),
                    ),

                    /// 🔄 Swap Button positioned on divider
                    if (tripTypeIndex != 2)
                    Positioned(
                      right: 35,
                      child: GestureDetector(
                        onTap: swapCities,
                        child: Container(
                          height: 46,
                          width: 46,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: constants.themeColor1,
                              width: 1,
                            ),
                            color: Colors.blue.shade50,
                          ),
                          child:  Center(
                            child: Icon(
                              Icons.swap_vert,
                              color: constants.themeColor1,
                              size: 35,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 12),
                _buildInfoField(
                  "Pick-up Date & Time",
                  _formatDateTime(selectedPickupDateTime),
                  Icons.access_time,
                  onTap:
                      () => showModernDateTimePicker(
                        context: context,
                        initialDate: selectedPickupDateTime,
                        onDateSelected: (dt) {
                          setState(() => selectedPickupDateTime = dt);
                        },
                      ),
                ),

                /// ADD RETURN for Outstation
                if (tripTypeIndex == 1) ...[
                  const SizedBox(height: 12),
                  if (!showReturnField)
                    GestureDetector(
                      onTap: () => setState(() => showReturnField = true),
                      child: Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: constants.themeColor1),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          "ADD RETURN",
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w600,
                            color: constants.themeColor1,
                          ),
                        ),
                      ),
                    )
                  else
                    Stack(
                      children: [
                        _buildInfoField(
                          "Return Date & Time",
                          _formatDateTime(selectedReturnDateTime),
                          Icons.calendar_today,
                          onTap: () => showModernDateTimePicker(
                            context: context,
                            initialDate: selectedReturnDateTime,
                            onDateSelected: (dt) {
                              setState(() => selectedReturnDateTime = dt); // ✅ fixed here
                            },
                          ),
                        ),
                        Positioned(
                          right: 8,
                          top: 8,
                          child: GestureDetector(
                            onTap: () => setState(() => showReturnField = false),
                            child: const Icon(Icons.close, size: 20),
                          ),
                        ),
                      ],
                    ),
                ],

                /// HOURLY - Select Hour
                if (tripTypeIndex == 2) ...[
                  const SizedBox(height: 12),
                  _buildDropdownField("Rent For", selectedHour, (val) {
                    setState(() => selectedHour = val!);
                  }),
                ],

                /// Overseas checkbox - shown only in AIRPORT
                if (tripTypeIndex == 0) ...[
                  const SizedBox(height: 12),

                  if (isOverseas) ...[
                    const SizedBox(height: 8),
                    _buildInfoField(
                      onTap: () {
                        _showTravellerBottomSheet();
                      },
                      "Traveller",
                      travellerCount > 0
                          ? "$travellerCount Traveller"
                          : "Select Adult & Child",
                      Icons.person_outline,
                    ),
                    const SizedBox(height: 8),
                    _buildInfoField(
                      onTap: () {
                        _showLuggageBottomSheet();
                      },
                      "Luggages",
                      totalLuggageCount > 0
                          ? "$totalLuggageCount"
                          : "Select Carry & Checked-In Luggage",
                      Icons.card_travel,
                    ),
                  ],
                  Row(
                    children: [
                      Checkbox(
                        value: isOverseas,
                        activeColor: constants.themeColor1,
                        onChanged:
                            (val) => setState(() => isOverseas = val ?? false),
                      ),
                      Text(
                        "Overseas",
                        style: GoogleFonts.poppins(fontSize: 14),
                      ),
                    ],
                  ),
                ],
                GradientButton(
                    label: "SEARCH",
                  onPressed: () async {
                    String? error;
                    if (tripTypeIndex == 0) {
                      // Airport
                      if (originController.text.isEmpty) {
                        error = "Please select pick-up location";
                      } else if (destinationController.text.isEmpty)
                        error = "Please select drop location";
                      else if (selectedPickupDateTime == null)
                        error = "Please select pickup date & time";
                      else if (isOverseas && travellerCount == 0)
                        error = "Please select traveller count";
                      else if (isOverseas && totalLuggageCount == 0)
                        error = "Please select luggage info";
                    } else if (tripTypeIndex == 1) {
                      // Outstation
                      if (originController.text.isEmpty) {
                        error = "Please select pick-up location";
                      } else if (destinationController.text.isEmpty)
                        error = "Please select drop location";
                      else if (selectedPickupDateTime == null)
                        error = "Please select pickup date & time";
                      // ignore: curly_braces_in_flow_control_structures
                      else if (showReturnField &&
                          selectedReturnDateTime == null)
                        error = "Please select return date & time";
                    } else if (tripTypeIndex == 2) {
                      // Hourly
                      if (originController.text.isEmpty) {
                        error = "Please select pick-up location";
                        // ignore: curly_braces_in_flow_control_structures
                      } else if (selectedPickupDateTime == null)
                        error = "Please select pickup date & time";
                    }

                    if (error != null) {
                      Fluttertoast.showToast(
                        msg: error,
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        backgroundColor: Colors.black87,
                        textColor: Colors.white,
                      );
                      return;
                    }
                    // ✅ Proceed with valid form
                    debugPrint("Form valid for tab $tripTypeIndex");
                    final vm = Provider.of<CabSearchViewModel>(context, listen: false);

                    Map<String, dynamic> requestBody = {
                      "type": tripTypeIndex == 0
                          ? "Airport Transfer"
                          : tripTypeIndex == 1
                          ? (showReturnField ? "Round Trip" : "One Way Trip")
                          : "Hourly Rental", // Update accordingly if needed
                      "pickup": originController.text,
                      "plat": "28.6434", // ideally get live lat/lng from geolocation or API
                      "plng": "77.2220",
                      "drop": destinationController.text,
                      "dlat": "28.5562",
                      "dlng": "77.1000",
                      "start_date": DateFormat("yyyy-MM-dd").format(selectedPickupDateTime!),
                      "start_time": DateFormat("HH:mm").format(selectedPickupDateTime!),
                      "end_date": showReturnField && selectedReturnDateTime != null
                          ? DateFormat("yyyy-MM-dd").format(selectedReturnDateTime!)
                          : "",
                      "end_time": showReturnField && selectedReturnDateTime != null
                          ? DateFormat("HH:mm").format(selectedReturnDateTime!)
                          : "",
                    };

                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (context) => const LoadingScreen(),
                    );

                    await vm.fetchCabs(requestBody);

                    // Navigate only if cabs were fetched
                    if (vm.cabs.isNotEmpty) {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> CabResultScreen(
                        cabs: vm.cabs,
                        date: DateFormat("dd MMM yyyy, hh:mm a").format(selectedPickupDateTime!),
                        pickup: originController.text,
                        drop: destinationController.text,
                        pickupState: selectedPickupState ?? '',
                        dropState: selectedDropState ?? '',
                        pickupDate: selectedPickupDateTime,
                        dropDate: selectedReturnDateTime,
                      ),));

                    } else {
                      Fluttertoast.showToast(
                        msg: vm.message,
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                      );
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _showLuggageBottomSheet() async {
    await showModalBottomSheet(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(5)),
      ),
      context: context,
      builder:
          (context) => SizedBox(
            height: MediaQuery.of(context).size.height * 0.60,
            child: LuggageBottomSheet(
              initialCabinCount: cabinCount,
              initialCheckdInCount: checkedInCount,
              initialInfantsCount: infantsCount,
              onDone: (adults, children, infants) {
                setState(() {
                  adultsCount = adults;
                  childrenCount = children;
                  infantsCount = infants;
                  totalLuggageCount = adults + children;
                });
              },
            ),
          ),
    );
  }

  void _showTravellerBottomSheet() async {
    await showModalBottomSheet(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(5)),
      ),
      context: context,
      builder:
          (context) => SizedBox(
            height: MediaQuery.of(context).size.height * 0.60,
            child: TravellerBottomSheet(
              initialAdultsCount: adultsCount,
              initialChildrenCount: childrenCount,
              initialInfantsCount: infantsCount,
              onDone: (adults, children, infants) {
                setState(() {
                  adultsCount = adults;
                  childrenCount = children;
                  infantsCount = infants;
                  travellerCount = adults + children + infants;
                });
              },
            ),
          ),
    );
  }

  void showModernDateTimePicker({
    required BuildContext context,
    required DateTime? initialDate,
    required Function(DateTime) onDateSelected,
  }) {
    DateTime tempPicked = _roundToNearestInterval(
      initialDate ?? DateTime.now(),
      15,
    );

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
          ),
          child: SafeArea(
            top: false,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Small header
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 10,
                  ),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: const Text(
                          "Cancel",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      const Spacer(),
                      const Text(
                        "Select Date and Time",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                          onDateSelected(tempPicked);
                        },
                        child: Text(
                          "Done",
                          style: TextStyle(
                            fontSize: 14,
                            color: constants.themeColor1,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const Divider(height: 1, thickness: 0.8),

                // Date & time picker
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.3,
                  child: CupertinoDatePicker(
                    mode: CupertinoDatePickerMode.dateAndTime,
                    initialDateTime: tempPicked,
                    minuteInterval: 15,
                    use24hFormat: true,
                    minimumYear: 2000,
                    maximumYear: DateTime.now().year + 10,
                    onDateTimeChanged: (DateTime newDateTime) {
                      tempPicked = newDateTime;
                    },
                  ),
                ),

                SizedBox(height: MediaQuery.of(context).padding.bottom),
              ],
            ),
          ),
        );
      },
    );
  }

  /// Rounds time to nearest interval (default: 15 min)
  DateTime _roundToNearestInterval(DateTime dt, int interval) {
    int minute = dt.minute;
    int remainder = minute % interval;
    int adjustedMinutes = remainder == 0 ? minute : minute - remainder;
    return DateTime(dt.year, dt.month, dt.day, dt.hour, adjustedMinutes);
  }

  Widget _buildSubTab(String title, int index) {
    final isSelected = selectedAirportTab == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => selectedAirportTab = index),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(
              color: isSelected ? constants.themeColor1 : Colors.grey.shade200,
            ),
            color:
                isSelected
                    ? constants.themeColor1.withOpacity(0.3)
                    : Colors.white,
          ),
          alignment: Alignment.center,
          child: Text(
            title,
            style: GoogleFonts.poppins(
              color: Colors.black87,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLocationInput(
      String label,
      TextEditingController controller,
      IconData icon,
      ) {
    return GestureDetector(
      onTap: () async {
        final selectedCity = await Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const SearchCabCityView()),
        );

        if (selectedCity != null) {
          setState(() {
            controller.text = selectedCity['city'] ?? '';

            // 🔹 Assign state based on label
            if (label.toLowerCase().contains('pickup')) {
              selectedPickupState = selectedCity['state'];
            } else if (label.toLowerCase().contains('drop')) {
              selectedDropState = selectedCity['state'];
            }
          });

          print("Selected Pickup State: $selectedPickupState");
          print("Selected Drop State: $selectedDropState");
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Icon(icon, size: 20, color: Colors.grey.shade600),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  Text(
                    controller.text.isEmpty
                        ? "Enter Location"
                        : controller.text,
                    style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }


  Widget _buildInfoField(
    String label,
    String value,
    IconData icon, {
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: Colors.grey.shade300),
          color: Colors.white,
        ),
        child: Row(
          children: [
            Icon(icon, size: 20, color: Colors.grey.shade600),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: GoogleFonts.poppins(
                      fontSize: 11,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  SizedBox(height: 5,),
                  Text(
                    value,
                    style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDropdownField(
    String label,
    int selectedValue,
    Function(int?) onChanged, {
    IconData icon = Icons.access_time, // Default icon, customizable
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        children: [
          Icon(icon, size: 20, color: Colors.grey.shade600),
          const SizedBox(width: 12),
          Expanded(
            child: DropdownButtonFormField<int>(
              decoration: InputDecoration(
                labelText: label,
                labelStyle: GoogleFonts.poppins(
                  fontSize: 12,
                  color: Colors.grey.shade600,
                ),
                border: InputBorder.none,
                isDense: true,
                contentPadding: EdgeInsets.zero,
              ),
              style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
              icon: const Icon(Icons.keyboard_arrow_down_rounded),
              value: selectedValue,
              dropdownColor: Colors.white,
              borderRadius: BorderRadius.circular(10),
              items: List.generate(
                12,
                (index) => DropdownMenuItem(
                  value: index + 1,
                  child: Text("${index + 1} Hour"),
                ),
              ),
              onChanged: onChanged,
            ),
          ),
        ],
      ),
    );
  }
}
