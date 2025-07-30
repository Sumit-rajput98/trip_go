import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FilterBottomSheet extends StatefulWidget {
  const FilterBottomSheet({super.key});

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  static const Color themeBlue = Color(0xff1B499F);
  static const Color themeRed = Color(0xffF73130);

  // Cab Type Options
  final Map<String, int> cabTypes = {
    "Sedan": 5,
    "Hatchback": 5,
    "SUV": 7,
  };

  // Fuel Type Options
  final Map<String, int> fuelTypes = {
    "Any": 17,
    "Diesel": 3,
    "Petrol": 3,
    "CNG": 6,
  };

  Set<String> selectedCabTypes = {};
  Set<String> selectedFuelTypes = {};

  void _resetFilters() {
    setState(() {
      selectedCabTypes.clear();
      selectedFuelTypes.clear();
    });
  }

  void _applyFilters() {
    Navigator.pop(context, {
      "cabTypes": selectedCabTypes,
      "fuelTypes": selectedFuelTypes,
    });
  }

  Widget _buildCheckboxTile(String label, int count, bool selected, void Function(bool?) onChanged) {
    return CheckboxListTile(
      dense: true,
      contentPadding: EdgeInsets.zero,
      visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
      controlAffinity: ListTileControlAffinity.leading,
      title: Text(
        "$label (${count.toString()})",
        style: GoogleFonts.poppins(fontSize: 14),
      ),
      value: selected,
      activeColor: themeBlue,
      onChanged: onChanged,
    );
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.75,
      maxChildSize: 0.95,
      minChildSize: 0.5,
      builder: (context, controller) {
        return Container(
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
                  Text("Cab Type",
                      style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w600)),
                  TextButton(
                    onPressed: _resetFilters,
                    child: Text("Reset",
                        style: GoogleFonts.poppins(
                            color: themeBlue,
                            fontWeight: FontWeight.w500,
                            fontSize: 13)),
                  )
                ],
              ),

              // Cab Type Filters
              ...cabTypes.entries.map((entry) => _buildCheckboxTile(
                entry.key,
                entry.value,
                selectedCabTypes.contains(entry.key),
                    (value) {
                  setState(() {
                    if (value == true) {
                      selectedCabTypes.add(entry.key);
                    } else {
                      selectedCabTypes.remove(entry.key);
                    }
                  });
                },
              )),

              const SizedBox(height: 10),
              Divider(),
              const SizedBox(height: 10),

              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Fuel Type",
                  style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w600),
                ),
              ),
              const SizedBox(height: 5),

              // Fuel Type Filters
              Expanded(
                child: ListView(
                  controller: controller,
                  children: fuelTypes.entries.map((entry) => _buildCheckboxTile(
                    entry.key,
                    entry.value,
                    selectedFuelTypes.contains(entry.key),
                        (value) {
                      setState(() {
                        if (value == true) {
                          selectedFuelTypes.add(entry.key);
                        } else {
                          selectedFuelTypes.remove(entry.key);
                        }
                      });
                    },
                  )).toList(),
                ),
              ),

              const SizedBox(height: 10),
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
                      gradient: const LinearGradient(colors: [themeBlue, themeRed]),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Center(
                      child: Text(
                        "Apply",
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
