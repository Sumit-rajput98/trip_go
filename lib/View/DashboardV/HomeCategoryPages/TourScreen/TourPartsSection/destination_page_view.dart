import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../constants.dart';
import '../destination_details_page.dart';

class DestinationPageView extends StatelessWidget {
  final List<List<Map<String, String>>> citiesGrouped;
  final PageController pageController;
  final int currentPage;

  const DestinationPageView({
    super.key,
    required this.citiesGrouped,
    required this.pageController,
    required this.currentPage,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 210,
          child: PageView.builder(
            controller: pageController,
            itemCount: citiesGrouped.length,
            itemBuilder: (context, index) {
              final group = citiesGrouped[index];
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: group.map((city) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => DestinationDetailsPage(
                            name: city['name']!,
                            image: city['image']!,
                          ),
                        ),
                      );
                    },
                    child: Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Image.network(
                            city['image']!,
                            width: 150,
                            height: 170,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          city['name']!,
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              );
            },
          ),
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            citiesGrouped.length,
                (index) => Container(
              width: 8,
              height: 8,
              margin: const EdgeInsets.symmetric(horizontal: 4),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: currentPage == index
                    ? constants.themeColor1
                    : constants.ultraLightThemeColor1,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
