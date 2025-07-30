import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trip_go/View/DashboardV/HomeCategoryPages/TourScreen/TourPartsSection/cancelation_policy.dart';
import 'package:trip_go/View/DashboardV/HomeCategoryPages/TourScreen/TourPartsSection/duration_and_details_section.dart';
import 'package:trip_go/View/DashboardV/HomeCategoryPages/TourScreen/TourPartsSection/exclusion_section.dart';
import 'package:trip_go/View/DashboardV/HomeCategoryPages/TourScreen/TourPartsSection/inclusions_section.dart';
import 'package:trip_go/View/DashboardV/HomeCategoryPages/TourScreen/TourPartsSection/itenirary_section.dart';
import 'package:trip_go/View/DashboardV/HomeCategoryPages/TourScreen/TourPartsSection/need_help_section.dart';
import 'package:trip_go/View/DashboardV/HomeCategoryPages/TourScreen/TourPartsSection/our_policy_section.dart';
import 'package:trip_go/View/DashboardV/HomeCategoryPages/TourScreen/TourPartsSection/payment_policy_section.dart';
import 'package:trip_go/View/DashboardV/HomeCategoryPages/TourScreen/TourPartsSection/similar_packages_section.dart';
import 'package:trip_go/constants.dart';
import '../../../../ViewM/TourVM/subcategory_view_model.dart';
import 'TourPartsSection/description_section.dart';
import 'TourPartsSection/tour_details_input_section.dart';
import 'package:carousel_slider/carousel_slider.dart';

class TourSubcategoryView extends StatefulWidget {
  final String slug;
  const TourSubcategoryView({super.key,required this.slug});

  @override
  State<TourSubcategoryView> createState() => _TourSubcategoryViewState();
}

class _TourSubcategoryViewState extends State<TourSubcategoryView> {
  final GlobalKey _overviewKey = GlobalKey();
  final GlobalKey _itineraryKey = GlobalKey();
  final GlobalKey _termsKey = GlobalKey();
  final GlobalKey _inclusionKey = GlobalKey();
  final GlobalKey _exclusion = GlobalKey();
  final GlobalKey _enquireNow = GlobalKey();
  final ScrollController _scrollController = ScrollController();

  void _scrollToSection(GlobalKey key) {
    final context = key.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<SubCategoryViewModel>(context, listen: false).getSubCategory(widget.slug);
    });
  }

  @override
  Widget build(BuildContext context) {
    String splitTitle(String title) {
      if (title.contains(':')) {
        final parts = title.split(':');
        return '${parts[0].trim()}:\n${parts.sublist(1).join(':').trim()}';
      } else {
        final words = title.split(' ');
        // If there are more than 3 words, break after 2 or 3 words
        if (words.length >= 4) {
          return '${words.sublist(0, words.length - 2).join(' ')}\n${words.sublist(words.length - 2).join(' ')}';
        } else if (words.length == 3) {
          return '${words[0]} ${words[1]}\n${words[2]}';
        }
      }
      return title;
    }
    final subCategoryVM = Provider.of<SubCategoryViewModel>(context);
    print("Similar packages count: ${subCategoryVM.subCategoryData?.similarPackages?.length}");

    if (subCategoryVM.subCategoryData == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          controller: _scrollController,
          child: Column(
            children: [
              // Header with background image
              Stack(
                children: [
                  Image.network(
                    'https://triprex.egenslab.com/wp-content/plugins/triprex-core/inc/theme-options/images/breadcrumb/inner-banner-bg.jpg',
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  Positioned(
                    top: 20,
                    left: 0,
                    right: 0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap: (){
                                Navigator.pop(context);
                              },
                                child: Icon(Icons.arrow_back, color: Colors.white)),
                            SizedBox(height: 10,),
                            Text(
                              splitTitle(subCategoryVM.subCategoryData!.packageName),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Poppins',
                              ),
                              maxLines: 2,
                            ),
                            const SizedBox(height: 4),
                            Text("Tour Code:", style: TextStyle(color: Colors.white, fontFamily: 'poppins', fontSize: 12)),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                const Icon(Icons.nights_stay, color: Colors.red, size: 18),
                                const SizedBox(width: 4),
                                Text("${subCategoryVM.subCategoryData!.nights} Nights /", style: const TextStyle(color: Colors.white, fontFamily: 'poppins', fontSize: 12)),
                                const SizedBox(width: 4),
                                const Icon(Icons.wb_cloudy_outlined, color: Colors.red, size: 14),
                                const SizedBox(width: 4),
                                Text("${subCategoryVM.subCategoryData!.days} Days", style: TextStyle(color: Colors.white, fontFamily: 'poppins', fontSize: 12)),
                              ],
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 45),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              const Text(
                                "Starting From",
                                style: TextStyle(color: Colors.white, fontSize: 14, fontFamily: 'poppins', fontWeight: FontWeight.w500),
                              ),
                              Text(
                                "₹ ${subCategoryVM.subCategoryData!.offerPrice}",
                                style: TextStyle(color: Colors.white, fontSize: 16, fontFamily: 'poppins', fontWeight: FontWeight.w500),
                              ),
                              const Text(
                                " Per Person on \n twin sharing",
                                style: TextStyle(color: Colors.white, fontSize: 14, fontFamily: 'poppins', fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Positioned(bottom: 5,
                    right: 10,
                    child: Row(children: [
                    IconButton(
                                icon: const Icon(Icons.download,color: Colors.white,),
                                onPressed: () {},
                              ),
                              IconButton(
                                icon: const Icon(Icons.share,color: Colors.white,),
                                onPressed: () {},
                              ),
                  ],))                
                ],
              ),
              SizedBox(height: 20,),
              // Tab Bar
              Container(
                color: constants.ultraLightThemeColor1,
                height: 50,
                margin: const EdgeInsets.symmetric(vertical: 10),
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Row(
                  children: [
                    // Scrollable tab buttons
                    Expanded(
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          _buildTabButton("Overview"),
                          _buildTabButton("Itinerary"),
                          _buildTabButton("Inclusion"),
                          _buildTabButton("exclusion"),
                          _buildTabButton("Hotels"),
                          _buildTabButton("Terms & Conditions"),
                        ],
                      ),
                    ),
                    const SizedBox(width: 4),
                    // Fixed icons

                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: CarouselSlider(
                    options: CarouselOptions(
                      height: 280,
                      viewportFraction: 1.0,
                      enableInfiniteScroll: false,
                      enlargeCenterPage: false,
                      autoPlay: true,
                    ),
                    items: subCategoryVM.subCategoryData!.gallery.map((img) {
                      return Builder(
                        builder: (BuildContext context) {
                          return Image.network(
                            img.image,
                            width: double.infinity,
                            height: 280,
                            fit: BoxFit.cover,
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) return child;
                              return Container(
                                width: double.infinity,
                                height: 280,
                                color: Colors.grey.shade100,
                                child: const Center(child: CircularProgressIndicator()),
                              );
                            },
                            errorBuilder: (context, error, stackTrace) => Container(
                              width: double.infinity,
                              height: 280,
                              color: Colors.grey.shade200,
                              child: const Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.broken_image, size: 50, color: Colors.grey),
                                  SizedBox(height: 8),
                                  Text(
                                    'Image failed to load',
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    }).toList(),
                  ),
                ),
              ),

              // Description
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    KeyedSubtree(
                      key: _overviewKey,
                      child: DescriptionSection(
                        overview: subCategoryVM.subCategoryData!.overview,
                      ),
                    ),
                    const SizedBox(height: 20),

                    // ITINERARY
                    KeyedSubtree(
                      key: _itineraryKey,
                      child: ItenirarySection(
                        itineraryList: subCategoryVM.subCategoryData!.itinerary,
                      ),
                    ),
                    const SizedBox(height: 20,),
                    KeyedSubtree(
                        key: _inclusionKey,
                        child: InclusionSection(inclusions: subCategoryVM.subCategoryData!.inclusions,)
                    ),
                    const SizedBox(height: 20,),
                    KeyedSubtree(
                        key: _exclusion,
                        child: ExclusionSection(exclusions: subCategoryVM.subCategoryData!.exclusions,)
                    ),
                    const SizedBox(height: 20,),
                    KeyedSubtree(
                      key: _termsKey,
                      child: OurPolicySection(
                        tourPolicy: subCategoryVM.subCategoryData!.tourPolicy,
                      ),
                    ),
                    const SizedBox(height: 20,),
                    CancellationPolicySection(cancellationPolicy: subCategoryVM.subCategoryData!.tourPolicy),
                    const SizedBox(height: 20,),
                    PaymentPolicySection(paymentPolicy: subCategoryVM.subCategoryData!.paymentPolicy),
                    const SizedBox(height: 20,),
                    KeyedSubtree(
                        key: _enquireNow,
                        child: TourDetailsInputSection(id: subCategoryVM.subCategoryData!.id,)
                    ),
                    const SizedBox(height: 20,),
                    DurationAndDetailSection(day: subCategoryVM.subCategoryData!.days, night: subCategoryVM.subCategoryData!.nights, details_day_night: subCategoryVM.subCategoryData!.detailsDayNight,),
                    const SizedBox(height: 20,),
                    const NeedHelpSection(),
                    SimilarPackagesSection(similarPackagesList: subCategoryVM.subCategoryData?.similarPackages ?? [],),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      // Bottom Bar
      bottomNavigationBar: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: Colors.black87,
            boxShadow: [BoxShadow(blurRadius: 6, color: Colors.black12)],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "₹ ${subCategoryVM.subCategoryData!.offerPrice.toString()}",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.white,
                      fontFamily: 'Poppins',
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    "per person on twin sharing",
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.white,
                      fontFamily: 'Poppins',
                    ),
                  ),
                ],
              ),
              Container(
                height: 40,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xffF73130), Color(0xff1B499F)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: TextButton(
                  onPressed: () {
                    _scrollToSection(_enquireNow);
                  },
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    "Enquire Now",
                    style: TextStyle(fontSize: 14, fontFamily: 'Poppins'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTabButton(String title) {
    return GestureDetector(
      onTap: () {
        switch (title) {
          case "Overview":
            _scrollToSection(_overviewKey);
            break;
          case "Itinerary":
            _scrollToSection(_itineraryKey);
            break;
          case "Inclusion":
            _scrollToSection(_inclusionKey);
            break;
          case "exclusion":
            _scrollToSection(_exclusion);
            break;
          case "Hotels":
            _scrollToSection(_termsKey);
            break;
          case "Terms & Conditions":
            _scrollToSection(_termsKey);
            break;
        }
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 6),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Center(
          child: Text(
            title,
            style: const TextStyle(fontSize: 12, fontFamily: 'poppins'),
          ),
        ),
      ),
    );
  }
}
