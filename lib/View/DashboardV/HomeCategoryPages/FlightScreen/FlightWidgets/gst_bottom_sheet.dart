import 'package:flutter/material.dart';
import '../../../../../constants.dart';

class GstBottomSheet extends StatefulWidget {
  const GstBottomSheet({super.key});

  @override
  State<GstBottomSheet> createState() => _GstBottomSheetState();
}

class _GstBottomSheetState extends State<GstBottomSheet> {
  final TextEditingController companyController = TextEditingController();
  final TextEditingController regNoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(5),
              topRight: Radius.circular(5),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "GST Information",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, fontFamily: 'poppins', color: constants.themeColor1,),
              ),
              const SizedBox(height: 26),
              Theme(
                data: Theme.of(context).copyWith(
                  primaryColor: constants.themeColor1,
                  inputDecorationTheme: InputDecorationTheme(
                    labelStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey,
                      fontFamily: 'poppins',
                    ),
                    floatingLabelStyle: TextStyle(
                      color: constants.themeColor1,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'poppins',
                    ),
                  ),
                ),
                child: TextField(
                  controller: companyController,
                  decoration: InputDecoration(
                    labelText: 'Company Name',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: constants.themeColor1,),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Theme(
                data: Theme.of(context).copyWith(
                  primaryColor: constants.themeColor1,
                  inputDecorationTheme: InputDecorationTheme(
                    labelStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey,
                      fontFamily: 'poppins',
                    ),
                    floatingLabelStyle: TextStyle(
                      color: constants.themeColor1,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'poppins',
                    ),
                  ),
                ),
                child: TextField(
                  controller: regNoController,
                  decoration: InputDecoration(
                    labelText: 'Registration No.',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: constants.themeColor1),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              // Align(
              //   alignment: Alignment.centerRight,
              //   child: ElevatedButton(
              //     onPressed: () {
              //       print('Company Name: ${companyController.text}');
              //       print('Registration No.: ${regNoController.text}');
              //       Navigator.pop(context);
              //     },
              //     child: const Text("Confirm"),
              //   ),
              // ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: constants.themeColor2,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  onPressed: () {
                    final companyName = companyController.text.trim();
                    final registrationNo = regNoController.text.trim();
                    Navigator.pop(context, {
                      'companyName': companyName,
                      'registrationNo': registrationNo,
                    });
                  },
                  child: Text(
                    'CONFIRM',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white, fontFamily: 'poppins')
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
