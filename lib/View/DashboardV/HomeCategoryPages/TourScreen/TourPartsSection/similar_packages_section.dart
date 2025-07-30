import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../Model/TourM/subcategory_model.dart';
import '../../../../../constants.dart';

class SimilarPackagesSection extends StatefulWidget {
  final List<SimilarPackage> similarPackagesList;
  const SimilarPackagesSection({super.key, required this.similarPackagesList});

  @override
  State<SimilarPackagesSection> createState() => _SimilarPackagesSectionState();
}

class _SimilarPackagesSectionState extends State<SimilarPackagesSection> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RichText(
            text: TextSpan(
              text: 'Similar',
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.bold,
                fontSize: 30,
                color: constants.themeColor1,
              ),
              children: [
                TextSpan(
                  text: ' Packages',
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          ...widget.similarPackagesList.map((package) {
            return Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              width: double.infinity,
              child: Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2)),
                clipBehavior: Clip.hardEdge,
                child: Stack(
                  children: [
                    Image.network(
                      package.image, // handle null if needed
                      height: 320,
                      width: double.infinity,
                      fit: BoxFit.fill,
                    ),
                    Positioned(
                      right: 15,
                      top: 12,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: const Color(0xff002543),
                          borderRadius: BorderRadius.circular(2),
                        ),
                        child: Text(
                          package.name, // example: "8D/7N"
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontFamily: 'poppins',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        color: Colors.white,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              package.name ?? "",
                              style: TextStyle(
                                fontSize: 20,
                                color: constants.themeColor1,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'poppins',
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              package.detailsDayNight ?? "", // description or route
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'poppins',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
        ],
      ),
    );
  }

}
