import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CabFilterSheet extends StatefulWidget {
  const CabFilterSheet({super.key});

  @override
  State<CabFilterSheet> createState() => _CabFilterSheetState();
}

class _CabFilterSheetState extends State<CabFilterSheet> {
  static const Color themeBlue = Color(0xff1B499F);
  static const Color themeRed = Color(0xffF73130);

  // Sample filter options
  bool acOnly = false;
  bool nonAcOnly = false;
  bool sedan = false;
  bool suv = false;
  bool hatchback = false;

  void _resetFilters() {
    setState(() {
      acOnly = false;
      nonAcOnly = false;
      sedan = false;
      suv = false;
      hatchback = false;
    });
  }

  void _applyFilters() {
    final Map<String, bool> filters = {
      'ac': acOnly,
      'non_ac': nonAcOnly,
      'sedan': sedan,
      'suv': suv,
      'hatchback': hatchback,
    };
    Navigator.pop(context, filters); // Return selected filters
  }

  Widget _buildCheckbox(String label, bool value, void Function(bool?) onChanged) {
    return CheckboxListTile(
      value: value,
      onChanged: onChanged,
      controlAffinity: ListTileControlAffinity.leading,
      title: Text(
        label,
        style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w500),
      ),
      activeColor: themeBlue,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: DraggableScrollableSheet(
        expand: false,
        initialChildSize: 0.6,
        minChildSize: 0.4,
        maxChildSize: 0.9,
        builder: (_, controller) => Container(
          padding: const EdgeInsets.fromLTRB(20, 15, 20, 10),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            children: [
              Container(
                height: 5,
                width: 50,
                margin: const EdgeInsets.only(bottom: 10),
                decoration: BoxDecoration(
                  color: Colors.deepPurple.shade400,
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Filter Options", style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w600)),
                  TextButton(
                    onPressed: _resetFilters,
                    child: Text("Reset", style: GoogleFonts.poppins(color: themeBlue, fontWeight: FontWeight.w500, fontSize: 13)),
                  ),
                ],
              ),
              Expanded(
                child: SingleChildScrollView(
                  controller: controller,
                  child: Column(
                    children: [
                      _buildCheckbox("AC Cabs Only", acOnly, (val) => setState(() => acOnly = val!)),
                      _buildCheckbox("Non-AC Cabs Only", nonAcOnly, (val) => setState(() => nonAcOnly = val!)),
                      const Divider(),
                      _buildCheckbox("Sedan", sedan, (val) => setState(() => sedan = val!)),
                      _buildCheckbox("SUV", suv, (val) => setState(() => suv = val!)),
                      _buildCheckbox("Hatchback", hatchback, (val) => setState(() => hatchback = val!)),
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: double.infinity,
                height: 45,
                child: ElevatedButton(
                  onPressed: _applyFilters,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    elevation: 2,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                    padding: EdgeInsets.zero,
                  ),
                  child: Ink(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      gradient: const LinearGradient(colors: [themeBlue, themeRed]),
                    ),
                    child: Center(
                      child: Text(
                        "Apply",
                        style: GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 15),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
