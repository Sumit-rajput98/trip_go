import 'package:flutter/material.dart';

class CityBuilder extends StatelessWidget {
  final String img;
  final String title;

  const CityBuilder({
    Key? key,
    required this.img,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: Stack(
          children: [
            Image.network(
              img,
              height: 180,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) =>
              const Icon(Icons.broken_image, size: 100),
              // loadingBuilder: (context, child, progress) {
              //   if (progress == null) return child;
              //   return Container(
              //     height: 180,
              //     width: double.infinity,
              //     child: const Center(child: CircularProgressIndicator()),
              //   );
              // },
            ),
            Positioned(
              left: 8,
              bottom: 8,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.black54,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  title,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'poppins'
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}