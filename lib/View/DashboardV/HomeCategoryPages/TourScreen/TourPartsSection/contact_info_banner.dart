import 'package:flutter/material.dart';

class ContactInfoBanner extends StatelessWidget {
  const ContactInfoBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Color(0xff3b3f51),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Hassle Free. 24X7 on-trip assistance',
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.bold,
                fontFamily: 'poppins',
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: const [
                Icon(Icons.call, color: Colors.white, size: 20),
                SizedBox(width: 8),
                Text(
                  '91+ 9211252356',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'poppins',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Row(
              children: const [
                Icon(Icons.email, color: Colors.white, size: 20),
                SizedBox(width: 8),
                Text(
                  'holidays@tripgoonline.com',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'poppins',
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
