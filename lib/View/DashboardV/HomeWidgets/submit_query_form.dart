import 'package:flutter/material.dart';
import '../../../Model/TourM/quick_enquiry_model.dart';
import '../../../ViewM/TourVM/quick_enquiry_view_model.dart';
import '../HomeCategoryPages/TourScreen/TourWidget/success_dialog.dart';
import '../HomeCategoryPages/TourScreen/TourWidget/unlabelled_text_field_.dart';

class SubmitQueryFormPage extends StatelessWidget {
  const SubmitQueryFormPage({super.key});

  @override
  Widget build(BuildContext context) {
    final destinationController = TextEditingController();
    final nameController = TextEditingController();
    final emailController = TextEditingController();
    final phoneController = TextEditingController();
    final messageController = TextEditingController();
    final formKey = GlobalKey<FormState>();

    return LayoutBuilder(
        builder: (context, constraints) {
          return Stack(
            clipBehavior: Clip.none,
            children: [
              Padding(
                padding: EdgeInsets.only(
                  left: 25,
                  right: 25,
                  top: 25,
                  bottom: MediaQuery.of(context).viewInsets.bottom + 25,
                ),
                child: SingleChildScrollView(
                  keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                  child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(height: 10), // Space below the cancel icon
                        const Text(
                          "Want to Go For A Memorable Holiday?",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'poppins',
                          ),
                        ),
                        const SizedBox(height: 20),
                        UnlabeledTextField(
                          hintText: 'Destination',
                          controller: destinationController,
                          validator: (value) =>
                          value == null || value.isEmpty ? 'Enter destination' : null,
                        ),
                        const SizedBox(height: 12),
                        UnlabeledTextField(
                          hintText: 'Your Name',
                          controller: nameController,
                          validator: (value) =>
                          value == null || value.isEmpty ? 'Enter your name' : null,
                        ),
                        const SizedBox(height: 12),
                        UnlabeledTextField(
                          hintText: 'Your E-Mail ID',
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) =>
                          value == null || !value.contains('@') ? 'Enter valid email' : null,
                        ),
                        const SizedBox(height: 12),
                        UnlabeledTextField(
                          hintText: 'Mobile No.',
                          controller: phoneController,
                          keyboardType: TextInputType.phone,
                          validator: (value) =>
                          value == null || value.length < 10 ? 'Enter valid number' : null,
                        ),
                        const SizedBox(height: 12),
                        TextFormField(
                          controller: messageController,
                          maxLines: 3,
                          decoration: const InputDecoration(
                            hintText: 'Your Message',
                            hintStyle: TextStyle(fontFamily: 'Poppins'),
                            contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(5))),
                            isDense: true,
                          ),
                          style: const TextStyle(fontFamily: 'Poppins'),
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          height: 45,
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            onPressed: () async {
                              if (formKey.currentState!.validate()) {
                                final model = QuickEnquiryModel(
                                  name: nameController.text,
                                  email: emailController.text,
                                  phone: phoneController.text,
                                  destination: destinationController.text,
                                  message: messageController.text,
                                );

                                final result = await QuickEnquiryViewModel().sendEnquiry(context, model);

                                if (result['success'] == true) {
                                  Navigator.pop(context); // Close the bottom sheet

                                  // Show dialog with message from response
                                  showDialog(
                                    context: context,
                                    barrierDismissible: false,
                                    builder: (BuildContext context) {
                                      return TickSuccessDialog(
                                        message: result['message'] ?? 'Query Submitted Successfully!',
                                      );
                                    },
                                  );
                                } else {
                                  // Optionally handle failure cases
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text(result['message'] ?? 'Submission failed!')),
                                  );
                                }
                              }
                            },
                            child: const Text(
                              "Enquire Now",
                              style: TextStyle(fontFamily: 'poppins', color: Colors.white, fontSize: 16),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ),
              // Positioned cancel icon
              Positioned(
                top: -40,
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
        }
    );
  }
}
