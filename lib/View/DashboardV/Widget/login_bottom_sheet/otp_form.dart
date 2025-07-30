import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trip_go/ViewM/AccountVM/validate_otp_view_model.dart';
import 'package:trip_go/constants.dart';

class OtpForm extends StatelessWidget {
  final TextEditingController otpController;
  final String phone;
  final int remainingTime;
  final VoidCallback onResend;
  final VoidCallback onSubmit;
  final VoidCallback onLoginWithPassword;

  const OtpForm({
    super.key,
    required this.otpController,
    required this.phone,
    required this.remainingTime,
    required this.onResend,
    required this.onSubmit,
    required this.onLoginWithPassword,
  });

  @override
  Widget build(BuildContext context) {
    final validateOtpVM = Provider.of<ValidateOtpViewModel>(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Please enter OTP which has been sent on your mobile or Email',
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
                  prefixIcon: const Icon(Icons.password_outlined),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
            ),
            const SizedBox(width: 10),
            remainingTime > 0
                ? Text("00:${remainingTime.toString().padLeft(2, '0')}",
                    style: const TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w500))
                : TextButton(
                    onPressed: onResend,
                    child: const Text("Resend", style: TextStyle(fontFamily: 'Poppins', color: Colors.blue, fontWeight: FontWeight.w600)),
                  ),
          ],
        ),
        const SizedBox(height: 20),
        validateOtpVM.isLoading
            ? const Center(child: CircularProgressIndicator())
            : GestureDetector(
                onTap: onSubmit,
                child: Container(
                  height: 50,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [constants.themeColor1, constants.themeColor2]),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: const Center(
                    child: Text('LOGIN', style: TextStyle(fontFamily: 'Poppins', color: Colors.white, fontWeight: FontWeight.w600)),
                  ),
                ),
              ),
        const SizedBox(height: 16),
        Center(
          child: GestureDetector(
            onTap: onLoginWithPassword,
            child: const Text(
              'Login with Password',
              style: TextStyle(fontFamily: 'Poppins', color: Colors.black87, fontWeight: FontWeight.w500),
            ),
          ),
        ),
      ],
    );
  }
}
