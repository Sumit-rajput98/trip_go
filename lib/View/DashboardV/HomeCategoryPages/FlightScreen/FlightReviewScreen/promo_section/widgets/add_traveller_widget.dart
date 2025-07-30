import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trip_go/constants.dart';
import '../../../../../../../Model/FlightM/add_traveller_model.dart';
import 'custom_text_field.dart';
import 'dob_calender_page.dart';

class AddTravellerWidget extends StatefulWidget {
  final Traveller? existingTraveller;

  const AddTravellerWidget({super.key, this.existingTraveller});

  @override
  State<AddTravellerWidget> createState() => _AddTravellerWidgetState();
}

class _AddTravellerWidgetState extends State<AddTravellerWidget> {
  final _formKey = GlobalKey<FormState>();

  String? title;
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  DateTime? selectedDate;
  final TextEditingController emailController = TextEditingController();

  @override
  void initState() {
    super.initState();

    if (widget.existingTraveller != null) {
      title = widget.existingTraveller!.title ?? 'Mr';
      firstNameController.text = widget.existingTraveller!.firstName;
      lastNameController.text = widget.existingTraveller!.lastName;
      emailController.text = widget.existingTraveller!.email ?? '';

      if (widget.existingTraveller!.dateOfBirth != null &&
          widget.existingTraveller!.dateOfBirth!.isNotEmpty) {
        selectedDate = DateTime.tryParse(widget.existingTraveller!.dateOfBirth!);

        if (selectedDate != null) {
          final paxType = calculatePaxType(selectedDate!);
          widget.existingTraveller!.paxType = paxType;
        }
      }
    } else {
      title = 'Mr';
    }
  }

  int calculatePaxType(DateTime dob) {
    final today = DateTime.now();
    int age = today.year - dob.year;
    if (today.month < dob.month || (today.month == dob.month && today.day < dob.day)) {
      age--;
    }

    if (age >= 12) return 1; // Adult
    if (age >= 2) return 2;  // Child
    return 3;                // Infant
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          widget.existingTraveller == null ? 'Add Traveller' : 'Edit Traveller',
          style: const TextStyle(fontFamily: 'poppins'),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              DropdownButtonFormField<String>(
                value: title,
                items: const [
                  DropdownMenuItem(value: 'Mr', child: Text('Mr', style: TextStyle(fontFamily: 'poppins'))),
                  DropdownMenuItem(value: 'Mrs', child: Text('Mrs', style: TextStyle(fontFamily: 'poppins'))),
                  DropdownMenuItem(value: 'Ms', child: Text('Ms', style: TextStyle(fontFamily: 'poppins'))),
                ],
                onChanged: (val) => setState(() => title = val),
                decoration: InputDecoration(
                  labelText: 'Title',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                ),
                validator: (value) => (value == null || value.isEmpty) ? 'Please select a title' : null,
              ),

              const SizedBox(height: 20),

              CustomTextField(
                controller: firstNameController,
                label: 'First Name',
                hint: 'Enter first name',
                validator: (value) => value == null || value.trim().isEmpty ? 'First name is required' : null,
              ),

              const SizedBox(height: 20),

              CustomTextField(
                controller: lastNameController,
                label: 'Last Name',
                hint: 'Enter last name',
                validator: (value) => value == null || value.trim().isEmpty ? 'Last name is required' : null,
              ),

              const SizedBox(height: 20),

              InkWell(
                onTap: () async {
                  final pickedDate = await Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const DOBCalendarPage()),
                  );

                  if (pickedDate != null && pickedDate is DateTime) {
                    setState(() {
                      selectedDate = pickedDate;
                    });
                  }
                },
                child: InputDecorator(
                  decoration: InputDecoration(
                    labelText: 'Date of Birth',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  child: Text(
                    selectedDate != null
                        ? "${selectedDate!.day.toString().padLeft(2, '0')}-${selectedDate!.month.toString().padLeft(2, '0')}-${selectedDate!.year}"
                        : 'Select Date of Birth (Optional)',
                    style: TextStyle(
                      color: selectedDate == null ? Colors.grey.shade600 : Colors.black,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              CustomTextField(
                controller: emailController,
                label: 'Email (Optional)',
                hint: 'Enter email',
                keyboardType: TextInputType.emailAddress,
              ),

              const SizedBox(height: 30),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: constants.themeColor2,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      final dobString = selectedDate?.toIso8601String().split('T')[0];
                      final paxType = calculatePaxType(selectedDate ?? DateTime.now());

                      print("Traveller Added -> PaxType: $paxType, DOB: $dobString");

                      final newTraveller = Traveller(
                        title: title,
                        firstName: firstNameController.text.trim(),
                        lastName: lastNameController.text.trim(),
                        dateOfBirth: dobString,
                        email: emailController.text.trim().isEmpty
                            ? null
                            : emailController.text.trim(),
                        paxType: paxType,
                      );

                      Navigator.pop(context, newTraveller);
                    }
                  },
                  child: Text(
                    widget.existingTraveller == null ? 'Add Traveller' : 'Save Changes',
                    style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
