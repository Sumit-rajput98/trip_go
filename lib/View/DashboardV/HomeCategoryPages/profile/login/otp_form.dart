import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trip_go/View/DashboardV/HomeCategoryPages/profile/auth_provider.dart';
import 'package:trip_go/View/DashboardV/HomeCategoryPages/profile/user_profile_page.dart';
import 'package:trip_go/ViewM/AccountVM/validate_otp_view_model.dart';
import 'package:trip_go/constants.dart';

class OtpForm extends StatelessWidget {
  final TextEditingController otpController;
  final TextEditingController loginController;
  final int remainingTime;
  final VoidCallback onResend;
  final VoidCallback? onLoginWithPassword;
  final VoidCallback? onLoginComplete;

  const OtpForm({
    super.key,
    required this.otpController,
    required this.loginController,
    required this.remainingTime,
    required this.onResend,
    required this.onLoginWithPassword, this.onLoginComplete,
  });

  @override
  Widget build(BuildContext context) {
    final validateOtpViewModel = Provider.of<ValidateOtpViewModel>(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10),
        const Text(
          'Please enter OTP which has been sent on your mobile.',
          style: TextStyle(fontSize: 13, fontFamily: 'Poppins'),
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: otpController,
                style: const TextStyle(fontFamily: 'Poppins'),
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'Enter OTP',
                  hintStyle: const TextStyle(fontFamily: 'Poppins'),
                  prefixIcon: const Icon(Icons.password_outlined),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            remainingTime > 0
                ? Text(
                    "00:${remainingTime.toString().padLeft(2, '0')}",
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500,
                    ),
                  )
                : TextButton(
                    onPressed: onResend,
                    child: const Text(
                      "Resend",
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        color: Colors.blue,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
          ],
        ),
        const SizedBox(height: 20),
        validateOtpViewModel.isLoading
            ? const Center(child: CircularProgressIndicator())
            : GestureDetector(
                onTap: () async {
                  String otp = otpController.text.trim();
                  String phone = loginController.text.trim();
                  String countryCode = "91";

                  if (otp.isEmpty || otp.length < 4) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Please enter valid OTP")),
                    );
                    return;
                  }

                  await validateOtpViewModel.validateOtp(
                    countryCode: countryCode,
                    phoneNumber: phone,
                    otp: otp,
                  );

                  if (validateOtpViewModel.otpResponse?.success == true) {
                    final data = validateOtpViewModel.otpResponse?.data;
                    final prefs = await SharedPreferences.getInstance();

                    await prefs.setBool('isLoggedIn', true);
                    Provider.of<AuthProvider>(context, listen: false).login();
                    await prefs.setString('email', data?.email ?? '');
                    await prefs.setString('phone', data?.phone ?? '');
                    await prefs.setString('countryCode', countryCode);

                    ScaffoldMessenger.of(context).showSnackBar(
                       SnackBar(content: Text(validateOtpViewModel.otpResponse?.message ?? "User Login Succesful")),
                    );

                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (_) => const UserProfilePage()),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          validateOtpViewModel.otpResponse?.message ??
                              "OTP verification failed",
                        ),
                      ),
                    );
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
                      'LOGIN',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
        const SizedBox(height: 16),
        Center(
          child: GestureDetector(
            onTap: onLoginWithPassword,
            child: const Text(
              'Login with Password',
              style: TextStyle(
                fontFamily: 'Poppins',
                color: Colors.black87,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
 