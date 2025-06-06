import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'city_builder.dart';

class InternationalDestinations extends StatelessWidget {
  const InternationalDestinations({super.key});

  @override
  Widget build(BuildContext context) {
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
                        fontSize: 20,
                      ),
                    ),
                    TextSpan(
                      text: 'International Destination',
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        ...[
          {
            'title': 'Italy',
            'img': 'https://tripoholidays.in/public/img/media_gallery/cd6eec6b-731b-4f79-91b5-e1f8b74b886e_mANtvQfPHI.jpg',
          },
          {
            'title': 'Austria',
            'img': 'https://tripoholidays.in/public/img/media_gallery/Museumsinsel_Berlin_Juli_2021_1_(cropped)_rruh3Pt1lN.jpg',
          },
          {
            'title': 'Switzerland',
            'img': 'https://tripoholidays.in/public/img/media_gallery/Norway_y6d1tks3nw.png',
          },
          {
            'title': 'France',
            'img': 'https://tripoholidays.in/public/img/media_gallery/eiffel-tower-and-fountains_1440x_wmBbC6nG0D.jpg',
          },
          {
            'title': 'Netherlands',
            'img': 'https://tripoholidays.in/public/img/media_gallery/Amsterdam%201_agMopUBBzk.jpg',
          },
        ].map((city) => Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: CityBuilder(img: city['img']!, title: city['title']!),
        )),
      ],
    );
  }
}

