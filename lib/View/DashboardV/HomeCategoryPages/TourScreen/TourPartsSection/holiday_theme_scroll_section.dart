import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../../../../ViewM/TourVM/holiday_themes_view_model.dart';
import '../../../../../constants.dart';
import '../tour_category_view.dart';

class HolidayThemeScroll extends StatefulWidget {
  const HolidayThemeScroll({super.key});

  @override
  State<HolidayThemeScroll> createState() => _HolidayThemeScrollState();
}

class _HolidayThemeScrollState extends State<HolidayThemeScroll> {
  late PageController _pageController;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    Provider.of<HolidayThemesViewModel>(context, listen: false).fetchThemes();
    _pageController = PageController(viewportFraction: 1.0); // Full width pages
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void scrollLeft() {
    if (_currentPage > 0) {
      _currentPage -= 1;
      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 400),
        curve: Curves.ease,
      );
    }
  }

  void scrollRight(int totalPages) {
    if (_currentPage < totalPages - 1) {
      _currentPage += 1;
      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 400),
        curve: Curves.ease,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeVM = Provider.of<HolidayThemesViewModel>(context);

    return Column(
      children: [
        const SizedBox(height: 20),
        Center(
          child: RichText(
            text: TextSpan(
              style: GoogleFonts.poppins(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
              children: [
                TextSpan(
                  text: 'Explore ',
                  style: TextStyle(color: constants.themeColor1),
                ),
                const TextSpan(
                  text: 'Holidays By Theme',
                  style: TextStyle(color: Colors.black),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 30),
        themeVM.isLoading
            ? const CircularProgressIndicator()
            : LayoutBuilder(builder: (context, constraints) {
                final totalItems = themeVM.themes.length;
                final totalPages = (totalItems / 2).ceil();

                return Stack(
                  children: [
                    SizedBox(
                      height: 240,
                      width: double.infinity,
                      child: PageView.builder(
                        controller: _pageController,
                        itemCount: totalPages,
                        onPageChanged: (index) {
                          setState(() => _currentPage = index);
                        },
                        itemBuilder: (context, index) {
                          final int first = index * 2;
                          final int second = first + 1;

                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20.0),
                            child: Row(
                              children: [
                                Expanded(child: _buildCard(themeVM.themes[first])),
                                const SizedBox(width: 16),
                                if (second < totalItems)
                                  Expanded(child: _buildCard(themeVM.themes[second]))
                                else
                                  const Spacer(), // if odd number, second half empty
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    // Left Arrow
                    Positioned(
                      left: 0,
                      top: 60,
                      child: CircleAvatar(
                        backgroundColor: Colors.black.withOpacity(0.5),
                        radius: 20,
                        child: IconButton(
                          icon: const Icon(Icons.arrow_back_ios, size: 18),
                          onPressed: scrollLeft,
                          color: Colors.white,
                          splashRadius: 24,
                        ),
                      ),
                    ),
                    // Right Arrow
                    Positioned(
                      right: 0,
                      top: 60,
                      child: CircleAvatar(
                        backgroundColor: Colors.black.withOpacity(0.5),
                        radius: 20,
                        child: IconButton(
                          icon: const Icon(Icons.arrow_forward_ios, size: 18),
                          onPressed: () => scrollRight(totalPages),
                          color: Colors.white,
                          splashRadius: 24,
                        ),
                      ),
                    ),
                  ],
                );
              }),
      ],
    );
  }

  Widget _buildCard(theme) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => TourCategoryView(
              name: theme.name,
              slug: theme.slug,
            ),
          ),
        );
      },
      child: Container(
        height: 200,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xfff0f9ff),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.blue.shade100),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(theme.image, height: 60),
            const SizedBox(height: 12),
            Text(
              theme.name,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w400,
                color: Colors.red,
                fontFamily: 'poppins',
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 6),
            Text(
              "Explore Now",
              style: TextStyle(
                color: constants.themeColor1,
                fontSize: 16,
                fontFamily: 'poppins',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
