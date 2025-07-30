import 'package:flutter/material.dart';
import 'package:trip_go/View/DashboardV/HomeCategoryPages/TourScreen/TourWidget/helper.dart';
import 'package:trip_go/View/DashboardV/HomeCategoryPages/TourScreen/TourWidget/quote_button.dart';
import 'package:trip_go/View/DashboardV/HomeCategoryPages/TourScreen/TourWidget/success_dialog.dart';
import 'package:trip_go/View/DashboardV/HomeCategoryPages/TourScreen/TourWidget/unlabelled_text_field_.dart';
import '../../../../../Model/TourM/category_model.dart';
import '../../../../../Model/TourM/package_inquiry_model.dart';
import '../../../../../ViewM/TourVM/package_inquiry_view_model.dart';
import '../../../../../constants.dart';
import '../tour_subcategory_view.dart';
import 'date_picker_field.dart';
import 'labeled_text_field.dart';
import 'number_picker_field.dart';

class TourCard extends StatelessWidget {
 
  final TourPackage package;
  const TourCard({super.key, required this.package});

  @override
  Widget build(BuildContext context) {
  
Widget buildFieldWithIcon({
  required TextEditingController controller,
  required String hintText,
  required IconData icon,
  TextInputType keyboardType = TextInputType.text,
  bool readOnly = false,
  VoidCallback? onTap,
}) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 14),
    child: TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      readOnly: readOnly,
      onTap: onTap,
      style: const TextStyle(fontFamily: 'Poppins'),
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: Icon(icon, color: Colors.grey),
        hintStyle: const TextStyle(fontFamily: 'Poppins', fontSize: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Color(0xFF1B499F)),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      validator: (val) => val == null || val.isEmpty ? 'Required' : null,
    ),
  );
}

Widget counterField({
  required String title,
  required int value,
  required Function(int) onChanged,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        title,
        style: const TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w500),
      ),
      const SizedBox(height: 6),
      Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade400),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            IconButton(
              onPressed: value > 0 ? () => onChanged(value - 1) : null,
              icon: const Icon(Icons.remove),
              color: Colors.grey,
            ),
            Text('$value', style: const TextStyle(fontFamily: 'Poppins')),
            IconButton(
              onPressed: () => onChanged(value + 1),
              icon: const Icon(Icons.add),
              color: const Color(0xFF1B499F),
            ),
          ],
        ),
      ),
    ],
  );
}

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 6,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
              child: Image.network(
                package.image,
                height: 180,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Image.network("https://admin.tripgoonline.com/public/img/media_gallery/goa_img_ssuV5Tgjk2.jpg", height: 180,
                  width: double.infinity,
                  fit: BoxFit.cover,),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Package Name
                  Text(
                    package.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: 'poppins',
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Divider(),

                  // Top Inclusions
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: package.topInclusions.map((inclusion) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Image.network(
                            inclusion.image,
                            height: 30,
                            width: 30,
                            errorBuilder: (_, __, ___) => const Icon(Icons.star),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Duration
                  Text(
                    "${package.noOfNights} Nights / ${package.noOfDays} Days",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: constants.themeColor1,
                      fontFamily: 'poppins',
                    ),
                  ),

                  const SizedBox(height: 4),
                  Text(
                    package.detailsDayNight,
                    style: const TextStyle(fontFamily: 'poppins'),
                  ),

                  const Divider(),
                  const SizedBox(height: 8),

                  // Pricing & Buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Pricing
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Starting for",
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: 'poppins',
                              color: Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            "₹${package.publishPrice}",
                            style: const TextStyle(
                              decoration: TextDecoration.lineThrough,
                              color: Colors.grey,
                              fontSize: 14,
                              fontFamily: 'poppins',
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            "₹${package.offerPrice}",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'poppins',
                              color: constants.themeColor1,
                            ),
                          ),
                        ],
                      ),

                      // Buttons
                      Column(
                        children: [
                          GetQuotesButton(onPressed: () {
                            showQuoteBottomSheet(context, package.id);
                          }),
                          const SizedBox(height: 4),
                          ViewDetailsButton(onPressed: () {Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => TourSubcategoryView(slug: package.slug),
                            ),
                          ); // Your view details logic here
                          }),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
