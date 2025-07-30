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
  final ScrollController _scrollController = ScrollController();

  void scrollLeft() {
    _scrollController.animateTo(
      _scrollController.offset - 200,
      duration: const Duration(milliseconds: 400),
      curve: Curves.ease,
    );
  }

  void scrollRight() {
    _scrollController.animateTo(
      _scrollController.offset + 200,
      duration: const Duration(milliseconds: 400),
      curve: Curves.ease,
    );
  }

  @override
  void initState() {
    super.initState();
    Provider.of<HolidayThemesViewModel>(context, listen: false).fetchThemes();
  }

  @override
  Widget build(BuildContext context) {
    final themeVM = Provider.of<HolidayThemesViewModel>(context);

    return Column(
      children: [
        const SizedBox(height: 20),
        RichText(
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
        const SizedBox(height: 30),
        themeVM.isLoading
            ? const CircularProgressIndicator()
            : Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: SingleChildScrollView(
                controller: _scrollController,
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: themeVM.themes.map((theme) {
                    return GestureDetector(
                      onTap: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => TourCategoryView(
                            name: theme.name,
                            slug: theme.slug,
                          )),
                        );
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 8),
                        padding: const EdgeInsets.all(16),
                        width: 180,
                        height: 200,
                        decoration: BoxDecoration(
                          color: const Color(0xfff0f9ff),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.blue.shade100),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.network(
                              theme.image,
                              height: 60,
                            ),
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
                  }).toList(),
                ),
              ),
            ),
            // Left Arrow
            Positioned(
              left: 0,
              top: 60,
              child: CircleAvatar(
                backgroundColor: Colors.black.withOpacity(0.5), // Semi-transparent background
                radius: 20,
                child: IconButton(
                  icon: const Icon(Icons.arrow_back_ios, size: 18, ),
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
                  onPressed: scrollRight,
                  color: Colors.white,
                  splashRadius: 24,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
