import 'package:flutter/material.dart';

import '../../../constants.dart';

class ReferalScrollWidget extends StatelessWidget {
  const ReferalScrollWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> boxImages = [
      'assets/icons/referandearn.png',   // replace with your asset path
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
      child: Row(
        children: List.generate(boxImages.length, (index) {
          return Container(
            width: 130,
            height: 50,
            margin: const EdgeInsets.only(right: 12),
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: constants.ultraLightThemeColor1,
              border: Border.all(
                color: constants.themeColor1,
                width: 1.5,
              ),
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
          );
        }),
      ),
    );
  }
}
