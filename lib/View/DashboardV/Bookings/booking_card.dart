import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trip_go/View/DashboardV/Bookings/user_flight_booking_details.dart';
import '../../../Model/AccountM/user_booking_model.dart';
import 'booking_utils.dart';

class BookingCard extends StatelessWidget {
  final BookingData booking;

  const BookingCard({super.key, required this.booking});

  @override
  Widget build(BuildContext context) {
    final segments = booking.fareQuoteIbLog?.results?.segments;
    final airline = segments?[0][0].airline;

    final departureAirport = segments?[0][0].origin?.airport?.airportName ?? booking.depart;
    final departureTime = segments?[0][0].origin?.time;

    final arrivalAirport = segments?[0][0].destination?.airport?.airportName ?? booking.arrival;
    final arrivalTime = segments?[0][0].destination?.time;

    final logoMap = {
      "6E": "https://flight.easemytrip.com/Content/AirlineLogon/6E.png",
      "AI": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS-QO8gVe353NPaAV3wid57LAtWqIdet-EVMA&s",
      "SG": "https://flight.easemytrip.com/Content/AirlineLogon/SG.png",
      "UK": "https://flight.easemytrip.com/Content/AirlineLogon/UK.png",
      "IX": "https://flight.easemytrip.com/Content/AirlineLogon/IX.png",
      "G8": "https://flight.easemytrip.com/Content/AirlineLogon/G8.png",
    };
    final logoUrl = logoMap[airline?.airlineCode];

    return GestureDetector(
      onTap: () {
        print(booking.bookingId);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => UserFlightBookingScreen(
              booking: booking,
            ),
          ),
        );
      },
      child: Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 4,
        margin: const EdgeInsets.only(bottom: 20),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Airline Info
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      if (logoUrl != null)
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(logoUrl, width: 25, height: 25),
                        )
                      else
                        Icon(Icons.flight, size: 25, color: Colors.blue.shade700),
                      SizedBox(width: 12),
                      Text(
                        '${airline?.airlineName ?? "Flight"} (${airline?.flightNumber ?? "N/A"})',
                        style: GoogleFonts.poppins(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue.shade900,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.green, width: 1.5),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      getBookingStatusText(booking.status),
                      style: GoogleFonts.poppins(
                        color: Colors.green,
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 12),

              // Departure Info
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.flight_takeoff, color: Colors.blue.shade700, size: 20),
                  SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Departure',
                          style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w500),
                        ),
                        SizedBox(height: 2),
                        Text(
                          '$departureAirport at ${formatTime(departureTime)}',
                          style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey.shade800),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              SizedBox(height: 10),

              // Arrival Info
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.flight_land, color: Colors.green.shade700, size: 20),
                  SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Arrival',
                          style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w500),
                        ),
                        SizedBox(height: 2),
                        Text(
                          '$arrivalAirport at ${formatTime(arrivalTime)}',
                          style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey.shade800),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              SizedBox(height: 10),

              // Booking Date
              Row(
                children: [
                  Icon(Icons.calendar_today, size: 15, color: Colors.grey.shade600),
                  SizedBox(width: 6),
                  Text(
                    formatDate(booking.departDate),
                    style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey.shade700),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
