import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trip_go/View/DashboardV/HomeCategoryPages/TourScreen/TourWidget/helper.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:trip_go/constants.dart';

class AnimatedEnquireButton extends StatefulWidget {
  const AnimatedEnquireButton({super.key});

  @override
  State<AnimatedEnquireButton> createState() => _AnimatedEnquireButtonState();
}

class _AnimatedEnquireButtonState extends State<AnimatedEnquireButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Color?> _borderColor;

  bool isPopupOpen = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    _borderColor = ColorTween(
      begin: constants.themeColor1,
      end: constants.themeColor2,
    ).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void togglePopup(BuildContext context) {
    if (!isPopupOpen) {
      // Show the dialog
      setState(() {
        isPopupOpen = true;
      });

      showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 100),
              child: Material(
                borderRadius: BorderRadius.circular(16),
                color: Colors.white,
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: Colors.white,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _optionTile(
                        title: "Get a quote",
                        subtitle: "Customise your holiday to your liking",
                        icon: Icons.request_quote_outlined,
                        onTap: () {
                          showQuoteBottomSheet(context, 0);
                        },
                      ),
                      const SizedBox(height: 12),
                      _optionTile(
                        title: "Chat with Whatsapp",
                        subtitle: "Customise your holiday to your liking",
                        icon: Icons.chat_bubble_outline,
                        onTap: () async {
                          final url = Uri.parse(
                              "https://api.whatsapp.com/send/?phone=919211252356&text=Hi&type=phone_number&app_absent=0");

                          if (await canLaunchUrl(url)) {
                            await launchUrl(
                              url,
                              mode: LaunchMode.externalApplication,
                            );
                          }
                        },
                      ),
                      const SizedBox(height: 12),
                      _optionTile(
                        title: "Call Us",
                        subtitle: "Our experts are just a call away",
                        icon: Icons.phone_outlined,
                        onTap: () async {
                          String phoneNumber = '+919211252356';
                          final Uri uri =
                              Uri(scheme: 'tel', path: phoneNumber);
                          if (await canLaunchUrl(uri)) {
                            await launchUrl(uri);
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ).then((_) {
        // When dialog is dismissed, reset the button state
        setState(() {
          isPopupOpen = false;
        });
      });
    } else {
      // Close dialog if already open
      Navigator.of(context).pop();
      setState(() {
        isPopupOpen = false;
      });
    }
  }

  Widget _optionTile({
    required String title,
    required String subtitle,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.grey.shade100,
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [Color(0xFF1B499F), Color(0xFFF73130)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Icon(icon, color: Colors.white, size: 20),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios, size: 14, color: Colors.grey),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _borderColor,
      builder: (context, child) {
        return GestureDetector(
          onTap: () => togglePopup(context),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              border: Border.all(
                color: _borderColor.value ?? Colors.orangeAccent,
                width: 2,
              ),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: _borderColor.value!.withOpacity(0.4),
                  blurRadius: 8,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
  padding: const EdgeInsets.all(6),
  decoration: BoxDecoration(
    shape: BoxShape.circle,
    gradient: LinearGradient(
      colors: [constants.themeColor1, constants.themeColor2],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    boxShadow: [
      BoxShadow(
        color: Colors.black26,
        blurRadius: 6,
        offset: Offset(0, 2),
      ),
    ],
  ),
  child: Icon(
    isPopupOpen ? Icons.close : Icons.chat,
    color: Colors.white,
    size: 22,
  ),
),
 const SizedBox(width: 8),
                Text(
                  isPopupOpen ? 'Close' : 'Enquire Now',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                    fontSize: 12,
                    fontFamily: 'poppins',
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
