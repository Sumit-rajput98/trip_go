import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:trip_go/Model/FlightM/flight_SSR_round_model.dart';
import '../../../../../ViewM/FlightVM/baggage_selection_round_provider.dart';

class BaggageRoundTabView extends StatefulWidget {
  final Data1 flightSsrRes;
  final bool isReturn;
  final void Function(double) onBaggagePriceChanged; // callback to update parent

  const BaggageRoundTabView({
    super.key,
    required this.flightSsrRes,
    required this.onBaggagePriceChanged,
    required this.isReturn
  });

  @override
  State<BaggageRoundTabView> createState() => _BaggageRoundTabViewState();
}

class _BaggageRoundTabViewState extends State<BaggageRoundTabView> {
  List<int> baggageCounts = [];
  int totalSelectedWeight = 0;
  double totalBaggagePrice = 0;

  @override
  void initState() {
    super.initState();
    final validList = _getValidBaggageList();
    baggageCounts = List.filled(validList.length, 0);
  }

  List<Baggage> _getValidBaggageList() {
    final fullList = widget.flightSsrRes.baggage?[0] ?? [];
    return fullList.where((item) => item.code != 'NoBaggage').toList();
  }

  int _extractWeight(String code) {
    if (code.length >= 2) {
      return int.tryParse(code.substring(code.length - 2)) ?? 0;
    }
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    final baggageList = _getValidBaggageList();
    final baggageProvider = Provider.of<BaggageSelectionRoundProvider>(context, listen: false);

    if (baggageList.isEmpty) {
      return Center(
        child: Text("No Baggage Available", style: GoogleFonts.poppins(fontSize: 18)),
      );
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 100), // avoid bottom sheet
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: baggageList.length,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          final baggageItem = baggageList[index];
          final code = baggageItem.code ?? '';
          final price = baggageItem.price?.toDouble() ?? 0.0;
          final weight = _extractWeight(code);
          final count = baggageCounts[index];

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [BoxShadow(blurRadius: 4, color: Colors.black12)],
              ),
              child: Row(
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    alignment: Alignment.center,
                    child: Image.network(
                      'https://flight.easemytrip.com/M_Content/img/img_MB/${weight}Kg-bag.png',
                      fit: BoxFit.contain,
                      errorBuilder: (c, e, s) => Icon(Icons.luggage, size: 32),
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '$weight Kg',
                          style: GoogleFonts.poppins(
                              fontSize: 14, fontWeight: FontWeight.w500),
                        ),
                        SizedBox(height: 4),
                        Text(
                          '₹${price.toStringAsFixed(0)}',
                          style: GoogleFonts.poppins(
                              fontSize: 14, fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          if (count > 0) {
                            setState(() {
                              baggageCounts[index]--;
                              totalSelectedWeight -= weight;
                              totalBaggagePrice -= price;
                              widget.onBaggagePriceChanged(totalBaggagePrice);
                            });

                            // ✅ Remove from Provider (with isReturn flag)
                            baggageProvider.removeBaggage(baggageItem.code ?? '', isReturn: widget.isReturn);

                            print('Total Baggage Price: ₹${baggageProvider.totalBaggagePrice}');
                          }
                        },
                        icon: Icon(Icons.remove_circle_outline, color: Colors.blue),
                      ),
                      Text('$count', style: GoogleFonts.poppins(fontSize: 16)),
                      IconButton(
                        onPressed: () {
                          if (totalSelectedWeight + weight <= 15) {
                            setState(() {
                              baggageCounts[index]++;
                              totalSelectedWeight += weight;
                              totalBaggagePrice += price;
                              widget.onBaggagePriceChanged(totalBaggagePrice);
                            });

                            // ✅ Add to Provider (with isReturn flag)
                            baggageProvider.addBaggage(baggageItem, isReturn: widget.isReturn);

                            print('Total Baggage Price: ₹${baggageProvider.totalBaggagePrice}');
                            final json = jsonEncode({
                              "AirlineCode": baggageItem.airlineCode,
                              "FlightNumber": baggageItem.flightNumber,
                              "WayType": baggageItem.wayType,
                              "Code": baggageItem.code,
                              "Description": baggageItem.description,
                              "Weight": baggageItem.weight,
                              "Currency": baggageItem.currency,
                              "Price": baggageItem.price,
                              "Origin": baggageItem.origin,
                              "Destination": baggageItem.destination,
                            });
                            print('BaggageDynamic: $json');
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("Max 15kg baggage allowed")),
                            );
                          }
                        },

                        icon: Icon(Icons.add_circle_outline, color: Colors.blue),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

/*
class BaggageTabView extends StatefulWidget {
  final Data flightSsrRes;
  const BaggageTabView({super.key, required this.flightSsrRes});

  @override
  State<BaggageTabView> createState() => _BaggageTabViewState();
}

class _BaggageTabViewState extends State<BaggageTabView> {
  bool isDelBomSelected = false;
  List<int> baggageCounts = [];

  @override
  void initState() {
    super.initState();
    final baggageList = widget.flightSsrRes.baggage?[0] ?? [];
    baggageCounts = List.filled(baggageList.length, 0);
  }

  @override
  Widget build(BuildContext context) {
    final baggageList = widget.flightSsrRes.baggage?[0] ?? [];
    final Color accentBlue = Color(0xFF009EE0);
    final Color bannerGreen = Color(0xFFDFF5E3);

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          baggageList.isEmpty || baggageList.every((b) => b.code == "NoBaggage")
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
                    // DEL-BOM selector
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
                        final code = baggageItem.code ?? '';

                        // Skip NoBaggage entries
                        if (code == "NoBaggage") return SizedBox.shrink();

                        // Extract weight from last 2 digits of the code
                        String weightFromCode = '';
                        if (code.length >= 4) {
                          weightFromCode = int.tryParse(code.substring(code.length - 2))?.toString() ?? '';
                        }

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
                                // Dynamic image based on weight
                                Image.network(
                                  'https://flight.easemytrip.com/M_Content/img/img_MB/${weightFromCode}Kg-bag.png',
                                  width: 50,
                                  height: 50,
                                  fit: BoxFit.contain,
                                  errorBuilder: (context, error, stackTrace) =>
                                      Icon(Icons.luggage),
                                ),
                                SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '${weightFromCode} Kg',
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
 */