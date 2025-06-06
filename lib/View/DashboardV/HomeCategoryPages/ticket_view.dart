import 'package:flutter/material.dart';
import 'package:screenshot/screenshot.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:intl/intl.dart';
import 'package:image/image.dart' as img;
import 'package:image/image.dart' show decodeImage, encodePng, copyCrop;

class TicketPage extends StatelessWidget {
  final ScreenshotController screenshotController = ScreenshotController();
  final dynamic itinerary;
  final List<dynamic> passengers;
  final List<dynamic> segments;

  TicketPage({
    Key? key,
    required this.itinerary,
    required this.passengers,
    required this.segments,
  }) : super(key: key);

  Future<void> downloadAsPdf() async {
    final imageBytes = await screenshotController.capture();

    if (imageBytes != null) {
      final pdf = pw.Document();

      final image = decodeImage(imageBytes);
      if (image == null) {
        print('Failed to decode image');
        return;
      }

      // Calculate A4 pixel height (at ~72 DPI, adjust if needed)
      final a4WidthPx = PdfPageFormat.a4.width.toInt();
      final a4HeightPx = PdfPageFormat.a4.height.toInt();

      int currentY = 0;
      while (currentY < image.height) {
        int sliceHeight = (currentY + a4HeightPx > image.height)
            ? image.height - currentY
            : a4HeightPx;

        final slice = img.copyCrop(
          image,
          x: 0,
          y: currentY,
          width: image.width,
          height: sliceHeight,
        );
        final sliceBytes = encodePng(slice);

        final pdfImage = pw.MemoryImage(sliceBytes);

        pdf.addPage(
          pw.Page(
            pageFormat: PdfPageFormat.a4,
            build: (pw.Context context) {
              return pw.Center(
                child: pw.Image(pdfImage, fit: pw.BoxFit.contain),
              );
            },
          ),
        );

        currentY += sliceHeight;
      }

      await Printing.layoutPdf(
        onLayout: (PdfPageFormat format) async => pdf.save(),
      );
    } else {
      print('Screenshot capture failed');
    }
  }

  @override
  Widget build(BuildContext context) {
    String _monthName(int month) {
      const monthNames = [
        'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
        'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
      ];
      return monthNames[month - 1];
    }
    String formatDate(DateTime date) {
      return "${date.day.toString().padLeft(2, '0')} "
          "${_monthName(date.month)} "
          "${date.year}";
    }

    String _getCabinClassName(int cabinClass) {
      switch (cabinClass) {
        case 1:
          return 'All';
        case 2:
          return 'Economy';
        case 3:
          return 'Premium Economy';
        case 4:
          return 'Business';
        case 5:
          return 'Premium Business';
        case 6:
          return 'First';
        default:
          return 'Unknown';
      }
    }

    final List<Map<String, String>> airlines = [
      {"name": "Air India", "logo": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS-QO8gVe353NPaAV3wid57LAtWqIdet-EVMA&s"},
      {"name": "Air India Express", "logo": "https://flight.easemytrip.com/Content/AirlineLogon/IX.png"},
      {"name": "IndiGo", "logo": "https://flight.easemytrip.com/Content/AirlineLogon/6E.png"},
      {"name": "Vistara", "logo": "https://flight.easemytrip.com/Content/AirlineLogon/UK.png"},
      {"name": "SpiceJet", "logo": "https://flight.easemytrip.com/Content/AirlineLogon/SG.png"},
      {"name": "GoAir", "logo": "https://flight.easemytrip.com/Content/AirlineLogon/G8.png"},
      {"name": "Flynas", "logo": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR44aavq2U0IVMa98wKAQpI47r3nQ_-Q-O0GHi3PRnXyvwc571_m14YaLdk5GBcUjFPVgA&usqp=CAU"},
    ];

    String _getAirlineLogo(String airlineName) {
      final airline = airlines.firstWhere(
            (airline) => airline['name'] == airlineName,
        orElse: () => {"logo": "https://flight.easemytrip.com/Content/AirlineLogon/SG.png"}, // fallback/default image
      );
      return airline['logo']!;
    }


    String formatDateTime(String dateStr) {
      final DateTime parsedDate = DateTime.parse(dateStr);
      return DateFormat('dd/MM/yyyy hh:mm a').format(parsedDate);
    }

    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Stack(
              children: [
               Screenshot(
                 controller: screenshotController,
                 child: Card(
                   color: Colors.white,
                   elevation: 8,
                   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                   margin: EdgeInsets.all(16),
                   child: Padding(
                     padding: const EdgeInsets.all(16.0),
                     child: Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         // Header
                         Row(
                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                           children: [
                             Image.asset('assets/images/trip_go.png', width: 100, height: 100),
                             Column(
                               crossAxisAlignment: CrossAxisAlignment.end,
                               children: [
                                 Text('Ticket', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, fontFamily: 'poppins')),
                                 Text('Booking ID: #${itinerary?.bookingId}', style: TextStyle(fontFamily: 'poppins')),
                                 // Assuming you want to show the issue date of the first passenger:
                                 if (passengers != null && passengers.isNotEmpty)
                                   Text(
                                     "Issued Date: ${formatDate(passengers[0].ticket.issueDate)}",
                                     style: TextStyle(fontFamily: 'poppins'),
                                   ),
                               ],
                             ),
                           ],
                         ),
                         Divider(height: 30, thickness: 1),
                         // Passenger Information
                         Text('Passenger Information:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, fontFamily: 'poppins')),
                         SizedBox(height: 10,),
                         Column(
                           children: List.generate(
                             passengers.length < 2 ? passengers.length : 2,
                                 (i) => Column(
                               crossAxisAlignment: CrossAxisAlignment.start,
                               children: [
                                 Text('Passenger ${i + 1}', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, fontFamily: 'poppins')),
                                 SizedBox(height: 10),
                                 Table(
                                   columnWidths: {
                                     0: FractionColumnWidth(0.4),
                                     1: FractionColumnWidth(0.6),
                                   },
                                   border: TableBorder.all(color: Colors.grey.shade300),
                                   children: [
                                     TableRow(children: [
                                       Padding(
                                         padding: const EdgeInsets.all(8.0),
                                         child: Text('Passenger', style: TextStyle(fontWeight: FontWeight.w500, fontFamily: 'poppins')),
                                       ),
                                       Padding(
                                         padding: const EdgeInsets.all(8.0),
                                         child: Text('${passengers[i].firstName} ${passengers[i].lastName}', style: TextStyle(fontFamily: 'poppins')),
                                       ),
                                     ]),
                                     TableRow(children: [
                                       Padding(
                                         padding: const EdgeInsets.all(8.0),
                                         child: Text('Gender', style: TextStyle(fontWeight: FontWeight.w500, fontFamily: 'poppins')),
                                       ),
                                       Padding(
                                         padding: const EdgeInsets.all(8.0),
                                         child: Text('${passengers[i].gender}', style: TextStyle(fontFamily: 'poppins')),
                                       ),
                                     ]),
                                     TableRow(children: [
                                       Padding(
                                         padding: const EdgeInsets.all(8.0),
                                         child: Text('Airline PNR', style: TextStyle(fontWeight: FontWeight.w500, fontFamily: 'poppins')),
                                       ),
                                       Padding(
                                         padding: const EdgeInsets.all(8.0),
                                         child: Text('${itinerary?.pnr}', style: TextStyle(fontFamily: 'poppins')),
                                       ),
                                     ]),
                                     TableRow(children: [
                                       Padding(
                                         padding: const EdgeInsets.all(8.0),
                                         child: Text('Ticket Number', style: TextStyle(fontWeight: FontWeight.w500, fontFamily: 'poppins')),
                                       ),
                                       Padding(
                                         padding: const EdgeInsets.all(8.0),
                                         child: Text("${passengers[i].ticket.ticketNumber}", style: TextStyle(fontFamily: 'poppins')),
                                       ),
                                     ]),
                                     TableRow(children: [
                                       Padding(
                                         padding: const EdgeInsets.all(8.0),
                                         child: Text('Seat No.', style: TextStyle(fontWeight: FontWeight.w500, fontFamily: 'poppins')),
                                       ),
                                       Padding(
                                         padding: const EdgeInsets.all(8.0),
                                         child: Text('2B', style: TextStyle(fontFamily: 'poppins')),
                                       ),
                                     ]),
                                   ],
                                 ),
                                 SizedBox(height: 20),
                               ],
                             ),
                           ),
                         ),
                         SizedBox(height: 20),
                         // Flight Information
                         Column(
                           crossAxisAlignment: CrossAxisAlignment.start,
                           children: [
                             Text('Flight Information:',
                                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, fontFamily: 'poppins')),
                             SizedBox(height: 10),
                             ...segments.map((segment) {
                               return Column(
                                 children: [
                                   Row(
                                     children: [
                                       Image.network(
                                         _getAirlineLogo(segment.airlineName),
                                         width: 40,
                                         height: 40,
                                       ),
                                       SizedBox(width: 10),
                                       Column(
                                         crossAxisAlignment: CrossAxisAlignment.start,
                                         children: [
                                           Text(segment.airlineName, style: TextStyle(fontFamily: 'poppins')),
                                           Text('Cabin Class: ${_getCabinClassName(segment.cabinClass)}',
                                               style: TextStyle(fontFamily: 'poppins')),
                                         ],
                                       ),
                                     ],
                                   ),
                                   SizedBox(height: 10),
                                   Table(
                                     border: TableBorder.all(color: Colors.grey),
                                     children: [
                                       TableRow(
                                         decoration: BoxDecoration(color: Colors.grey[200]),
                                         children: [
                                           Padding(
                                             padding: const EdgeInsets.all(8.0),
                                             child: Text('Departure',
                                                 style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'poppins')),
                                           ),
                                           Padding(
                                             padding: const EdgeInsets.all(8.0),
                                             child: Text('Arrival',
                                                 style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'poppins')),
                                           ),
                                           Padding(
                                             padding: const EdgeInsets.all(8.0),
                                             child: Text('Duration',
                                                 style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'poppins')),
                                           ),
                                         ],
                                       ),
                                       TableRow(children: [
                                         Padding(
                                           padding: const EdgeInsets.all(8.0),
                                           child: Text(
                                             '${formatDateTime(segment.depTime)}\n${segment.originCityName} (${segment.originAirportCode})\nTerminal - ${segment.originTerminal}',
                                             style: TextStyle(fontFamily: 'poppins'),
                                           ),
                                         ),
                                         Padding(
                                           padding: const EdgeInsets.all(8.0),
                                           child: Text(
                                             '${formatDateTime(segment.arrTime)}\n${segment.destinationCityName} (${segment.destinationAirportCode})\nTerminal - ${segment.destinationTerminal}',
                                             style: TextStyle(fontFamily: 'poppins'),
                                           ),
                                         ),
                                         Padding(
                                           padding: const EdgeInsets.all(8.0),
                                           child: Text('${segment.duration} m', style: TextStyle(fontFamily: 'poppins')),
                                         ),
                                       ]),
                                     ],
                                   ),
                                   SizedBox(height: 20),
                                 ],
                               );
                             }).toList(),
                           ],
                         ),

                         SizedBox(height: 20),

                         // Cost Details
                         Table(
                           children: [
                             TableRow(children: [
                               Text('Base Fare', style: TextStyle(fontFamily: 'poppins')),
                               Text(
                                 '\₹${itinerary.fare.baseFare.toStringAsFixed(2)}',
                                 textAlign: TextAlign.right,
                                 style: TextStyle(fontFamily: 'poppins'),
                               ),
                             ]),
                             TableRow(children: [
                               Text('Tax & Surcharges', style: TextStyle(fontFamily: 'poppins')),
                               Text(
                                 '\₹${itinerary.fare.tax.toStringAsFixed(2)}',
                                 textAlign: TextAlign.right,
                                 style: TextStyle(fontFamily: 'poppins'),
                               ),
                             ]),
                             TableRow(children: [
                               Padding(
                                 padding: const EdgeInsets.symmetric(vertical: 8.0),
                                 child: Text(
                                   'Total Amount:',
                                   style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'poppins'),
                                 ),
                               ),
                               Padding(
                                 padding: const EdgeInsets.symmetric(vertical: 8.0),
                                 child: Text(
                                   '\₹${(itinerary.fare.baseFare + itinerary.fare.tax).toStringAsFixed(2)}',
                                   textAlign: TextAlign.right,
                                   style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'poppins'),
                                 ),
                               ),
                             ]),
                           ],
                         ),
                         SizedBox(height: 20),

                         // Important Information
                         Text('Important Information:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, fontFamily: 'poppins')),
                         SizedBox(height: 8),
                         Text(
                           '• Please ensure you have all the required travel documents for your journey.\n'
                               '• All passengers must present valid ID at check-in.\n'
                               '• Arrive at least 3 hours before domestic flight, 4 hours for international.\n'
                               '• Baggage rules apply per airline.\n'
                               '• Company not responsible for delays or cancellations.\n'
                               '• Children must be accompanied by an adult.',
                           style: TextStyle(height: 1.5, fontFamily: 'poppins'),
                         ),
                         SizedBox(height: 20),

                         // Footer
                         Table(
                           columnWidths: {
                             0: FlexColumnWidth(2),  // Label column (Platform, Phone, Email)
                             1: FlexColumnWidth(4),  // Value column (Trip Go Online, number, email)
                           },
                           border: TableBorder.all(color: Colors.grey),  // Optional: adds borders
                           children: [
                             TableRow(
                               decoration: BoxDecoration(color: Colors.grey[200]),
                               children: [
                                 Padding(
                                   padding: const EdgeInsets.all(4.0),
                                   child: Text('', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, fontFamily: 'poppins')),
                                 ),
                                 Padding(
                                   padding: const EdgeInsets.all(4.0),
                                   child: Text('Trip Go Online', style: TextStyle(fontSize: 13, fontFamily: 'poppins')),
                                 ),
                               ],
                             ),
                             TableRow(
                               decoration: BoxDecoration(color: Colors.grey[100]),
                               children: [
                                 Padding(
                                   padding: const EdgeInsets.all(4.0),
                                   child: Text('Phone', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15, fontFamily: 'poppins')),
                                 ),
                                 Padding(
                                   padding: const EdgeInsets.all(4.0),
                                   child: Text('+91 82374 38974', style: TextStyle(fontSize: 13, fontFamily: 'poppins')),
                                 ),
                               ],
                             ),
                             TableRow(
                               decoration: BoxDecoration(color: Colors.grey[200]),
                               children: [
                                 Padding(
                                   padding: const EdgeInsets.all(4.0),
                                   child: Text('Email', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15, fontFamily: 'poppins')),
                                 ),
                                 Padding(
                                   padding: const EdgeInsets.all(4.0),
                                   child: Text('surenkumar@gmail.com', style: TextStyle(fontSize: 13, fontFamily: 'poppins')),
                                 ),
                               ],
                             ),
                           ],
                         )
                       ],
                     ),
                   ),
                 ),
               ),
                Positioned(
                  top: 24,
                  right: 24,
                  child: GestureDetector(
                    onTap: downloadAsPdf,
                    child: Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 4,
                            offset: Offset(2, 2),
                          ),
                        ],
                      ),
                      child: Icon(Icons.download, color: Colors.black),
                    ),
                  ),
                ),
              ],
            )
          ),
        ),
      ),
    );
  }
}
