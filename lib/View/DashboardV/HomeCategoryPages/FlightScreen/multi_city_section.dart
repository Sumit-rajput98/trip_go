import 'package:flutter/material.dart';
import 'package:trip_go/View/DashboardV/HomeCategoryPages/FlightScreen/select_origin_city_screen.dart';

import 'FlightWidgets/calender_screen.dart';
import 'FlightWidgets/class_selection_bottom_sheet.dart';
import 'FlightWidgets/flight_widgets.dart';
import 'FlightWidgets/traveller_selection_bottom_sheet.dart';

class MultiCitySection extends StatefulWidget {
  const MultiCitySection({super.key});

  @override
  _MultiCitySectionState createState() => _MultiCitySectionState();
}

class _MultiCitySectionState extends State<MultiCitySection> {
  List<Map<String, dynamic>> flights = [];

  int adultsCount = 1;
  int childrenCount = 0;
  int infantsCount = 0;
  int travellerCount = 1;
  String selectedClass = 'Economy';

  @override
  void initState() {
    super.initState();
    flights = [
      {
        'from': {'city': 'DELHI', 'code': 'DEL'},
        'to': {'city': 'MUMBAI', 'code': 'BOM'},
        'date': null,
      },
      {
        'from': {'city': 'MUMBAI', 'code': 'BOM'},
        'to': null,
        'date': null,
      },
    ];
  }

  void _addFlight() {
    final lastFlight = flights.last;
    if (lastFlight['from'] == null ||
        lastFlight['to'] == null ||
        lastFlight['date'] == null ||
        lastFlight['from']['code'] == '' ||
        lastFlight['to']['code'] == '') {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Please fill in all flight details before adding a new flight.',
          ),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }

    setState(() {
      flights.add({'from': lastFlight['to'], 'to': null, 'date': null});
    });
  }

  void _removeFlight(int index) {
    if (flights.length > 2) {
      setState(() {
        flights.removeAt(index);
      });
    }
  }

  Future<void> _selectCity(int index, bool isFrom) async {
    final selectedCity = await Navigator.push<Map<String, String>>(
      context,
      MaterialPageRoute(builder: (context) => SelectOriginCityScreen()),
    );
    if (selectedCity != null) {
      setState(() {
        if (isFrom) {
          flights[index]['from'] = selectedCity;
        } else {
          flights[index]['to'] = selectedCity;
        }
      });
    }
  }

  Future<void> _selectDate(int index) async {
    final picked = await Navigator.push<DateTime>(
      context,
      MaterialPageRoute(
        builder: (context) => FullScreenCalendar(isDeparture: true),
      ),
    );
    if (picked != null) {
      setState(() {
        flights[index]['date'] = picked;
      });
    }
  }

  void _showTravellerBottomSheet() async {
    await showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
      ),
      builder:
          (context) => TravellerBottomSheet(
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
    );
  }

  void _showClassSelectionBottomSheet() async {
    await showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
      ),
      builder:
          (context) => ClassSelectionBottomSheet(
        initialClass: selectedClass,
        onClassSelected: (classSelected) {
          setState(() {
            selectedClass = classSelected;
          });
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ...flights.asMap().entries.map((entry) {
          final i = entry.key;
          final flight = entry.value;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Flight ${i + 1}',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () => _selectCity(i, true),
                      child: LocationBox(
                        label: 'FROM',
                        code: flight['from']?['code'] ?? '',
                        city: flight['from']?['city'] ?? '',
                      ),
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => _selectCity(i, false),
                      child: LocationBox(
                        label: 'TO',
                        code: flight['to']?['code'] ?? '___',
                        city: flight['to']?['city'] ?? '',
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              DateBox(
                label: 'DEPARTURE DATE',
                date: flight['date'],
                isDeparture: true,
                enabled: true,
                onTap: () => _selectDate(i),
              ),
              if (flights.length > 2)
                Align(
                  alignment: Alignment.centerRight,
                  child:
                  i > 1
                      ? IconButton(
                    icon: Icon(Icons.remove_circle, color: Colors.red),
                    onPressed: () => _removeFlight(i),
                  )
                      : SizedBox.shrink(), // Hide for Flight 1 & 2
                ),

              const SizedBox(height: 10),
            ],
          );
        }),
        Align(
          alignment: Alignment.centerLeft,
          child: OutlinedButton.icon(
            onPressed: _addFlight,
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: Colors.deepPurple),
              foregroundColor: Colors.deepPurple,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6),
              ),
            ),
            icon: Icon(Icons.add_circle_outline),
            label: Text('Add Flight'),
          ),
        ),

        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: _showTravellerBottomSheet,
                child: TravellerBox(travellerCount: travellerCount),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: GestureDetector(
                onTap: _showClassSelectionBottomSheet,
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 14),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Color(0xFFF6F6FA),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'CLASS',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            selectedClass,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Icon(Icons.keyboard_arrow_down_outlined),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}