import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../constants.dart';
import 'add_gmail_dialog.dart';
import 'add_mobile_dialog.dart';
import 'change_password.dart';
import 'delete_gmail.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    clipBehavior: Clip.hardEdge,
                    height: 190,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.vertical(
                        bottom: Radius.circular(30),
                      ),
                      color: Colors.blue,
                    ),
                  ),
                  Positioned(
                    top: 50,
                    left: 10,
                    child: Icon(
                      Icons.arrow_back,
                      size: 25,
                      color: Colors.white,
                    ),
                  ),
                  Positioned(
                    top: 53,
                    left: 40,
                    child: Text(
                      "My Profile",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 50,
                    left: 250,
                    child: Text(
                      "Manage Account",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 42,
                    left: 390,
                    child: Icon(
                      Icons.manage_accounts_outlined,
                      size: 30,
                      color: Colors.white,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 100),
                    child: Center(
                      child: CircleAvatar(
                        radius: 25,
                        backgroundColor: Colors.white,
                        child: Icon(Icons.person, color: Colors.blue, size: 45),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomTextField(
                      label: "First Name",
                      hint: "Enter your first name",
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Enter your first name";
                        }
                        return null;
                      },
                    ),
                    CustomTextField(
                      label: "Last Name",
                      hint: "Enter your last name",
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Enter your last name";
                        }
                        return null;
                      },
                    ),
                    CustomTextField(
                      label: "Address",
                      hint: "Enter Address",
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Enter your address";
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  if (_formKey.currentState!.validate()) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => ProfilePage()),
                    );
                  }
                },
                child: Container(
                  height: 50,
                  width: 200,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.blue,
                  ),
                  child: Text(
                    "Update",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
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


class CustomTextField extends StatelessWidget {
  final String label;
  final String hint;
  final String? Function(String?) validator;
  final TextEditingController? controller;

  const CustomTextField({
    super.key,
    required this.label,
    required this.hint,
    required this.validator,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          controller: controller,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: hint,
            labelText: label,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            labelStyle: const TextStyle(color: Colors.blue),
          ),
          cursorColor: Colors.blue,
          validator: validator,
        ),
        const SizedBox(height: 5),
        Divider(
          height: 5,
          color: Colors.black.withOpacity(.2),
          thickness: .5,
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}


