import 'package:flutter/material.dart';
import 'package:trip_go/constants.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../Model/BusM/bus_boarding_model.dart';
import '../../Model/BusM/bus_search_model.dart';
import '../../View/DashboardV/HomeCategoryPages/BusScreen/bus_review_and_travellers_page.dart';
import '../../View/Widgets/custom_app_bar.dart';

class DroppingPointSelectionPage extends StatefulWidget {
  final List<CityPointDetail> droppingPoints;
  final int paymentPrice;
  final origin;
  final destination;
  final String traceId;
  final String resultIndex;
  final bool isDropPointMandatory;
  final int selectedSeats;
  final List<BusResult> busResults;

  const DroppingPointSelectionPage({
    super.key,
    required this.droppingPoints,
    required this.paymentPrice,
    required this.origin,
    required this.destination,
    required this.traceId,
    required this.resultIndex,
    required this.isDropPointMandatory,
    required this.selectedSeats,
    required this.busResults,
  });

  @override
  State<DroppingPointSelectionPage> createState() => _DroppingPointSelectionPageState();
}

class _DroppingPointSelectionPageState extends State<DroppingPointSelectionPage> {
  int? selectedIndex;

  @override
  Widget build(BuildContext context) {
    final points = widget.droppingPoints;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        title: "Select Dropping Point",
        titleStyle: GoogleFonts.poppins(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 20),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            Text('Choose Dropping Point', style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
            const SizedBox(height: 12),
            Expanded(
              child: ListView.builder(
                itemCount: points.length,
                itemBuilder: (context, index) {
                  final point = points[index];
                  final isSelected = index == selectedIndex;

                  return GestureDetector(
                    onTap: () {
                      setState(() => selectedIndex = index);
                      Future.delayed(const Duration(milliseconds: 150), () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => BusReviewAndTravellerPage(
                            paymentPrice: widget.paymentPrice,
                            origin: widget.origin,
                            destination: widget.destination,
                            busResults: widget.busResults,
                            traceId: widget.traceId,
                            resultIndex: widget.resultIndex,
                            isDropPointMandatory: widget.isDropPointMandatory,
                            selectedSeats: widget.selectedSeats,
                          )),
                        );
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                      decoration: BoxDecoration(
                        color: isSelected ? constants.themeColor1.withOpacity(0.1) : Colors.white,
                        border: Border.all(
                          color: isSelected ? constants.themeColor1 : Colors.grey.shade300,
                          width: 1.4,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            timeFormatter(point.cityPointTime),
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w600,
                              color: isSelected ? constants.themeColor1 : Colors.black,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              point.cityPointLocation,
                              style: GoogleFonts.poppins(
                                height: 1.4,
                                color: isSelected ? constants.themeColor1 : Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  String timeFormatter(String dateTime) {
    final dt = DateTime.tryParse(dateTime);
    if (dt == null) return dateTime;
    final hour = dt.hour % 12 == 0 ? 12 : dt.hour % 12;
    final minute = dt.minute.toString().padLeft(2, '0');
    final period = dt.hour >= 12 ? 'PM' : 'AM';
    return '$hour:$minute $period';
  }
}
