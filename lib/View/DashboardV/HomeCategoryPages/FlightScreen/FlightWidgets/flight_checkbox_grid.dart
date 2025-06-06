// flight_checkbox_grid.dart

import 'package:flutter/material.dart';

class FlightCheckboxGrid extends StatelessWidget {
  final bool nonStop;
  final bool studentFare;
  final bool armedForces;
  final bool seniorCitizen;
  final Function(bool?) onNonStopChanged;
  final Function(bool?) onStudentFareChanged;
  final Function(bool?) onArmedForcesChanged;
  final Function(bool?) onSeniorCitizenChanged;

  const FlightCheckboxGrid({
    super.key,
    required this.nonStop,
    required this.studentFare,
    required this.armedForces,
    required this.seniorCitizen,
    required this.onNonStopChanged,
    required this.onStudentFareChanged,
    required this.onArmedForcesChanged,
    required this.onSeniorCitizenChanged,
  });

  @override
  Widget build(BuildContext context) {
    return GridView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 5,
        crossAxisSpacing: 6,
        mainAxisSpacing: 4,
      ),
      children: [
        CheckboxListTile(
          value: nonStop,
          onChanged: onNonStopChanged,
          title: const Text('Non Stop Flights', style: TextStyle(fontSize: 13, fontFamily: 'poppins')),
          controlAffinity: ListTileControlAffinity.leading,
          contentPadding: EdgeInsets.zero,
          dense: true,
          visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
        ),
        CheckboxListTile(
          value: studentFare,
          onChanged: onStudentFareChanged,
          title: const Text('Student Fare', style: TextStyle(fontSize: 13, fontFamily: 'poppins')),
          controlAffinity: ListTileControlAffinity.leading,
          contentPadding: EdgeInsets.zero,
          dense: true,
          visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
        ),
        CheckboxListTile(
          value: armedForces,
          onChanged: onArmedForcesChanged,
          title: const Text('Armed Forces', style: TextStyle(fontSize: 13, fontFamily: 'poppins')),
          controlAffinity: ListTileControlAffinity.leading,
          contentPadding: EdgeInsets.zero,
          dense: true,
          visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
        ),
        CheckboxListTile(
          value: seniorCitizen,
          onChanged: onSeniorCitizenChanged,
          title: const Text('Senior Citizen', style: TextStyle(fontSize: 13, fontFamily: 'poppins')),
          controlAffinity: ListTileControlAffinity.leading,
          contentPadding: EdgeInsets.zero,
          dense: true,
          visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
        ),
      ],
    );
  }
}
