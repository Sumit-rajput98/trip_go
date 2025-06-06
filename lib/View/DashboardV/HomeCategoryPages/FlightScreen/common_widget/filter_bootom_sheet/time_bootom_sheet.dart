import 'package:flutter/material.dart';
import 'package:trip_go/constants.dart';
class TimeBottomSheet extends StatefulWidget {
  final bool isOneWay;

  const TimeBottomSheet({super.key, required this.isOneWay});

  @override
  State<TimeBottomSheet> createState() => _TimeBottomSheetState();
}

class _TimeBottomSheetState extends State<TimeBottomSheet> {
  final List<String> timeSlots = ["Early Morning", "Morning", "Mid Day", "Night"];
  final List<String> slotTimes = ["Before 6AM", "6AM - 12PM", "12PM - 6PM", "After 6PM"];
  Set<String> selectedFrom = {};
  Set<String> selectedTo = {};

  static const Color themeColor1 = Color(0xff1B499F);
  static const Color themeColor2 = Color(0xffF73130);

  Widget buildTimeGrid(String title, Set<String> selectedSet) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
            style: const TextStyle(
                fontFamily: "Poppins", fontSize: 16, fontWeight: FontWeight.w500)),
        const SizedBox(height: 20),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: List.generate(timeSlots.length, (index) {
            final isSelected = selectedSet.contains(timeSlots[index]);
            return GestureDetector(
              onTap: () {
                setState(() {
                  isSelected
                      ? selectedSet.remove(timeSlots[index])
                      : selectedSet.add(timeSlots[index]);
                });
              },
              child: Container(
                width: (MediaQuery.of(context).size.width / 2) - 30,
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                decoration: BoxDecoration(
                  color: isSelected ? themeColor1.withOpacity(0.1) : Colors.white,
                  border: Border.all(
                      color: isSelected ? themeColor1 : Colors.grey.shade400),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    Text(timeSlots[index],
                        style: TextStyle(
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.w600,
                            color: isSelected ? themeColor1 : Colors.black)),
                    const SizedBox(height: 4),
                    Text(slotTimes[index],
                        style: const TextStyle(
                            fontSize: 11,
                            fontFamily: "Poppins",
                            color: Colors.grey)),
                  ],
                ),
              ),
            );
          }),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 15, 20, 25),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      height: widget.isOneWay ? 400 : 550,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              height: 5,
              width: 50,
              margin: const EdgeInsets.only(bottom: 10),
              decoration: BoxDecoration(
                color: Colors.deepPurple.shade400,
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
          const Center(
            child: Text("Time",
                style: TextStyle(
                    fontFamily: "Poppins",
                    fontSize: 18,
                    fontWeight: FontWeight.w600)),
          ),
          const SizedBox(height: 20),
          buildTimeGrid("Departure from New Delhi", selectedFrom),
          if (!widget.isOneWay) ...[
            const SizedBox(height: 20),
            buildTimeGrid("Departure from Mumbai", selectedTo),
          ],
          const Spacer(),
          Center(
            child: SizedBox(
              height: 42,
              width: 160,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context, {
                    'fromTimes': selectedFrom,
                    'toTimes': selectedTo,
                  });
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
                    gradient: const LinearGradient(
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
          )
        ],
      ),
    );
  }
}
