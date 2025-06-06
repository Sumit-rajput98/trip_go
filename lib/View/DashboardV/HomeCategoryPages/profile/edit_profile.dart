import 'dart:io';
import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
import 'package:trip_go/View/DashboardV/HomeCategoryPages/profile/change_password.dart';
import 'package:trip_go/View/DashboardV/HomeCategoryPages/profile/update_number_view.dart';
import 'package:trip_go/constants.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  File? _selectedImage;

  final List<String> _titles = ["Mr", "Ms", "Mrs"];
  String _selectedTitle = "Mr";

  // void _pickImage() async {
  //   final pickedFile =
  //   await ImagePicker().pickImage(source: ImageSource.gallery);
  //   if (pickedFile != null) {
  //     setState(() {
  //       _selectedImage = File(pickedFile.path);
  //     });
  //   }
  // }



  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;

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
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: media.height * 0.3,
                child: Stack(
                  children: [
                    // Background Image
                    Container(
                      height: media.height * 0.3,
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(
                            "https://plus.unsplash.com/premium_photo-1681487924146-c091598b7e8a?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    // AppBar Items
                    Positioned(
                      top: 40,
                      left: 16,
                      right: 16,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () => Navigator.pop(context),
                            child: const Icon(Icons.arrow_back, color: Colors.white),
                          ),
                          Text(
                            "Edit Profile",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'poppins',
                            ),
                          ),
                          Icon(Icons.check, color: Colors.white),
                        ],
                      ),
                    ),
                    // Circle Avatar
                    Positioned(
                      bottom: 60,
                      left: 0,
                      right: 0,
                      child: CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.transparent,
                        child: ClipOval(
                          child: Image.network(
                            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR0_XPfyUZJugz5lXkm0DUtAkpjRw367tcFig&s',
                            fit: BoxFit.cover,
                            width: 100,
                            height: 100,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 60,
                      right: 140,
                      child: CircleAvatar(
                        radius: 18,
                        backgroundColor: constants.themeColor1,
                        child: IconButton(
                          color: constants.themeColor1,
                          iconSize: 18,
                          icon: Icon(Icons.edit, color: Colors.white,),
                          onPressed: (){},
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              // Title Chips
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: _titles.map((title) {
                    final isSelected = _selectedTitle == title;
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 6),
                      child: ChoiceChip(
                        label: Text(title),
                        selected: isSelected,
                        onSelected: (_) {
                          setState(() {
                            _selectedTitle = title;
                          });
                        },
                        selectedColor: constants.themeColor1,
                        labelStyle: TextStyle(
                          color: isSelected ? Colors.white : Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomTextField(
                    controller: _firstNameController,
                    label: "First Name",
                  ),
                  CustomTextField(
                    controller: _lastNameController,
                    label: "Last Name",
                  ),
                  CustomTextField(
                    controller: _emailController,
                    label: "Email",
                    keyboardType: TextInputType.emailAddress,
                  ),
                  SizedBox(height: 10,),
                  Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Row(
                        children: [
                          Text("+91-9876543210", style: TextStyle(color: Colors.grey.shade500, fontFamily: 'poppins', fontSize: 15),),
                          IconButton(onPressed: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=> UpdateNumberView()));
                          }, icon: Icon(Icons.edit, size: 18, color: Colors.grey.shade500,))
                        ],
                      )
                  ),
                ],
              ),
              SizedBox(height: 10,),
              Text("DEACTIVATE ACCOUNT", style: TextStyle(color: constants.themeColor1, fontFamily: 'poppins', fontSize: 15),),
              SizedBox(height: 20,),
              InkWell(
                onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> ChangePasswordView()));
                },
                child: Text("CHANGE PASSWORD", style: TextStyle(color: constants.themeColor1, fontFamily: 'poppins', fontSize: 15),)),
              SizedBox(height: 20,),
              Text("LOG OUT", style: TextStyle(color: constants.themeColor1, fontFamily: 'poppins', fontSize: 15),),
            ],
          ),
        ),
      ),
    );
  }
}


class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final TextInputType keyboardType;

  const CustomTextField({
    Key? key,
    required this.controller,
    required this.label,
    this.keyboardType = TextInputType.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(fontFamily: 'poppins', fontSize: 15),
        ),
        keyboardType: keyboardType,
      ),
    );
  }
}
