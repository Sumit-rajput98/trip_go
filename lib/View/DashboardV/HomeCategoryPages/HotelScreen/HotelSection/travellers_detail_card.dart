import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trip_go/View/DashboardV/HomeCategoryPages/HotelScreen/HotelDetail/hotel_detail_page.dart';
import 'package:trip_go/constants.dart'; // for themeColor1
import 'package:email_validator/email_validator.dart';

import '../Widget/add_guest_screen.dart';

class TravellerDetailsCard extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final Function(Map<String, dynamic> passengerData) onDataReady;

  const TravellerDetailsCard({
    required this.formKey,
    required this.onDataReady,
    super.key,
  });

  @override
  State<TravellerDetailsCard> createState() => TravellerDetailsCardState();
}

class TravellerDetailsCardState extends State<TravellerDetailsCard>  {
  late GlobalKey<FormState> _formKey;
  List<Map<String, dynamic>> guestList = [];

  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();

  String _selectedTitle = 'Mr.';

  @override
  void initState() {
    super.initState();
    _formKey = widget.formKey;
    // Call when the form is valid
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   widget.formKey.currentState?.validate();
    //   _sendData();
    // });
  }

  void submitIfValid() {
    if (_formKey.currentState?.validate() ?? false) {
      final passenger = {
        "Title": _selectedTitle,
        "FirstName": _firstNameController.text,
        "MiddleName": "",
        "LastName": _lastNameController.text,
        "Email": _emailController.text,
        "Phoneno": _phoneController.text,
        "PaxType": 1,
        "LeadPassenger": true,
        "Age": 0,
        "PassportNo": null,
        "PassportIssueDate": null,
        "PassportExpDate": null,
        "PaxId": 0,
        "GSTCompanyAddress": null,
        "GSTCompanyContactNumber": null,
        "GSTCompanyName": null,
        "GSTNumber": null,
        "GSTCompanyEmail": null,
        "PAN": "NNAPS6341Q"
      };

      widget.onDataReady(passenger);
    }
  }

  List<Map<String, dynamic>> getAllGuestData() {
    return [getMainPassenger()] + guestList;
  }

  Map<String, dynamic> getMainPassenger() {
    return {
      "Title": _selectedTitle,
      "FirstName": _firstNameController.text,
      "MiddleName": "",
      "LastName": _lastNameController.text,
      "Email": _emailController.text,
      "Phoneno": _phoneController.text,
      "PaxType": 1,
      "LeadPassenger": true,
      "Age": 0,
      "PassportNo": null,
      "PassportIssueDate": null,
      "PassportExpDate": null,
      "PaxId": 0,
      "GSTCompanyAddress": null,
      "GSTCompanyContactNumber": null,
      "GSTCompanyName": null,
      "GSTNumber": null,
      "GSTCompanyEmail": null,
      "PAN": "NNAPS6341Q"
    };
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
        color: Colors.white,
      ),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Section Title
            Text("Traveller Details", style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
            const SizedBox(height: 4),
            Text(
              "Enter your details as per your Govt ID proof.",
              style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey[600]),
            ),
            const SizedBox(height: 14),

            /// Title + First Name
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _label("Title"),
                      const SizedBox(height: 4),
                      DropdownButtonFormField<String>(
                        value: _selectedTitle,
                        items: ['Mr.', 'Mrs.', 'Ms.']
                            .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                            .toList(),
                        onChanged: (val) {
                          if (val != null) setState(() => _selectedTitle = val);
                        },
                        decoration: _inputDecoration(),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  flex: 5,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _label("First Name "),
                      const SizedBox(height: 4),
                      TextFormField(
                        controller: _firstNameController,
                        validator: (val) => val!.isEmpty ? "Enter first name" : null,
                        decoration: _inputDecoration(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            /// Last Name
            _label("Last Name"),
            const SizedBox(height: 4),
            TextFormField(
              controller: _lastNameController,
              validator: (val) => val!.isEmpty ? "Enter last name" : null,
              decoration: _inputDecoration(),
            ),
            const SizedBox(height: 16),

            /// Contact Info
            Text("Contact Information",
                style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
            const SizedBox(height: 12),

            /// Email
            _label("Email Address"),
            const SizedBox(height: 4),
            TextFormField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              validator: (val) {
                if (val == null || val.isEmpty) return "Enter email";
                final regex = RegExp(r'^[\w\.-]+@[\w\.-]+\.\w+$');
                if (!regex.hasMatch(val)) return "Enter valid email";
                return null;
              },
              decoration: _inputDecoration(
                suffixIcon: const Icon(Icons.mail_outline, size: 18),
              ),
            ),
            const SizedBox(height: 12),

            /// Phone Field with country code box
            _label("Phone Number"),
            const SizedBox(height: 4),
            Row(
              children: [
                /// Country Code Box
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade400),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text("+91", style: GoogleFonts.poppins(fontSize: 13)),
                ),
                const SizedBox(width: 10),

                /// Phone Number Field
                Expanded(
                  child: TextFormField(
                    controller: _phoneController,
                    keyboardType: TextInputType.phone,
                    validator: (val) {
                      if (val == null || val.isEmpty) return "Enter phone number";
                      if (!RegExp(r'^[6-9]\d{9}$').hasMatch(val)) return "Enter valid 10-digit number";
                      return null;
                    },
                    decoration: _inputDecoration(
                      suffixIcon: const Icon(Icons.phone, size: 18),
                    ),
                  ),
                ),

              ],
            ),
            SizedBox(height: 20,),
            Center(
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddGuestScreen(
                        onGuestDataSubmit: (guest) {
                          setState(() {
                            guestList.add(guest);
                          });
                        },
                      ),
                    ),
                  );
                },
                child: Text(
                  "+ Add more Guest",
                  style: TextStyle(
                    fontFamily: 'poppins',
                    fontWeight: FontWeight.bold,
                    color: constants.themeColor1,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            /// Show the added guest list
            ...guestList.map((guest) {
              return Container(
                margin: const EdgeInsets.only(bottom: 10),
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: Colors.grey.shade400),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        "${guest['Title']} ${guest['FirstName']} ${guest['LastName']}",
                        style: GoogleFonts.poppins(fontSize: 14),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        setState(() {
                          guestList.remove(guest);
                        });
                      },
                    ),
                  ],
                ),
              );
            }).toList(),

          ],
        ),
      ),
    );
  }

  /// Label widget above fields
  Widget _label(String text) {
    return Text(
      text,
      style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w500),
    );
  }

  /// Common Input Decoration
  InputDecoration _inputDecoration({Widget? suffixIcon}) {
    return InputDecoration(
      hintStyle: GoogleFonts.poppins(fontSize: 13),
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      suffixIcon: suffixIcon,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: themeColor1, width: 1.5),
      ),
    );
  }

  /// External call to validate
  bool validateTravellerForm() {
    return _formKey.currentState?.validate() ?? false;
  }
}
