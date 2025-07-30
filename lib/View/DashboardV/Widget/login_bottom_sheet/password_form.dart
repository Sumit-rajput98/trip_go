import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trip_go/ViewM/AccountVM/login_view_model.dart';
import 'package:trip_go/constants.dart';

class PasswordForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final VoidCallback onSubmit;
  final VoidCallback onForgotToggle;
  final bool obscurePassword;
  final VoidCallback togglePasswordVisibility;
  final bool showForgotSection;

  const PasswordForm({
    super.key,
    required this.formKey,
    required this.emailController,
    required this.passwordController,
    required this.onSubmit,
    required this.onForgotToggle,
    required this.obscurePassword,
    required this.togglePasswordVisibility,
    required this.showForgotSection,
  });

  @override
  Widget build(BuildContext context) {
    final loginVM = Provider.of<LoginViewModel>(context);

    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            controller: emailController,
            style: const TextStyle(fontFamily: 'Poppins'),
            decoration: InputDecoration(
              hintText: 'Enter your Email Id / Mobile no.',
              prefixIcon: const Icon(Icons.email_outlined),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              contentPadding: const EdgeInsets.symmetric(horizontal: 12),
            ),
            validator: (value) {
              if (value == null || value.trim().isEmpty) return 'This field cannot be empty';
              final emailRegex = RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
              final phoneRegex = RegExp(r'^(?:\+91|91)?[6-9][0-9]{9}$');
              if (!emailRegex.hasMatch(value) && !phoneRegex.hasMatch(value)) {
                return 'Enter a valid Email or Mobile Number';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          if (!showForgotSection)
            TextFormField(
              controller: passwordController,
              obscureText: obscurePassword,
              style: const TextStyle(fontFamily: 'Poppins'),
              decoration: InputDecoration(
                hintText: 'Enter your Password',
                prefixIcon: const Icon(Icons.lock_outline),
                suffixIcon: IconButton(
                  icon: Icon(obscurePassword ? Icons.visibility_off : Icons.visibility),
                  onPressed: togglePasswordVisibility,
                ),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
              validator: (value) {
                if (showForgotSection) return null;
                return (value == null || value.isEmpty) ? 'Password cannot be empty' : null;
              },
            ),
          if (!showForgotSection)
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: onForgotToggle,
                child: const Text('Forgot Password?', style: TextStyle(fontFamily: 'Poppins', color: Colors.blue, fontWeight: FontWeight.w500)),
              ),
            ),
          const SizedBox(height: 20),
          loginVM.isLoading
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
                    child: Center(
                      child: Text(
                        showForgotSection ? 'SEND EMAIL' : 'LOGIN',
                        style: const TextStyle(fontFamily: 'Poppins', color: Colors.white, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}
