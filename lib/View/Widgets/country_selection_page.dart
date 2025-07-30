import 'package:flutter/material.dart';
import 'package:trip_go/constants.dart';
import 'package:google_fonts/google_fonts.dart';

class CountrySelectionPage extends StatefulWidget {
  final String selectedCountry;
  final Function(String) onApply;

  const CountrySelectionPage({
    super.key,
    required this.selectedCountry,
    required this.onApply,
  });

  @override
  State<CountrySelectionPage> createState() => _CountrySelectionPageState();
}

class _CountrySelectionPageState extends State<CountrySelectionPage> {
  late String selectedCountry;
  String selectedLanguage = 'English';
  bool isCountryTab = true;

  final List<Map<String, String>> countries = [
    {'name': 'India', 'flag': 'https://flagcdn.com/w40/in.png'},
    {'name': 'USA', 'flag': 'https://flagcdn.com/w40/us.png'},
    {'name': 'UK', 'flag': 'https://flagcdn.com/w40/gb.png'},
    {'name': 'Germany', 'flag': 'https://flagcdn.com/w40/de.png'},
    {'name': 'France', 'flag': 'https://flagcdn.com/w40/fr.png'},
    {'name': 'Japan', 'flag': 'https://flagcdn.com/w40/jp.png'},
    {'name': 'Canada', 'flag': 'https://flagcdn.com/w40/ca.png'},
    {'name': 'Brazil', 'flag': 'https://flagcdn.com/w40/br.png'},
    {'name': 'Australia', 'flag': 'https://flagcdn.com/w40/au.png'},
    {'name': 'Italy', 'flag': 'https://flagcdn.com/w40/it.png'},
  ];

  final List<String> languages = ['English'];

  @override
  void initState() {
    super.initState();
    selectedCountry = widget.selectedCountry;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back, color: Colors.black),
                    onPressed: () => Navigator.pop(context),
                  ),
                  const SizedBox(width: 4), // Tighter gap
                  Text(
                    'Select the preferred option',
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        body: Column(
          children: [
            // Toggle Buttons
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    // Country Tab
                    Expanded(
                      child: GestureDetector(
                        onTap: () => setState(() => isCountryTab = true),
                        child: Container(
                          decoration: BoxDecoration(
                            color: isCountryTab ? constants.themeColor1 : Colors.transparent,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            'Country',
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w600,
                              color: isCountryTab ? Colors.white : Colors.black54,
                            ),
                          ),
                        ),
                      ),
                    ),
                    // Language Tab
                    Expanded(
                      child: GestureDetector(
                        onTap: () => setState(() => isCountryTab = false),
                        child: Container(
                          decoration: BoxDecoration(
                            color: !isCountryTab ? constants.themeColor1 : Colors.transparent,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            'Language',
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w600,
                              color: !isCountryTab ? Colors.white : Colors.black54,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 8),
            // Country or Language List
            Expanded(
              child: isCountryTab
                  ? ListView.builder(
                itemCount: countries.length,
                itemBuilder: (context, index) {
                  final country = countries[index];
                  return RadioListTile<String>(
                    value: country['name']!,
                    groupValue: selectedCountry,
                    onChanged: (value) => setState(() => selectedCountry = value!),
                    title: Row(
                      children: [
                        Image.network(
                          country['flag']!,
                          width: 30,
                          height: 20,
                          fit: BoxFit.cover,
                        ),
                        const SizedBox(width: 12),
                        Text(
                          country['name']!,
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    controlAffinity: ListTileControlAffinity.trailing,
                  );
                },
              )
                  : ListView(
                children: languages.map((lang) {
                  return RadioListTile<String>(
                    value: lang,
                    groupValue: selectedLanguage,
                    onChanged: (value) => setState(() => selectedLanguage = value!),
                    title: Text(
                      lang,
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                    controlAffinity: ListTileControlAffinity.trailing,
                  );
                }).toList(),
              ),
            ),
            // Apply Button
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: constants.themeColor1,
                  minimumSize: Size(double.infinity, 48),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                onPressed: () {
                  widget.onApply(isCountryTab ? selectedCountry : selectedLanguage);
                  Navigator.pop(context);
                },
                child: Text(
                  'APPLY',
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            )
          ],
        ),
        backgroundColor: Colors.white,
      ),
    );
  }
}
