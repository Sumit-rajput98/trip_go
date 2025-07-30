import 'dart:async';

import 'package:flutter/material.dart';

class DailyDeals extends StatefulWidget {
  const DailyDeals({super.key});

  @override
  State<DailyDeals> createState() => _DailyDealsState();
}

class _DailyDealsState extends State<DailyDeals> {

  late Timer _timer;
  Duration _remainingTime = Duration.zero;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    final now = DateTime.now();
    final targetTime = DateTime(now.year, now.month, now.day, 12, 30, 0);

    if (now.isBefore(targetTime)) {
      _remainingTime = targetTime.difference(now);
    } else {
      _remainingTime = Duration.zero; // Timer already passed
    }

    _timer = Timer.periodic(Duration(seconds: 1), (_) {
      if (_remainingTime.inSeconds > 0) {
        setState(() {
          _remainingTime -= Duration(seconds: 1);
        });
      } else {
        _timer.cancel();
      }
    });
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return '$hours : $minutes : $seconds';
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  final List<Map<String, String>> airlines = const [
    {
      "name": "Air India",
      "logo": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS-QO8gVe353NPaAV3wid57LAtWqIdet-EVMA&s"
    },
    {
      "name": "Air India Express",
      "logo": "https://flight.easemytrip.com/Content/AirlineLogon/IX.png"
    },
    {
      "name": "Indigo",
      "logo": "https://flight.easemytrip.com/Content/AirlineLogon/6E.png"
    },
    {
      "name": "Vistara",
      "logo": "https://flight.easemytrip.com/Content/AirlineLogon/UK.png"
    },
    {
      "name": "SpiceJet",
      "logo": "https://flight.easemytrip.com/Content/AirlineLogon/SG.png"
    },
    {
      "name": "GoAir",
      "logo": "https://flight.easemytrip.com/Content/AirlineLogon/G8.png"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 30),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFFF4F5F9), Color(0xFFF0F2F8), Colors.white],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Left side
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    // onTap: (){
                    //   Navigator.push(context, MaterialPageRoute(builder: (context)=> TicketPage()));
                    // },
                    child: const Text(
                      'DAILY DEALS',
                      style: TextStyle(
                        fontSize: 25,
                        fontFamily: 'poppins',
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: const [
                      Icon(Icons.location_on, size: 18, color: Color(0xff1B499F),),
                      SizedBox(width: 4),
                      Text(
                        'From/To Mumbai',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black54,
                          fontFamily: 'poppins'
                        ),
                      ),
                      SizedBox(width: 4),
                      Icon(Icons.keyboard_arrow_down, size: 18, color: Color(0xff1B499F),),
                    ],
                  ),
                ],
              ),

              // Right side - Timer and image
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'Closed At',
                        style: TextStyle(
                          fontSize: 15,
                          color: Color(0xff1B499F),
                          fontFamily: 'poppins',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        _formatDuration(_remainingTime),
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xffF73130),
                          fontFamily: 'poppins',
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 30),

          SizedBox(
            height: 140,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              child: Row(
                children: List.generate(4, (index) {
                  final airline = airlines[index];
                  return Container(
                    width: 250,
                    margin: EdgeInsets.only(right: index == 3 ? 0 : 16),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: const Color(0xFFFFEBEE), width: 2),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12.withOpacity(0.05),
                          blurRadius: 6,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // First line: logo + name + Flat 5% off
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 30,
                              width: 40,
                              child: Image.network(
                                airline["logo"]!,
                                fit: BoxFit.contain,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                airline["name"]!,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                  fontFamily: 'poppins'
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                              decoration: BoxDecoration(
                                color: Colors.redAccent.withOpacity(0.15),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Text(
                                'Flat 5% off',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.redAccent,
                                  fontFamily: 'poppins'
                                ),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 8),
                        Text(
                          'Fri, 16 May',
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.black54,
                            fontFamily: 'poppins'
                          ),
                        ),

                        const SizedBox(height: 8,),
                        // Second line: Date, Departure time, Arrival time
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [

                            Text(
                              '12:05',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                                fontFamily: 'poppins'
                              ),
                            ),
                            Text(
                              '06:30',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                                  fontFamily: 'poppins'
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 4),

                        // Third line: Departure and Arrival airport codes
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text(
                              'DEL',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Colors.black87,
                                  fontFamily: 'poppins'
                              ),
                            ),
                            Text(
                              'BOM',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Colors.black87,
                                  fontFamily: 'poppins'
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                }),
              ),
            ),
          )
        ],
      ),
    );
  }
}
