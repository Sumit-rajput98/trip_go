import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trip_go/View/DashboardV/HomeCategoryPages/profile/auth_provider.dart';
import 'package:trip_go/View/DashboardV/HomeCategoryPages/profile/user_profile_page.dart';
import 'package:trip_go/ViewM/AccountVM/forgot_password_view_model.dart';
import 'package:trip_go/ViewM/AccountVM/login_view_model.dart';
import 'package:trip_go/constants.dart';

class PasswordLoginForm extends StatefulWidget {
  final VoidCallback? onLoginComplete;
  const PasswordLoginForm({super.key, this.onLoginComplete});

  @override
  State<PasswordLoginForm> createState() => _PasswordLoginFormState();
}

class _PasswordLoginFormState extends State<PasswordLoginForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _obscurePassword = true;
  bool _isLoading = false;
  bool _showForgotSection = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submit() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);

      final loginViewModel = Provider.of<LoginViewModel>(context, listen: false);
      await loginViewModel.login(
        _emailController.text.trim(),
        _passwordController.text.trim(),
      );

      final loginResult = loginViewModel.loginModel;

      if (loginResult != null && loginResult.success == true) {
        final prefs = await SharedPreferences.getInstance();
        final data = loginResult.data;
        await prefs.setBool('isLoggedIn', true);
        Provider.of<AuthProvider>(context, listen: false).login();
        
        await prefs.setString('email', data?.email ?? '');
        await prefs.setString('phone', data?.phone ?? '');
        await prefs.setString('countryCode', "91");
         final msg = loginResult.message ?? "Login Successful";
        ScaffoldMessenger.of(context).showSnackBar(
           SnackBar(content: Text(msg)),
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const UserProfilePage()),
        );
      } else {
        final errorMsg = loginResult?.message ?? 'Login failed';
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(errorMsg)),
        );
      }

      setState(() => _isLoading = false);
    }
  }
void _sendForgotEmail() async {
  final email = _emailController.text.trim();
  final emailRegex = RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

  if (!emailRegex.hasMatch(email)) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Enter a valid email")),
    );
    return;
  }

  setState(() => _isLoading = true);
  final forgotVM = Provider.of<ForgotPasswordViewModel>(context, listen: false);

  try {
    await forgotVM.sendResetLink(email);

    if (forgotVM.response?.success == true) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(forgotVM.response?.message ?? "Reset link sent")),
      );
      setState(() {
        _showForgotSection = false;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(forgotVM.response?.message ?? "Failed to send reset link")),
      );
    }
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Something went wrong")),
    );
  } finally {
    setState(() => _isLoading = false);
  }
}

  @override
  Widget build(BuildContext context) {
    final loginViewModel = Provider.of<LoginViewModel>(context);
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          TextFormField(
            controller: _emailController,
            style: const TextStyle(fontFamily: 'Poppins'),
            decoration: InputDecoration(
              hintText: 'Enter your Email Id / Mobile no.',
              prefixIcon: const Icon(Icons.email_outlined),
              hintStyle: const TextStyle(fontFamily: 'Poppins'),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              contentPadding: const EdgeInsets.symmetric(horizontal: 12),
            ),
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'This field cannot be empty';
              }
              final emailRegex = RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
              final phoneRegex = RegExp(r'^(?:\+91|91)?[6-9][0-9]{9}$');
              if (!emailRegex.hasMatch(value) && !phoneRegex.hasMatch(value)) {
                return 'Enter a valid Email or Mobile Number';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          if (!_showForgotSection)
            TextFormField(
              controller: _passwordController,
              obscureText: _obscurePassword,
              style: const TextStyle(fontFamily: 'Poppins'),
              decoration: InputDecoration(
                hintText: 'Enter your Password',
                prefixIcon: const Icon(Icons.lock_outline),
                suffixIcon: IconButton(
                  icon: Icon(_obscurePassword ? Icons.visibility_off : Icons.visibility),
                  onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
                ),
                hintStyle: const TextStyle(fontFamily: 'Poppins'),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                contentPadding: const EdgeInsets.symmetric(horizontal: 12),
              ),
              validator: (value) {
                if (_showForgotSection) return null;
                return (value == null || value.isEmpty) ? 'Password cannot be empty' : null;
              },
            ),
          if (!_showForgotSection)
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  setState(() => _showForgotSection = true);
                },
                child: const Text(
                  'Forgot Password?',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    color: Colors.blue,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          const SizedBox(height: 20),
          _isLoading
              ? const Center(child: CircularProgressIndicator())
              : GestureDetector(
                  onTap: _showForgotSection ? _sendForgotEmail : _submit,
                  child: Container(
                    height: 50,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [constants.themeColor1, constants.themeColor2],
                      ),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Center(
                      child: Text(
                        _showForgotSection ? 'SEND EMAIL' : 'LOGIN',
                        style: const TextStyle(
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
