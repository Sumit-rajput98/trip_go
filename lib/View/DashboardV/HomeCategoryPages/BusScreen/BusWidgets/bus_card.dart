import 'package:flutter/material.dart';
import 'package:trip_go/View/Widgets/Drawer/custom_drawer.dart';

class BusCard extends StatelessWidget {
  final String name;
  String? busType;
  final String departure;
  final String arrival;
  final String duration;
  final String rating;
  final String price;
  final String availableSeats;
  final List<String> features; // e.g., ["WiFi", "Water Bottle", "Blanket"]

  BusCard({
    super.key,
    required this.name,
    this.busType,
    required this.departure,
    required this.arrival,
    required this.duration,
    required this.rating,
    required this.price,
    required this.availableSeats,
    this.features = const [],
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Top Card Section
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
            ),
            color: Colors.white,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.blue.shade50,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          "Recommended",
                          style: TextStyle(
                            fontSize: 12,
                            fontFamily: 'poppins',
                            fontWeight: FontWeight.w500,
                            color: constants.themeColor1,
                          ),
                        ),
                      ),

                      const SizedBox(height: 8),

                      Text(
                        name,
                        style: const TextStyle(
                          fontSize: 13,
                          fontFamily: 'poppins',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        "Starting From",
                        style: const TextStyle(
                          fontSize: 13,
                          fontFamily: 'poppins',
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        "$price",
                        style: const TextStyle(
                          fontSize: 18,
                          fontFamily: 'poppins',
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                        ),
                      ),
                      Text(
                        "${availableSeats} Seat (s) left",
                        style: TextStyle(
                          fontSize: 12,
                          fontFamily: 'poppins',
                          fontWeight: FontWeight.w500,
                          color: constants.themeColor1,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Flexible(
                    child: Text(
                      maxLines: 2,
                      busType ?? "",
                      style: const TextStyle(
                        fontSize: 12,
                        fontFamily: 'poppins',
                        color: Colors.black54,
                      ),
                    ),
                  ),
                  SizedBox(width: 5,),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: Colors.green, // Filled blue background
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.star, size: 12, color: Colors.white),
                        const SizedBox(width: 2),
                        Text(
                          rating,
                          style: const TextStyle(
                            fontSize: 11,
                            fontFamily: 'poppins',
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    departure,
                    style: const TextStyle(
                      fontSize: 14,
                      fontFamily: 'poppins',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    duration,
                    style: const TextStyle(
                      fontSize: 12,
                      fontFamily: 'poppins',
                      color: Colors.grey,
                    ),
                  ),
                  Text(
                    arrival,
                    style: const TextStyle(
                      fontSize: 14,
                      fontFamily: 'poppins',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              const Divider(),
              Row(
                children: [
                  const Icon(Icons.event_seat, size: 18, color: Colors.black54),
                  const SizedBox(width: 8),
                  const Icon(Icons.exit_to_app, size: 18, color: Colors.black54),
                  const SizedBox(width: 8),
                  const Icon(Icons.ac_unit, size: 18, color: Colors.black54),
                  const SizedBox(width: 8),
                  const Text(
                    "2+",
                    style: TextStyle(
                      fontSize: 12,
                      fontFamily: 'poppins',
                      color: Colors.black87,
                    ),
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      Icon(Icons.gps_fixed, size: 18, color: constants.themeColor1,),
                      SizedBox(width: 5,),
                      Text(
                        "Live Tracking",
                        style: TextStyle(
                          fontSize: 12,
                          fontFamily: 'poppins',
                          color: constants.themeColor1,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),

        // Extended Features Section
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(12),
              bottomRight: Radius.circular(12),
            ),
            color: Colors.grey.shade50,
          ),
          child: Wrap(
            spacing: 10,
            runSpacing: 8,
            children: features.map((feature) {
              return Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.circle, size: 8, color: constants.themeColor1),
                  const SizedBox(width: 4),
                  Text(
                    feature,
                    style: const TextStyle(
                      fontSize: 9,
                      fontFamily: 'poppins',
                      color: Colors.black87,
                    ),
                  ),
                ],
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
