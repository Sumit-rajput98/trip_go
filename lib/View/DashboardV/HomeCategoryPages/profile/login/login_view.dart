import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trip_go/View/DashboardV/HomeCategoryPages/profile/login/login_form.dart';
import 'package:trip_go/View/DashboardV/HomeCategoryPages/profile/login/otp_form.dart';
import 'package:trip_go/View/DashboardV/HomeCategoryPages/profile/login/password_login_form.dart';
import 'package:trip_go/View/DashboardV/HomeCategoryPages/profile/user_profile_page.dart';
import 'package:trip_go/ViewM/AccountVM/login_otp_view_model.dart';
import 'package:trip_go/ViewM/AccountVM/validate_otp_view_model.dart';
import 'package:trip_go/constants.dart';

enum LoginStep { mobile, otp, password }

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController loginController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  LoginStep currentStep = LoginStep.mobile;
  int remainingTime = 30;
  Timer? _timer;
  late final TextEditingController otpController;

  @override
  void initState() {
    super.initState();
    otpController = TextEditingController();
  }

  void setStep(LoginStep step) {
    setState(() {
      currentStep = step;
      if (step == LoginStep.otp) startTimer();
    });
  }

 void startTimer() {
  _timer?.cancel();
  setState(() => remainingTime = 30);
  _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
    if (remainingTime == 0) {
      timer.cancel();
    } else {
      if (mounted) {
        setState(() {
          remainingTime--;
        });
      }
    }
  });
}

Future<void> handleResendOtp() async {
  final loginOtpVM = Provider.of<LoginOtpViewModel>(context, listen: false);

  await loginOtpVM.loginWithOtp({
    "CountryCode": "91",
    "PhoneNumber": loginController.text.trim(),
  });

  final loginSuccess = loginOtpVM.otpResponse?.success ?? false;
  final responseMsg = loginOtpVM.otpResponse?.message ?? "Unexpected error";

  if (loginSuccess) {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(responseMsg)),
      );
    }
    startTimer(); // start only on success
  } else {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(responseMsg)),
      );
    }
    // do not start timer if sending failed
  }
}

  @override
  void dispose() {
    _timer?.cancel();
    otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: constants.ultraLightThemeColor1,
        elevation: 1,
        centerTitle: true,
        title: Image.asset('assets/images/trip_go.png', height: 36),
        leading:
            currentStep != LoginStep.mobile
                ? IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.black),
                  onPressed: () => setStep(LoginStep.mobile),
                )
                : null,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const SizedBox(height: 10),
            Text(
              currentStep == LoginStep.otp
                  ? 'OTP Authentication'
                  : currentStep == LoginStep.password
                  ? 'Login with Password'
                  : 'Welcome to TripGo Online!',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontFamily: 'Poppins',
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 6),
            Text(
              currentStep == LoginStep.otp
                  ? 'We have sent a code to ${loginController.text}'
                  : currentStep == LoginStep.password
                  ? 'Login with your registered email or mobile and password'
                  : 'Please Login / SignUp using your Mobile to continue',
              style: const TextStyle(fontSize: 14, fontFamily: 'Poppins'),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            buildCardView(),
          ],
        ),
      ),
    );
  }

  Widget buildCardView() {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child:
            currentStep == LoginStep.otp
                ? OtpForm(
                  otpController: otpController,
                  loginController: loginController,
                  remainingTime: remainingTime,
                  onResend: handleResendOtp,
                  onLoginWithPassword: () => setStep(LoginStep.password),
                )
                : currentStep == LoginStep.password
                ? const PasswordLoginForm()
                : LoginForm(
                  formKey: _formKey,
                  loginController: loginController,
                  onSuccess: () => setStep(LoginStep.otp),
                ),
      ),
    );
  }
}
