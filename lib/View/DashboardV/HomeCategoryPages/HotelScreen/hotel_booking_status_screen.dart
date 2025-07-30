import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:trip_go/View/DashboardV/HomeCategoryPages/FlightScreen/common_widget/bottom_sgeets.dart';
import 'package:trip_go/View/DashboardV/HomeCategoryPages/HotelScreen/BookingDetails/hotel_booking_details_view.dart';
import 'package:trip_go/ViewM/HotelVM/hotel_book_view_model.dart';

import '../../../Widgets/gradient_button.dart';
import '../../bottom_navigation_bar.dart';

class HotelBookingStatusScreen extends StatefulWidget {
  final dynamic request;

  const HotelBookingStatusScreen({super.key, required this.request});

  @override
  State<HotelBookingStatusScreen> createState() => _HotelBookingStatusScreenState();
}

class _HotelBookingStatusScreenState extends State<HotelBookingStatusScreen> {
  late HotelBookViewModel vm;

  @override
  void initState() {
    super.initState();
    vm = context.read<HotelBookViewModel>();

    // Trigger the booking API when the screen is initialized
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   vm.bookHotel(widget.request);
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Consumer<HotelBookViewModel>(
          builder: (_, vm, __) {
            switch (vm.state) {
              case BookingState.loading:
                return const CircularProgressIndicator();

              case BookingState.success:
                return _AnimatedResult(
                  lottiePath: 'assets/animation/Success.json',
                  title: 'Booking Successful',
                  subtitle:
                      'Invoice #: ${vm.response?.data?.bookResult?.invoiceNumber ?? '-'}',
                      vm:vm
                );

              case BookingState.failure:
                return _AnimatedResult(
                  lottiePath: 'assets/animation/failed.json', // optional, safe fallback handled
                  title: 'Booking Failed',
                  subtitle: vm.error ?? 'Please try again later',
                );

              default:
                return const SizedBox.shrink();
            }
          },
        ),
      ),
    );
  }
}


class _AnimatedResult extends StatelessWidget {
  final String? lottiePath; // Nullable now
  final String title;
  final String subtitle;
  final HotelBookViewModel? vm;

  const _AnimatedResult({
    this.lottiePath,
    required this.title,
    required this.subtitle,  this.vm,
  });

  Future<bool> _assetExists(String path) async {
    try {
      await rootBundle.load(path);
      return true;
    } catch (_) {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return FutureBuilder<bool>(
      future: lottiePath != null ? _assetExists(lottiePath!) : Future.value(false),
      builder: (context, snapshot) {
        final showLottie = snapshot.data == true;

        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (showLottie)
              Lottie.asset(lottiePath!, width: 200, repeat: false),
            if (!showLottie)
              const Icon(Icons.info_outline, color: Colors.red, size: 80),

            const SizedBox(height: 24),
            Text(title, style: textTheme.headlineSmall),
            const SizedBox(height: 8),
            Text(
              subtitle,
              style: textTheme.bodyMedium?.copyWith(color: Colors.grey[600]),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: GradientButton(
                label: 'Done',
                onPressed: () => Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => HotelBookingDetailsView(request: {
                  "BookingId": vm?.response?.data?.bookResult?.bookingId ?? "_"
              },)),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

