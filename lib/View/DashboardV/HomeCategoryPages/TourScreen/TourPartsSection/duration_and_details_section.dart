import 'package:flutter/material.dart';
import '../../../../../constants.dart';

class DurationAndDetailSection extends StatefulWidget {
  final int night;
  final int day;
  final String details_day_night;
  const DurationAndDetailSection({super.key, required this.day,required this.night, required this.details_day_night});

  @override
  State<DurationAndDetailSection> createState() => _DurationAndDetailSectionState();
}

class _DurationAndDetailSectionState extends State<DurationAndDetailSection> {
  final iconSize = 35.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 15,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              buildIconWithLabel(
                "https://tripoholidays.in/public/images/hotel-icon.png",
                "Hotel",
              ),
              buildIconWithLabel(
                "https://tripoholidays.in/public/images/binoculars-icon.png",
                "Sightseeing",
              ),
              buildIconWithLabel(
                "https://tripoholidays.in/public/images/sedan-icon.png",
                "Transfers",
              ),
              buildIconWithLabel(
                "https://tripoholidays.in/public/images/dinner-icon.png",
                "Meals",
              ),
            ],
          ),
          const SizedBox(height: 15),
          Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: <Widget>[
                    const Expanded(
                      child: Divider(
                        color: Colors.grey,
                        thickness: 1,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Text(
                        "Duration & Details",
                        style: TextStyle(
                          fontSize: 12,
                          fontFamily: 'Poppins',
                          color: Colors.black
                        ),
                      ),
                    ),
                    const Expanded(
                      child: Divider(
                        color: Colors.grey,
                        thickness: 1,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Duration: ${widget.night} Night${widget.night > 1 ? 's' : ''} & ${widget.day} Day${widget.day > 1 ? 's' : ''}",
                        style: const TextStyle(
                          fontSize: 14,
                          fontFamily: 'Poppins',
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "Places to Visit: ${widget.details_day_night}",
                        style: TextStyle(
                          fontSize: 14,
                          fontFamily: 'Poppins',
                        ),
                      ),
                      SizedBox(height: 10,)
                    ],
                  ),
                )
              ],
            ),
        ],
      ),
    );
  }

  Widget buildIconWithLabel(String imageUrl, String label) {
    return Column(
      children: [
        Image.network(
          imageUrl,
          width: 35,
          height: 35,
          fit: BoxFit.contain,
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            fontFamily: 'Poppins',
          ),
        ),
      ],
    );
  }
}
