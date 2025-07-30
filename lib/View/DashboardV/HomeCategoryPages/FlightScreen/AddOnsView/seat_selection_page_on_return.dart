import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../../../../Model/FlightM/flight_SSR_round_model.dart';
import '../../../../../ViewM/FlightVM/seat_selection_provider_round.dart';

class SeatSelectionPageOnReturn extends StatefulWidget {
  Map<String, dynamic>? fare;
  final Data1? flightSsrRes;
  final int? adultCount;
  final int? childrenCount;
  final int? infantsCount;
  final bool isReturn;
  SeatSelectionPageOnReturn({super.key, this.flightSsrRes, this.adultCount, this.childrenCount, this.infantsCount, this.fare, required this.isReturn});

  @override
  State<SeatSelectionPageOnReturn> createState() => _SeatSelectionPageOnReturnState();
}

class _SeatSelectionPageOnReturnState extends State<SeatSelectionPageOnReturn> {
  List<String> selectedSeats = [];
  List<Seat> selectedSeatDetails = [];
  bool isDetailExpanded = false;
  late Map<String, Seat> apiSeatMap;
  late int maxRow;
  final List<String> columns = ['A', 'B', 'C', 'D', 'E', 'F'];

  @override
  void initState() {
    super.initState();
    if (widget.fare != null) {
      final baggageList = widget.fare!['Baggage'] as List<dynamic>?;

      if (baggageList != null && baggageList.isNotEmpty) {
        final firstBaggage = Baggage.fromJson(baggageList[0]);
        print('FlightNumber: ${firstBaggage.flightNumber}');
      } else {
        print('No Baggage data found in fare');
      }
    } else {
      print('widget.fare is null');
    }
    processApiData();
  }

  void processApiData() {
    apiSeatMap = {};
    maxRow = 0;

    for (final seatDynamic in widget.flightSsrRes?.seatDynamic ?? []) {
      for (final segmentSeat in seatDynamic.segmentSeat) {
        for (final rowSeat in segmentSeat.rowSeats) {
          for (final seat in rowSeat.seats) {
            if (seat.availablityType == 0 || seat.availablityType == 5) {
              continue; // Skip hidden seats
            }

            apiSeatMap[seat.code] = seat;

            final rowNumber = int.tryParse(seat.rowNo) ?? 0;
            if (rowNumber > maxRow) maxRow = rowNumber;
          }
        }
      }
    }
  }

  String getSeatType(Seat seat) {
    if (seat.availablityType == 3) return 'R';
    if (seat.availablityType == 4) return 'B';
    if (seat.availablityType != 1) return 'X';

    if (seat.price! >= 2000) return 'XL';
    if (seat.price! >= 1000) return 'P';
    return 'P';
  }

  // Updated seat color mapping
  Color getSeatColor(String type, Seat seat) {
    switch (type) {
      case 'R': // Reserved
        return Colors.red.shade400;
      case 'B': // Blocked
        return Colors.grey.shade400;
      case 'X': // Other unavailable
        return Colors.grey.shade300;
      case 'XL':
        return Colors.orange.shade300;
      case 'P':
        return Colors.pink.shade200;
      default:
        return seat.availablityType == 1 ? Colors.green : Colors.grey;
    }
  }

  // Updated seat price getter
  double getSeatPrice(String? seatId) {
    return seatId != null ? (apiSeatMap[seatId]?.price ?? 0).toDouble() : 0;
  }

  Widget seatLegendItem(String label, Color color, double seatSize) {
    return Row(
      children: [
        Container(
          width: seatSize * 0.8,
          height: seatSize * 0.8,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        SizedBox(width: seatSize * 0.3),
        Text(label, style: GoogleFonts.poppins(fontSize: seatSize * 0.4)),
      ],
    );
  }

  final int rowCount = 30;

  // Update seatBox widget
  Widget seatBox(String seatId, double seatSize) {
    final seatProvider = Provider.of<SeatSelectionProviderRound>(context, listen: false);
    final seat = apiSeatMap[seatId];
    if (seat == null) return SizedBox(width: seatSize, height: seatSize);

    final type = getSeatType(seat);
    final isSelected = selectedSeats.contains(seatId);
    final isAvailable = seat.availablityType == 1;

    return GestureDetector(
      onTap: isAvailable
          ? () {
        setState(() {
          if (isSelected) {
            // Remove seat locally
            selectedSeats.remove(seatId);
            selectedSeatDetails.removeWhere((seat) => seat.code == seatId);

            // Remove from Provider
            seatProvider.removeSeat(seatId, isReturn: widget.isReturn);

            // Print total price after removal
            print('Total Seat Price after removal: ₹${seatProvider.totalPrice}');
          } else if (selectedSeats.length < (widget.adultCount ?? 0) + (widget.childrenCount ?? 0)) {
            selectedSeats.add(seatId);
            final seat = apiSeatMap[seatId];
            if (seat != null) {
              selectedSeatDetails.add(seat);

              // Add to Provider
              seatProvider.addSeat(seat, isReturn: widget.isReturn);

              // Print total price after addition
              print('Total Seat Price after addition: ₹${seatProvider.totalPrice}');
            }

            print('Selected Seats: ${selectedSeats.join(", ")}');
            for (var seat in selectedSeatDetails) {
              final seatJson = jsonEncode({
                "AirlineCode": seat.airlineCode,
                "FlightNumber": seat.flightNumber,
                "CraftType": seat.craftType,
                "Origin": seat.origin,
                "Destination": seat.destination,
                "AvailablityType": seat.availablityType,
                "Description": seat.description,
                "Code": seat.code,
                "RowNo": seat.rowNo,
                "SeatNo": seat.seatNo,
                "SeatType": seat.seatType,
                "SeatWayType": seat.seatWayType,
                "Compartment": seat.compartment,
                "Deck": seat.deck,
                "Currency": seat.currency,
                "Price": seat.price,
              });
              print('SeatDynamic: $seatJson');
            }
            for (var seat in selectedSeatDetails) {
              print('Selected seat ${seat.code} price: ₹${seat.price}');
            }
          }
        });
      }
          : null,

      child: Container(
        margin: EdgeInsets.symmetric(horizontal: seatSize * 0.08),
        width: seatSize,
        height: seatSize,
        decoration: BoxDecoration(
          color: isSelected ? Colors.green : getSeatColor(type, seat),
          borderRadius: BorderRadius.circular(6),
          border: isSelected ? Border.all(color: Colors.white, width: 2) : null,
        ),
        child: _buildSeatContent(isSelected, type, seatSize, seat),
      ),
    );
  }

  // Update seat content builder
  Widget _buildSeatContent(
      bool isSelected,
      String type,
      double size,
      Seat seat,
      ) {
    if (!(seat.availablityType == 1)) {
      return Icon(
        seat.availablityType == 3 ? Icons.lock : Icons.close,
        size: size * 0.55,
        color: Colors.white,
      );
    }

    return isSelected
        ? Icon(Icons.check, size: size * 0.7, color: Colors.white)
        : Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          type,
          style: GoogleFonts.poppins(
            fontSize: size * 0.35,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
        Text(
          '₹${seat.price!.toInt()}',
          style: GoogleFonts.poppins(
            fontSize: size * 0.3,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }

  // Updated row builder
  Widget buildRow(int displayRow, double seatSize) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: seatSize * 0.2),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildRowNumber(displayRow, seatSize),
          ...columns.sublist(0, 3).map((col) {
            final seatId = '$displayRow$col';
            return seatBox(seatId, seatSize);
          }),
          SizedBox(width: seatSize * 1.2),
          ...columns.sublist(3).map((col) {
            final seatId = '$displayRow$col';
            return seatBox(seatId, seatSize);
          }),
          _buildRowNumber(displayRow, seatSize),
        ],
      ),
    );
  }

  Widget _buildRowNumber(int row, double size) {
    return SizedBox(
      width: size * 1.3,
      child: Text(
        row.toString(),
        textAlign: TextAlign.center,
        style: GoogleFonts.poppins(
          fontSize: size * 0.4,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    bool isDelBomSelected = false;
    final screenWidth = MediaQuery.of(context).size.width;
    final seatSize = screenWidth / 14;

    if (widget.flightSsrRes == null ||
        widget.flightSsrRes?.seatDynamic == null ||
        widget.flightSsrRes!.seatDynamic!.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'assets/images/exception_image.svg', // your local image path
              width: 200,
              height: 200,
            ),
            SizedBox(height: 16),
            Text(
              'No seat data available!',
              style: GoogleFonts.poppins(fontSize: 18, color: Colors.grey),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          // padding: EdgeInsets.all(seatSize * 0.5),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 8),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(width: seatSize * 1.3),
                  SvgPicture.network(
                    'https://flight.easemytrip.com/M_Content/img/img_MB/toilet-icon.svg',
                    height: seatSize,
                  ),
                  Spacer(),
                  SvgPicture.network(
                    'https://flight.easemytrip.com/M_Content/img/img_MB/toilet-icon.svg',
                    height: seatSize,
                  ),
                  SizedBox(width: seatSize * 1.3),
                ],
              ),
              SizedBox(height: seatSize * 0.3),

              // Exit Icons
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(width: seatSize * 1.3),
                  SvgPicture.network(
                    'https://flight.easemytrip.com/M_Content/img/img_MB/lft-exit.svg',
                    height: seatSize,
                  ),
                  Spacer(),
                  SvgPicture.network(
                    'https://flight.easemytrip.com/M_Content/img/img_MB/lft-exit.svg',
                    height: seatSize,
                  ),
                  SizedBox(width: seatSize * 1.3),
                ],
              ),
              SizedBox(height: seatSize * 0.4),

              // Column Headers
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(width: seatSize * 1.3),
                  ...columns
                      .sublist(0, 3)
                      .map(
                        (c) => SizedBox(
                      width: seatSize,
                      child: Text(
                        c,
                        textAlign: TextAlign.left,
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: seatSize * 1.2),
                  ...columns
                      .sublist(3)
                      .map(
                        (c) => SizedBox(
                      width: seatSize,
                      child: Text(
                        c,
                        textAlign: TextAlign.right,
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: seatSize * 1.3),
                ],
              ),

              // Seat Rows
              Column(
                mainAxisSize: MainAxisSize.min,
                children: List.generate(maxRow, (rowIndex) {
                  int displayRow = rowIndex + 1; // Changed from maxRow + 1

                  /*if ([10, 15, 30].contains(displayRow)) {
                    return _buildExitRow(seatSize);
                  }*/
                  return buildRow(displayRow, seatSize);
                }),
              ),
              SizedBox(height: seatSize * 2),
            ],
          ),
        ),
      ),
    );
  }
}