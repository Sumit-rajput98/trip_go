import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trip_go/Model/FlightM/flight_SSR_model_lcc.dart';
import 'package:trip_go/Model/FlightM/flight_SSR_round_model.dart';

class BaggageTabView2 extends StatefulWidget {
  final Data1 flightSsrRes;
  const BaggageTabView2({super.key, required this.flightSsrRes});

  @override
  State<BaggageTabView2> createState() => _BaggageTabView2State();
}

class _BaggageTabView2State extends State<BaggageTabView2> {
  bool isDelBomSelected = false;
  final List<Map<String, dynamic>> baggageOptions = [
    {
      'label': 'Additional 3 Kg',
      'price': 1650,
      'image': 'https://flight.easemytrip.com/M_Content/img/img_MB/3Kg-bag.png',
    },
    {
      'label': 'Additional 5 Kg',
      'price': 2750,
      'image': 'https://flight.easemytrip.com/M_Content/img/img_MB/5Kg-bag.png',
    },
    {
      'label': 'Additional 10 Kg',
      'price': 5500,
      'image':
      'https://flight.easemytrip.com/M_Content/img/img_MB/10Kg-bag.png',
    },
    {
      'label': 'Additional 15 Kg',
      'price': 8250,
      'image':
      'https://flight.easemytrip.com/M_Content/img/img_MB/15Kg-bag.png',
    },
    {
      'label': 'Additional 25 Kg',
      'price': 13750,
      'image':
      'https://flight.easemytrip.com/M_Content/img/img_MB/25Kg-bag.png',
    },
  ];

  List<int> baggageCounts = [];

  @override
  void initState() {
    super.initState();
    final baggageList = widget.flightSsrRes.baggage?[0] ?? [];
    baggageCounts = List.filled(baggageList.length, 0);
  }

  @override
  @override
  Widget build(BuildContext context) {
    final baggageList = widget.flightSsrRes.baggage?[0] ?? [];
    final Color accentBlue = Color(0xFF009EE0);
    final Color bannerGreen = Color(0xFFDFF5E3);

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          baggageList.isEmpty || baggageList[0].code == "NoBaggage"
              ? Padding(
            padding: const EdgeInsets.fromLTRB(0, 50, 0, 0),
            child: Center(
              child: Text(
                "No Baggage Available",
                style: GoogleFonts.poppins(fontSize: 18),
              ),
            ),
          )
              : Column(
            children: [
              // DEL-BOM selector (you can make this dynamic later)
              Container(
                height: 60,
                width: double.infinity,
                color: Color(0xFFD1E9FF),
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        isDelBomSelected = !isDelBomSelected;
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: isDelBomSelected ? Color(0xFF2196F3) : Colors.white,
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(color: Colors.grey.shade300),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.flight_takeoff,
                            size: 18,
                            color: isDelBomSelected ? Colors.white : Colors.redAccent,
                          ),
                          SizedBox(width: 6),
                          Text(
                            "DEL-BOM",
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w600,
                              color: isDelBomSelected ? Colors.white : Colors.black87,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              // Banner
              Container(
                color: bannerGreen,
                width: double.infinity,
                padding: EdgeInsets.all(12),
                child: Text(
                  'Save huge on extra baggage by booking in advance.',
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: Colors.green.shade900,
                  ),
                ),
              ),

              // Section title
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                child: Text(
                  'Add Check-in Baggage',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),

              // Dynamic baggage list
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: baggageList.length,
                itemBuilder: (context, index) {
                  final baggageItem = baggageList[index];

                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(blurRadius: 4, color: Colors.black12),
                        ],
                      ),
                      child: Row(
                        children: [
                          // You may add a dynamic image here if available; fallback to default if null
                          Image.network(
                            'https://flight.easemytrip.com/M_Content/img/img_MB/${baggageItem.weight}Kg-bag.png',
                            width: 50,
                            height: 50,
                            fit: BoxFit.contain,
                            errorBuilder: (context, error, stackTrace) => Icon(Icons.luggage),
                          ),
                          SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${baggageItem.weight} Kg',  // or baggageItem.description if better
                                  style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  '₹${baggageItem.price}',
                                  style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    if (baggageCounts[index] > 0) baggageCounts[index]--;
                                  });
                                },
                                icon: Icon(
                                  Icons.remove_circle_outline,
                                  color: accentBlue,
                                ),
                              ),
                              Container(
                                width: 24,
                                alignment: Alignment.center,
                                child: Text(
                                  '${baggageCounts[index]}',
                                  style: GoogleFonts.poppins(fontSize: 16),
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    baggageCounts[index]++;
                                  });
                                },
                                icon: Icon(
                                  Icons.add_circle_outline,
                                  color: accentBlue,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

