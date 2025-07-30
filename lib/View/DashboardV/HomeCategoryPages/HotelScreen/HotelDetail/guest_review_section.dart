import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GuestReviewSection extends StatelessWidget {
  const GuestReviewSection({super.key});

  final List<Map<String, dynamic>> reviews = const [
    {
      'title': 'Wonderful',
      'name': 'Voyager5037248154',
      'date': 'May 2025',
      'rating': 5,
      'desc':
          'Testing was ready good and services was very well I like the staff they are very corporator and humble specially the guards are also very helpful to me they help me with my luggage and the whole...',
    },
    {
      'title': 'Wonderful',
      'name': 'Arun Kumar A',
      'date': 'May 2025',
      'rating': 5,
      'desc':
          'I had a really great stay there the services are good and staff also helpful. front office cooperative helps me a lot and security guards specially Mr Gajendra sir at main entrance is really humble...',
    },
    {
      'title': 'Hotel is good',
      'name': 'Amarjyoti D',
      'date': 'May 2025',
      'rating': 5,
      'desc':
          'We stayed here as part of our tour. It was our fifth hotel so far and I think the best. The room was well furnished with views. The bathroom well equipped. We did ask for an extra blanket and this...',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 16, 16, 24),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Guest Review",
              style: GoogleFonts.poppins(
                  fontSize: 16, fontWeight: FontWeight.w600)),
          const SizedBox(height: 12),
          ...reviews.map((review) => _buildReviewCard(review)).toList(),
        ],
      ),
    );
  }

  Widget _buildReviewCard(Map<String, dynamic> review) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade200),
        borderRadius: BorderRadius.circular(10),
        color: Colors.grey.shade50,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header row
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title, name, date
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(review['title'],
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w600, fontSize: 14)),
                    const SizedBox(height: 2),
                    Text(
                      "${review['name']} | ${review['date']}",
                      style: GoogleFonts.poppins(
                          fontSize: 12, color: Colors.grey.shade600),
                    ),
                  ],
                ),
              ),
              // Rating
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  review['rating'].toString(),
                  style: GoogleFonts.poppins(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            review['desc'],
            style: GoogleFonts.poppins(fontSize: 13),
          ),
        ],
      ),
    );
  }
}
