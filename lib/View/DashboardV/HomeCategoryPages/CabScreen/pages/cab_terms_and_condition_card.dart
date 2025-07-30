import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class TermsConditionsCard extends StatelessWidget {
  final String htmlContent;

  const TermsConditionsCard({super.key, required this.htmlContent});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Terms & Conditions",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                fontFamily: 'poppins',
              ),
            ),
            const Divider(),
            Html(
              data: htmlContent,
              style: {
                "li": Style(
                  fontSize: FontSize.medium,
                  fontFamily: 'poppins',
                ),
              },
            ),
          ],
        ),
      ),
    );
  }
}
