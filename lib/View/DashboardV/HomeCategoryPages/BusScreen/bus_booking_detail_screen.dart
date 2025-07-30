import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../../../../Model/BusM/bus_booking_details_model.dart';
import '../../../../ViewM/BusVM/bus_booking_details_view_model.dart';
import '../../../../ViewM/BusVM/bus_cancel_view_model.dart';
import '../../../../constants.dart';
import '../../bottom_navigation_bar.dart';

class BusBookingDetailsScreen extends StatefulWidget {
  final String? traceId;
  final String? busId;

  const BusBookingDetailsScreen({
    super.key,
    required this.traceId,
    required this.busId,
  });

  @override
  State<BusBookingDetailsScreen> createState() => _BusBookingDetailsScreenState();
}

class _BusBookingDetailsScreenState extends State<BusBookingDetailsScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      final vm = Provider.of<BusBookingDetailsViewModel>(context, listen: false);
      vm.getBusBookingDetails(
        traceId: widget.traceId ?? "",
        busId: int.tryParse(widget.busId ?? '') ?? 0,
      );
    });
  }

  String _formatDate(DateTime? date) {
    if (date == null) return '--';
    return DateFormat('dd MMM yyyy').format(date);
  }

  String _formatTime(String? datetime) {
    if (datetime == null || datetime.isEmpty) return '--';
    final dt = DateTime.tryParse(datetime);
    return dt != null ? DateFormat('hh:mm a').format(dt) : '--';
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: Colors.blue.shade50,
        appBar: AppBar(
          backgroundColor: Colors.blue.shade50,
          elevation: 0,
          leading: const BackButton(color: Colors.black),
          title: const Text("", style: TextStyle(color: Colors.black)),
        ),
        body: Consumer<BusBookingDetailsViewModel>(
          builder: (context, vm, _) {
            if (vm.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (vm.error != null) {
              return Center(child: Text('Error: ${vm.error}'));
            }

            final itinerary = vm.bookingDetails?.data?.result?.itinerary;
            if (itinerary == null) {
              return const Center(child: Text('No booking data available.'));
            }

            final passengers = itinerary.passengers ?? [];
            final price = passengers.isNotEmpty ? passengers.first.seat?.price : null;

            return Padding(
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
                      "Amount Paid: ₹${price?.offeredPrice ?? '--'}",
                      style: const TextStyle(fontSize: 16, fontFamily: 'poppins'),
                    ),
                    Text(
                      "Ticket No: ${itinerary.ticketNo ?? '--'}",
                      style: const TextStyle(color: Colors.grey, fontFamily: 'poppins'),
                    ),
                    const SizedBox(height: 10),
                    _infoCard(itinerary),
                    const SizedBox(height: 10),
                    _boardingPointCard(itinerary.boardingPointdetails),
                    const SizedBox(height: 10),

                    // Show all passengers
                    Column(
                      children: passengers.map((p) => Column(
                        children: [
                          _passengerCard(p),
                          const SizedBox(height: 10),
                        ],
                      )).toList(),
                    ),

                    Row(
                      children: [
                        Expanded(
                          child: _actionButton("Cancel Ticket", () {
                            int busId = int.tryParse(widget.busId ?? "") ?? 0;
                            _showCancelDialog(context, busId);
                          }),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: _actionButton("Back to Home", () {
                            Navigator.popUntil(context, (route) => route.isFirst);
                          }),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "We have sent the invoice to:\n ${passengers.isNotEmpty ? passengers.first.email : '--'}",
                      style: const TextStyle(color: Colors.grey, fontFamily: 'poppins'),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _infoCard(Itinerary itinerary) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              itinerary.travelName ?? '',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, fontFamily: 'poppins'),
            ),
            const SizedBox(height: 4),
            Text(
              itinerary.busType ?? '',
              style: const TextStyle(fontSize: 14, color: Colors.grey, fontFamily: 'poppins'),
            ),
            const Divider(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("From", style: TextStyle(color: Colors.grey, fontFamily: 'poppins')),
                    Text(itinerary.origin ?? '--', style: const TextStyle(fontFamily: 'poppins')),
                    Text(
                      _formatDate(DateTime.tryParse(itinerary.departureTime)),
                      style: const TextStyle(fontSize: 12, fontFamily: 'poppins', fontWeight: FontWeight.bold),
                    ),
                    Text(_formatTime(itinerary.departureTime), style: const TextStyle(fontSize: 12, fontFamily: 'poppins')),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Text("To", style: TextStyle(color: Colors.grey, fontFamily: 'poppins')),
                    Text(itinerary.destination ?? '--', style: const TextStyle(fontFamily: 'poppins')),
                    Text(
                      _formatDate(DateTime.tryParse(itinerary.arrivalTime)),
                      style: const TextStyle(fontSize: 12, fontFamily: 'poppins', fontWeight: FontWeight.bold),
                    ),
                    Text(_formatTime(itinerary.arrivalTime), style: const TextStyle(fontSize: 12, fontFamily: 'poppins')),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _boardingPointCard(BoardingPointDetails? point) {
    if (point == null) return const SizedBox.shrink();

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Boarding Point Details",
              style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'poppins'),
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Point:", style: TextStyle(fontFamily: 'poppins')),
                Text(point.cityPointName, style: const TextStyle(fontFamily: 'poppins')),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Location:", style: TextStyle(fontFamily: 'poppins')),
                Flexible(
                  child: Text(point.cityPointLocation, textAlign: TextAlign.right, style: const TextStyle(fontFamily: 'poppins')),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Time:", style: TextStyle(fontFamily: 'poppins')),
                Text(
                  _formatTime(point.cityPointTime),
                  style: const TextStyle(fontFamily: 'poppins'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _actionButton(String text, VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: constants.themeColor1,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        padding: const EdgeInsets.symmetric(vertical: 14),
      ),
      child: Text(
        text,
        style: const TextStyle(
            fontFamily: 'poppins',
            color: Colors.white,
            fontSize: 12
        ),
      ),
    );
  }

  Widget _passengerCard(Passenger? p) {
    if (p == null) return const SizedBox.shrink();

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Passenger Details", style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'poppins')),
            const Divider(),
            Text("${p.firstName ?? ''} ${p.lastName ?? ''}", style: const TextStyle(fontFamily: 'poppins')),
            const SizedBox(height: 8),
            Text("Phone: ${p.phoneNo}", style: const TextStyle(fontFamily: 'poppins')),
            if (p.seat != null) ...[
              const SizedBox(height: 8),
              Text("Seat: ${p.seat!.seatName}", style: const TextStyle(fontFamily: 'poppins')),
            ]
          ],
        ),
      ),
    );
  }
}

  void _showCancelDialog(BuildContext context, int busId) {
    final remarksController = TextEditingController();

    Get.defaultDialog(
      title: "Cancel Ticket",
      titleStyle: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: constants.themeColor1,
        fontFamily: 'poppins',
      ),
      content: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Are you sure you want to cancel the ticket?",
              style: TextStyle(
                fontSize: 16,
                color: Colors.black87,
                fontFamily: 'poppins',
              ),
            ),
            const SizedBox(height: 18),
            const Text(
              "Enter Remarks",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
                fontFamily: 'poppins',
              ),
            ),
            const SizedBox(height: 8),
            SizedBox(
              height: 45,
              child: TextField(
                controller: remarksController,
                style: const TextStyle(fontSize: 14),
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  hintText: "Type your reason...",
                  hintStyle: const TextStyle(color: Colors.grey, fontFamily: 'poppins'),
                  border: const OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: constants.themeColor1),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      radius: 8,
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    Get.back();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey[300],
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    "No",
                    style: TextStyle(
                      fontFamily: 'poppins',
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: ElevatedButton(
                  onPressed: () async {
                    Get.back();
                    final viewModel = Provider.of<BusCancelViewModel>(context, listen: false);
                    await viewModel.cancelBus(busId, remarksController.text);

                    if (viewModel.cancelModel?.success == true) {
                      Get.snackbar(
                        "Success",
                        viewModel.cancelModel?.message ?? "Cancelled",
                        backgroundColor: Colors.green,
                        colorText: Colors.white,
                      );

                      // Navigate to BottomNavigationbar (replace all routes)
                      Get.offAll(() => const BottomNavigationbar());
                    } else {
                      Get.snackbar(
                        "Error",
                        viewModel.error ?? "Something went wrong",
                        backgroundColor: Colors.red,
                        colorText: Colors.white,
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: constants.themeColor1,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    "Yes",
                    style: TextStyle(
                      fontFamily: 'poppins',
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }




