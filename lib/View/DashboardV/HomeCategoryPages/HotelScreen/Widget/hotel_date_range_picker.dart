import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:trip_go/View/Widgets/custom_app_bar.dart';
import 'package:trip_go/constants.dart';

class HotelDateRangePage extends StatefulWidget {
  final DateTime? initialCheckIn;
  final DateTime? initialCheckOut;

  const HotelDateRangePage({super.key, this.initialCheckIn, this.initialCheckOut});

  @override
  State<HotelDateRangePage> createState() => _HotelDateRangePageState();
}

class _HotelDateRangePageState extends State<HotelDateRangePage> {
  DateTime today = DateTime.now();
  DateTime? checkIn;
  DateTime? checkOut;

  @override
  void initState() {
    super.initState();
    checkIn = widget.initialCheckIn;
    checkOut = widget.initialCheckOut;
  }

  List<DateTime> get next12Months {
    List<DateTime> months = [];
    DateTime current = DateTime(today.year, today.month);
    for (int i = 0; i < 12; i++) {
      months.add(DateTime(current.year, current.month + i));
    }
    return months;
  }

  bool isSameDay(DateTime a, DateTime b) =>
      a.year == b.year && a.month == b.month && a.day == b.day;

  bool isInRange(DateTime date) {
    if (checkIn == null || checkOut == null) return false;
    return date.isAfter(checkIn!) && date.isBefore(checkOut!);
  }

  bool isSelected(DateTime date) =>
      isSameDay(date, checkIn ?? DateTime(2000)) ||
      isSameDay(date, checkOut ?? DateTime(2000));

  void onDateTap(DateTime date) {
    setState(() {
      if (checkIn == null || (checkIn != null && checkOut != null)) {
        checkIn = date;
        checkOut = null;
      } else if (date.isAfter(checkIn!)) {
        checkOut = date;
      } else {
        checkIn = date;
        checkOut = null;
      }
    });
  }

  int get nightCount =>
      (checkIn != null && checkOut != null) ? checkOut!.difference(checkIn!).inDays : 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(title: "Select Date"),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildHeaderCell("Check-In Date", checkIn),
                  Container(width: 1, height: 40, color: Colors.grey.shade300),
                  _buildHeaderCell("Check-Out Date", checkOut),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
            ),
            _buildWeekdayHeader(),
            Expanded(
              child: ListView.builder(
                itemCount: next12Months.length,
                itemBuilder: (context, index) {
                  final month = next12Months[index];
                  return _buildMonthView(month);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: ElevatedButton(
                onPressed: checkIn != null
                    ? () {
                        Navigator.pop(context, {
                          'checkIn': checkIn,
                          'checkOut': checkOut,
                        });
                      }
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1B499F),
                  minimumSize: const Size.fromHeight(50),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                ),
                child: Text(
                  checkOut != null
                      ? 'Done (${nightCount} Night${nightCount > 1 ? 's' : ''})'
                      : 'Select Date',
                  style: GoogleFonts.poppins(fontWeight: FontWeight.w500,color: Colors.white),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderCell(String label, DateTime? date) {
    return Column(
      children: [
        Text(label, style: GoogleFonts.poppins(fontSize: 12)),
        const SizedBox(height: 4),
        Text(
          date != null ? DateFormat('ddMMM yyyy').format(date) : '--',
          style: GoogleFonts.poppins(fontWeight: FontWeight.w600, color: constants.themeColor1),
        ),
         Text(
        date != null ? DateFormat("EEE").format(date).toUpperCase() : '',
        style: GoogleFonts.poppins(
          fontSize: 12,
          color: Colors.grey.shade700,
          fontWeight: FontWeight.w500,
        ),
      ),
      ],
    );
  }

  Widget _buildWeekdayHeader() {
    final weekdayNames = ['SUN', 'MON', 'TUE', 'WED', 'THU', 'FRI', 'SAT'];
    return Padding(
      padding: const EdgeInsets.only(top: 4),
      child: Container(
        decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(4),
                ),
        child: Row(
          children: weekdayNames.map((d) {
            return Expanded(
              child: Container(
                alignment: Alignment.center,
                height: 36,
                
                child: Text(d, style: GoogleFonts.poppins(fontSize: 12)),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildMonthView(DateTime month) {
    final firstDay = DateTime(month.year, month.month, 1);
    final daysInMonth = DateUtils.getDaysInMonth(month.year, month.month);
    final startWeekday = firstDay.weekday % 7;
    List<Widget> dayWidgets = [];

    for (int i = 0; i < startWeekday; i++) {
      dayWidgets.add(const SizedBox());
    }

    for (int i = 1; i <= daysInMonth; i++) {
      final date = DateTime(month.year, month.month, i);
      final isInSelectedRange = isInRange(date);
      final isStartOrEnd = isSelected(date);
      final isDisabled = date.isBefore(today);

      BoxDecoration? decoration;
      Color textColor = Colors.black;

      if (isStartOrEnd) {
        decoration = BoxDecoration(
          color: const Color(0xFF1B499F),
          borderRadius: BorderRadius.circular(6),
        );
        textColor = Colors.white;
      } else if (isInSelectedRange) {
        decoration = BoxDecoration(
          color: const Color(0xFF1B499F),
          borderRadius: BorderRadius.circular(6),
        );
        textColor = Colors.white;
      }

      dayWidgets.add(GestureDetector(
        onTap: isDisabled ? null : () => onDateTap(date),
        child: Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.all(4),
          decoration: decoration,
          height: 40,
          child: Text(
            "$i",
            style: GoogleFonts.poppins(
              color: isDisabled ? Colors.grey : textColor,
              fontSize: 14,
            ),
          ),
        ),
      ));
    }

    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: const Color(0xFF1B499F),
            
          ),
          child: Center(
            child: Text(
              DateFormat('MMMM yyyy').format(month),
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
        GridView.count(
          crossAxisCount: 7,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          children: dayWidgets,
        ),
      ],
    );
  }
}
