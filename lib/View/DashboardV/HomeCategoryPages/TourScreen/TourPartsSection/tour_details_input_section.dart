import 'package:flutter/material.dart';
import 'package:trip_go/constants.dart';
import '../../../../../Model/TourM/package_inquiry_model.dart';
import '../../../../../ViewM/TourVM/package_inquiry_view_model.dart';
import '../TourWidget/labeled_text_field.dart';
import '../TourWidget/success_dialog.dart';

class TourDetailsInputSection extends StatefulWidget {
  final int id; // assuming you're passing package data here
  const TourDetailsInputSection({super.key, required this.id});

  @override
  State<TourDetailsInputSection> createState() => _TourDetailsInputSectionState();
}

class _TourDetailsInputSectionState extends State<TourDetailsInputSection> {
  final formKey = GlobalKey<FormState>();

  int adults = 1;
  int children = 0;
  int infants = 0;

  final TextEditingController cityController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController contactController = TextEditingController();

  void increment(String type) {
    setState(() {
      if (type == 'adult') adults++;
      if (type == 'child') children++;
      if (type == 'infant') infants++;
    });
  }

  void decrement(String type) {
    setState(() {
      if (type == 'adult' && adults > 1) adults--;
      if (type == 'child' && children > 0) children--;
      if (type == 'infant' && infants > 0) infants--;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
              ),
              border: Border.all(color: Colors.grey.shade400),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Blue title box
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: constants.themeColor1,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const [
                      Text(
                        "Want to Go For A Amazing Holiday?",
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        "Provide Your Details to Know Best Holiday Deals",
                        style: TextStyle(
                          fontSize: 12,
                          fontFamily: 'Poppins',
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 10),
                    ],
                  ),
                ),
                const SizedBox(height: 15),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      LabeledTextField(
                        label: "City",
                        hintText: "City",
                        controller: cityController,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) return "City is required";
                          return null;
                        },
                      ),
                      const SizedBox(height: 15),
                      const SizedBox(height: 6),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text("Adults", style: TextStyle(fontFamily: 'Poppins', fontSize: 14)),
                              buildCounter("adult", adults),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text("Child", style: TextStyle(fontFamily: 'Poppins', fontSize: 14)),
                              buildCounter("child", children),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text("Infant", style: TextStyle(fontFamily: 'Poppins', fontSize: 14)),
                              buildCounter("infant", infants),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),
                      LabeledTextField(
                        label: "Your Name",
                        hintText: "Name",
                        controller: nameController,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) return "Name is required";
                          return null;
                        },
                      ),
                      const SizedBox(height: 15),
                      LabeledTextField(
                        label: "Your Email",
                        hintText: "Email",
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) return "Email is required";
                          if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}$').hasMatch(value.trim())) {
                            return "Enter a valid email";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 15),
                      LabeledTextField(
                        label: "Contact Number",
                        hintText: "+919898XXXXXX",
                        controller: contactController,
                        keyboardType: TextInputType.phone,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) return "Contact number is required";
                          if (!RegExp(r'^\+?\d{10,15}$').hasMatch(value.trim())) {
                            return "Enter a valid contact number";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      Center(
                        child: SizedBox(
                          height: 45,
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () async {
                              if (formKey.currentState!.validate()) {
                                final model = PackageInquiryModel(
                                  name: nameController.text,
                                  email: emailController.text,
                                  phone: contactController.text,
                                  adult: adults,
                                  children: children,
                                  packageId: widget.id,
                                  city: cityController.text,
                                  travelDate: "",
                                );

                                final viewModel = PackageInquiryViewModel();
                                final responseMsg = await viewModel.submitInquiry(model, context);

                                Navigator.pop(context);

                                if (responseMsg != null && context.mounted) {
                                  showDialog(
                                    context: context,
                                    barrierDismissible: false,
                                    builder: (BuildContext context) {
                                      return TickSuccessDialog(message: responseMsg);
                                    },
                                  );
                                }
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: constants.themeColor1,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 8),
                            ),
                            child: const Text(
                              "Send Query",
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget buildCounter(String label, int value) {
    return Row(
      children: [
        // Minus button inside square
        GestureDetector(
          onTap: () => decrement(label),
          child: Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(4),
            ),
            child: const Center(
              child: Icon(Icons.remove, size: 15),
            ),
          ),
        ),
        Container(
          width: 25,
          height: 35,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Center(
            child: Text(
              "$value",
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ),
        ),
        // Plus button inside square
        GestureDetector(
          onTap: () => increment(label),
          child: Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(4),
            ),
            child: const Center(
              child: Icon(Icons.add, size: 15),
            ),
          ),
        ),
      ],
    );
  }

}
