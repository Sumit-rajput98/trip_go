import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

typedef EditOptionCallback = void Function();

void showEditBottomSheet(BuildContext context, {
  required VoidCallback onSearchTap,
  required VoidCallback onDateTimeEditTap,
  required VoidCallback onPreferencesTap,
}) {
  const themeColor1 = Color(0xff1B499F);

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) => Container(
      height: MediaQuery.of(context).size.height * 0.7,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          // Handle bar
          Container(
            width: 40,
            height: 5,
            margin: const EdgeInsets.only(top: 12, bottom: 20),
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          // Header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                const Icon(Icons.edit_outlined, color: themeColor1, size: 24),
                const SizedBox(width: 12),
                Text(
                  'Edit Journey Details',
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const Spacer(),
                IconButton(
                  icon: Icon(Icons.close, color: Colors.grey.shade600),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
          ),
          Divider(color: Colors.grey.shade200),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(20),
              children: [
                _buildEditOption(
                  context,
                  'Change Route',
                  'Delhi → Noida',
                  Icons.route,
                  onSearchTap,
                ),
                _buildEditOption(
                  context,
                  'Change Date & Time',
                  'Today • 8:30 AM',
                  Icons.access_time,
                  onDateTimeEditTap,
                ),
                _buildEditOption(
                  context,
                  'Change Trip Type',
                  'Airport Transfer',
                  Icons.flight_takeoff,
                  onSearchTap,
                ),
                _buildEditOption(
                  context,
                  'Add Preferences',
                  'Overseas, Travellers, Luggage',
                  Icons.tune,
                  onPreferencesTap,
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

Widget _buildEditOption(
    BuildContext context,
    String title,
    String subtitle,
    IconData icon,
    VoidCallback onTap,
    ) {
  const themeColor1 = Color(0xff1B499F);

  return Container(
    margin: const EdgeInsets.only(bottom: 16),
    child: Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          Navigator.pop(context);
          onTap();
        },
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.grey.shade50,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: themeColor1.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, color: themeColor1, size: 20),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey.shade400),
            ],
          ),
        ),
      ),
    ),
  );
}
