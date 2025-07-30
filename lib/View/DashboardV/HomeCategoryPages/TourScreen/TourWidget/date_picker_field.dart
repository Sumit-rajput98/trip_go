import 'package:flutter/material.dart';
import 'custom_calender_dialog.dart';

class DatePickerField extends StatefulWidget {
  final TextEditingController controller;
  final Function(DateTime) onDateSelected;

  const DatePickerField({
    super.key,
    required this.controller,
    required this.onDateSelected,
  });

  @override
  State<DatePickerField> createState() => _DatePickerFieldState();
}

class _DatePickerFieldState extends State<DatePickerField> {
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
        hintText: "Travel Date",
        border: OutlineInputBorder(),
        isDense: true,
        contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      ),
      style: const TextStyle(fontFamily: 'Poppins', fontSize: 14),
    );
  }
}
