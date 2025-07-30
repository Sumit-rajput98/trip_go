import 'package:flutter/material.dart';
import 'package:trip_go/constants.dart';
import 'package:trip_go/Model/Offers/ExclusiveOffersModel.dart';

class OffersCardsWidget extends StatelessWidget {
  final String offer;
  final List<Datum> offersList;

  const OffersCardsWidget({
    super.key,
    required this.offer,
    required this.offersList,
  });

  @override
  Widget build(BuildContext context) {
    if (offersList.isEmpty) {
      return const Padding(
        padding: EdgeInsets.all(16),
        child: Center(child: Text("No offers available")),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: List.generate(offersList.length, (index) {
            final offerData = offersList[index];

            return Container(
              width: 160,
              height: 240,
              margin: const EdgeInsets.only(right: 12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 6,
                    offset: const Offset(2, 3),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Image
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(14)),
                    child: Image.network(
                      offerData.image ?? '',
                      width: double.infinity,
                      height: 150,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) =>
                           Image.network("https://images.unsplash.com/photo-1606606124992-2dac8ce669e0?q=80&w=1241&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D", width: double.infinity,height: 150, fit: BoxFit.cover,),
                    ),
                  ),

                  // Offer Type
                  Padding(
                    padding: const EdgeInsets.only(left: 10, top: 8),
                    child: Text(
                      offerData.offerType ?? '',
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.black54,
                        fontFamily: 'poppins',
                      ),
                    ),
                  ),

                  
                  Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10, top: 4),
                    child: Text(
                      offerData.name ?? '',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'poppins',
                        color: Colors.black,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SizedBox(height: 10,),
                ],
              ),
            );
          }
          ),
          
        ),
      ),
    );
  }
}
