import 'package:flutter/material.dart';
import 'package:trip_go/constants.dart';

class OffersCardsWidget extends StatelessWidget {
  final String offer;

  const OffersCardsWidget({super.key, required this.offer});

  @override
  Widget build(BuildContext context) {
    // Define the number of cards to display based on the offer
    int cardCount = offer == 'Top Offers' ? 3 : offer == 'Flights' ? 4 : 0;

    // Different image URLs based on offer category
    Map<String, List<String>> offerImages = {
      'Top Offers': [
        'https://img.freepik.com/free-photo/air-ticket-flight-booking-concept_53876-132674.jpg?uid=R158444821&ga=GA1.1.1838222959.1726491060&semt=ais_hybrid&w=740',
        'https://img.freepik.com/free-photo/happy-woman-shopping-sale_1150-13902.jpg',
        'https://img.freepik.com/free-photo/cyber-monday-sale-banner_1150-16051.jpg',
      ],
      'Flights': [
        'https://img.freepik.com/free-photo/sale-with-special-discount-traveling_23-2150040398.jpg?uid=R158444821&ga=GA1.1.1838222959.1726491060&semt=ais_hybrid&w=740',
        'https://img.freepik.com/free-photo/hand-holding-credit-card-online-shopping_1150-18942.jpg',
        'https://img.freepik.com/free-photo/banking-internet-payment-concept_1150-16790.jpg',
        'https://img.freepik.com/free-photo/online-payment-concept-with-coin_1150-14806.jpg',
      ],
    };

    // Dummy text and descriptions for each card
    List<String> descriptions = [
      'Get the best deals this season!',
      'Limited time offer on selected items!',
      'Big discounts on top brands!',
      'Exclusive offers for bank customers!',
    ];

    // "Use code" box text
    String useCodeText = 'Use code: OFFER20';

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Column(
          children: [
            Row(
              children: List.generate(cardCount, (index) {
                return Container(
                  width: 180,
                  height: 250,
                  margin: const EdgeInsets.only(right: 12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 5,
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Image
                      ClipRRect(
                        borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
                        child: Image.network(
                          offerImages[offer]?[index] ?? '',
                          width: double.infinity,
                          height: 120,
                          fit: BoxFit.cover,
                        ),
                      ),
                      // Text and description
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Offer title
                            Text(
                              offer,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(height: 4),
                            // Description
                            Text(
                              descriptions[index % descriptions.length],
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.black54,
                              ),
                            ),
                          ],
                        ),
                      ),
                      // "Use code" box
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                          decoration: BoxDecoration(
                            color: constants.themeColor1,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Text(
                            useCodeText,
                            style: const TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 10,)
                    ],
                  ),
                );
              }),
            ),
            SizedBox(height: 10,),
          ],
        ),
      ),
    );
  }
}
