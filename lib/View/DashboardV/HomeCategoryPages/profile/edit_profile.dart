import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trip_go/View/DashboardV/HomeCategoryPages/profile/change_password.dart';
import 'package:trip_go/View/DashboardV/HomeCategoryPages/profile/update_number_view.dart';
import 'package:trip_go/View/DashboardV/Widget/show_toast.dart';
import 'package:trip_go/ViewM/AccountVM/edit_profile_view_model.dart';
import 'package:trip_go/ViewM/AccountVM/user_view_model.dart';
import 'package:trip_go/constants.dart';
import 'package:image_picker/image_picker.dart';

 // Assuming showToast is here

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _countryController = TextEditingController();
  final _stateController = TextEditingController();
  final _cityController = TextEditingController();
  final _addressController = TextEditingController();
  final _zipController = TextEditingController();

  final List<String> _titles = ["Mr", "Ms", "Mrs"];
  String _selectedTitle = "Mr";
  String? _selectedGender;
  DateTime? _selectedDob;
  String? phone;
  String? countryCode;

  File? _selectedImage;

  @override
  void initState() {
    super.initState();
    _fetchUserDetail();
  }

  Future<void> _fetchUserDetail() async {
    final prefs = await SharedPreferences.getInstance();
    phone = prefs.getString('phone') ?? '';
    countryCode = prefs.getString('countryCode') ?? '91';

    final userVM = Provider.of<UserViewModel>(context, listen: false);
    await userVM.fetchUserDetail({
      "CountryCode": countryCode,
      "PhoneNumber": phone,
    });

    final user = userVM.userModel?.data;
    if (user != null) {
      setState(() {
        _selectedTitle = user.title ?? "Mr";
        _firstNameController.text = user.firstName ?? '';
        _lastNameController.text = user.lastName ?? '';
        _emailController.text = user.email ?? '';
        _countryController.text = user.country?.toString() ?? '';
        _stateController.text = user.state?.toString() ?? '';
        _cityController.text = user.city?.toString() ?? '';
        _addressController.text = user.address?.toString() ?? '';
        _zipController.text = user.zip?.toString() ?? '';
        _selectedGender = ["Male", "Female", "Other"].contains(user.gender) ? user.gender : null;
        _selectedDob = user.dob != null ? DateTime.tryParse(user.dob) : null;
      });
    }
  }

  void _pickDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDob ?? DateTime(2000),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        _selectedDob = picked;
      });
    }
  }
  
  Future<void> _pickImage() async {
  final ImagePicker picker = ImagePicker();
  final XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);

  if (pickedFile != null) {
    setState(() {
      _selectedImage = File(pickedFile.path);
    });
  }
}



  Future<void> _submitProfile() async {
    final vm = Provider.of<EditProfileViewModel>(context, listen: false);

    final body = {
      "profile_img": _selectedImage != null ? _selectedImage!.path : "",

      "PhoneNumber": phone,
      "Title": _selectedTitle,
      "FirstName": _firstNameController.text.trim(),
      "LastName": _lastNameController.text.trim(),
      "Email": _emailController.text.trim(),
      "Country": _countryController.text.trim(),
      "State": _stateController.text.trim(),
      "City": _cityController.text.trim(),
      "Address": _addressController.text.trim(),
      "Zip": _zipController.text.trim(),
      "Gender": _selectedGender,
      "DOB": _selectedDob?.toIso8601String()?.split('T')[0], // 'yyyy-MM-dd'
      "Status": 1
    };

    await vm.updateUserProfile(body);

    if (vm.editProfileResponse?.success == true) {
      showToast("Profile updated successfully");
      Navigator.pop(context);
    } else {
      showToast(vm.errorMessage ?? "Failed to update profile");
    }
  }

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;
    final userVM = Provider.of<UserViewModel>(context);
    final editVM = Provider.of<EditProfileViewModel>(context);

    if (userVM.isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Theme(
      data: Theme.of(context).copyWith(
        primaryColor: constants.themeColor1,
        textSelectionTheme: TextSelectionThemeData(cursorColor: constants.themeColor1),
        inputDecorationTheme: InputDecorationTheme(
          focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: constants.themeColor1)),
          labelStyle: TextStyle(color: constants.themeColor1),
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: media.height * 0.3,
                    child: Stack(
                      children: [
                        Container(
                          width: double.infinity,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage("https://plus.unsplash.com/premium_photo-1681487924146-c091598b7e8a?q=80"),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Positioned(
                          top: 40,
                          left: 16,
                          right: 16,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const BackButton(color: Colors.white),
                              const Text("Edit Profile", style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold, fontFamily: 'poppins')),
                              IconButton(
                                icon: const Icon(Icons.check, color: Colors.white),
                                onPressed: _submitProfile,
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          bottom: 60,
                          left: 0,
                          right: 0,
                          child: CircleAvatar(
                            radius: 50,
                            backgroundColor: Colors.transparent,
                            child: CircleAvatar(
  radius: 50,
  backgroundColor: Colors.white,
  child: ClipOval(
    child: _selectedImage != null
        ? Image.file(_selectedImage!, fit: BoxFit.cover, width: 100, height: 100)
        : Image.network(
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR0_XPfyUZJugz5lXkm0DUtAkpjRw367tcFig&s',
            fit: BoxFit.cover,
            width: 100,
            height: 100,
          ),
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
                              icon:  Icon(Icons.edit, size: 18, color: Colors.white),
                              onPressed: _pickImage,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: _titles.map((title) {
                      final isSelected = _selectedTitle == title;
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 6),
                        child: ChoiceChip(
                          label: Text(title),
                          selected: isSelected,
                          onSelected: (_) => setState(() => _selectedTitle = title),
                          selectedColor: constants.themeColor1,
                          labelStyle: TextStyle(
                            color: isSelected ? Colors.white : Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 10),
                  CustomTextField(controller: _firstNameController, label: "First Name"),
                  CustomTextField(controller: _lastNameController, label: "Last Name"),
                  CustomTextField(controller: _emailController, label: "Email", keyboardType: TextInputType.emailAddress),

                  /// Gender Dropdown
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                    child: DropdownButtonFormField<String>(
                      value: _selectedGender,
                      decoration: const InputDecoration(labelText: "Gender"),
                      items: ["Male", "Female", "Other"].map((gender) {
                        return DropdownMenuItem(value: gender, child: Text(gender));
                      }).toList(),
                      onChanged: (val) => setState(() => _selectedGender = val),
                    ),
                  ),

                  /// DOB Picker
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                    child: InkWell(
                      onTap: _pickDate,
                      child: InputDecorator(
                        decoration: const InputDecoration(labelText: "Date of Birth"),
                        child: Text(
                          _selectedDob != null ? "${_selectedDob!.toLocal()}".split(' ')[0] : "Select Date",
                          style: const TextStyle(fontFamily: 'poppins'),
                        ),
                      ),
                    ),
                  ),

                  CustomTextField(controller: _countryController, label: "Country"),
                  CustomTextField(controller: _stateController, label: "State"),
                  CustomTextField(controller: _cityController, label: "City"),
                  CustomTextField(controller: _addressController, label: "Address"),
                  CustomTextField(controller: _zipController, label: "Zip Code", keyboardType: TextInputType.number),

                  if (phone != null)
                    Padding(
                      padding: const EdgeInsets.only(left: 20, top: 12),
                      child: Row(
                        children: [
                          Text("+$countryCode-$phone",
                              style: TextStyle(color: Colors.grey.shade500, fontFamily: 'poppins', fontSize: 15)),
                          IconButton(
                            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const UpdateNumberView())),
                            icon: Icon(Icons.edit, size: 18, color: Colors.grey.shade500),
                          ),
                        ],
                      ),
                    ),

                  const SizedBox(height: 20),
                  InkWell(
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ChangePasswordView())),
                    child: Text("CHANGE PASSWORD", style: TextStyle(color: constants.themeColor1, fontFamily: 'poppins', fontSize: 15)),
                  ),
                  const SizedBox(height: 20),
                  Text("LOG OUT", style: TextStyle(color: constants.themeColor1, fontFamily: 'poppins', fontSize: 15)),
                ],
              ),
            ),

            /// Loading spinner during update
            if (editVM.isLoading)
              const Center(
                child: CircularProgressIndicator(),
              ),
          ],
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
    super.key,
    required this.controller,
    required this.label,
    this.keyboardType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(labelText: label),
      ),
    );
  }
}
