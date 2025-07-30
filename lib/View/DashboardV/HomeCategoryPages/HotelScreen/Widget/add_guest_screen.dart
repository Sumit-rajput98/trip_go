import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trip_go/View/Widgets/custom_app_bar.dart';
import 'package:trip_go/constants.dart';

class AddGuestScreen extends StatefulWidget {
  final Function(Map<String, dynamic>) onGuestDataSubmit;

  const AddGuestScreen({Key? key, required this.onGuestDataSubmit}) : super(key: key);

  @override
  State<AddGuestScreen> createState() => _AddGuestScreenState();
}

class _AddGuestScreenState extends State<AddGuestScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  String _selectedTitle = 'Mr.';
  bool _isChild = false;

  void _submitGuestData() {
    if (_formKey.currentState?.validate() ?? false) {
      final guestData = {
        "Title": _selectedTitle,
        "FirstName": _firstNameController.text,
        "MiddleName": "",
        "LastName": _lastNameController.text,
        "Email": _emailController.text,
        "Phoneno": _phoneController.text,
        "PaxType": _isChild ? 2 : 1,
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
      widget.onGuestDataSubmit(guestData);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Add Guest"),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(14),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade300),
            color: Colors.white,
          ),
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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

                  const SizedBox(height: 20),

                  /// Checkbox for child
                  CheckboxListTile(
                    contentPadding: EdgeInsets.zero,
                    value: _isChild,
                    onChanged: (val) => setState(() => _isChild = val ?? false),
                    title: Text("Child below 12 years old",
                        style: GoogleFonts.poppins(fontSize: 13)),
                    controlAffinity: ListTileControlAffinity.leading,
                  ),

                  const SizedBox(height: 20),
                  Center(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: constants.themeColor1,
                        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
                      ),
                      onPressed: _submitGuestData,
                      child: Text("Add Guest", style: GoogleFonts.poppins(fontWeight: FontWeight.w600, color: Colors.white)),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _label(String text) {
    return Text(text, style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w500));
  }

  InputDecoration _inputDecoration({Widget? suffixIcon}) {
    return InputDecoration(
      hintStyle: GoogleFonts.poppins(fontSize: 13),
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      suffixIcon: suffixIcon,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: constants.themeColor1, width: 1.5),
      ),
    );
  }
}
