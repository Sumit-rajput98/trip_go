import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trip_go/View/DashboardV/HomeCategoryPages/profile/auth_provider.dart';
import 'package:trip_go/View/DashboardV/HomeCategoryPages/profile/user_profile_page.dart';
import 'package:trip_go/ViewM/AccountVM/login_otp_view_model.dart';
import 'package:trip_go/ViewM/AccountVM/register_view_model.dart';
import 'package:trip_go/constants.dart';

class LoginForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController loginController;
  final VoidCallback onSuccess;
  final VoidCallback? onLoginComplete;

  const LoginForm({
    super.key,
    required this.formKey,
    required this.loginController,
    required this.onSuccess,
    this.onLoginComplete,
  });

  @override
  Widget build(BuildContext context) {
    final loginOtpVM = Provider.of<LoginOtpViewModel>(context);
    final registerVM = Provider.of<RegisterViewModel>(context);

    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Login or Create an account',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              fontFamily: 'Poppins',
            ),
          ),
          const SizedBox(height: 10),
          TextFormField(
            controller: loginController,
            style: const TextStyle(fontFamily: 'Poppins'),
            decoration: InputDecoration(
              hintText: 'Enter your Email Id/Mobile no.',
              prefixIcon: const Icon(Icons.email_outlined),
              hintStyle: const TextStyle(fontFamily: 'Poppins'),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 12),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'This field cannot be empty';
              }
              final emailRegex = RegExp(
                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
              );
              final phoneRegex = RegExp(r'^[0-9]{10,13}$');
              if (!emailRegex.hasMatch(value) && !phoneRegex.hasMatch(value)) {
                return 'Enter valid Mobile Number';
              }
              return null;
            },
          ),
          const SizedBox(height: 20),
          (loginOtpVM.isLoading || registerVM.isLoading)
              ? const Center(child: CircularProgressIndicator())
              : GestureDetector(
                onTap: () async {
                  if (formKey.currentState!.validate()) {
                    final input = loginController.text.trim();
                    const countryCode = "91";

                    final emailRegex = RegExp(
                      r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9]+\.[a-zA-Z]+$",
                    );
                    final phoneRegex = RegExp(r'^[0-9]{10,13}$');

                    dynamic registerBody =
                        
                             {"CountryCode": countryCode, "PhoneNumber": input};
                            

                    try {
                      await registerVM.registerUser(registerBody);
                      final registerSuccess =
                          registerVM.registerResponse?.success == true;
                      final alreadyRegistered =
                          registerVM.registerResponse?.message
                              ?.toLowerCase()
                              .contains("already registered") ??
                          false;

                      if (registerSuccess || alreadyRegistered) {
                        // if (registerSuccess) {
                        //   final user = registerVM.registerResponse?.data;
                        //   final prefs = await SharedPreferences.getInstance();
                        //   await prefs.setBool('isLoggedIn', true);
                        //   await prefs.setInt('userId', user?.id ?? 0);
                        //   await prefs.setString('phone', user?.phone ?? '');
                        //   await prefs.setString('email', user?.email ?? '');
                        //   await prefs.setString('country', user?.country ?? '');
                        //   Provider.of<AuthProvider>(
                        //     context,
                        //     listen: false,
                        //   ).login();

                        //   ScaffoldMessenger.of(context).showSnackBar(
                        //     SnackBar(
                        //       content: Text(
                        //         registerVM.registerResponse?.message ??
                        //             "User Registered",
                        //       ),
                        //     ),
                        //   );
                        // }

                        // 2. Call loginWithOtp (either after register success or already registered)
                        await loginOtpVM.loginWithOtp({
                            "CountryCode": countryCode,
                            "PhoneNumber": input,
                          });

                        final loginSuccess =
                            loginOtpVM.otpResponse?.success == true;
                        if (loginSuccess) {
                          
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                loginOtpVM.otpResponse?.message ??
                                    "OTP sent successfully",
                              ),
                            ),
                          );

                          onSuccess(); 
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                loginOtpVM.otpResponse?.message ??
                                    "Login Failed",
                              ),
                            ),
                          );
                        }
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              registerVM.registerResponse?.message ??
                                  "Registration failed",
                            ),
                          ),
                        );
                      }
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Something went wrong")),
                      );
                    }
                  }
                },
                child: Container(
                  height: 50,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [constants.themeColor1, constants.themeColor2],
                    ),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: const Center(
                    child: Text(
                      'CONTINUE',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
        ],
      ),
    );
  }
}
