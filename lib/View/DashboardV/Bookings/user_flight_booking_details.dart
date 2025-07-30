import 'dart:io';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:open_file/open_file.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trip_go/Model/AccountM/user_booking_model.dart';
import 'package:trip_go/View/DashboardV/HomeCategoryPages/FlightScreen/FlightWidgets/download_fab_button.dart';
import 'package:trip_go/View/Widgets/custom_app_bar.dart';
import 'package:trip_go/constants.dart';
import 'package:path_provider/path_provider.dart';
import '../../../ViewM/CabVM/flight_ticket_download_view_model.dart';

class UserFlightBookingScreen extends StatefulWidget {
  final BookingData booking;

  const UserFlightBookingScreen({super.key, required this.booking});

  @override
  State<UserFlightBookingScreen> createState() => _UserFlightBookingScreenState();
}

class _UserFlightBookingScreenState extends State<UserFlightBookingScreen> {
  late final FlightTicketDownloadViewModel _flightDownloadViewModel;
  bool isDownloading = false;

  @override
  void initState() {
    super.initState();
    _flightDownloadViewModel = FlightTicketDownloadViewModel();
  }
  @override
  Widget build(BuildContext context) {
    String _monthName(int month) {
      const months = ["", "Jan", "Feb", "Mar", "Apr", "May", "Jun",
        "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"];
      return months[month];
    }
    String formatFullDateTime(String? timeStr) {
      if (timeStr == null) return "N/A";
      final time = DateTime.tryParse(timeStr);
      if (time == null) return "N/A";
      return "${time.day.toString().padLeft(2, '0')} "
          "${_monthName(time.month)} "
          "${time.year}, "
          "${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}";
    }
    String _formatCurrency(double? amount, String? symbol) {
      if (amount == null) return 'N/A';
      return "${symbol ?? '₹'} ${amount.toStringAsFixed(2)}";
    }

    final logoMap = {
      "6E": "https://flight.easemytrip.com/Content/AirlineLogon/6E.png", // Indigo
      "AI": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS-QO8gVe353NPaAV3wid57LAtWqIdet-EVMA&s", // Air India
      "SG": "https://flight.easemytrip.com/Content/AirlineLogon/SG.png", // SpiceJet
      "UK": "https://flight.easemytrip.com/Content/AirlineLogon/UK.png", // Vistara
      "IX": "https://flight.easemytrip.com/Content/AirlineLogon/IX.png", // Air India Express
      "G8": "https://flight.easemytrip.com/Content/AirlineLogon/G8.png", // GoAir
    };


    final segments = widget.booking.fareQuoteIbLog?.results?.segments;
    final airline = segments?[0][0].airline;

    final logoUrl = logoMap[airline?.airlineCode];
    final List<Segment> segmentList = segments != null ? segments[0] : [];

    final firstSegment = segmentList.isNotEmpty ? segmentList[0] : null;
    final secondSegment = segmentList.length > 1 ? segmentList[1] : null;

    return SafeArea(
      top: false,
      child: Scaffold(
        appBar: CustomAppBar(title: "All Details"),
        backgroundColor: Colors.grey.shade100,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        offset: Offset(0, 3),
                        blurRadius: 8,
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          if (logoUrl != null)
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.network(
                                logoUrl,
                                height: 25,
                                width: 25,
                                fit: BoxFit.contain,
                                errorBuilder: (_, __, ___) => Icon(Icons.flight),
                              ),
                            ),
                          const SizedBox(width: 8),
                          Text(
                            "${widget.booking.depart}–${widget.booking.arrival}",
                            style: GoogleFonts.poppins(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Text(
                            formatFullDateTime(firstSegment?.origin?.time),
                            style: GoogleFonts.poppins(color: Colors.grey),
                          ),
                          const SizedBox(width: 5),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.blue.shade50,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              "Depart",
                              style: GoogleFonts.poppins(
                                color: Color(0xff006DFF),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const Divider(),

                      /// FIRST FLIGHT TILE
                      buildFlightTile(
                        airlineName: firstSegment?.airline?.airlineName ?? '',
                        fareClass: firstSegment?.supplierFareClass ?? '',
                        fromCode: firstSegment?.origin?.airport?.airportCode ?? '',
                        fromTime: firstSegment?.origin?.time ?? '',
                        toCode: firstSegment?.destination?.airport?.airportCode ?? '',
                        toTime: firstSegment?.destination?.time ?? '',
                        fromTerminal: firstSegment?.origin?.airport?.terminal ?? '',
                        toTerminal: firstSegment?.destination?.airport?.terminal ?? '',
                        duration: firstSegment?.duration ?? 0,
                        fromCity: firstSegment?.origin?.airport?.airportName ?? '',
                        toCity: firstSegment?.destination?.airport?.airportName ?? '',
                      ),

                      /// LAYOVER and SECOND SEGMENT
                      if (secondSegment != null) ...[
                        const SizedBox(height: 10),
                        buildLayover("${secondSegment.duration} mins Layover"),
                        const SizedBox(height: 10),
                        buildFlightTile(
                          airlineName: secondSegment.airline?.airlineName ?? '',
                          fareClass: secondSegment.supplierFareClass ?? '',
                          fromCode: secondSegment.origin?.airport?.airportCode ?? '',
                          fromTime: secondSegment.origin?.time ?? '',
                          toCode: secondSegment.destination?.airport?.airportCode ?? '',
                          toTime: secondSegment.destination?.time ?? '',
                          fromTerminal: secondSegment.origin?.airport?.terminal ?? '',
                          toTerminal: secondSegment.destination?.airport?.terminal ?? '',
                          duration: secondSegment.duration ?? 0,
                          fromCity: secondSegment.origin?.airport?.airportName ?? '',
                          toCity: secondSegment.destination?.airport?.airportName ?? '',
                        ),
                      ],

                      Divider(),

                    ],
                  ),
                ),
                /// Passenger & Seat Details Card
                if (widget.booking.bookingRequest?.passengers != null &&
                    widget.booking.bookingRequest!.passengers.isNotEmpty)
                  Container(
                    margin: const EdgeInsets.only(top: 16),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          offset: Offset(0, 3),
                          blurRadius: 8,
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Passenger & Seat Details",
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 12),
                        ...widget.booking.bookingRequest!.passengers.map((passenger) {
                          final seat = passenger.seatDynamic.isNotEmpty
                              ? passenger.seatDynamic[0]
                              : null;

                          return Padding(
                            padding: const EdgeInsets.only(bottom: 16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${passenger.title} ${passenger.firstName} ${passenger.lastName}",
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  children: [
                                    Icon(Icons.phone_android, size: 14, color: Colors.grey),
                                    const SizedBox(width: 6),
                                    Text(
                                      "${passenger.contactNo}",
                                      style: GoogleFonts.poppins(fontSize: 12),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Icon(Icons.email_outlined, size: 14, color: Colors.grey),
                                    const SizedBox(width: 6),
                                    Text(
                                      "${passenger.email}",
                                      style: GoogleFonts.poppins(fontSize: 12),
                                    ),
                                  ],
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Icon(Icons.flag_outlined, size: 16, color: Colors.grey),
                                    const SizedBox(width: 6),
                                    Flexible(
                                      child: Text(
                                        "${passenger.addressLine1}, ${passenger.countryName}",
                                        style: GoogleFonts.poppins(fontSize: 12),
                                        maxLines: 3,
                                      ),
                                    ),
                                  ],
                                ),
                                if (seat != null) ...[
                                  const SizedBox(height: 6),
                                  Text(
                                    "Seat: ${seat.seatNo} • Row: ${seat.rowNo} • Type: ${seat.seatType} • Price: ${seat.price} ${seat.currency}",
                                    style: GoogleFonts.poppins(
                                      fontSize: 12,
                                      color: Colors.grey.shade700,
                                    ),
                                  ),
                                ],
                              ],
                            ),
                          );
                        }).toList(),
                      ],
                    ),
                  ),

                /// Basic Details Card
                Container(
                  margin: const EdgeInsets.only(top: 16),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        offset: Offset(0, 3),
                        blurRadius: 8,
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Basic Booking Details",
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),

                      /// Booking Info Table
                      _buildRow("Booking Type", widget.booking.bookingType ?? 'N/A'),
                      _buildRow("Onward PNR", widget.booking.pnr ?? 'N/A'),
                      _buildRow("Booking Date", formatFullDateTime(widget.booking.createdAt)),
                      // _buildRow("Update Date", formatFullDateTime(booking.up)),
                      // _buildRow("Onward Booking", booking.bookingId ?? 'N/A'),
                      // _buildRow("Payment Status", booking.bookingResponse?.paymentStatus ?? 'N/A'),
                      _buildRow("Onward Fare Type", widget.booking.policy ?? 'N/A'),
                      // _buildRow("Ticket Status", booking.status ?? 'N/A'),
                    ],
                  ),
                ),
                /// Onward Fare Details Card
                if (widget.booking.paymentDetail != null) ...[
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          offset: Offset(0, 3),
                          blurRadius: 8,
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Onward Fare Details",
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 12),

                        _buildRow("Base Fare", _formatCurrency(widget.booking.paymentDetail!.onwardBaseFare, widget.booking.paymentDetail!.currencySymbol)),
                        _buildRow("Tax", _formatCurrency(widget.booking.paymentDetail!.tax, widget.booking.paymentDetail!.currencySymbol)),
                        _buildRow("Meal Charges", _formatCurrency(widget.booking.paymentDetail!.mealPrice, widget.booking.paymentDetail!.currencySymbol)),
                        _buildRow("Seat Charges", _formatCurrency(widget.booking.paymentDetail!.seatPrice, widget.booking.paymentDetail!.currencySymbol)),
                        _buildRow("Customer Fare", _formatCurrency(widget.booking.paymentDetail!.amount, widget.booking.paymentDetail!.currencySymbol)),
                        _buildRow("Agent Fare", _formatCurrency(widget.booking.paymentDetail!.agentFare, widget.booking.paymentDetail!.currencySymbol)),
                        _buildRow("Agent Commission", _formatCurrency(widget.booking.paymentDetail!.agentMarkup, widget.booking.paymentDetail!.currencySymbol)),
                        _buildRow("Admin Fare", _formatCurrency(widget.booking.paymentDetail!.adminFare, widget.booking.paymentDetail!.currencySymbol)),
                      ],
                    ),
                  ),
                ],


              ],
            ),
          ),
        ),
        floatingActionButton: DownloadFAB(
          text: isDownloading ? "Downloading..." : "Download Ticket",
          isDisabled: isDownloading,
          onPressed: isDownloading
              ? null
              : () async {
            setState(() {
              isDownloading = true;
            });

            try {
              // Step 1: Download PDF
              final bytes = await _flightDownloadViewModel.downloadFlightTicket(
                bookingId: widget.booking.bookingId,
              );

              if (bytes == null) {
                Get.snackbar(
                  'Error',
                  'Failed to download ticket',
                  snackPosition: SnackPosition.TOP, // 👈 Snackbar at top
                );
                return;
              }

              // Step 2: Save to file
              final dir = await getTemporaryDirectory();
              final filePath =
                  '${dir.path}/FlightTicket_${DateTime.now().millisecondsSinceEpoch}.pdf';
              final file = File(filePath);
              await file.writeAsBytes(bytes);

              if (kDebugMode) print("PDF saved to: $filePath");

              // ✅ Show Snackbar with path
              Get.snackbar(
                'Download Complete',
                filePath,
                snackPosition: SnackPosition.TOP,
                duration: const Duration(seconds: 4),
                backgroundColor: constants.lightThemeColor1, // ✅ Set your desired background color
                colorText: Colors.white, // ✅ Optional: make text readable on dark bg
              );

              // Step 3: Open file
              await OpenFile.open(filePath);
            } catch (e) {
              if (kDebugMode) print("Download error: $e");
              Get.snackbar(
                'Error',
                'Something went wrong',
                snackPosition: SnackPosition.TOP,
              );
            } finally {
              setState(() {
                isDownloading = false;
              });
            }
          },
        ),

      ),

    );
  }

  Widget buildFlightTile({
    required String airlineName,
    required String fareClass,
    required String fromCode,
    required String fromTime,
    required String toCode,
    required String toTime,
    required String fromTerminal,
    required String toTerminal,
    required int duration,
    required String fromCity,
    required String toCity,
  }) {
    String _monthName(int month) {
      const months = ["", "Jan", "Feb", "Mar", "Apr", "May", "Jun",
        "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"];
      return months[month];
    }
    String formatFullDateTime(String? timeStr) {
      if (timeStr == null) return "N/A";
      final time = DateTime.tryParse(timeStr);
      if (time == null) return "N/A";
      return "${time.day.toString().padLeft(2, '0')} "
          "${_monthName(time.month)} "
          "${time.year}, "
          "${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}";
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("$airlineName – $fareClass", style: GoogleFonts.poppins(fontSize: 13)),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("$fromCode (${fromTerminal})", style: GoogleFonts.poppins(fontSize: 12)),
            Icon(Icons.flight_takeoff, size: 16, color: Colors.grey),
            Text("$toCode (${toTerminal})", style: GoogleFonts.poppins(fontSize: 12)),
          ],
        ),
        const SizedBox(height: 4),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(formatFullDateTime(fromTime), style: GoogleFonts.poppins(fontSize: 12)),
            Text(formatFullDateTime(toTime), style: GoogleFonts.poppins(fontSize: 12)),
          ],
        ),
        const SizedBox(height: 4),
        Text("Duration: ${duration} mins", style: GoogleFonts.poppins(fontSize: 12)),
        Text("$fromCity → $toCity", style: GoogleFonts.poppins(fontSize: 12)),
      ],
    );
  }

  Widget _buildRow(String key, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 4,
            child: Text(
              "$key:",
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w600,
                fontSize: 13,
              ),
            ),
          ),
          Expanded(
            flex: 6,
            child: Text(
              value,
              style: GoogleFonts.poppins(
                fontSize: 13,
                color: Colors.grey.shade700,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildLayover(String text) {
    return Center(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        decoration: BoxDecoration(
          color: Colors.orange.shade50,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          text,
          style: GoogleFonts.poppins(color: Colors.orange.shade900, fontSize: 12),
        ),
      ),
    );
  }
}
