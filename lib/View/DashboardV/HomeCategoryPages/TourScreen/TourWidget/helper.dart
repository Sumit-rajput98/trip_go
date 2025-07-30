import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:trip_go/View/DashboardV/HomeCategoryPages/TourScreen/TourWidget/success_dialog.dart';

import '../../../../../Model/TourM/package_inquiry_model.dart';
import '../../../../../ViewM/TourVM/package_inquiry_view_model.dart';
  // Customized Quick Inquiry Bottom Sheet inspired by the UI from image
void showQuoteBottomSheet(BuildContext context, int packageId) {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final packageController = TextEditingController();
  final cityController = TextEditingController();
  final dateController = TextEditingController();
  int adult = 2, child = 0, infant = 0;

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (_) {
      return StatefulBuilder(
        builder: (context, setState) {
          bool isLoading = false;

          return Stack(
            clipBehavior: Clip.none,
            children: [
              Padding(
                padding: EdgeInsets.only(
                  left: 16,
                  right: 16,
                  top: 20,
                  bottom: MediaQuery.of(context).viewInsets.bottom + 20,
                ),
                child: Form(
                  key: formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GradientTitle(text: 'Quick Inquiry'),
                        const SizedBox(height: 20),
                        CustomInputField(
                          hint: "Package Name / Destination Name",
                          icon: Icons.location_on_outlined,
                          controller: packageController,
                        ),
                        const SizedBox(height: 16),
                        DateField(controller: dateController),
                        const SizedBox(height: 16),
                        CustomInputField(
                          hint: "City of Departure",
                          icon: Icons.location_city,
                          controller: cityController,
                        ),
                        const SizedBox(height: 16),
                        CustomInputField(
                          hint: "Your Name",
                          icon: Icons.person_outline,
                          controller: nameController,
                        ),
                        const SizedBox(height: 16),
                        CustomInputField(
                          hint: "Mobile No.",
                          icon: Icons.phone_outlined,
                          controller: phoneController,
                          inputType: TextInputType.phone,
                        ),
                        const SizedBox(height: 16),
                        CustomInputField(
                          hint: "Your E-mail Address",
                          icon: Icons.email_outlined,
                          controller: emailController,
                          inputType: TextInputType.emailAddress,
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            NumberStepper(title: "Adult", value: adult, onChanged: (v) => adult = v),
                            NumberStepper(title: "Child", value: child, onChanged: (v) => child = v),
                            NumberStepper(title: "Infant", value: infant, onChanged: (v) => infant = v),
                          ],
                        ),
                        const SizedBox(height: 25),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: isLoading
                                ? null
                                : () async {
                              if (formKey.currentState!.validate()) {
                                setState(() => isLoading = true);

                                final model = PackageInquiryModel(
                                  name: nameController.text,
                                  email: emailController.text,
                                  phone: phoneController.text,
                                  adult: adult,
                                  children: child,
                                  packageId: packageId,
                                  city: cityController.text,
                                  travelDate: dateController.text,
                                );

                                final viewModel = PackageInquiryViewModel();
                                final responseMsg =
                                await viewModel.submitInquiry(model, context);

                                if (context.mounted) {
                                  Navigator.pop(context);
                                  if (responseMsg != null) {
                                    showDialog(
                                      context: context,
                                      barrierDismissible: false,
                                      builder: (BuildContext context) {
                                        return TickSuccessDialog(message: responseMsg);
                                      },
                                    );
                                  }
                                }

                                setState(() => isLoading = false);
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              backgroundColor: const Color(0xFF1B499F),
                            ),
                            child: isLoading
                                ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.white,
                              ),
                            )
                                : const Text(
                              'Submit',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                top: -30,
                right: 0,
                left: 0,
                child: Center(
                  child: CircleAvatar(
                    backgroundColor: Colors.black,
                    radius: 20,
                    child: IconButton(
                      icon: const Icon(Icons.close, color: Colors.white),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      );
    },
  );
}

class CustomInputField extends StatelessWidget {
  final String hint;
  final IconData icon;
  final TextEditingController controller;
  final TextInputType? inputType;

  const CustomInputField({super.key, 
    required this.hint,
    required this.icon,
    required this.controller,
    this.inputType,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: inputType,
      validator: (val) => val == null || val.isEmpty ? 'Required' : null,
      style: const TextStyle(fontFamily: 'Poppins'),
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: Colors.grey),
        hintText: hint,
        hintStyle: const TextStyle(fontFamily: 'Poppins'),
        filled: true,
        fillColor: Colors.grey[100],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Color(0xFF1B499F)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Color(0xFF1B499F)),
        ),
      ),
    );
  }
}
class GradientTitle extends StatelessWidget {
  final String text;
  const GradientTitle({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (Rect bounds) {
        return const LinearGradient(
          colors: [Color(0xFF1B499F), Color(0xFFF73130)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ).createShader(bounds);
      },
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          fontFamily: 'Poppins',
          color: Colors.white, // gets masked
        ),
      ),
    );
  }
}
class DateField extends StatelessWidget {
  final TextEditingController controller;

  const DateField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final picked = await showDatePicker(
          context: context,
          firstDate: DateTime.now(),
          lastDate: DateTime(2100),
          initialDate: DateTime.now(),
        );
        if (picked != null) {
          controller.text = DateFormat('dd-MM-yyyy').format(picked);
        }
      },
      child: AbsorbPointer(
        child: CustomInputField(
          hint: "Date of Departure",
          icon: Icons.date_range_outlined,
          controller: controller,
        ),
      ),
    );
  }
}
class NumberStepper extends StatefulWidget {
  final String title;
  final int value;
  final ValueChanged<int> onChanged;

  const NumberStepper({super.key, 
    required this.title,
    required this.value,
    required this.onChanged,
  });

  @override
  _NumberStepperState createState() => _NumberStepperState();
}

class _NumberStepperState extends State<NumberStepper> {
  late int count;

  @override
  void initState() {
    super.initState();
    count = widget.value;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(widget.title, style: const TextStyle(fontFamily: 'Poppins')),
        const SizedBox(height: 4),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 0),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              IconButton(
                onPressed: () {
                  if (count > 0) {
                    setState(() => count--);
                    widget.onChanged(count);
                  }
                },
                icon: const Icon(Icons.remove),
              ),
              Text('$count', style: const TextStyle(fontFamily: 'Poppins')),
              IconButton(
                onPressed: () {
                  setState(() => count++);
                  widget.onChanged(count);
                },
                icon: const Icon(Icons.add),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
