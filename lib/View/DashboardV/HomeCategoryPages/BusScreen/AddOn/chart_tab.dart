import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../../../../Model/BusM/bus_seat_model.dart';
import '../../../../../Model/BusM/selected_seat_model.dart';
import '../../../../../constants.dart';
import '../BusScreen/bus_seat_provider.dart';

class ChartTab extends StatelessWidget {
  final SeatLayoutModel seatLayout;
  final String htmlLayout;

  const ChartTab({
    super.key,
    required this.seatLayout,
    required this.htmlLayout,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 8),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SeatIndicator(color: Colors.pinkAccent, label: "Ladies"),
              SeatIndicator(color: Colors.green, label: "Selected"),
              SeatIndicator(
                color: Colors.white,
                border: true,
                label: "Available",
              ),
              SeatIndicator(color: Colors.grey, label: "Booked"),
            ],
          ),
        ),
        const SizedBox(height: 10),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.grey.shade400, width: 1.5),
              ),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final seatColumns = seatLayout.seatDetails.length;
                  final seatWidth = 50.0 + 8.0;
                  final aisleAfter = seatColumns == 4 ? 1 : (seatColumns ~/ 2 - 1);
                  final aisleWidth = 32.0;
                  double iconLeft = 0;
                  for (int i = 0; i < seatColumns - 1; i++) {
                    iconLeft += seatWidth;
                    if (i == aisleAfter) iconLeft += aisleWidth;
                  }

                  return SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: SizedBox(
                              height: 50,
                              child: Row(
                                children: [
                                  SizedBox(width: iconLeft),
                                  Image.asset(
                                    'assets/images/steering-wheel.png',
                                    width: 50,
                                    height: 50,
                                    color: Colors.grey,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),
                          HtmlLayoutView(seatLayout: seatLayout),
                          const SizedBox(height: 16),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class HtmlLayoutView extends StatelessWidget {
  final SeatLayoutModel seatLayout;

  const HtmlLayoutView({super.key, required this.seatLayout});

  @override
  Widget build(BuildContext context) {
    final seatProvider = Provider.of<BusSeatProvider>(context);
    final seatRows = seatLayout.seatDetails;
    int aisleAfter = seatRows.length == 4 ? 1 : (seatRows.length ~/ 2 - 1);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (int col = 0; col < seatRows.length; col++) ...[
          if (col > 0 && col - 1 == aisleAfter)
            const SizedBox(width: 32),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              for (var seat in seatRows[col])
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6.0),
                  child: seat.seatType == 0
                      ? const SizedBox(width: 50, height: 50)
                      : _buildSeatWidget(seat, seatProvider),
                ),
            ],
          ),
        ],
      ],
    );
  }

  Widget _buildSeatWidget(SeatDetail seat, BusSeatProvider seatProvider) {
    final isBooked = !seat.seatStatus;
    final isSelected = seatProvider.isSelected(seat.seatName);

    Color bgColor = Colors.white;
    Color textColor = Colors.black;
    Border? border = Border.all(color: Colors.grey.shade400, width: 1.2);

    if (seat.isLadiesSeat) bgColor = Colors.pinkAccent;
    if (isBooked) {
      bgColor = Colors.grey;
      textColor = Colors.white;
    } else if (isSelected) {
      bgColor = Colors.green;
      textColor = Colors.white;
    }

    return GestureDetector(
      onTap: isBooked
          ? null
          : () {
              final selectedSeat = SelectedSeatModel(
                seatName: seat.seatName,
                seatIndex: seat.seatIndex.toString(),
                rowNo: seat.rowNo,
                columnNo: seat.columnNo,
                isLadiesSeat: seat.isLadiesSeat,
                isMalesSeat: seat.isMalesSeat,
                isUpper: seat.isUpper,
                seatType: seat.seatType,
                height: seat.height,
                width: seat.width,
                seatStatus: seat.seatStatus,
                price: seat.price,
              );
              seatProvider.toggleSeat(selectedSeat);
            },
      child: Container(
        width: 50,
        height: 50,
        margin: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(8),
          border: border,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 2,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        alignment: Alignment.center,
        child: Text(
          '₹${seat.price.basePrice.toStringAsFixed(0)}',
          style: GoogleFonts.poppins(
            color: textColor,
            fontSize: 13,
            fontWeight: FontWeight.w500,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

class SeatIndicator extends StatelessWidget {
  final Color color;
  final String label;
  final bool border;
  const SeatIndicator({
    super.key,
    required this.color,
    required this.label,
    this.border = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 16,
          height: 16,
          decoration: BoxDecoration(
            color: color,
            border: border ? Border.all(color: Colors.black26) : null,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        const SizedBox(width: 4),
        Text(label, style: GoogleFonts.poppins(fontSize: 12)),
      ],
    );
  }
}