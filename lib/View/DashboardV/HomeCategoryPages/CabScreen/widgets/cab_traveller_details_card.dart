import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CabTravellerDetailsCard extends StatelessWidget {
  final TextEditingController firstNameController;
  final TextEditingController lastNameController;
  final TextEditingController emailController;
  final TextEditingController phoneController;

  const CabTravellerDetailsCard({
    super.key,
    required this.firstNameController,
    required this.lastNameController,
    required this.emailController,
    required this.phoneController,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
        color: Colors.white,
      ),
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
                      value: 'Mr.',
                      items: ['Mr.', 'Mrs.', 'Ms.']
                          .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                          .toList(),
                      onChanged: (val) {},
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
                    _label("First Name"),
                    const SizedBox(height: 4),
                    TextFormField(
                      controller: firstNameController,
                      decoration: _inputDecoration(),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'First name is required';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          _label("Last Name"),
          const SizedBox(height: 4),
          TextFormField(
            controller: lastNameController,
            decoration: _inputDecoration(),
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Last name is required';
              }
              return null;
            },
          ),

          const SizedBox(height: 16),

          Text("Contact Information", style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
          const SizedBox(height: 12),

          _label("Email Address"),
          const SizedBox(height: 4),
          TextFormField(
            controller: emailController,
            keyboardType: TextInputType.emailAddress,
            decoration: _inputDecoration(suffixIcon: const Icon(Icons.mail_outline, size: 18)),
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Email is required';
              }
              return null;
            },
          ),

          const SizedBox(height: 12),

          _label("Phone Number"),
          const SizedBox(height: 4),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade400),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text("+91", style: GoogleFonts.poppins(fontSize: 13)),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: TextFormField(
                  controller: phoneController,
                  keyboardType: TextInputType.phone,
                  decoration: _inputDecoration(suffixIcon: const Icon(Icons.phone, size: 18)),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Phone No. is required';
                    }
                    return null;
                  },
                ),
              ),
            ],
          ),
        ],
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
        borderSide: const BorderSide(color: Colors.blue, width: 1.5),
      ),
    );
  }
}

