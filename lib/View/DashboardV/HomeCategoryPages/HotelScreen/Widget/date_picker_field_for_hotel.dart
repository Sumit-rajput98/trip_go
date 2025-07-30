import 'package:flutter/material.dart';

import '../../TourScreen/TourWidget/custom_calender_dialog.dart';

class DatePickerFieldForHotel extends StatefulWidget {
  final TextEditingController controller;
  final Function(DateTime) onDateSelected;

  const DatePickerFieldForHotel({
    super.key,
    required this.controller,
    required this.onDateSelected,
  });

  @override
  State<DatePickerFieldForHotel> createState() => _DatePickerFieldForHotelState();
}

class _DatePickerFieldForHotelState extends State<DatePickerFieldForHotel> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      readOnly: true,
      onTap: () async {
        FocusScope.of(context).unfocus();

        final selectedDate = await showDialog<DateTime>(
          context: context,
          builder: (context) => const CustomCalendarDialog(),
        );

        if (selectedDate != null) {
          widget.controller.text =
          "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}";
          widget.onDateSelected(selectedDate);
        }
      },
      decoration: const InputDecoration(
        border: InputBorder.none, // ✅ No border
        isDense: true,
        contentPadding: EdgeInsets.zero, // ✅ Tight layout
      ),
      style: const TextStyle(
        fontFamily: 'Poppins',
        fontSize: 16,
        fontWeight: FontWeight.bold, // ✅ Bold text
      ),
    );
  }
}
