import 'package:flutter/material.dart';

class HotelSearchFilter extends StatefulWidget {
  const HotelSearchFilter({super.key});

  @override
  State<HotelSearchFilter> createState() => _HotelSearchFilterState();
}

class _HotelSearchFilterState extends State<HotelSearchFilter> {
  String _formatMonthYear(DateTime date) {
    return "${_getMonth(date.month)} '${date.year.toString().substring(2)}";
  }

  String _getWeekday(DateTime date) {
    const weekdays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    return weekdays[date.weekday - 1];
  }

  String _getMonth(int month) {
    const months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    return months[month - 1];
  }

  DateTime? checkInDate;
  DateTime? checkOutDate;
  Future<void> _selectDate(BuildContext context, bool isCheckIn) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2026),
    );
    if (picked != null) {
      setState(() {
        if (isCheckIn) {
          checkInDate = picked;
        } else {
          checkOutDate = picked;
        }
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0,0,0,0),
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            const Text(
              'SAME HOTEL, CHEAPEST PRICE. GUARANTEED!',
              style: TextStyle(fontWeight: FontWeight.w900, fontSize: 12, fontFamily: 'poppins'),
            ),
            const SizedBox(height: 10),
            // City / Hotel Name
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFFEDEBFF),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Enter City name, Location or Specific hotel',
                    style: TextStyle(fontSize: 12, color: Colors.black54, fontFamily: 'poppins'),
                  ),
                  const SizedBox(height: 6),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: const [
                        Icon(Icons.location_on_outlined, color: Colors.grey),
                        SizedBox(width: 10),
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Enter City/Hotel Name',
                              hintStyle: TextStyle(fontWeight: FontWeight.w600, fontSize: 16, fontFamily: 'poppins'),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                // Check-in
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color(0xFFEDEBFF),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Check-in',
                          style: TextStyle(fontSize: 12, color: Colors.black54, fontFamily: 'poppins'),
                        ),
                        const SizedBox(height: 6),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: GestureDetector(
                            onTap:()=> _selectDate(context,true),
                            child: Row(
                              children: [
                                const Icon(Icons.calendar_today_outlined, size: 20, color: Colors.grey),
                                const SizedBox(width: 10),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(checkInDate != null ? '${checkInDate!.day}' : '24', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 25)),
                                    const SizedBox(width: 8),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(checkInDate != null
                                            ? _formatMonthYear(checkInDate!)
                                            : "Apr '25", style: const TextStyle(fontSize: 12)),
                                        Text(checkInDate != null
                                            ? _getWeekday(checkInDate!)
                                            : 'Thu', style: const TextStyle(fontSize: 12)),
                                      ],
                                    ),
                                  ],
                                ),

                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(width: 12),

                // Check-out
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color(0xFFEDEBFF),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Check-out',
                          style: TextStyle(fontSize: 12, color: Colors.black54, fontFamily: 'poppins'),
                        ),
                        const SizedBox(height: 6),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: GestureDetector(
                            onTap:()=> _selectDate(context,false),
                            child: Row(
                              children: [
                                const Icon(Icons.calendar_today_outlined, size: 20, color: Colors.grey),
                                const SizedBox(width: 10),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(checkOutDate != null ? '${checkOutDate!.day}' : '25', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 25)),
                                    const SizedBox(width: 8),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(checkOutDate != null
                                            ? _formatMonthYear(checkOutDate!)
                                            : "Apr '25", style: const TextStyle(fontSize: 12)),
                                        Text(checkOutDate != null
                                            ? _getWeekday(checkOutDate!)
                                            : 'Thu', style: const TextStyle(fontSize: 12)),
                                      ],
                                    ),
                                  ],
                                ),

                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),


            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFFEDEBFF),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  const Icon(Icons.person_outline, color: Colors.grey),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Guest and Room',
                        style: TextStyle(fontSize: 12, color: Colors.black54),
                      ),
                      SizedBox(height: 4),
                      Text(
                        '1 Guest, 1 Room',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const Spacer(),
                  const Icon(Icons.add, color: Colors.grey),
                ],
              ),
            ),

            const SizedBox(height: 16),

            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFFEDEBFF),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Nationality',
                    style: TextStyle(fontSize: 12, color: Colors.black87),
                  ),
                  const SizedBox(height: 6),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      color: Colors.white, // White dropdown background
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        isExpanded: true,
                        value: 'Albania',
                        items: const [
                          DropdownMenuItem(value: 'Albania', child: Text('Albania')),
                          DropdownMenuItem(value: 'USA', child: Text('USA')),
                          DropdownMenuItem(value: 'India', child: Text('India')),
                        ],
                        onChanged: (value) {},
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}