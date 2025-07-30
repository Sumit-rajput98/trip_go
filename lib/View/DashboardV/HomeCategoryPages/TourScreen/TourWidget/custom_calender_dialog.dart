import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:trip_go/constants.dart';

class CustomCalendarDialog extends StatefulWidget {
  const CustomCalendarDialog({super.key});

  @override
  State<CustomCalendarDialog> createState() => _CustomCalendarDialogState();
}

class _CustomCalendarDialogState extends State<CustomCalendarDialog> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      insetPadding: const EdgeInsets.all(16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      content: SizedBox(
        width: double.maxFinite,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                color: constants.themeColor1, // ✅ Blue header
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
              ),
              child: const Center(
                child: Text(
                  'Select Date',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            TableCalendar(
              firstDay: DateTime.now(),
              lastDay: DateTime(2100),
              focusedDay: _focusedDay,
              selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
              onDaySelected: (selectedDay, focusedDay) {
                Navigator.of(context).pop(selectedDay); // ✅ Return date immediately
              },
              calendarStyle: CalendarStyle(
                selectedDecoration: BoxDecoration(
                  color: constants.themeColor1,
                  shape: BoxShape.circle,
                ),
                todayDecoration: BoxDecoration(
                  color: constants.themeColor1,
                  shape: BoxShape.circle,
                ),
              ),
              headerStyle: HeaderStyle(
                formatButtonVisible: false,
                titleCentered: true,
                titleTextStyle: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                leftChevronIcon: Icon(Icons.chevron_left, color: constants.themeColor1),
                rightChevronIcon: Icon(Icons.chevron_right, color:constants.themeColor1, ),
              ),
              daysOfWeekStyle: const DaysOfWeekStyle(
                weekdayStyle: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w600),
                weekendStyle: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w600),
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
