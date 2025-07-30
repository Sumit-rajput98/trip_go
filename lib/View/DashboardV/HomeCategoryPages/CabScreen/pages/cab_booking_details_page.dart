import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:trip_go/constants.dart';

import '../../../../../Model/CabM/cab_booking_details_model.dart';
import '../../../../../ViewM/CabVM/cab_cancel_view_model.dart';
import '../../../bottom_navigation_bar.dart';
import 'cab_terms_and_condition_card.dart';

class CabBookingDetailPage extends StatelessWidget {
  final CabOrder booking;

  const CabBookingDetailPage({super.key, required this.booking});
  void showCabCancelDialog(BuildContext context, String orderNo) {
    final remarksController = TextEditingController();

    Get.defaultDialog(
      title: "Cancel Booking",
      titleStyle: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        fontFamily: 'poppins',
      ),
      content: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Are you sure you want to cancel the booking?",
              style: TextStyle(fontSize: 16, fontFamily: 'poppins'),
            ),
            const SizedBox(height: 18),
            const Text("Enter Reason", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, fontFamily: 'poppins')),
            const SizedBox(height: 8),
            TextField(
              controller: remarksController,
              decoration: const InputDecoration(
                hintText: "Type your reason...",
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              ),
            )
          ],
        ),
      ),
      radius: 8,
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: () => Get.back(),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.grey[300]),
                child: const Text("No", style: TextStyle(color: Colors.black, fontFamily: 'poppins')),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: ElevatedButton(
                onPressed: () async {
                  Get.back();
                  final viewModel = Provider.of<CabCancelViewModel>(context, listen: false);
                  await viewModel.cancelCab(orderNo, remarksController.text);

                  if (viewModel.cancelModel?.success == true) {
                    Get.snackbar("Success", viewModel.cancelModel?.message ?? "Cancelled", backgroundColor: Colors.green, colorText: Colors.white);
                    Get.offAll(() => const BottomNavigationbar());
                  } else {
                    Get.snackbar("Error", viewModel.error ?? "Something went wrong", backgroundColor: Colors.red, colorText: Colors.white);
                  }
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                child: const Text("Yes", style: TextStyle(color: Colors.white, fontFamily: 'poppins')),
              ),
            )
          ],
        )
      ],
    );
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
                  "Amount Due: ₹${booking.dueAmount}",
                  style: const TextStyle(fontSize: 16, fontFamily: 'poppins'),
                ),
                Text(
                  "Order No: ${booking.orderNo}",
                  style: const TextStyle(color: Colors.grey, fontFamily: 'poppins'),
                ),
                const SizedBox(height: 10),
                _infoCard(booking),
                const SizedBox(height: 10),
                _passengerCard(booking),
                const SizedBox(height: 10),
                TermsConditionsCard(htmlContent: booking.termsAndConditions),
                const SizedBox(height: 10),
                _actionButtons(context, booking),
                const SizedBox(height: 10),
                Text(
                  "We have sent the invoice to: \n ${booking.email}",
                  style: const TextStyle(color: Colors.grey, fontFamily: 'poppins'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _infoCard(CabOrder b) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              b.productName,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, fontFamily: 'poppins'),
            ),
            const Divider(height: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Pickup", style: TextStyle(color: Colors.grey, fontFamily: 'poppins')),
                    Text(b.pickup, style: const TextStyle(fontFamily: 'poppins')),
                    Text(b.startDate.split("T").first, style: const TextStyle(fontSize: 12, fontFamily: 'poppins')),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Drop", style: TextStyle(color: Colors.grey, fontFamily: 'poppins')),
                    Text(b.drop.isNotEmpty ? b.drop.first.drop : '--', style: const TextStyle(fontFamily: 'poppins')),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _dropCard(CabOrder b) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Trip Details", style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'poppins')),
            const Divider(),
            Text("Time: ${b.startDate}", style: const TextStyle(fontFamily: 'poppins')),
            const SizedBox(height: 6),
            // Text("Total Days: ${b.totalDays}", style: const TextStyle(fontFamily: 'poppins')),
            // const SizedBox(height: 6),
            // Text("Extra per KM: ₹${b.extraPerKm}", style: const TextStyle(fontFamily: 'poppins')),
          ],
        ),
      ),
    );
  }

  Widget _passengerCard(CabOrder b) {
    if (b == null) return const SizedBox.shrink();

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
            Text("${b.name ?? ''}", style: const TextStyle(fontFamily: 'poppins')),
            const SizedBox(height: 8),
            Text("Phone: ${b.phone}", style: const TextStyle(fontFamily: 'poppins')),
            // if (p.seat != null) ...[
            //   const SizedBox(height: 8),
            //   Text("Seat: ${b.status}", style: const TextStyle(fontFamily: 'poppins')),
            // ]
          ],
        ),
      ),
    );
  }

  Widget _actionButtons(BuildContext context, CabOrder b) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: () => showCabCancelDialog(context, b.orderNo),
            style: ElevatedButton.styleFrom(
              backgroundColor: constants.themeColor1,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              padding: const EdgeInsets.symmetric(vertical: 14),
            ),
            child: const Text("Cancel Booking", style: TextStyle(fontFamily: 'poppins', fontSize: 12, color: Colors.white)),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: ElevatedButton(
            onPressed: () => Navigator.popUntil(context, (route) => route.isFirst),
            style: ElevatedButton.styleFrom(
              backgroundColor: constants.themeColor1,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              padding: const EdgeInsets.symmetric(vertical: 14),
            ),
            child: const Text("Back to Home", style: TextStyle(fontFamily: 'poppins', fontSize: 12, color: Colors.white)),
          ),
        ),
      ],
    );
  }
}
