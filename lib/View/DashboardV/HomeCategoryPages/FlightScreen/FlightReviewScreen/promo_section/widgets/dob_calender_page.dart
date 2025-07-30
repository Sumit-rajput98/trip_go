import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:trip_go/constants.dart';

class DOBCalendarPage extends StatefulWidget {
  const DOBCalendarPage({super.key});

  @override
  State<DOBCalendarPage> createState() => _DOBCalendarPageState();
}

class _DOBCalendarPageState extends State<DOBCalendarPage> {
  DateTime _focusedDay = DateTime.now().subtract(Duration(days: 365 * 25));
  DateTime? _selectedDay;

  Future<void> _selectYear() async {
    final selectedYear = await Navigator.push<int>(
      context,
      MaterialPageRoute(builder: (_) => SelectYearPage(initialYear: _focusedDay.year)),
    );
    if (selectedYear != null) {
      setState(() {
        _focusedDay = DateTime(selectedYear, _focusedDay.month, _focusedDay.day);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text(
          'Select Date of Birth',
          style: TextStyle(fontFamily: 'poppins', color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: constants.themeColor1,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Column(
        children: [
          // Tappable Year Text
          GestureDetector(
            onTap: _selectYear,
            child: Container(
              width: double.infinity,  // take full screen width
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,  // center the text + icon
                children: [
                  Text(
                    _focusedDay.year.toString(),
                    style: const TextStyle(fontFamily: 'poppins', fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(width: 10),
                  const Icon(Icons.keyboard_arrow_down_sharp),
                ],
              ),
            ),
          ),

          // Table Calendar
          TableCalendar(
            firstDay: DateTime(1900),
            lastDay: DateTime.now(),
            focusedDay: _focusedDay,
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
              });
            },
            calendarStyle: CalendarStyle(
              defaultTextStyle: const TextStyle(fontFamily: 'poppins', fontSize: 16, fontWeight: FontWeight.w500),
              weekendTextStyle: const TextStyle(fontFamily: 'poppins', fontSize: 16, fontWeight: FontWeight.w500),
              selectedDecoration: BoxDecoration(color: constants.themeColor1, shape: BoxShape.circle),
              todayDecoration: BoxDecoration(color: constants.themeColor2, shape: BoxShape.circle),
            ),
            daysOfWeekStyle: const DaysOfWeekStyle(
              weekdayStyle: TextStyle(fontFamily: 'poppins', fontSize: 14, fontWeight: FontWeight.w600),
              weekendStyle: TextStyle(fontFamily: 'poppins', fontSize: 14, fontWeight: FontWeight.w600),
            ),
            headerStyle: const HeaderStyle(
              formatButtonVisible: false,
              titleCentered: true,
              titleTextStyle: TextStyle(fontFamily: 'poppins', fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
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
                minimumSize: const Size(double.infinity, 50),
                backgroundColor: constants.themeColor1,
              ),
              child: const Text('Confirm DOB', style: TextStyle(fontSize: 18, color: Colors.white)),
            ),
          ),
          SizedBox(height: 40,)
        ],
      ),
    );
  }
}

class SelectYearPage extends StatelessWidget {
  final int initialYear;

  const SelectYearPage({super.key, required this.initialYear});

  @override
  Widget build(BuildContext context) {
    final years = List.generate(DateTime.now().year - 1899, (index) => 1900 + index).reversed.toList();
    int selectedYear = initialYear;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Year', style: TextStyle(fontFamily: 'poppins', color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: constants.themeColor1,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: ListView.builder(
        itemCount: years.length,
        itemBuilder: (context, index) {
          final year = years[index];
          return ListTile(
            title: Text(year.toString(), style: const TextStyle(fontFamily: 'poppins', fontSize: 18)),
            trailing: year == selectedYear ? const Icon(Icons.check, color: Colors.green) : null,
            onTap: () {
              Navigator.pop(context, year);
            },
          );
        },
      ),
    );
  }
}
