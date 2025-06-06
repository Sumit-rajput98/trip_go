import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../../constants.dart';

class ChangePasswordView extends StatelessWidget {
  const ChangePasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    final TextEditingController oldPasswordController = TextEditingController();
    final TextEditingController newPasswordController = TextEditingController();
    final TextEditingController confirmPasswordController = TextEditingController();

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
          'Change Password',
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: 20,),
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
                        CupertinoIcons.lock,
                        size: height * 0.07,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  CustomTextField(
                    controller: oldPasswordController,
                    label: "Confirm Password",
                  ),
                  CustomTextField(
                    controller: newPasswordController,
                    label: "Confirm New Password",
                  ),
                  CustomTextField(
                    controller: confirmPasswordController,
                    label: "Confirm New Password",
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: SizedBox(
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
                            'Change Password',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontFamily: 'poppins',
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
    );
  }
}

class CustomTextField extends StatefulWidget {
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
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool isVisible = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: TextField(
        controller: widget.controller,
        obscureText: !isVisible,
        decoration: InputDecoration(
          labelText: widget.label,
          labelStyle: const TextStyle(fontFamily: 'poppins', fontSize: 15),
          suffixIcon: IconButton(
            icon: Icon(
              isVisible ? Icons.visibility : Icons.visibility_off,
              color: Colors.grey,
            ),
            onPressed: () {
              setState(() {
                isVisible = !isVisible;
              });
            },
          ),
        ),
        keyboardType: widget.keyboardType,
      ),
    );
  }
}
