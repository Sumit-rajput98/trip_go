import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trip_go/ViewM/AccountVM/login_otp_view_model.dart';
import 'package:trip_go/ViewM/AccountVM/register_view_model.dart';
import 'package:trip_go/constants.dart';

class MobileForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController controller;
  final VoidCallback onSubmit;

  const MobileForm({
    super.key,
    required this.formKey,
    required this.controller,
    required this.onSubmit,
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
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, fontFamily: 'Poppins'),
          ),
          const SizedBox(height: 10),
          TextFormField(
            controller: controller,
            style: const TextStyle(fontFamily: 'Poppins'),
            decoration: InputDecoration(
              hintText: 'Enter your Email Id/Mobile no.',
              prefixIcon: const Icon(Icons.email_outlined),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              contentPadding: const EdgeInsets.symmetric(horizontal: 12),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) return 'This field cannot be empty';
              final emailRegex = RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
              final phoneRegex = RegExp(r'^[0-9]{10,13}$');
              if (!emailRegex.hasMatch(value) && !phoneRegex.hasMatch(value)) {
                return 'Enter valid Email or Mobile Number';
              }
              return null;
            },
          ),
          const SizedBox(height: 20),
          (loginOtpVM.isLoading || registerVM.isLoading)
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
                      child: Text('CONTINUE', style: TextStyle(fontFamily: 'Poppins', color: Colors.white, fontWeight: FontWeight.w600)),
                    ),
                  ),
                ),
          const SizedBox(height: 20),
          const Divider(),
          const SizedBox(height: 4),
          const Center(child: Text('Or Login Via', style: TextStyle(fontFamily: 'Poppins'))),
          const SizedBox(height: 4),
          const Divider(),
          const SizedBox(height: 15),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: Colors.grey.shade400),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                    padding: const EdgeInsets.symmetric(vertical: 10),
                  ),
                  child: Image.network('https://images.emtcontent.com/mob-web/google-logo.png', height: 24),
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: Colors.grey.shade400),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                    padding: const EdgeInsets.symmetric(vertical: 10),
                  ),
                  child: Image.network('https://images.emtcontent.com/mob-web/facebook.png', height: 24),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
