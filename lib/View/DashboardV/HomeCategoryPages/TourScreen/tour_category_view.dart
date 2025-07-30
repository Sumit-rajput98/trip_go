import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trip_go/View/DashboardV/HomeCategoryPages/profile/change_password.dart';
import 'package:trip_go/ViewM/TourVM/destinantion_view_model.dart';
import 'package:trip_go/constants.dart';
import '../../../../ViewM/TourVM/category_view_model.dart';
import '../../HomeWidgets/submit_query_form.dart';
import '../../HomeWidgets/tour_card_shimmer.dart';
import 'TourWidget/quote_button.dart';
import 'TourWidget/top_image_search_bar.dart';
import 'TourWidget/tour_card.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TourCategoryView extends StatefulWidget {
  final String name;
  final String slug;
  const TourCategoryView({super.key, required this.name, required this.slug});

  @override
  State<TourCategoryView> createState() => _TourCategoryViewState();
}

class _TourCategoryViewState extends State<TourCategoryView> {
  List<String> selectedThemes = [];
  void _showFilterPopup(
    BuildContext context,
    List<String> selectedPackageThemes,
  ) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) {
        RangeValues priceRange = const RangeValues(10000, 89000);
        RangeValues durationRange = const RangeValues(4, 8);

        Map<String, bool> themes = {
          "Honeymoon": selectedPackageThemes.contains("Honeymoon"),
          "Fixed Group Departure": selectedPackageThemes.contains(
            "Fixed Group Departure",
          ),
          "Family": selectedPackageThemes.contains("Family"),
          "Adventure": selectedPackageThemes.contains("Adventure"),
          "Summer": selectedPackageThemes.contains("Summer"),
          "Ladies Special": selectedPackageThemes.contains("Ladies Special"),
          "Beaches": selectedPackageThemes.contains("Beaches"),
          "Winter": selectedPackageThemes.contains("Winter"),
        };

        return StatefulBuilder(
          builder: (context, setState) {
            return Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Header
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Filter",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            priceRange = const RangeValues(10000, 178000);
                            durationRange = const RangeValues(4, 8);
                            themes.updateAll((key, value) => false);
                          });
                          Provider.of<CategoryViewModel>(
                            context,
                            listen: false,
                          ).resetFilters();
                        },
                        child: Text(
                          "Reset",
                          style: TextStyle(color: constants.themeColor1),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  // Price Range
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Price",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: 'poppins',
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "₹${priceRange.start.toInt()} - ₹${priceRange.end.toInt()}",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: 'poppins',
                      ),
                    ),
                  ),
                  SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                      activeTrackColor: constants.themeColor1,
                      inactiveTrackColor: Colors.grey.shade300,
                      thumbColor: constants.themeColor1,
                      overlayColor: constants.themeColor1.withOpacity(0.2),
                      valueIndicatorColor: constants.themeColor1,
                      thumbShape: const RoundSliderThumbShape(
                        enabledThumbRadius: 8,
                      ),
                      overlayShape: const RoundSliderOverlayShape(
                        overlayRadius: 14,
                      ),
                    ),
                    child: RangeSlider(
                      values: priceRange,
                      min: 10000,
                      max: 178000,
                      divisions: 100,
                      labels: RangeLabels(
                        "₹${priceRange.start.toInt()}",
                        "₹${priceRange.end.toInt()}",
                      ),
                      onChanged: (val) => setState(() => priceRange = val),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Duration Range
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Duration",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: 'poppins',
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Set Your Days: ${durationRange.start.toInt()} - ${durationRange.end.toInt()}",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: 'poppins',
                      ),
                    ),
                  ),
                  SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                      activeTrackColor: constants.themeColor1,
                      inactiveTrackColor: Colors.grey.shade300,
                      thumbColor: constants.themeColor1,
                      overlayColor: constants.themeColor1.withOpacity(0.2),
                      valueIndicatorColor: constants.themeColor1,
                      thumbShape: const RoundSliderThumbShape(
                        enabledThumbRadius: 8,
                      ),
                      overlayShape: const RoundSliderOverlayShape(
                        overlayRadius: 14,
                      ),
                    ),
                    child: RangeSlider(
                      values: durationRange,
                      min: 4,
                      max: 8,
                      divisions: 4,
                      labels: RangeLabels(
                        "${durationRange.start.toInt()} Days",
                        "${durationRange.end.toInt()} Days",
                      ),
                      onChanged: (val) => setState(() => durationRange = val),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Themes
                  Align(
                    alignment: Alignment.centerLeft,
                    child: const Text(
                      "Themes",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: 'poppins',
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Wrap(
                    spacing: 8,
                    children:
                        themes.keys.map((theme) {
                          return FilterChip(
                            label: Text(theme),
                            selected: themes[theme]!,
                            onSelected: (selected) {
                              setState(() {
                                themes[theme] = selected;
                              });
                            },
                          );
                        }).toList(),
                  ),

                  const SizedBox(height: 30),

                  // Apply Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        final selectedThemes =
                            themes.entries
                                .where((entry) => entry.value)
                                .map((entry) => entry.key)
                                .toList();

                        Provider.of<CategoryViewModel>(
                          context,
                          listen: false,
                        ).applyFilters(
                          minPrice: priceRange.start,
                          maxPrice: priceRange.end,
                          maxDays: durationRange.end.toInt(),
                          selectedThemes: selectedThemes,
                        );

                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xfff15842),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        textStyle: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Poppins',
                        ),
                      ),
                      child: const Text("Apply"),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  void _showThemesPopup(
    BuildContext context,
    List<String> selectedPackageThemes,
  ) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) {
        double price = 89000;
        double duration = 6;
        Map<String, bool> themes = {
          "Honeymoon": selectedPackageThemes.contains("Honeymoon"),
          "Fixed Group Departure": selectedPackageThemes.contains(
            "Fixed Group Departure",
          ),
          "Family": selectedPackageThemes.contains("Family"),
          "Adventure": selectedPackageThemes.contains("Adventure"),
          "Summer": selectedPackageThemes.contains("Summer"),
          "Ladies Special": selectedPackageThemes.contains("Ladies Special"),
          "Beaches": selectedPackageThemes.contains("Beaches"),
          "Winter": selectedPackageThemes.contains("Winter"),
        };

        return StatefulBuilder(
          builder: (context, setState) {
            return Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Header
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Holiday Themes",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'poppins',
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            themes.updateAll((key, value) => false);
                          });
                          Provider.of<CategoryViewModel>(
                            context,
                            listen: false,
                          ).resetFilters();
                        },
                        child: Text(
                          "Reset",
                          style: TextStyle(color: constants.themeColor1),
                        ),
                      ),
                    ],
                  ),

                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Themes",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: 'poppins',
                      ),
                    ),
                  ),
                  SizedBox(height: 5),
                  Wrap(
                    spacing: 8,
                    children:
                        themes.keys.map((theme) {
                          return FilterChip(
                            label: Text(theme),
                            selected: themes[theme]!,
                            onSelected: (selected) {
                              setState(() {
                                themes[theme] = selected;
                              });
                            },
                          );
                        }).toList(),
                  ),

                  const SizedBox(height: 30),

                  // Apply Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        final selectedThemes =
                            themes.entries
                                .where((entry) => entry.value)
                                .map((entry) => entry.key)
                                .toList();

                        Provider.of<CategoryViewModel>(
                          context,
                          listen: false,
                        ).applyFilters(
                          maxPrice: price,
                          maxDays: duration.toInt(),
                          selectedThemes: selectedThemes,
                        );

                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xfff15842),
                        foregroundColor: Colors.white, // 🧾 Text color
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            30,
                          ), // 🟠 Rounded corners
                        ),
                        textStyle: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Poppins',
                        ),
                      ),
                      child: const Text("Apply"),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  void _showSortPopup(BuildContext context, CategoryViewModel viewModel) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) {
        String selected = 'low';

        return StatefulBuilder(
          builder: (context, setState) {
            return Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Sort By",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'poppins'),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            selected = 'low';
                          });
                        },
                        child: Text(
                          "Reset",
                          style: TextStyle(
                              color: Colors.blue, fontFamily: 'poppins'),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),

                  // Sort Options
                  Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () => setState(() => selected = 'low'),
                          child: Container(
                            padding: EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: selected == 'low'
                                  ? Colors.orange[100]
                                  : Colors.grey[200],
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Column(
                              children: [
                                SvgPicture.network(
                                  "https://www.easemytrip.com/holidays/Content/customize/mob/newimg/low-hirgh.svg",
                                  height: 50,
                                  placeholderBuilder: (_) =>
                                      CircularProgressIndicator(),
                                ),
                                SizedBox(height: 8),
                                Text("Low to High",
                                    style: TextStyle(fontFamily: 'poppins')),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: GestureDetector(
                          onTap: () => setState(() => selected = 'high'),
                          child: Container(
                            padding: EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: selected == 'high'
                                  ? Colors.orange[100]
                                  : Colors.grey[200],
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Column(
                              children: [
                                SvgPicture.network(
                                  "https://www.easemytrip.com/holidays/Content/customize/mob/newimg/hight-low.svg",
                                  height: 50,
                                  placeholderBuilder: (_) =>
                                      CircularProgressIndicator(),
                                ),
                                SizedBox(height: 8),
                                Text("High to Low",
                                    style: TextStyle(fontFamily: 'poppins')),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 30),

                  // Apply Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        viewModel.sortPackagesByPrice(
                            ascending: selected == 'low');
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xfff15842),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        textStyle: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Poppins',
                        ),
                      ),
                      child: const Text("Apply"),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  void _showDurationPopup(
    BuildContext context,
    List<String> selectedPackageThemes,
  ) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) {
        RangeValues durationRange = const RangeValues(4, 8);

        return StatefulBuilder(
          builder: (context, setState) {
            return Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Duration Range
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Duration",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            durationRange = const RangeValues(4, 8);
                          });
                          Provider.of<CategoryViewModel>(
                            context,
                            listen: false,
                          ).resetFilters();
                        },
                        child: Text(
                          "Reset",
                          style: TextStyle(color: constants.themeColor1),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Set Your Days: ${durationRange.start.toInt()} - ${durationRange.end.toInt()}",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: 'poppins',
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                      activeTrackColor: constants.themeColor1,
                      inactiveTrackColor: Colors.grey.shade300,
                      thumbColor: constants.themeColor1,
                      overlayColor: constants.themeColor1.withOpacity(0.2),
                      valueIndicatorColor: constants.themeColor1,
                      thumbShape: const RoundSliderThumbShape(
                        enabledThumbRadius: 8,
                      ),
                      overlayShape: const RoundSliderOverlayShape(
                        overlayRadius: 14,
                      ),
                    ),
                    child: RangeSlider(
                      values: durationRange,
                      min: 4,
                      max: 8,
                      divisions: 4,
                      labels: RangeLabels(
                        "${durationRange.start.toInt()} Days",
                        "${durationRange.end.toInt()} Days",
                      ),
                      onChanged: (val) => setState(() => durationRange = val),
                    ),
                  ),
                  const SizedBox(height: 50),
                  // Apply Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Provider.of<CategoryViewModel>(
                          context,
                          listen: false,
                        ).applyFilters(
                          maxDays: durationRange.end.toInt(),
                          selectedThemes: selectedThemes,
                        );

                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xfff15842),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        textStyle: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Poppins',
                        ),
                      ),
                      child: const Text("Apply"),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  void _showPricePopup(
    BuildContext context,
    List<String> selectedPackageThemes,
  ) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) {
        RangeValues priceRange = const RangeValues(12999, 178000);

        return StatefulBuilder(
          builder: (context, setState) {
            return Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Header
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Price Range",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'poppins',
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            priceRange = const RangeValues(10000, 178000);
                          });
                          Provider.of<CategoryViewModel>(
                            context,
                            listen: false,
                          ).resetFilters();
                        },
                        child: Text(
                          "Reset",
                          style: TextStyle(color: constants.themeColor1),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Set your Own Budget",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: 'poppins',
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "₹${priceRange.start.toInt()} - ₹${priceRange.end.toInt()}",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: 'poppins',
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                      activeTrackColor: constants.themeColor1,
                      inactiveTrackColor: Colors.grey.shade300,
                      thumbColor: constants.themeColor1,
                      overlayColor: constants.themeColor1.withOpacity(0.2),
                      valueIndicatorColor: constants.themeColor1,
                      thumbShape: const RoundSliderThumbShape(
                        enabledThumbRadius: 8,
                      ),
                      overlayShape: const RoundSliderOverlayShape(
                        overlayRadius: 14,
                      ),
                    ),
                    child: RangeSlider(
                      values: priceRange,
                      min: 12999,
                      max: 178000,
                      divisions: 100,
                      labels: RangeLabels(
                        "₹${priceRange.start.toInt()}",
                        "₹${priceRange.end.toInt()}",
                      ),
                      onChanged: (val) => setState(() => priceRange = val),
                    ),
                  ),

                  const SizedBox(height: 50),

                  // Apply Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Provider.of<CategoryViewModel>(
                          context,
                          listen: false,
                        ).applyFilters(
                          minPrice: priceRange.start,
                          maxPrice: priceRange.end,
                          selectedThemes: selectedThemes,
                        );

                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xfff15842),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        textStyle: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Poppins',
                        ),
                      ),
                      child: const Text("Apply"),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  TextEditingController fromController = TextEditingController();
  TextEditingController toController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<CategoryViewModel>(
        context,
        listen: false,
      ).loadPackages(widget.slug);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            // Scrollable content
            Padding(
              padding: const EdgeInsets.only(top: 300), // Adjust height to avoid overlap
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // Removed TopImageSearchBar and Filter buttons from here
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Consumer<CategoryViewModel>(
                        builder: (context, viewModel, child) {
                          if (viewModel.isLoading || viewModel.data.isEmpty) {
                            return Column(
                              children: List.generate(3, (_) => const TourCardShimmer()),
                            );
                          }

                          return ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: viewModel.data.length,
                            itemBuilder: (context, index) {
                              final package = viewModel.data[index];
                              return GestureDetector(
                                onTap: () {
                                  print("Package themes : ${package.packageThemes}");
                                },
                                child: TourCard(package: package),
                              );
                            },
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 100),
                  ],
                ),
              ),
            ),

            // Fixed TopImageSearchBar + Filter Buttons
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Column(
                children: [
                  Consumer<DestinationViewModel>(
                    builder: (context, viewModel, child) {
                      final allDestinations = viewModel.groupedDestinations.expand((e) => e).toList();
                      return TopImageSearchBar(
                        category: widget.name,
                        fromController: fromController,
                        toController: toController,
                        allDestinations: allDestinations,
                      );
                    },
                  ),
                  // const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    color: Colors.white, // ensure it doesn't overlap content
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Wrap(
                        spacing: 8,
                        children: [
                          filterButton("Filters", Icons.filter_list),
                          filterButton("Themes", Icons.category),
                          filterButton("Sort", Icons.sort),
                          filterButton("Duration", Icons.access_time),
                          filterButton("Price", Icons.credit_card),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Bottom Buttons remain unchanged
            Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () async {
                        final url = Uri.parse(
                          "https://api.whatsapp.com/send/?phone=919211252356&text=I+need+Europe+tours+packages&type=phone_number&app_absent=0",
                        );

                        if (await canLaunchUrl(url)) {
                          await launchUrl(
                            url,
                            mode: LaunchMode.externalApplication,
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Could not open WhatsApp"),
                            ),
                          );
                        }
                      },
                      child: Container(
                        height: 50,
                        color: const Color(0xff2AA81A),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/icons/whatsapp.png',
                                height: 20,
                                width: 20,
                              ),
                              const SizedBox(width: 8),
                              const Text(
                                "WhatsApp Chat",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'poppins',
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(20),
                            ),
                          ),
                          builder:
                              (_) => const Padding(
                            padding: EdgeInsets.only(top: 20),
                            child: SubmitQueryFormPage(),
                          ),
                        );
                      },
                      child: Container(
                        height: 50,
                        color: constants.themeColor1,
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/icons/faq.png',
                                height: 30,
                                width: 30,
                                color: Colors.white,
                              ),
                              const SizedBox(width: 8),
                              const Text(
                                "Submit Query",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'poppins',
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }


  Widget filterButton(String label, IconData icon) {
    return OutlinedButton.icon(
      onPressed: () {
        switch (label) {
          case "Filters":
            _showFilterPopup(context, selectedThemes);
            break;
          case "Themes":
            _showThemesPopup(context, selectedThemes);
            break;
          case "Sort":
            _showSortPopup(context, Provider.of<CategoryViewModel>(context, listen: false));
            break;
          case "Duration":
            _showDurationPopup(context, selectedThemes);
            break;
          case "Price":
            _showPricePopup(context, selectedThemes);
            break;
        }
      },
      icon: Icon(icon, size: 16, color: Colors.black),
      label: Text(
        label,
        style: TextStyle(
          fontFamily: 'poppins',
          color: Colors.black,
          fontWeight: FontWeight.w300,
        ),
      ),
      style: OutlinedButton.styleFrom(
        shape: StadiumBorder(),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      ),
    );
  }
}
