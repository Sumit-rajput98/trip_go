import 'dart:async';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trip_go/View/DashboardV/HomeCategoryPages/profile/auth_provider.dart';
import 'package:trip_go/View/DashboardV/Widget/show_toast.dart';
import 'package:trip_go/ViewM/AccountVM/login_otp_view_model.dart';
import 'package:trip_go/ViewM/AccountVM/validate_otp_view_model.dart';
import 'package:trip_go/ViewM/AccountVM/register_view_model.dart';
import 'package:trip_go/ViewM/AccountVM/login_view_model.dart';
import 'package:trip_go/ViewM/AccountVM/forgot_password_view_model.dart';
import 'package:trip_go/constants.dart';
import 'package:trip_go/View/DashboardV/HomeCategoryPages/profile/user_profile_page.dart';

enum LoginStep { mobile, otp, password }

class LoginBottomSheet extends StatefulWidget {
  final BuildContext rootContext;
  const LoginBottomSheet({super.key, required this.rootContext});
  @override
  State<LoginBottomSheet> createState() => _LoginBottomSheetState();
}

class _LoginBottomSheetState extends State<LoginBottomSheet> {
  final List<Map<String, String>> carouselItems = [
    {
      'title': 'Enjoy Massive Savings',
      'subtitle': 'With Discounted Fare on Flight Bookings',
      'image': 'https://images.emtcontent.com/common/flightpopico1.svg',
      'bgColor': '0xFFE3F2FD',
    },
    {
      'title': 'Check in to Savings',
      'subtitle': 'Book your favourite hotel at cheap price.',
      'image': 'https://images.emtcontent.com/common/hotelpopico.svg',
      'bgColor': '0xFFE8F5E9',
    },
    {
      'title': 'Get Exclusive Bus Deals',
      'subtitle': 'Save more on every bus ride you book.',
      'image': 'https://images.emtcontent.com/common/buspopico.svg',
      'bgColor': '0xFFFFF3E0',
    },
    {
      'title': 'Invite & Earn!',
      'subtitle': 'Invite Friends & Earn Up to ₹2000 in EMT Wallet',
      'image': 'https://images.emtcontent.com/common/invite-earn-icon.svg',
      'bgColor': '0xFFF3E5F5',
    },
  ];

  int _currentIndex = 0;
  LoginStep currentStep = LoginStep.mobile;
  final TextEditingController loginController = TextEditingController();
  final TextEditingController otpController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  int remainingTime = 30;
  Timer? _timer;
  bool _obscurePassword = true;
  bool _showForgotSection = false;
  final GlobalKey<FormState> _mobileFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _passwordFormKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _timer?.cancel();
    loginController.dispose();
    otpController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void setStep(LoginStep step) {
    setState(() {
      currentStep = step;
      if (step == LoginStep.otp) startTimer();
    });
  }

  void startTimer() {
    _timer?.cancel();
    remainingTime = 30;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) return;
      if (remainingTime == 0) {
        timer.cancel();
      } else {
        setState(() {
          remainingTime--;
        });
      }
    });
  }Future<void> _handleMobileSubmit() async {
  if (!_mobileFormKey.currentState!.validate()) return;

  final input = loginController.text.trim();
  final loginOtpVM = Provider.of<LoginOtpViewModel>(context, listen: false);
  final registerVM = Provider.of<RegisterViewModel>(context, listen: false);
  const countryCode = "91";

  try {
    // Step 1: Register the user (even if already exists)
    await registerVM.registerUser({
      "CountryCode": countryCode,
      "PhoneNumber": input,
    });

    final regResponse = registerVM.registerResponse;
    final regSuccess = regResponse?.success == true;
    final alreadyRegistered = regResponse?.message
            ?.toLowerCase()
            .contains("already registered") ??
        false;

    if (regSuccess || alreadyRegistered) {
      // if (regSuccess) {
      //   final user = regResponse?.data;
      //   final prefs = await SharedPreferences.getInstance();
      //   await prefs.setBool('isLoggedIn', true);
      //   await prefs.setInt('userId', user?.id ?? 0);
      //   await prefs.setString('phone', user?.phone ?? '');
      //   Provider.of<AuthProvider>(context, listen: false).login();
      // }

      // Step 2: Login with OTP
      await loginOtpVM.loginWithOtp({
        "CountryCode": countryCode,
        "PhoneNumber": input,
      });

      if (loginOtpVM.otpResponse?.success == true) {
        showToast(loginOtpVM.otpResponse?.message ?? "OTP Sent");
        setStep(LoginStep.otp); // go to OTP screen
      } else {
        showToast(loginOtpVM.otpResponse?.message ?? "OTP Failed");
      }
    } else {
      showToast(regResponse?.message ?? "Registration Failed");
    }
  } catch (e) {
    showToast("Something went wrong");
  }
}

Future<void> _handleOtpSubmit() async {
  final otp = otpController.text.trim();
  if (otp.isEmpty || otp.length < 4) {
    showToast("Please enter valid OTP");
    return;
  }

  final validateOtpVM = Provider.of<ValidateOtpViewModel>(context, listen: false);
  await validateOtpVM.validateOtp(
    countryCode: "91",
    phoneNumber: loginController.text.trim(),
    otp: otp,
  );

  final success = validateOtpVM.otpResponse?.success == true;
  final message = validateOtpVM.otpResponse?.message ?? (success ? "Login Success" : "Login Failed");

  if (success) {
    final data = validateOtpVM.otpResponse?.data;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', true);
    Provider.of<AuthProvider>(context, listen: false).login();

    
    await prefs.setString('email', data?.email ?? '');
    await prefs.setString('phone', data?.phone ?? '');
    await prefs.setString('countryCode', "91");
    

    showToast(message);
    Navigator.pop(context);
  } else {
    showToast(message);
  }
}
Future<void> _handlePasswordSubmit() async {
  if (!_passwordFormKey.currentState!.validate()) return;

  final loginVM = Provider.of<LoginViewModel>(context, listen: false);
  await loginVM.login(
    loginController.text.trim(),
    passwordController.text.trim(),
  );

  final success = loginVM.loginModel?.success == true;
  final message = loginVM.loginModel?.message ?? (success ? "Login Success" : "Login Failed");

  if (success) {
    final data = loginVM.loginModel?.data;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', true);
    Provider.of<AuthProvider>(context, listen: false).login();

    
    await prefs.setString('email', data?.email ?? '');
    await prefs.setString('phone', data?.phone ?? '');
    await prefs.setString('countryCode', '91');

    showToast(message);
    Navigator.pop(context);
  } else {
    showToast(message);
  }
}
Future<void> _handleForgotPassword() async {
  final email = loginController.text.trim();
  final emailRegex = RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

  if (!emailRegex.hasMatch(email)) {
    showToast("Enter a valid email");
    return;
  }

  final forgotVM = Provider.of<ForgotPasswordViewModel>(context, listen: false);
  await forgotVM.sendResetLink(email);

  final success = forgotVM.response?.success == true;
  final message = forgotVM.response?.message ?? (success ? "Email sent successfully" : "Try Again");

  showToast(message);

  if (success) {
    setState(() => _showForgotSection = false);
  }
}

  @override
  Widget build(BuildContext context) {
    return AnimatedPadding(
      duration: const Duration(milliseconds: 300),
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: SingleChildScrollView(
        child: SizedBox(
          height: currentStep == LoginStep.mobile ? 500 : 380,
          child: Stack(
            children: [
              // Carousel (only shown in mobile step)
              if (currentStep == LoginStep.mobile)
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                  child: CarouselSlider.builder(
                    itemCount: carouselItems.length,
                    itemBuilder: (context, index, _) {
                      final item = carouselItems[index];
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: Color(int.parse(item['bgColor']!)),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 16),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(item['title']!,
                                        style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600,
                                            fontFamily: 'Poppins')),
                                    const SizedBox(height: 6),
                                    Text(item['subtitle']!,
                                        style: const TextStyle(
                                            fontSize: 13, fontFamily: 'Poppins')),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: SvgPicture.network(
                                item['image']!,
                                height: 70,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                    options: CarouselOptions(
                      height: 140,
                      autoPlay: true,
                      viewportFraction: 1.0,
                      onPageChanged: (index, reason) {
                        setState(() => _currentIndex = index);
                      },
                    ),
                  ),
                ),

              // Close button
              Positioned(
                top: 12,
                right: 12,
                child: GestureDetector(
                  onTap: () {
                    if (currentStep != LoginStep.mobile) {
                      setStep(LoginStep.mobile);
                    } else {
                      Navigator.of(context).pop();
                    }
                  },
                  child: const CircleAvatar(
                    radius: 16,
                    backgroundColor: Colors.white,
                    child: Icon(Icons.close, size: 18, color: Colors.black),
                  ),
                ),
              ),

              // Form content
              Positioned(
                top: currentStep == LoginStep.mobile ? 120 : 0,
                left: 0,
                right: 0,
                child: Container(
                  height: currentStep == LoginStep.mobile ? 380 : 380,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
                    boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 8)],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (currentStep != LoginStep.mobile) ...[
                        const SizedBox(height: 20),
                        Text(
                          currentStep == LoginStep.otp
                              ? 'OTP Authentication'
                              : 'Login with Password',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Poppins',
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          currentStep == LoginStep.otp
                              ? 'We have sent a code to\n${loginController.text}'
                              : 'Login with your registered email or mobile and password',
                          style: const TextStyle(fontSize: 14, fontFamily: 'Poppins'),
                        ),
                        const SizedBox(height: 20),
                      ],
                      
                      // Mobile Form
                      if (currentStep == LoginStep.mobile) _buildMobileForm(),
                      
                      // OTP Form
                      if (currentStep == LoginStep.otp) _buildOtpForm(),
                      
                      // Password Form
                      if (currentStep == LoginStep.password) _buildPasswordForm(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMobileForm() {
    final loginOtpVM = Provider.of<LoginOtpViewModel>(context);
    final registerVM = Provider.of<RegisterViewModel>(context);
    
    return Form(
      key: _mobileFormKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Login or Create an account',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, fontFamily: 'Poppins'),
          ),
          const SizedBox(height: 10),
          TextFormField(
            controller: loginController,
            style: const TextStyle(fontFamily: 'Poppins'),
            decoration: InputDecoration(
              hintText: 'Enter your Email Id/Mobile no.',
              prefixIcon: const Icon(Icons.email_outlined),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              contentPadding: const EdgeInsets.symmetric(horizontal: 12),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) return 'This field cannot be empty';
              final emailRegex = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
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
                  onTap: _handleMobileSubmit,
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

  Widget _buildOtpForm() {
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
                    onPressed: startTimer,
                    child: const Text("Resend", style: TextStyle(fontFamily: 'Poppins', color: Colors.blue, fontWeight: FontWeight.w600)),
                  ),
          ],
        ),
        const SizedBox(height: 20),
        validateOtpVM.isLoading
            ? const Center(child: CircularProgressIndicator())
            : GestureDetector(
                onTap: _handleOtpSubmit,
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
            onTap: () => setStep(LoginStep.password),
            child: const Text(
              'Login with Password',
              style: TextStyle(fontFamily: 'Poppins', color: Colors.black87, fontWeight: FontWeight.w500),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPasswordForm() {
    final loginVM = Provider.of<LoginViewModel>(context);
    
    return Form(
      key: _passwordFormKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            controller: loginController,
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
          if (!_showForgotSection)
            TextFormField(
              controller: passwordController,
              obscureText: _obscurePassword,
              style: const TextStyle(fontFamily: 'Poppins'),
              decoration: InputDecoration(
                hintText: 'Enter your Password',
                prefixIcon: const Icon(Icons.lock_outline),
                suffixIcon: IconButton(
                  icon: Icon(_obscurePassword ? Icons.visibility_off : Icons.visibility),
                  onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
                ),
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
                onPressed: () => setState(() => _showForgotSection = true),
                child: const Text('Forgot Password?', style: TextStyle(fontFamily: 'Poppins', color: Colors.blue, fontWeight: FontWeight.w500)),
              ),
            ),
          const SizedBox(height: 20),
          loginVM.isLoading
              ? const Center(child: CircularProgressIndicator())
              : GestureDetector(
                  onTap: _showForgotSection ? _handleForgotPassword : _handlePasswordSubmit,
                  child: Container(
                    height: 50,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [constants.themeColor1, constants.themeColor2]),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Center(
                      child: Text(
                        _showForgotSection ? 'SEND EMAIL' : 'LOGIN',
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