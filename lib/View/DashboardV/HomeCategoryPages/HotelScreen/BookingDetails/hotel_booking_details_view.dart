import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:trip_go/Model/HotelM/hotel_bokking_detail_model.dart';
import 'package:trip_go/ViewM/HotelVM/hotel_booking_details_view_model.dart';
import 'package:trip_go/constants.dart';

import '../../../../../ViewM/BusVM/hotel_cancel_view_model.dart';
import '../../../bottom_navigation_bar.dart';

class HotelBookingDetailsView extends StatefulWidget {
  final dynamic request;
  const HotelBookingDetailsView({super.key, required this.request});

  @override
  State<HotelBookingDetailsView> createState() => _HotelBookingDetailsViewState();
}

class _HotelBookingDetailsViewState extends State<HotelBookingDetailsView> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<HotelBookingDetailViewModel>().fetchBookingDetail(widget.request);
    });
  }

  String _formatDate(DateTime? date) {
    if (date == null) return '--';
    return DateFormat('dd MMM yyyy').format(date);
  }

  String _calculateDuration(DateTime? checkIn, DateTime? checkOut) {
    if (checkIn == null || checkOut == null) return '--';
    final nights = checkOut.difference(checkIn).inDays;
    return '$nights ${nights == 1 ? 'night' : 'nights'}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade50,
      appBar: AppBar(
        backgroundColor: Colors.blue.shade50,
        elevation: 0,
        leading: const BackButton(color: Colors.black),
      ),
      body: Consumer<HotelBookingDetailViewModel>(
        builder: (context, vm, _) {
          if (vm.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (vm.error != null) {
            return Center(child: Text('Error: ${vm.error}'));
          }

          final data = vm.bookingDetail?.data?.getBookingDetailResult;
          if (data == null) {
            return const Center(child: Text('No booking data available.'));
          }

          final room = data.hotelRoomsDetails?.first;
          final amount = room?.price?.offeredPriceRoundedOff?.toString() ?? '--';
          final email = room?.hotelPassenger?.first.email ?? "booking@tripgo.in";

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
                    "Amount paid: ₹$amount",
                    style: const TextStyle(fontSize: 16, fontFamily: 'poppins'),
                  ),
                  Text(
                    "Booking Ref No: ${data.bookingRefNo ?? '--'}",
                    style: const TextStyle(color: Colors.grey, fontFamily: 'poppins'),
                  ),
                  const SizedBox(height: 16),
                  _hotelInfoCard(data),
                  const SizedBox(height: 16),
                  _roomDetailsCard(room),
                  const SizedBox(height: 20),
                  _guestInfoCard(room?.hotelPassenger ?? []),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: _actionButton("Cancel Booking", () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Download triggered")),
                          );
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
                    "We have sent the invoice to:\n$email",
                    style: const TextStyle(color: Colors.grey, fontFamily: 'poppins'),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _hotelInfoCard(GetBookingDetailResult data) {
    final nights = _calculateDuration(data.checkInDate, data.checkOutDate);
    
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    data.hotelName ?? '--',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: 'poppins',
                      fontSize: 16,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.visible,
                    softWrap: true,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  '${data.starRating ?? '-'} ★',
                  style: const TextStyle(
                    color: Colors.green,
                    fontFamily: 'poppins',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            // Text(
            //   '${data.city ?? '--'} | ${data.starRating ?? '-'} ★',
            //   style: const TextStyle(color: Colors.grey, fontFamily: 'poppins'),
            // ),
            Text(
              '${data.addressLine1 ?? '--'}',
              style: const TextStyle(color: Colors.grey, fontFamily: 'poppins'),
            ),
            const Divider(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Check-in",
                      style: TextStyle(color: Colors.grey, fontFamily: 'poppins', fontSize: 12),
                    ),
                    Text(
                      _formatDate(data.checkInDate),
                      style: const TextStyle(fontWeight: FontWeight.bold, fontFamily: 'poppins', fontSize: 12),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Text(
                      "Check-out",
                      style: TextStyle(color: Colors.grey, fontFamily: 'poppins', fontSize: 12),
                    ),
                    Text(
                      _formatDate(data.checkOutDate),
                      style: const TextStyle(fontWeight: FontWeight.bold, fontFamily: 'poppins', fontSize: 12),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Divider(),
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Duration: $nights",
                      style: const TextStyle(color: Colors.grey, fontFamily: 'poppins'),
                    ),
                    Text(
                      "Booking Ref No: ${data.bookingRefNo ?? '--'}",
                      style: const TextStyle(fontWeight: FontWeight.bold, fontFamily: 'poppins'),
                    ),
                  ],
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () {
                    if (data.bookingRefNo != null) {
                      Clipboard.setData(ClipboardData(text: data.bookingRefNo!));
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Booking Ref No copied")),
                      );
                    }
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

  Widget _roomDetailsCard(HotelRoomsDetail? room) {
    if (room == null) return const SizedBox.shrink();

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Room Information",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontFamily: 'poppins',
                fontSize: 14,
              ),
            ),
            const Divider(),
            _roomInfoRow("Room Type", room.roomTypeName),
            const SizedBox(height: 6),
            _roomInfoRow("Travellers",
                '${room.adultCount ?? 0} Adult${(room.adultCount ?? 0) > 1 ? "s" : ""}, '
                    '${room.childCount ?? 0} Child${(room.childCount ?? 0) > 1 ? "ren" : ""}'
            ),
            const SizedBox(height: 6),
            if (room.amenities != null && room.amenities!.isNotEmpty)
              _roomInfoRow("Amenities", room.amenities!.join(', ')),
          ],
        ),
      ),
    );
  }

  Widget _roomInfoRow(String key, String? value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "$key:",
          style: const TextStyle(
            fontFamily: 'poppins',
            fontSize: 13,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            value ?? '--',
            textAlign: TextAlign.right,
            style: const TextStyle(
              fontFamily: 'poppins',
              fontSize: 13,
            ),
          ),
        ),
      ],
    );
  }

  Widget _guestInfoCard(List<HotelPassenger> passengers) {
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
                  "Guest Details",
                  style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'poppins'),
                ),
                Spacer(),
                Icon(Icons.info_outline, size: 18),
              ],
            ),
            const Divider(),
            ...passengers.map((g) => _guestRow(
              "${g.title ?? ''} ${g.firstName ?? ''} ${g.lastName ?? ''}",
              // "Age: ${g.age ?? '-'} | ${g.paxType == 1 ? 'Adult' : 'Child'}",
              "${g.paxType == 1 ? 'Adult' : 'Child'}",
            )),
          ],
        ),
      ),
    );
  }

  Widget _guestRow(String name, String details) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              name,
              style: const TextStyle(fontFamily: 'poppins', fontSize: 12),
            ),
          ),
          Text(
            details,
            style: const TextStyle(fontFamily: 'poppins', fontSize: 12),
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

  void _showCancelDialog(BuildContext context, int bookingId) {
    final remarksController = TextEditingController();

    Get.defaultDialog(
      title: "Cancel Hotel Booking",
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
              "Are you sure you want to cancel the Hotel Booking?",
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

                    final viewModel = Provider.of<HotelCancelViewModel>(context, listen: false);
                    await viewModel.cancelHotel({
                      "BookingId": bookingId,
                      "Remarks": remarksController.text,
                    });

                    if (viewModel.cancelModel?.success == true) {
                      Get.snackbar(
                        "Success",
                        viewModel.cancelModel?.message ?? "Hotel booking cancelled",
                        backgroundColor: Colors.green,
                        colorText: Colors.white,
                      );
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

}

