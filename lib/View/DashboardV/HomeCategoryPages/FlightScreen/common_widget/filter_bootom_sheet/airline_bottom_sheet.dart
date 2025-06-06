import 'package:flutter/material.dart';
import 'package:trip_go/constants.dart';
class AirlineBottomSheet extends StatefulWidget {
  final Set<String> initiallySelectedAirlines;
  const AirlineBottomSheet({super.key, required this.initiallySelectedAirlines});

  @override
  State<AirlineBottomSheet> createState() => _AirlineBottomSheetState();
}

class _AirlineBottomSheetState extends State<AirlineBottomSheet> {
  static const Color themeColor1 = Color(0xff1B499F);
  static const Color themeColor2 = Color(0xffF73130);

  final List<Map<String, dynamic>> airlines = [
    {"name": "Air India", "logo": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS-QO8gVe353NPaAV3wid57LAtWqIdet-EVMA&s"},
    {"name": "Indigo", "logo": "https://flight.easemytrip.com/Content/AirlineLogon/6E.png"},
    {"name": "Vistara", "logo": "https://flight.easemytrip.com/Content/AirlineLogon/AI.png"},
    {"name": "SpiceJet", "logo": "https://flight.easemytrip.com/Content/AirlineLogon/SG.png"},
    {"name": "GoAir", "logo": "https://flight.easemytrip.com/Content/AirlineLogon/6E.png"},
  ];

  final Set<String> selectedAirlines = {};

  void toggleSelection(String name) {
    setState(() {
      if (selectedAirlines.contains(name)) {
        selectedAirlines.remove(name);
      } else {
        selectedAirlines.add(name);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.fromLTRB(20, 15, 20, 25),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: Text("Select Airlines",
                  style: TextStyle(
                      fontFamily: "Poppins",
                      fontSize: 18,
                      fontWeight: FontWeight.w600)),
            ),
            const SizedBox(height: 20),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: airlines.map((airline) {
                final isSelected = selectedAirlines.contains(airline["name"]);
                return GestureDetector(
                  onTap: () => toggleSelection(airline["name"]),
                  child: Container(
                    width: (MediaQuery.of(context).size.width - 60) / 2,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: isSelected ? themeColor1 : Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(12),
                      color: isSelected ? themeColor1.withOpacity(0.1) : Colors.white,
                    ),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 18,
                          backgroundImage: NetworkImage(airline["logo"]),
                          backgroundColor: Colors.transparent,
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(airline["name"],
                              style: TextStyle(
                                  fontFamily: "Poppins",
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: isSelected ? themeColor1 : Colors.black)),
                        )
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () =>  Navigator.pop(context, selectedAirlines),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 14),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [themeColor1, themeColor2],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Center(
                  child: Text("Apply",
                      style: TextStyle(
                          fontFamily: "Poppins",
                          fontSize: 15,
                          color: Colors.white,
                          fontWeight: FontWeight.w600)),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

