import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class TravellerBottomSheet extends StatefulWidget {
  final int initialAdultsCount;
  final int initialChildrenCount;
  final int initialInfantsCount;
  final Function(int, int, int) onDone;

  const TravellerBottomSheet({
    required this.initialAdultsCount,
    required this.initialChildrenCount,
    required this.initialInfantsCount,
    required this.onDone,
  });

  @override
  _TravellerBottomSheetState createState() => _TravellerBottomSheetState();
}

class _TravellerBottomSheetState extends State<TravellerBottomSheet> {
  int adultsCount = 0;
  int childrenCount = 0;
  int infantsCount = 0;

  @override
  void initState() {
    super.initState();
    adultsCount = widget.initialAdultsCount;
    childrenCount = widget.initialChildrenCount;
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
                  'No. of Travellers',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    int totalTravellers = adultsCount + childrenCount + infantsCount;
                    if (totalTravellers > 9) {
                      Fluttertoast.showToast(
                        msg: "Maximum 9 passengers allowed",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        backgroundColor: Colors.black,
                        textColor: Colors.white,
                        fontSize: 16.0,
                      );
                    } else {
                      widget.onDone(adultsCount, childrenCount, infantsCount);
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
                  'Adults ',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '(12+ yrs)',
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
              max: 9,
              selectedCount: adultsCount,
              onSelect: (count) {
                setState(() => adultsCount = count);
              },
            ),
            SizedBox(height: 20),

            // Children
            Row(
              children: [
                Text(
                  'Children ',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '(2-12 yrs)',
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
              min: 0,
              max: 8,
              selectedCount: childrenCount,
              onSelect: (count) {
                setState(() => childrenCount = count);
              },
            ),
            SizedBox(height: 20),

            // Infants
            Row(
              children: [
                Text(
                  'Infants ',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '(0-2 yrs)',
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
              min: 0,
              max: 4,
              selectedCount: infantsCount,
              onSelect: (count) {
                setState(() => infantsCount = count);
              },
            ),
          ],
        ),
      ),
    );
  }
}
