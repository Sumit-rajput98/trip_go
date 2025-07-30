import 'dart:io';
import 'package:open_file/open_file.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:trip_go/Model/FlightM/flight_booking_details.dart';
import 'package:trip_go/View/DashboardV/HomeCategoryPages/ticket_view.dart';
import 'package:trip_go/constants.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import '../../../../ViewM/CabVM/flight_ticket_download_view_model.dart';
import '../../../../ViewM/FlightVM/flight_booking_details_view_model.dart';

class BookingSuccessPage extends StatefulWidget {
  final bool? isInternational;
  final String? pnr;
  final String? traceId;
  final String? bookingId;
  final int? paymentPrice;

  const BookingSuccessPage({
    super.key,
    this.isInternational,
    required this.paymentPrice,
    required this.pnr,
    required this.traceId,
    required this.bookingId,
  });

  @override
  State<BookingSuccessPage> createState() => _BookingSuccessPageState();
}

class _BookingSuccessPageState extends State<BookingSuccessPage> {
  late final FlightBookingDetailsViewModel viewModel;
  late final FlightTicketDownloadViewModel _flightDownloadViewModel;
  @override
  void initState() {
    super.initState();
    print("@@@@@@@@@ ${widget.isInternational}");
    _flightDownloadViewModel = FlightTicketDownloadViewModel();
    viewModel = FlightBookingDetailsViewModel();
    fetchBookingDetails();
  }

  Future<void> fetchBookingDetails() async {
    await viewModel.loadBookingDetails(
      traceId: widget.traceId!,
      pnr: widget.pnr!,
      bookingId: widget.bookingId!,
    );
    setState(() {});
  }

  String _formatDateTime(DateTime? dateTime) {
    if (dateTime == null) return "N/A";
    return DateFormat('dd MMM yyyy, hh:mm a').format(dateTime);
  }

  String _formatDuration(int? minutes) {
    if (minutes == null) return "N/A";
    final hours = minutes ~/ 60;
    final remainingMinutes = minutes % 60;
    return '${hours}h ${remainingMinutes}min';
  }

  String _calculateTotalDuration(Segment? first, Segment? last) {
    if (first == null || last == null) return "N/A";

    final depTime = first.origin?.depTime;
    final arrTime = last.destination?.arrTime;

    if (depTime == null || arrTime == null) return "N/A";

    final totalMinutes = arrTime.difference(depTime).inMinutes;
    return _formatDuration(totalMinutes);
  }

  String _getGenderString(int? gender) {
    if (gender == 1) return 'M';
    if (gender == 2) return 'F';
    return '';
  }

  int _getAgeFromDOB(DateTime? dob) {
    if (dob == null) return 0;
    final today = DateTime.now();
    int age = today.year - dob.year;
    if (today.month < dob.month || (today.month == dob.month && today.day < dob.day)) {
      age--;
    }
    return age;
  }

  @override
  Widget build(BuildContext context) {
    print("@@@@@@@@@ ${widget.isInternational}");
    if (viewModel.isLoading) {
      return const Scaffold(
        backgroundColor: Colors.white,
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final itinerary = viewModel.bookingDetails!.data!.flightItinerary!;
    final passengers = itinerary.passenger ?? [];
    final segments = itinerary.segments ?? [];
    final onwardSegments = segments.where((s) => s.tripIndicator == 1).toList();
    final firstSegment = onwardSegments.isNotEmpty ? onwardSegments.first : null;
    final lastSegment = onwardSegments.isNotEmpty ? onwardSegments.last : null;

    final returnSegments = segments.where((s) => s.tripIndicator == 2).toList();
    final firstReturnSegment = returnSegments.isNotEmpty ? returnSegments.first : null;
    final lastReturnSegment = returnSegments.isNotEmpty ? returnSegments.last : null;

    return Scaffold(
      backgroundColor: Colors.blue.shade50,
      appBar: AppBar(
        title: const Text(''),
        backgroundColor: Colors.blue.shade50,
        elevation: 0,
        leading: const BackButton(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: const [
                  Icon(Icons.check_circle, color: Colors.green),
                  SizedBox(width: 8),
                  Text(
                    "Booking Successful",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'poppins',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                "Amount paid: ₹${widget.paymentPrice}",
                style: const TextStyle(fontSize: 16, fontFamily: 'poppins'),
              ),
              Text(
                "Booking ID: ${itinerary.bookingId}",
                style: const TextStyle(color: Colors.grey, fontFamily: 'poppins'),
              ),
              const SizedBox(height: 16),
              if (firstSegment != null && lastSegment != null)
                _flightInfoCard(firstSegment, lastSegment, itinerary),

              if (widget.isInternational == true)
              _flightInfoCard1(firstReturnSegment!, lastReturnSegment!, itinerary),
              const SizedBox(height: 20),
              _passengerInfo(passengers, firstSegment),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _actionButton("Book Return Ticket", () {}),
                  _actionButton("Download Ticket", () async {
                    final bytes = await _flightDownloadViewModel.downloadFlightTicket(
                      bookingId: itinerary.bookingId.toString(),
                    );

                    if (bytes != null) {
                      final dir = await getTemporaryDirectory();
                      final file = File('${dir.path}/FlightTicket_${DateTime.now().millisecondsSinceEpoch}.pdf');
                      await file.writeAsBytes(bytes);

                      if (kDebugMode) print("PDF saved to: ${file.path}");

                      await OpenFile.open(file.path);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Failed to download ticket')),
                      );
                    }
                  }),

                ],
              ),
              const SizedBox(height: 10),
              Text(
                "We have sent the ticket to:\n${passengers.isNotEmpty ? passengers[0].email : "N/A"}",
                style: const TextStyle(color: Colors.grey, fontFamily: 'poppins'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _flightInfoCard(Segment firstSegment, Segment lastSegment, FlightItinerary itinerary) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "${firstSegment.airline!.airlineName} (${firstSegment.airline!.flightNumber})",
              style: const TextStyle(fontWeight: FontWeight.bold, fontFamily: 'poppins'),
            ),
            Text(
              "Class: ${_getCabinClass(firstSegment.cabinClass)}",
              style: const TextStyle(color: Colors.grey, fontFamily: 'poppins'),
            ),
            const Divider(),

            // Origin
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _formatDateTime(firstSegment.origin!.depTime),
                      style: const TextStyle(color: Colors.grey, fontFamily: 'poppins', fontSize: 12),
                    ),
                    Text(
                      "Terminal: ${firstSegment.origin!.airport!.terminal}",
                      style: const TextStyle(
                          color: Colors.grey, fontFamily: 'poppins', fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const Text("Origin",
                          style: TextStyle(color: Colors.grey, fontFamily: 'poppins', fontSize: 12)),
                      Text(
                        "${firstSegment.origin!.airport!.airportCode} • ${firstSegment.origin!.airport!.airportName}",
                        style: const TextStyle(fontWeight: FontWeight.bold, fontFamily: 'poppins', fontSize: 12),
                        textAlign: TextAlign.right,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Destination
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _formatDateTime(lastSegment.destination!.arrTime),
                      style: const TextStyle(color: Colors.grey, fontFamily: 'poppins', fontSize: 12),
                    ),
                    Text(
                      "Terminal: ${lastSegment.destination!.airport!.terminal}",
                      style: const TextStyle(
                          color: Colors.grey, fontFamily: 'poppins', fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const Text("Destination",
                          style: TextStyle(color: Colors.grey, fontFamily: 'poppins', fontSize: 12)),
                      Text(
                        "${lastSegment.destination!.airport!.airportCode} • ${lastSegment.destination!.airport!.airportName}",
                        style: const TextStyle(fontWeight: FontWeight.bold, fontFamily: 'poppins', fontSize: 12),
                        textAlign: TextAlign.right,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            const Divider(),

            // Duration + PNR
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Duration: ${_calculateTotalDuration(firstSegment, lastSegment)}",
                      style: const TextStyle(color: Colors.grey, fontFamily: 'poppins'),
                    ),
                    Text(
                      "PNR: ${itinerary.pnr}",
                      style: const TextStyle(fontWeight: FontWeight.bold, fontFamily: 'poppins'),
                    ),
                  ],
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () {
                    Clipboard.setData(ClipboardData(text: itinerary.pnr!));
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("PNR copied to clipboard")),
                    );
                  },
                  child: const Icon(Icons.copy, size: 18),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _flightInfoCard1(Segment firstSegment, Segment lastSegment, FlightItinerary itinerary) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "${firstSegment.airline!.airlineName} (${firstSegment.airline!.flightNumber})",
              style: const TextStyle(fontWeight: FontWeight.bold, fontFamily: 'poppins'),
            ),
            Text(
              "Class: ${_getCabinClass(firstSegment.cabinClass)}",
              style: const TextStyle(color: Colors.grey, fontFamily: 'poppins'),
            ),
            const Divider(),

            // Origin
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _formatDateTime(firstSegment.origin!.depTime),
                      style: const TextStyle(color: Colors.grey, fontFamily: 'poppins', fontSize: 12),
                    ),
                    Text(
                      "Terminal: ${firstSegment.origin!.airport!.terminal}",
                      style: const TextStyle(
                          color: Colors.grey, fontFamily: 'poppins', fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const Text("Origin",
                          style: TextStyle(color: Colors.grey, fontFamily: 'poppins', fontSize: 12)),
                      Text(
                        "${firstSegment.origin!.airport!.airportCode} • ${firstSegment.origin!.airport!.airportName}",
                        style: const TextStyle(fontWeight: FontWeight.bold, fontFamily: 'poppins', fontSize: 12),
                        textAlign: TextAlign.right,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Destination
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _formatDateTime(lastSegment.destination!.arrTime),
                      style: const TextStyle(color: Colors.grey, fontFamily: 'poppins', fontSize: 12),
                    ),
                    Text(
                      "Terminal: ${lastSegment.destination!.airport!.terminal}",
                      style: const TextStyle(
                          color: Colors.grey, fontFamily: 'poppins', fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const Text("Destination",
                          style: TextStyle(color: Colors.grey, fontFamily: 'poppins', fontSize: 12)),
                      Text(
                        "${lastSegment.destination!.airport!.airportCode} • ${lastSegment.destination!.airport!.airportName}",
                        style: const TextStyle(fontWeight: FontWeight.bold, fontFamily: 'poppins', fontSize: 12),
                        textAlign: TextAlign.right,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            const Divider(),

            // Duration + PNR
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Duration: ${_calculateTotalDuration(firstSegment, lastSegment)}",
                      style: const TextStyle(color: Colors.grey, fontFamily: 'poppins'),
                    ),
                    Text(
                      "PNR: ${itinerary.pnr}",
                      style: const TextStyle(fontWeight: FontWeight.bold, fontFamily: 'poppins'),
                    ),
                  ],
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () {
                    Clipboard.setData(ClipboardData(text: itinerary.pnr!));
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("PNR copied to clipboard")),
                    );
                  },
                  child: const Icon(Icons.copy, size: 18),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _getCabinClass(int? cabinClass) {
    switch (cabinClass) {
      case 1:
        return "Economy";
      case 2:
        return "Premium Economy";
      case 3:
        return "Business";
      case 4:
        return "First Class";
      default:
        return "N/A";
    }
  }

  Widget _passengerInfo(List<Passenger> passengers, Segment? segment) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Text(
                  "Passenger details",
                  style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'poppins'),
                ),
                Spacer(),
                Icon(Icons.info_outline, size: 18),
              ],
            ),
            const Divider(),

            // Show all passengers
            for (final passenger in passengers)
              _passengerRow(
                "${passenger.title} ${passenger.firstName} ${passenger.lastName}",
                "Age: ${_getAgeFromDOB(passenger.dateOfBirth)} ${_getGenderString(passenger.gender)}",
              ),
          ],
        ),
      ),
    );
  }


  Widget _passengerRow(String name, String details) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(name,
                style: const TextStyle(fontFamily: 'poppins', fontSize: 12)),
          ),
          Text(details,
              style: const TextStyle(fontFamily: 'poppins', fontSize: 12)),
        ],
      ),
    );
  }

  Widget _actionButton(String text, VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: constants.themeColor1,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      child: Text(
        text,
        style: const TextStyle(fontFamily: 'poppins', color: Colors.white, fontSize: 12),
      ),
    );
  }
}
