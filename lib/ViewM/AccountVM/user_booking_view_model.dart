import 'package:flutter/material.dart';
import '../../AppManager/Api/api_service/AccountService/user_booking_details_service.dart';
import '../../Model/AccountM/user_booking_model.dart';


class UserBookingViewModel extends ChangeNotifier {
  final UserBookingDetailsService _service = UserBookingDetailsService();

  UserBookingModel? _bookingModel;
  bool _isLoading = false;
  String? _error;

  UserBookingModel? get bookingModel => _bookingModel;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> fetchUserBookingDetails({
    required String countryCode,
    required String phoneNumber,
  }) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final response = await _service.getUserBookingDetails(
        countryCode: countryCode,
        phoneNumber: phoneNumber,
      );
      _bookingModel = UserBookingModel.fromJson(response);
    } catch (e) {
      _error = "Failed to load booking details";
      debugPrint("Error: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:trip_go/constants.dart';
// import '../../ViewM/AccountVM/user_booking_view_model.dart';y
//
// class MyBookingsScreen extends StatefulWidget {
//   const MyBookingsScreen({super.key});
//
//   @override
//   _MyBookingsScreenState createState() => _MyBookingsScreenState();
// }
//
// class _MyBookingsScreenState extends State<MyBookingsScreen> {
//   int selectedCategoryIndex = 0; // Flights
//   int selectedStatusIndex = 0;   // Upcoming
//
//   final ScrollController _statusScrollController = ScrollController();
//
//   final List<String> bookingCategories = [
//     'Flights', 'Hotels', 'Tours', 'Buses', 'Cabs', 'Visa', 'Activities', 'Forex'
//   ];
//
//   final List<String> bookingIcons = [
//     'assets/icons/flight.png',
//     'assets/icons/hotel.png',
//     'assets/icons/holiday.png',
//     'assets/icons/bu.png',
//     'assets/icons/cab.png',
//     'assets/icons/visa.png',
//     'assets/icons/insurance.png',
//     'assets/icons/forex.png',
//   ];
//
//   final List<String> statusTabs = [
//     'Upcoming', 'Cancelled', 'Completed', 'Unsuccessful'
//   ];
//
//   @override
//   void initState() {
//     super.initState();
//     Future.microtask(() {
//       Provider.of<UserBookingViewModel>(context, listen: false)
//           .fetchUserBookingDetails(
//         countryCode: "91",
//         phoneNumber: "9310167293",
//       );
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final viewModel = Provider.of<UserBookingViewModel>(context);
//
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//         toolbarHeight: 40.0,
//         centerTitle: false,
//         titleSpacing: 0,
//         leading: IconButton(
//           icon: Icon(Icons.arrow_circle_left_outlined, size: 30),
//           padding: EdgeInsets.zero,
//           constraints: BoxConstraints(),
//           onPressed: () => Navigator.pop(context),
//         ),
//         title: Text(
//           'My Bookings',
//           style: TextStyle(
//             fontSize: 16.0,
//             fontFamily: 'poppins',
//             fontWeight: FontWeight.w500,
//             color: Colors.black,
//           ),
//         ),
//       ),
//       body: Column(
//         children: [
//           // STATUS TABS
//           SingleChildScrollView(
//             controller: _statusScrollController,
//             scrollDirection: Axis.horizontal,
//             child: Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 10),
//               child: Container(
//                 padding: EdgeInsets.symmetric(vertical: 8),
//                 color: Colors.white,
//                 child: Row(
//                   children: List.generate(statusTabs.length, (index) {
//                     bool isSelected = selectedStatusIndex == index;
//                     return GestureDetector(
//                       onTap: () {
//                         setState(() {
//                           selectedStatusIndex = index;
//                         });
//                       },
//                       child: Container(
//                         margin: EdgeInsets.only(right: 10),
//                         padding: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
//                         decoration: BoxDecoration(
//                           color: isSelected
//                               ? constants.ultraLightThemeColor1
//                               : Colors.white,
//                           borderRadius: BorderRadius.circular(20),
//                           border: Border.all(
//                             color: isSelected
//                                 ? constants.themeColor1
//                                 : Colors.grey.shade300,
//                             width: 1,
//                           ),
//                         ),
//                         child: Text(
//                           statusTabs[index],
//                           style: TextStyle(
//                             fontSize: 13,
//                             fontFamily: 'poppins',
//                             fontWeight: FontWeight.w500,
//                             color: isSelected ? Colors.deepPurple : Colors.black,
//                           ),
//                         ),
//                       ),
//                     );
//                   }),
//                 ),
//               ),
//             ),
//           ),
//
//           // CONTENT AREA
//           Expanded(
//             child: Builder(
//               builder: (_) {
//                 if (viewModel.isLoading) {
//                   return Center(child: CircularProgressIndicator());
//                 }
//
//                 if (viewModel.error != null) {
//                   return Center(child: Text(viewModel.error!));
//                 }
//
//                 final bookings = viewModel.bookingModel?.data ?? [];
//
//                 if (selectedCategoryIndex == 0) {
//                   // Flights only
//                   final filteredBookings = bookings.where((booking) {
//                     switch (selectedStatusIndex) {
//                       case 0: return booking.status == 2; // Upcoming
//                       case 1: return booking.status == 0; // Cancelled
//                       case 2: return booking.status == 1; // Completed
//                       default: return true;
//                     }
//                   }).toList();
//
//                   return ListView.builder(
//                     itemCount: filteredBookings.length,
//                     itemBuilder: (context, index) {
//                       final booking = filteredBookings[index];
//                       return ListTile(
//                         leading: Icon(Icons.flight),
//                         title: Text('${booking.depart} → ${booking.arrival}'),
//                         subtitle: Text('Booking ID: ${booking.bookingId}'),
//                         trailing: Text(booking.depart ?? ''),
//                       );
//                     },
//                   );
//                 }
//
//                 return Center(
//                   child: Text(
//                     '${statusTabs[selectedStatusIndex]} ${bookingCategories[selectedCategoryIndex]} Bookings',
//                     style: TextStyle(
//                       fontSize: 18,
//                       fontFamily: 'poppins',
//                       fontWeight: FontWeight.w600,
//                       color: Colors.black87,
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
