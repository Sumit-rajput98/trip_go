import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:trip_go/View/DashboardV/HomeCategoryPages/ticket_view.dart';
import 'package:trip_go/constants.dart';
import 'package:intl/intl.dart';
import '../../../../ViewM/FlightVM/flight_booking_details_view_model.dart';

class BookingSuccessPage extends StatefulWidget {
  final String? pnr;
  final String? traceId;
  final String? bookingId;
  final int? paymentPrice;

  const BookingSuccessPage({super.key,required this.paymentPrice, required this.pnr, required this.traceId, required this.bookingId});

  @override
  State<BookingSuccessPage> createState() => _BookingSuccessPageState();
}

class _BookingSuccessPageState extends State<BookingSuccessPage> {
  late final FlightBookingDetailsViewModel viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = FlightBookingDetailsViewModel();
    fetchBookingDetails();
  }

  Future<void> fetchBookingDetails() async {
    await viewModel.loadBookingDetails(
      traceId: widget.traceId ?? "",
      pnr: widget.pnr ?? "",
      bookingId: widget.bookingId ?? "",
    );
    setState(() {}); // Trigger rebuild after data is loaded
  }


  @override
  Widget build(BuildContext context) {
    final bookingDetails = viewModel.bookingDetails;
    final itinerary = bookingDetails?.data.itinerary;
    final fare = itinerary?.fare;
    final passengers = itinerary?.passengers ?? [];
    return Scaffold(
      backgroundColor: Colors.blue.shade50,
      appBar: AppBar(
        title: Text(''),
        backgroundColor: Colors.blue.shade50,
        elevation: 0,
        leading: BackButton(color: Colors.black),
      ),
      body: viewModel.isLoading
          ? Center(child: CircularProgressIndicator())
          : viewModel.errorMessage != null
          ? Center(child: Text('Error: ${viewModel.errorMessage}'))
          : Padding(
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
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, fontFamily: 'poppins'),
                  ),
                ],
              ),
              SizedBox(height: 8),
              // Text("Amount paid: ${fare?.publishedFare}", style: TextStyle(fontSize: 16, fontFamily: 'poppins')),
              Text("Amount paid: ${widget.paymentPrice}", style: TextStyle(fontSize: 16, fontFamily: 'poppins')),
              Text("Booking ID: ${itinerary?.bookingId}", style: TextStyle(color: Colors.grey, fontFamily: 'poppins')),
              SizedBox(height: 16),
              _trainInfoCard(),
              SizedBox(height: 20),
              _passengerInfo(),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _actionButton("Book Return Ticket", (){}),
                  _actionButton("Download Ticket", (){
                    final bookingDetails = viewModel.bookingDetails;
                    final itinerary = bookingDetails?.data.itinerary;
                    final passengers = itinerary?.passengers ?? [];
                    final segments = itinerary?.segments ?? [];
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> TicketPage(
                      itinerary: itinerary,
                      passengers: passengers,
                      segments: segments,
                    )));
                  }),
                ],
              ),
              SizedBox(height: 10),
              Text("We have sent the ticket to:\n${passengers[0].email}", style: TextStyle(color: Colors.grey, fontFamily: 'poppins')),
              // TextButton(onPressed: () {}, child: Text("Resend", style: TextStyle(color: Colors.grey, fontFamily: 'poppins')), ),
              // SizedBox(height: 20),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceAround,
              //   children: [
              //     _footerAction(CupertinoIcons.train_style_one, "View train route"),
              //     _footerAction(Icons.cancel, "Cancel booking"),
              //   ],
              // ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _trainInfoCard() {
    String _formatDateTime(String rawDateTime) {
      try {
        final dateTime = DateTime.parse(rawDateTime);
        final formatter = DateFormat('dd MMM yyyy, hh:mm a');
        return formatter.format(dateTime);
      } catch (e) {
        return rawDateTime;
      }
    }

    final bookingDetails = viewModel.bookingDetails;
    final itinerary = bookingDetails?.data.itinerary;
    final fare = itinerary?.fare;
    final passengers = itinerary?.passengers ?? [];
    final segments = itinerary?.segments ?? [];

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "${segments[0].airlineName} (${segments[0].flightNumber})",
              style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'poppins'),
            ),
            Text(
              "Second sitting - General",
              style: TextStyle(color: Colors.grey, fontFamily: 'poppins'),
            ),
            Divider(),

            /// Boarding row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    Text(
                      _formatDateTime(segments[0].depTime),
                      style: const TextStyle(color: Colors.grey, fontFamily: 'poppins', fontSize: 12),
                    ),
                    Text(
                      "Terminal : ${segments[0].originTerminal}",
                      style: const TextStyle(color: Colors.grey, fontFamily: 'poppins', fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text("Origin", style: TextStyle(color: Colors.grey, fontFamily: 'poppins', fontSize: 12)),
                      Text(
                        "${segments[0].originAirportCode} • ${segments[0].originAirportName}",
                        style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'poppins', fontSize: 12),
                        softWrap: true,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.right,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),

            /// Drop-off row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    Text(
                      _formatDateTime(segments[0].arrTime),
                      style: const TextStyle(color: Colors.grey, fontFamily: 'poppins', fontSize: 12),
                    ),
                    Text(
                      "Terminal : ${segments[0].destinationTerminal}",
                      style: const TextStyle(color: Colors.grey, fontFamily: 'poppins', fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text("Destination", style: TextStyle(color: Colors.grey, fontFamily: 'poppins', fontSize: 12)),
                      Text(
                        "${segments[0].destinationAirportCode} • ${segments[0].destinationAirportName}",
                        style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'poppins', fontSize: 12),
                        softWrap: true,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.right,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Divider(),

            /// Duration + PNR
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Duration 1h 45min", style: TextStyle(color: Colors.grey, fontFamily: 'poppins')),
                    Text("PNR: ${itinerary?.pnr}", style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'poppins')),
                  ],
                ),
                Spacer(),
                Icon(Icons.copy, size: 18),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _passengerInfo() {
    final bookingDetails = viewModel.bookingDetails;
    final itinerary = bookingDetails?.data.itinerary;
    final passengers = itinerary?.passengers ?? [];
    final segments =itinerary?.segments ?? [];

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: const [
                Text("Passenger details", style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'poppins')),
                Spacer(),
                Icon(Icons.info_outline, size: 18),
              ],
            ),
            const Divider(),
            // Display first two passengers (if they exist)
            for (int i = 0; i < passengers.length && i < 2; i++)
              _passengerRow(
                "${passengers[i].firstName} ${passengers[i].lastName} (${_getAgeFromDOB(passengers[i].dateOfBirth)} ${_getGenderString(passengers[i].gender)})",
                "${passengers[i].paxId}", // Replace with seat if you have seat info
                segments.isNotEmpty ? segments[0].flightStatus : "No status", // Replace with actual status if available
              ),
            if (passengers.length > 2)
              Text("+${passengers.length - 2} more", style: const TextStyle(color: Colors.blue, fontFamily: 'poppins')),
          ],
        ),
      ),
    );
  }

// Helper function to calculate age from date of birth
  int _getAgeFromDOB(String dob) {
    final birthDate = DateTime.tryParse(dob);
    if (birthDate == null) return 0;
    final today = DateTime.now();
    int age = today.year - birthDate.year;
    if (today.month < birthDate.month || (today.month == birthDate.month && today.day < birthDate.day)) {
      age--;
    }
    return age;
  }

// Helper function to convert gender int to string
  String _getGenderString(int gender) {
    // Assuming 1 = Male, 2 = Female (adjust if your API uses different codes)
    if (gender == 1) return 'M';
    if (gender == 2) return 'F';
    return '';
  }

// Example of _passengerRow widget
  Widget _passengerRow(String name, String seat, String status) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(child: Text(name, style: const TextStyle(fontFamily: 'poppins', fontSize: 12))),
          Text(seat, style: const TextStyle(fontFamily: 'poppins', fontSize: 12)),
          SizedBox(width: 2,),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            decoration: BoxDecoration(
                color: Colors.green.shade100,
                borderRadius: BorderRadius.circular(10)),
            child: Text(status, style: TextStyle(color: Colors.green, fontFamily: 'poppins', fontSize: 12)),
          ),
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
        style: TextStyle(fontFamily: 'poppins', color: Colors.white),
      ),
    );
  }

  // Widget _footerAction(IconData icon, String label) {
  //   return Column(
  //     children: [
  //       Icon(icon, color: constants.themeColor1),
  //       SizedBox(height: 4),
  //       Text(label, style: TextStyle(fontSize: 12, fontFamily: 'poppins')),
  //     ],
  //   );
  // }
}