import 'package:flutter/material.dart';
class SortBottomSheet extends StatefulWidget {
  const SortBottomSheet({super.key});

  @override
  State<SortBottomSheet> createState() => _SortBottomSheetState();
}

class _SortBottomSheetState extends State<SortBottomSheet> {
  String selectedOption = "Smart";

  static const Color themeColor1 = Color(0xff1B499F);
  static const Color themeColor2 = Color(0xffF73130);

  final List<String> options = ["Price", "Departure", "Fastest", "Smart"];

  Widget buildSortGrid() {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: options.map((option) {
        final isSelected = selectedOption == option;
        final description = option == "Price"
            ? "Low to High"
            : option == "Departure"
            ? "Earliest First"
            : option == "Fastest"
            ? "Shortest First"
            : "Recommended";

        return GestureDetector(
          onTap: () => setState(() => selectedOption = option),
          child: Container(
            width: (MediaQuery.of(context).size.width - 60) / 2,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              border: Border.all(
                color: isSelected ? themeColor1 : Colors.grey.shade300,
              ),
              color: isSelected ? themeColor1.withOpacity(0.1) : Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(option,
                    style: TextStyle(
                      fontFamily: "Poppins",
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: isSelected ? themeColor1 : Colors.black,
                    )),
                const SizedBox(height: 4),
                Text(description,
                    style: const TextStyle(
                      fontFamily: "Poppins",
                      fontSize: 11,
                      color: Colors.grey,
                    )),
              ],
            ),
          ),
        );
      }).toList(),
    );
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
              child: Text("Sort By",
                  style: TextStyle(
                      fontFamily: "Poppins",
                      fontSize: 18,
                      fontWeight: FontWeight.w600)),
            ),
            const SizedBox(height: 20),
            buildSortGrid(),
            const SizedBox(height: 20),
            const Text(
              "Smart Sort? Flights are sorted based on price, duration, stops & other factors to help you choose the best flight.",
              style: TextStyle(
                fontFamily: "Poppins",
                fontSize: 11,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                Navigator.pop(context, {
                  'delBom': selectedOption,
                });
              },
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
                  child: Text(
                    "Apply",
                    style: TextStyle(
                      fontFamily: "Poppins",
                      fontSize: 15,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}



class FlightFilter {
  List<String> selectedAirlines;
  int? maxStops;
  double? minPrice;
  double? maxPrice;
  TimeOfDay? departureStartTime;
  TimeOfDay? departureEndTime;
  TimeOfDay? arrivalStartTime;
  TimeOfDay? arrivalEndTime;

  FlightFilter({
    this.selectedAirlines = const [],
    this.maxStops,
    this.minPrice,
    this.maxPrice,
    this.departureStartTime,
    this.departureEndTime,
    this.arrivalStartTime,
    this.arrivalEndTime,
  });
}
