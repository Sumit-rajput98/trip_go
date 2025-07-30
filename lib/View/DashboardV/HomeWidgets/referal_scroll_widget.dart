import 'package:flutter/material.dart';
import 'package:trip_go/View/DashboardV/HomeCategoryPages/Information/information_page.dart';
import 'package:trip_go/View/DashboardV/HomeCategoryPages/ReferAndEarn/refer_and_earn_page.dart';
import 'package:trip_go/View/DashboardV/HomeWidgets/hot_deals_page.dart';

import '../../../constants.dart';

class ReferalScrollWidget extends StatelessWidget {
  const ReferalScrollWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> boxImages = [
      'assets/icons/referandearn.png', // replace with your asset path
      'assets/icons/hot-deals.png',
      'assets/icons/important.png',
    ];

    final List<String> boxLabels = [
      'Referal & Earn',
      'Hot Deals',
      'Important Information',
    ];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Row(
          children: List.generate(boxImages.length, (index) {
            return GestureDetector(
              onTap: () {
                if (index == 0) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (context) => const ReferAndEarnPage(),
                    ),
                  );
                } else if (index == 1) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (context) => const HotDealsPage(),
                    ),
                  );
                } else if (index == 2) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (context) => const InformationPage(),
                    ),
                  );
                }
              },
              child: Container(
                width: 130,
                height: 50,
                margin: const EdgeInsets.only(right: 12),
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: constants.ultraLightThemeColor1,
                  border: Border.all(color: constants.themeColor1, width: 1.5),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    Image.asset(
                      boxImages[index],
                      width: 20,
                      height: 20,
                      color: constants.themeColor1,
                    ),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        boxLabels[index],
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'poppins',
                        ),
                        softWrap: true,
                        maxLines: 2,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
