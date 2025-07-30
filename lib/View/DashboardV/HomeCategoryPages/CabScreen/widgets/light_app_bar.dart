import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class LightAppBar extends StatelessWidget {
  final String drop, date;
  final VoidCallback onBack, onSearch, onEdit;

  const LightAppBar({
    super.key,
    required this.drop,
    required this.date,
    required this.onBack,
    required this.onSearch,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      backgroundColor: Colors.white,
      systemOverlayStyle: SystemUiOverlayStyle.dark,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.green.shade600),
                ),
                child: Text(
                  'LIVE',
                  style: GoogleFonts.poppins(
                    color: Colors.green.shade700,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Flexible(
                child: Text(
                  drop,
                  style: GoogleFonts.poppins(
                    color: Colors.black87,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.visible,
                  softWrap: true,
                ),
              ),
            ],
          ),
          Text(
            date,
            style: GoogleFonts.poppins(
              color: Colors.grey.shade600,
              fontSize: 12,
            ),
          ),
        ],
      ),
      leading: IconButton(
        icon: _iconButton(Icons.arrow_back_ios_new),
        onPressed: onBack,
      ),
      actions: [
        IconButton(
          icon: _iconButton(Icons.search),
          onPressed: onSearch,
        ),
        IconButton(
          icon: _iconButton(Icons.edit_outlined),
          onPressed: onEdit,
        ),
        const SizedBox(width: 8),
      ],
    );
  }

  Widget _iconButton(IconData icon) => Container(
    padding: const EdgeInsets.all(8),
    decoration: BoxDecoration(
      color: Colors.grey.shade100,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Icon(icon, color: const Color(0xff1B499F)),
  );
}
