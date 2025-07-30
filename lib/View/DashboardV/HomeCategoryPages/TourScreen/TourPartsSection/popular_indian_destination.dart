import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:trip_go/constants.dart';
import '../../../../../AppManager/Api/api_service/TourService/indian_destination_view_model.dart';
import '../tour_category_view.dart';
import 'city_builder.dart';

class PopularIndianDestination extends StatefulWidget {
  const PopularIndianDestination({super.key});

  @override
  State<PopularIndianDestination> createState() => _PopularIndianDestinationState();
}
class _PopularIndianDestinationState extends State<PopularIndianDestination> {
  late final PageController _pageController;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.75);
    _autoScroll();
  }

  void _autoScroll() {
    Future.delayed(const Duration(seconds: 3)).then((_) {
      if (_pageController.hasClients) {
        _currentPage++;
        _pageController.animateToPage(
          _currentPage % 5, // Use destination list length here
          duration: const Duration(milliseconds: 600),
          curve: Curves.easeInOut,
        );
        _autoScroll(); // recursive call
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => IndianDestinationViewModel()..loadDestinations(),
      child: Consumer<IndianDestinationViewModel>(
        builder: (context, viewModel, _) {
          if (viewModel.isLoading) {
            return const CircularProgressIndicator();
          } else if (viewModel.errorMessage != null) {
            return Text(viewModel.errorMessage!);
          } else {
            final destinations = viewModel.destinations;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("DESTINATION", style: GoogleFonts.poppins(
                  fontSize: 24,
                  fontWeight: FontWeight.w400,
                ),),
                Center(
                  child: RichText(
                    text: TextSpan(
                      style: GoogleFonts.poppins(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                      ),
                      children: [
                        TextSpan(
                          text: 'Popular ',
                          style: TextStyle(color: constants.themeColor1),
                        ),
                        TextSpan(
                          text: 'Indian Destinations',
                          style: const TextStyle(color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  height: 400, // Adjust height as needed
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: destinations.length,
                    itemBuilder: (context, index) {
                      final destination = destinations[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => TourCategoryView(
                                name: destination.name,
                                slug: destination.slug,
                              ),
                            ),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: CityBuilder2(
                            img: destination.image,
                            title: destination.name,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
