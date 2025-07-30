import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:trip_go/constants.dart';

class FullScreenCalendar extends StatefulWidget {
  final bool isDeparture;

  const FullScreenCalendar({super.key, required this.isDeparture});

  @override
  State<FullScreenCalendar> createState() => _FullScreenCalendarState();
}

class _FullScreenCalendarState extends State<FullScreenCalendar> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isDeparture ? 'Select Departure Date' : 'Select Return Date', style: TextStyle(fontFamily: 'poppins', color: Colors.white, fontWeight: FontWeight.bold),),
        backgroundColor: constants.themeColor1,
        iconTheme: IconThemeData(
          color: Colors.white,
          weight: 800,
          size: 30,
        ),
      ),
      body: SafeArea(
        top: false,
        child: Column(
          children: [
            TableCalendar(
              firstDay: DateTime.now(),
              lastDay: DateTime(2030),
              focusedDay: _focusedDay,
              selectedDayPredicate: (day) {
                return isSameDay(_selectedDay, day);
              },
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay;
                });
              },
              calendarStyle: CalendarStyle(
                defaultTextStyle: TextStyle(
                  fontFamily: 'poppins',
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
                weekendTextStyle: TextStyle(
                  fontFamily: 'poppins',
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
                selectedDecoration: BoxDecoration(
                  color: constants.themeColor1,
                  shape: BoxShape.circle,
                ),
                todayDecoration: BoxDecoration(
                  color: constants.themeColor1,
                  shape: BoxShape.circle,
                ),
              ),
              daysOfWeekStyle: DaysOfWeekStyle(
                weekdayStyle: TextStyle(
                  fontFamily: 'poppins',
                  fontSize: 14,
                  fontWeight: FontWeight.w600, // Bold or semi-bold Sun, Mon, etc.
                ),
                weekendStyle: TextStyle(
                  fontFamily: 'poppins',
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              headerStyle: HeaderStyle(
                formatButtonVisible: false,
                titleCentered: true,
                titleTextStyle: TextStyle(
                  fontFamily: 'poppins',
                  fontSize: 20,
                  fontWeight: FontWeight.bold, // "April 2025" bold
                  color: Colors.black,
                ),
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: () {
                  if (_selectedDay != null) {
                    Navigator.pop(context, _selectedDay);
                  }
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 50),
                  backgroundColor: constants.themeColor1,
                ),
                child: const Text('Confirm Date', style: TextStyle(fontSize: 18, color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
