import 'package:flutter/material.dart';

import '../../../../../constants.dart';

class DescriptionSection extends StatefulWidget {
  final String overview;
  const DescriptionSection({super.key, required this.overview});

  @override
  State<DescriptionSection> createState() => _DescriptionSectionState();
}

class _DescriptionSectionState extends State<DescriptionSection> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Description",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            fontFamily: 'Poppins',
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _isExpanded
                    ? widget.overview
                    : widget.overview.length > 180
                    ? "${widget.overview.substring(0, 180)}..."
                    : widget.overview,
                style: const TextStyle(fontSize: 14, fontFamily: 'poppins'),
              ),
              const SizedBox(height: 8),
              GestureDetector(
                onTap: () {
                  setState(() {
                    _isExpanded = !_isExpanded;
                  });
                },
                child: Text(
                  _isExpanded ? "Read less" : "Read more",
                  style: TextStyle(
                    fontSize: 14,
                    color: constants.themeColor1,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'poppins'
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
