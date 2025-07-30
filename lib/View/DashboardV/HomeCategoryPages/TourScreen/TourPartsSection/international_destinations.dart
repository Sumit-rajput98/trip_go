import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../../../../ViewM/TourVM/international_destination_view_model.dart';
import '../tour_category_view.dart';
import 'city_builder.dart';

class InternationalDestinations extends StatefulWidget {
  const InternationalDestinations({super.key});

  @override
  State<InternationalDestinations> createState() => _InternationalDestinationsState();
}

class _InternationalDestinationsState extends State<InternationalDestinations> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => InternationalDestinationViewModel()..loadDestinations(),
      child: Consumer<InternationalDestinationViewModel>(
        builder: (context, model, _) {
          if (model.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          return Column(
            children: [
              Center(
                child: Column(
                  children: [
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: 'Popular ',
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.bold,
                              color: Color(0xffF73130),
                              fontSize: 18,
                            ),
                          ),
                          TextSpan(
                            text: 'International Destination',
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              ...model.destinations.map((destination) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TourCategoryView(
                          name: destination.name,
                          slug: destination.slug,
                        ),
                      ),
                    );
                  },
                  child: CityBuilder(
                    img: destination.image,
                    title: destination.name,
                  ),
                ),
              )),
            ],
          );
        },
      ),
    );
  }
}

