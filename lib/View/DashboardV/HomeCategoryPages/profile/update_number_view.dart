import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:trip_go/View/DashboardV/HomeCategoryPages/profile/profile_widget/truecaller_button.dart';
import '../../../../constants.dart';

class UpdateNumberView extends StatefulWidget {
  const UpdateNumberView({super.key});

  @override
  State<UpdateNumberView> createState() => _UpdateNumberViewState();
}

class _UpdateNumberViewState extends State<UpdateNumberView> {

  String selectedCountryCode = '+91';

  final List<Map<String, String>> countries = [
    {'name': 'India', 'code': '+91'},
    {'name': 'United States', 'code': '+1'},
    {'name': 'United Kingdom', 'code': '+44'},
    // Add more countries here
  ];

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    final TextEditingController mobileController = TextEditingController();
    final _formKey = GlobalKey<FormState>();

    return Theme(
      data: Theme.of(context).copyWith(
        primaryColor: constants.themeColor1,
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: constants.themeColor1,
        ),
        inputDecorationTheme: InputDecorationTheme(
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: constants.themeColor1),
          ),
          labelStyle: TextStyle(color: constants.themeColor1),
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: constants.ultraLightThemeColor1,
          title: const Text(
            'Update Number',
            style: TextStyle(fontFamily: 'poppins'),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 20,),
              Container(
                height: height * 0.59,
                width: double.infinity,
                margin: const EdgeInsets.symmetric(horizontal: 15),
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.8),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(height: 10,),
                      Container(
                        width: height * 0.14,
                        height: height * 0.14,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                            colors: [constants.themeColor1, constants.themeColor2],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                        ),
                        child: Center(
                          child: Icon(
                            CupertinoIcons.person,
                            size: height * 0.07,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20,),
                      Text("Please add a valid number to Proceed", style: TextStyle(fontFamily: 'poppins'),),
                      const SizedBox(height: 20),
                      buildMobileTextField(
                          label: "Enter Mobile Number",
                          controller: mobileController,
                          validator: (value) =>
                          (value == null || value.isEmpty) ? "Please enter your mobile number" : null,
                        ),
                      const SizedBox(height: 30),
                        SizedBox(
                          height: media.height * 0.06,
                          width: media.width,
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  constants.themeColor1,
                                  constants.themeColor2,
                                ],
                              ),
                              borderRadius: BorderRadius.circular(3),
                            ),
                            child: ElevatedButton(
                              onPressed: () {
                                // Handle button tap
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.transparent,
                                shadowColor: Colors.transparent,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(3),
                                ),
                              ),
                              child: const Text(
                                'Confirm and Submit',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                  fontFamily: 'poppins',
                                ),
                              ),
                            ),
                          ),
                        ),
                      const SizedBox(height: 20,),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        child: Row(
                          children: [
                            Expanded(
                              child: Divider(
                                color: Colors.grey,
                                thickness: 1,
                                endIndent: 10,
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(color: Colors.grey, width: 1), // border color and width
                                borderRadius: BorderRadius.circular(4), // rounded corners
                              ),
                              child: const Text(
                                'OR Continue with:',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Divider(
                                color: Colors.grey,
                                thickness: 1,
                                indent: 10,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10,),
                      TruecallerButton(
                        onPressed: () {
                          // Your Truecaller login logic here
                        },
                      )
                    ],
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


Widget buildMobileTextField({
  required String label,
  required TextEditingController controller,
  required String? Function(String?) validator,
  bool readOnly = false, // Error flag
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      AnimatedContainer(
        duration: Duration(milliseconds: 300),
        padding: EdgeInsets.only(), // Adjust padding here
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start, // Aligns the row properly
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              decoration: BoxDecoration(
                color: constants.ultraLightThemeColor1,
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: Colors.grey[300]!),
              ),
              child: Text(
                "+91",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            SizedBox(width: 8), // Space between `+91` and input field
            Expanded(
              child: TextFormField(
                controller: controller,
                validator: validator,
                readOnly: readOnly,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  labelText: label,
                  labelStyle: const TextStyle(
                    color: Colors.grey,
                    fontFamily: 'Poppins',
                  ),
                  filled: true,
                  fillColor: constants.ultraLightThemeColor1,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide(color: Colors.grey[300]!),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide(color: Colors.grey[300]!),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide(color: constants.themeColor1, width: 1.5),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ],
  );
}


