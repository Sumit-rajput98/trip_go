import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../HotelScreen/HotelDetail/hotel_detail_page.dart';

DateTime _roundToNearestInterval(DateTime dateTime, int minuteInterval) {
  final int minute = dateTime.minute;
  final int offset = (minute / minuteInterval).round() * minuteInterval;
  return DateTime(dateTime.year, dateTime.month, dateTime.day, dateTime.hour, offset);
}

// Add the showModernDateTimePicker method from your CabSearchCard
void showModernDateTimePicker({
  required BuildContext context,
  required DateTime? initialDate,
  required Function(DateTime) onDateSelected,
}) {
  DateTime tempPicked = _roundToNearestInterval(
    initialDate ?? DateTime.now(),
    15,
  );

  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    builder: (context) {
      return Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ),
        child: SafeArea(
          top: false,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Text(
                        "Cancel",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const Spacer(),
                    const Text(
                      "Select Date and Time",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                        onDateSelected(tempPicked);
                      },
                      child: Text(
                        "Done",
                        style: TextStyle(
                          fontSize: 14,
                          color: themeColor1,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(height: 1, thickness: 0.8),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.3,
                child: CupertinoDatePicker(
                  mode: CupertinoDatePickerMode.dateAndTime,
                  initialDateTime: tempPicked,
                  minuteInterval: 15,
                  use24hFormat: true,
                  minimumYear: 2000,
                  maximumYear: DateTime.now().year + 10,
                  onDateTimeChanged: (DateTime newDateTime) {
                    tempPicked = newDateTime;
                  },
                ),
              ),
              SizedBox(height: MediaQuery.of(context).padding.bottom),
            ],
          ),
        ),
      );
    },
  );
}
