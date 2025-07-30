import 'package:flutter/material.dart';

class SortByBottomSheet extends StatefulWidget {
  const SortByBottomSheet({super.key});

  @override
  State<SortByBottomSheet> createState() => _SortByBottomSheetState();
}

class _SortByBottomSheetState extends State<SortByBottomSheet> {
  static const Color themeColor1 = Color(0xff1B499F);
  static const Color themeColor2 = Color(0xffF73130);

  final List<String> sortOptions = [
    "Popular First",
    "Price - Low To High",
    "Price - High To Low",
  ];

  String selectedOption = "Popular First";

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 15, 20, 25),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      height: 300,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Indicator bar
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

          /// Title
          const Center(
            child: Text(
              "Sort By",
              style: TextStyle(
                fontFamily: "Poppins",
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),

          const SizedBox(height: 30),

          /// Sort Options
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: sortOptions.map((option) {
              final isSelected = selectedOption == option;
              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedOption = option;
                  });
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
                  decoration: BoxDecoration(
                    color: isSelected ? themeColor1.withOpacity(0.1) : Colors.white,
                    border: Border.all(
                      color: isSelected ? themeColor1: Colors.grey.shade300,
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    option,
                    style: TextStyle(
                      fontFamily: "Poppins",
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: isSelected ? themeColor1 : Colors.black,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),

          const Spacer(),

          /// Apply Button
          Center(
            child: SizedBox(
              height: 42,
              width: 160,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context, selectedOption);
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.zero,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
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
                    child: const Text(
                      "Apply",
                      style: TextStyle(
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        color: Colors.white,
                      ),
                    ),
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
