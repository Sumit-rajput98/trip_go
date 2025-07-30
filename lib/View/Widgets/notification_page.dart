import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trip_go/View/DashboardV/bottom_navigation_bar.dart';
import 'package:trip_go/View/Widgets/custom_app_bar.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final notifications = [
      // {
      //   'initial': 'F',
      //   'color': Colors.blueAccent,
      //   'title': 'Flight Booking Confirmed',
      //   'subtitle':
      //       'Your flight to Goa is confirmed. Check-in opens 24h before departure.',
      //   'time': '2 min ago',
      //   'date': 'Apr 18, 2024',
      // },
      // {
      //   'initial': 'H',
      //   'color': Colors.deepPurple,
      //   'title': 'Hotel Reserved',
      //   'subtitle': 'Your hotel at Taj Resort, Goa is booked for 3 nights.',
      //   'time': '10 min ago',
      //   'date': 'Apr 18, 2024',
      // },
      // {
      //   'initial': 'B',
      //   'color': Colors.orange,
      //   'title': 'Bus Ticket Issued',
      //   'subtitle': 'Your bus to Manali departs at 10:30 PM tonight.',
      //   'time': '1 hr ago',
      //   'date': 'Apr 18, 2024',
      // },
      {
        'initial': 'O',
        'color': Colors.green,
        'title': 'Special Offer!',
        'subtitle':
            'Get 15% off on your next hotel booking. Limited time only!',
        'time': 'Today',
        'date': 'Apr 18, 2025',
      },
      // {
      //   'initial': 'A',
      //   'color': Colors.redAccent,
      //   'title': 'Travel Alert',
      //   'subtitle':
      //       'Weather warning for your destination. Please check updates.',
      //   'time': 'Yesterday',
      //   'date': 'Apr 17, 2024',
      // },
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF6F8FA),
      appBar: CustomAppBar(title: "Notifications", onBack: ()=> Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>BottomNavigationbar()), (r)=>false),),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // // Customize button
          // Padding(
          //   padding: const EdgeInsets.fromLTRB(16, 18, 16, 0),
          //   child: Row(
          //     children: [
          //       Expanded(
          //         child: ElevatedButton.icon(
          //           style: ElevatedButton.styleFrom(
          //             backgroundColor: Colors.black,
          //             foregroundColor: Colors.white,
          //             shape: RoundedRectangleBorder(
          //               borderRadius: BorderRadius.circular(12),
          //             ),
          //             padding: const EdgeInsets.symmetric(vertical: 14),
          //             elevation: 0,
          //           ),
          //           onPressed: () {},
          //           icon: const Icon(Icons.tune, size: 20),
          //           label: Text(
          //             'Customize your notifications!',
          //             style: GoogleFonts.poppins(
          //               fontWeight: FontWeight.w600,
          //               fontSize: 15,
          //             ),
          //           ),
          //         ),
          //       ),
          //       const SizedBox(width: 8),
          //       IconButton(
          //         icon: const Icon(Icons.settings, color: Colors.black87),
          //         onPressed: () {},
          //         tooltip: 'Notification Settings',
          //       ),
          //     ],
          //   ),
          // ),
           const SizedBox(height: 18),
          // Section header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              'Previously',
              style: GoogleFonts.poppins(
                fontSize: 15.5,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
          ),
          const SizedBox(height: 8),
          // Notification list or empty state
          Expanded(
            child:
                notifications.isEmpty
                    ? _NotificationEmptyState()
                    : ListView.separated(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      itemCount: notifications.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 10),
                      itemBuilder: (context, index) {
                        final n = notifications[index];
                        return Material(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          elevation: 0.5,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(16),
                            onTap: () {},
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 16,
                                horizontal: 14,
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Leading initial in colored circle
                                  Container(
                                    width: 44,
                                    height: 44,
                                    decoration: BoxDecoration(
                                      color: (n['color'] as Color).withOpacity(
                                        0.13,
                                      ),
                                      shape: BoxShape.circle,
                                    ),
                                    alignment: Alignment.center,
                                    child: Text(
                                      n['initial'] as String,
                                      style: GoogleFonts.poppins(
                                        fontSize: 22,
                                        fontWeight: FontWeight.w700,
                                        color: n['color'] as Color,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  // Title, subtitle
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Expanded(
                                              child: Text(
                                                n['title'] as String,
                                                style: GoogleFonts.poppins(
                                                  fontSize: 15.5,
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.black87,
                                                ),
                                              ),
                                            ),
                                            const SizedBox(width: 8),
                                            Text(
                                              n['date'] as String,
                                              style: GoogleFonts.poppins(
                                                fontSize: 12.5,
                                                color: Colors.grey.shade500,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          n['subtitle'] as String,
                                          style: GoogleFonts.poppins(
                                            fontSize: 13.5,
                                            color: Colors.black54,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.access_time,
                                              size: 14,
                                              color: Colors.grey.shade400,
                                            ),
                                            const SizedBox(width: 4),
                                            Text(
                                              n['time'] as String,
                                              style: GoogleFonts.poppins(
                                                fontSize: 12,
                                                color: Colors.grey.shade500,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
          ),
        ],
      ),
    );
  }
}

class _NotificationEmptyState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 40),
            Icon(
              Icons.notifications_none,
              size: 72,
              color: Colors.grey.shade300,
            ),
            const SizedBox(height: 24),
            Text(
              'No notifications yet',
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Your notifications will appear here once you receive them.',
              style: GoogleFonts.poppins(fontSize: 14.5, color: Colors.black54),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 18),
            TextButton(
              onPressed: () {},
              child: Text(
                'Go to historical notifications.',
                style: GoogleFonts.poppins(
                  color: Colors.blueAccent,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
