import 'package:flutter/material.dart';
import 'package:trip_go/constants.dart';

import 'filter_bootom_sheet/airline_bottom_sheet.dart';
import 'filter_bootom_sheet/sort_by_bottom_sheet.dart';
import 'filter_bootom_sheet/time_bootom_sheet.dart';
class AppColors {
  static const Color themeColor1 = Color(0xff1B499F);
  static const Color themeColor2 = Color(0xffF73130);

  static const Gradient gradient = LinearGradient(
    colors: [themeColor1, themeColor2],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );
}


class GradientButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const GradientButton({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 48,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: BoxDecoration(
        gradient: AppColors.gradient,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: onPressed,
          child: Center(
            child: Text(
              text,
              style: const TextStyle(
                fontFamily: 'Poppins',
                fontSize: 16,
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Future<void> showTimeFilterSheet(BuildContext context, bool isRoundTrip) {
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) => TimeBottomSheet(isOneWay: !isRoundTrip),
  );
}

// // Airline Filter Sheet
// Future<void> showAirlineFilterSheet(BuildContext context) {
//   return showModalBottomSheet(
//     context: context,
//     isScrollControlled: true,
//     shape: const RoundedRectangleBorder(
//       borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
//     ),
//     builder: (context) => AirlineBottomSheet(),
//   );
// }

Future<Map<String, dynamic>?> showFilterSheet(BuildContext context, bool isRoundTrip) {
  return showModalBottomSheet<Map<String, dynamic>>(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) => FilterBottomSheet(isOneWay: !isRoundTrip),
  );
}

// // Sort By Bottom Sheet
// Future<void> showSortBySheet(BuildContext context, bool isRoundTrip) {
//   return showModalBottomSheet(
//     context: context,
//     isScrollControlled: true,
//     shape: const RoundedRectangleBorder(
//       borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
//     ),
//     builder: (context) =>SortBottomSheet(isOneWay: !isRoundTrip),
//   );
// }


class FilterBottomSheet extends StatefulWidget {
  final bool isOneWay;
  const FilterBottomSheet({super.key, required this.isOneWay});

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  final List<String> timeSlots = ["Early Morning", "Morning", "Mid Day", "Night"];
  final List<String> slotTimes = ["Before 6AM", "6AM - 12PM", "12PM - 6PM", "After 6PM"];
  Set<String> selectedFrom = {};
  Set<String> selectedTo = {};

  final Color themeColor1 = const Color(0xff1B499F);
  final Color themeColor2 = const Color(0xffF73130);

  bool nonStop = false;
  bool oneStop = false;

  RangeValues delPrice = const RangeValues(5552, 31761);
  RangeValues bomPrice = const RangeValues(5215, 23619);

  List<String> selectedDelTimes = [];
  List<String> selectedAirlines = [];

  List<Map<String, dynamic>> airlineList = [
    {"name": "Air India", "price": "₹12,710","logo":"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS-QO8gVe353NPaAV3wid57LAtWqIdet-EVMA&s"},
    {"name": "Air India Express", "price": "₹16,590","logo":"https://flight.easemytrip.com/Content/AirlineLogon/IX.png"},
    {"name": "Vistara", "price": "₹14,968","logo":"https://flight.easemytrip.com/Content/AirlineLogon/UK.png"},
    {"name": "Indigo", "price": "₹11,401","logo":"https://flight.easemytrip.com/Content/AirlineLogon/6E.png"},
    {"name": "SpiceJet", "price": "₹12,043","logo":"https://flight.easemytrip.com/Content/AirlineLogon/SG.png"},
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.85,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 12.0),
            child: Text("Filters",
                style: TextStyle(
                    fontFamily: "Poppins",
                    fontSize: 18,
                    fontWeight: FontWeight.w600)),
          ),
          const Divider(height: 1),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Stops
                  const Text("Stops",
                      style: TextStyle(fontFamily: "Poppins", fontSize: 15, fontWeight: FontWeight.w500)),
                  CheckboxListTile(
                    contentPadding: EdgeInsets.zero,
                    title: const Text("Non-Stop", style: TextStyle(fontFamily: "Poppins")),
                    value: nonStop,
                    onChanged: (val) => setState(() => nonStop = val!),
                  ),
                  CheckboxListTile(
                    contentPadding: EdgeInsets.zero,
                    title: const Text("1 Stop", style: TextStyle(fontFamily: "Poppins")),
                    value: oneStop,
                    onChanged: (val) => setState(() => oneStop = val!),
                  ),

                  const SizedBox(height: 10),
                  const Divider(),

                  Text("Flight Price from New Delhi",
                      style: const TextStyle(fontFamily: "Poppins", fontWeight: FontWeight.w500, fontSize: 15)),
                  RangeSlider(
                    values: delPrice,
                    min: 5000,
                    max: 35000,
                    divisions: 10,
                    labels: RangeLabels("${delPrice.start.round()}", "${delPrice.end.round()}"),
                    onChanged: (values) => setState(() => delPrice = values),
                  ),

                  if (!widget.isOneWay) ...[
                    Text("Flight Price from Mumbai",
                        style: const TextStyle(fontFamily: "Poppins", fontWeight: FontWeight.w500, fontSize: 15)),
                    RangeSlider(
                      values: bomPrice,
                      min: 5000,
                      max: 30000,
                      divisions: 10,
                      labels: RangeLabels("${bomPrice.start.round()}", "${bomPrice.end.round()}"),
                      onChanged: (values) => setState(() => bomPrice = values),
                    ),
                  ],

                  const Divider(),

                  const Text("Departure from New Delhi",
                      style: TextStyle(fontFamily: "Poppins", fontWeight: FontWeight.w500, fontSize: 15)),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: timeSlots.map((slot) {
                      bool isSelected = selectedDelTimes.contains(slot);
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            isSelected
                                ? selectedDelTimes.remove(slot)
                                : selectedDelTimes.add(slot);
                          });
                        },
                        child: Container(
                          width: (MediaQuery.of(context).size.width - 60) / 2,
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            border: Border.all(color: isSelected ? themeColor1 : Colors.grey.shade300),
                            borderRadius: BorderRadius.circular(10),
                            color: isSelected ? themeColor1.withOpacity(0.1) : Colors.white,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(slot,
                                  style: TextStyle(
                                      fontFamily: "Poppins",
                                      fontSize: 13,
                                      fontWeight: FontWeight.w500,
                                      color: isSelected ? themeColor1 : Colors.black)),
                              Text(
                                slot == "Early Morning"
                                    ? "Before 6AM"
                                    : slot == "Morning"
                                    ? "6AM - 12PM"
                                    : slot == "Mid Day"
                                    ? "12PM - 6PM"
                                    : "After 6PM",
                                style: const TextStyle(fontSize: 11, fontFamily: "Poppins"),
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),

                  const SizedBox(height: 15),

                  // Airlines
                  const Text("Airlines",
                      style: TextStyle(fontFamily: "Poppins", fontWeight: FontWeight.w500, fontSize: 15)),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: airlineList.map((airline) {
                      bool isSelected = selectedAirlines.contains(airline['name']);
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            isSelected
                                ? selectedAirlines.remove(airline['name'])
                                : selectedAirlines.add(airline['name']);
                          });
                        },
                        child: Container(
                          width: (MediaQuery.of(context).size.width - 60) / 2,
                          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
                          decoration: BoxDecoration(
                            border: Border.all(color: isSelected ? themeColor2 : Colors.grey.shade300),
                            borderRadius: BorderRadius.circular(10),
                            color: isSelected ? themeColor2.withOpacity(0.1) : Colors.white,
                          ),
                          child: Row(
                            children: [
                              CircleAvatar(radius: 12, backgroundColor: Colors.grey.shade300,backgroundImage: NetworkImage(airline['logo']),),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(airline['name'],
                                        style: TextStyle(
                                            fontFamily: "Poppins",
                                            fontSize: 13,
                                            color: isSelected ? themeColor2 : Colors.black)),
                                    Text(airline['price'],
                                        style: const TextStyle(
                                            fontFamily: "Poppins",
                                            fontSize: 11,
                                            color: Colors.grey)),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  )
                ],
              ),
            ),
          ),

          // Bottom Buttons
          Container(
            height: 60,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
              boxShadow: [
                BoxShadow(color: Colors.black12, blurRadius: 5, offset: Offset(0, -2))
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {},
                  child:  Text("Clear",
                      style: TextStyle(
                          color: constants.themeColor2,
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.w500,
                          fontSize: 14)),
                ),
                SizedBox(
                  height: 42,
                  width: 160,
                  child: ElevatedButton(
                    onPressed: () {
                      final filterData = {
                        'nonStop': nonStop,
                        'oneStop': oneStop,
                        'delPrice': delPrice,
                        'selectedDelTimes': selectedDelTimes,
                        'selectedAirlines': selectedAirlines,
                      };
                      Navigator.pop(context, filterData);
                      // Navigator.pop(context, {
                      //   "nonStop": nonStop,
                      //   "oneStop": oneStop,
                      //   "delPrice": delPrice,
                      //   "bomPrice": bomPrice,
                      //   "selectedDelTimes": selectedDelTimes,
                      //   "selectedAirlines": selectedAirlines,
                      // }
                      // );
                    },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.zero,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25)),
                      backgroundColor: Colors.transparent,
                      elevation: 2,
                    ),
                    child: Ink(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [themeColor1, themeColor2],
                        ),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Container(
                        alignment: Alignment.center,
                        child: const Text("Apply Filter",
                            style: TextStyle(
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                                color: Colors.white)),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}