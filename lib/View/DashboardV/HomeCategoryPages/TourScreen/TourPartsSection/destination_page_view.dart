import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../../ViewM/TourVM/destinantion_view_model.dart';
import '../tour_category_view.dart';

class DestinationPageView extends StatefulWidget {
  final PageController pageController;
  final int currentPage;

  const DestinationPageView({
    super.key,
    required this.pageController,
    required this.currentPage,
  });

  @override
  State<DestinationPageView> createState() => _DestinationPageViewState();
}

class _DestinationPageViewState extends State<DestinationPageView> {
  @override
  void initState() {
    super.initState();
    Provider.of<DestinationViewModel>(context, listen: false).loadDestinations();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DestinationViewModel>(
      builder: (context, model, _) {
        if (model.isLoading) {
          return SizedBox(
            height: 210,
            child: PageView.builder(
              itemCount: 2,
              itemBuilder: (context, index) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(2, (i) => shimmerCard()),
                );
              },
            ),
          );
        }

        return Column(
          children: [
            SizedBox(
              height: 210,
              child: PageView.builder(
                controller: widget.pageController,
                itemCount: model.groupedDestinations.length,
                itemBuilder: (context, index) {
                  final group = model.groupedDestinations[index];
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: group.map((city) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => TourCategoryView(
                                name: city.name,
                                slug: city.slug,
                              ),
                            ),
                          );
                        },
                        child: Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: Image.network(
                                city.image,
                                width: 150,
                                height: 170,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Positioned(
                              left: 8,
                              bottom: 8,
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: Colors.black54,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  city.name,
                                  style: GoogleFonts.poppins(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                  ),
                                ),
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
            ],
        );
      },
    );
  }

  Widget shimmerCard() {
    return Column(
      children: [
        Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
          child: Container(
            width: 150,
            height: 170,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
          child: Container(
            width: 80,
            height: 12,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
