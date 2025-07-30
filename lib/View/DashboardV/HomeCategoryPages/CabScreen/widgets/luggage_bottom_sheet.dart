import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LuggageBottomSheet extends StatefulWidget {
  final int initialCabinCount;
  final int initialCheckdInCount;
  final int initialInfantsCount;
  final Function(int, int, int) onDone;

  const LuggageBottomSheet({super.key, 
    required this.initialCabinCount,
    required this.initialCheckdInCount,
    required this.initialInfantsCount,
    required this.onDone,
  });

  @override
   LuggageBottomSheetState createState() =>  LuggageBottomSheetState();
}

class  LuggageBottomSheetState extends State <LuggageBottomSheet> {
  int cabinCount = 0;
  int checkedInCount = 0;
  int infantsCount = 0;

  @override
  void initState() {
    super.initState();
    cabinCount = widget.initialCabinCount;
    checkedInCount = widget.initialCheckdInCount;
    infantsCount = widget.initialInfantsCount;
  }

  Widget buildCountSelector({
    required int min,
    required int max,
    required int selectedCount,
    required Function(int) onSelect,
  }) {
    return Wrap(
      spacing: 5,
      runSpacing: 8,
      children: List.generate(max - min + 1, (index) {
        int number = min + index;
        return GestureDetector(
          onTap: () => onSelect(number),
          child: Container(
            width: 36,
            height: 36,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: selectedCount == number ? Color(0xFF341f97) : Colors.white,
              borderRadius: BorderRadius.circular(5),
              border: Border.all(color: Colors.grey, width: 1),
            ),
            child: Text(
              '$number',
              style: TextStyle(
                color: selectedCount == number ? Colors.white : Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Heading Row with "No. of Travellers" and "Done"
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Luggage Type',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    int totalTravellers = cabinCount + checkedInCount + infantsCount;
                    if (totalTravellers > 6) {
                      Fluttertoast.showToast(
                        msg: "total number of luggage don't exceed 6.",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        backgroundColor: Colors.black,
                        textColor: Colors.white,
                        fontSize: 16.0,
                      );
                    } else {
                      widget.onDone(cabinCount, checkedInCount, infantsCount);
                      Navigator.pop(context);
                    }
                  },
                  child: Text(
                    'Done',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF341f97),
                    ),
                  ),
                ),

              ],
            ),
            Divider(),
            SizedBox(height: 16),

            // Adults
            Row(
              children: [
                Text(
                  'Cabin ',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '(In Kg)',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            SizedBox(height: 15),
            buildCountSelector(
              min: 1,
              max: 6,
              selectedCount: cabinCount,
              onSelect: (count) {
                setState(() => cabinCount = count);
              },
            ),
            SizedBox(height: 20),

            // Children
            Row(
              children: [
                Text(
                  'Checked In ',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                // Text(
                //   '(2-12 yrs)',
                //   style: TextStyle(
                //     fontFamily: 'Poppins',
                //     fontSize: 16,
                //     fontWeight: FontWeight.w500,
                //   ),
                // ),
              ],
            ),
            SizedBox(height: 15),
            buildCountSelector(
              min: 1,
              max: 6,
              selectedCount: checkedInCount,
              onSelect: (count) {
                setState(() => checkedInCount = count);
              },
            ),
            SizedBox(height: 20),

            // // Infants
            // Row(
            //   children: [
            //     Text(
            //       'Infants ',
            //       style: TextStyle(
            //         fontFamily: 'Poppins',
            //         fontSize: 16,
            //         fontWeight: FontWeight.bold,
            //       ),
            //     ),
            //     Text(
            //       '(0-2 yrs)',
            //       style: TextStyle(
            //         fontFamily: 'Poppins',
            //         fontSize: 16,
            //         fontWeight: FontWeight.w500,
            //       ),
            //     ),
            //   ],
            // ),
            // SizedBox(height: 15),
            // buildCountSelector(
            //   min: 0,
            //   max: 4,
            //   selectedCount: infantsCount,
            //   onSelect: (count) {
            //     setState(() => infantsCount = count);
            //   },
            // ),
          ],
        ),
      ),
    );
  }
}
