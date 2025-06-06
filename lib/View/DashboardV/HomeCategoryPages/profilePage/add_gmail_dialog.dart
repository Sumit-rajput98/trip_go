import 'package:flutter/material.dart';
import 'package:trip_go/View/DashboardV/HomeCategoryPages/profilePage/profile_page.dart';

import '../../../../constants.dart';
class AddGmail extends StatelessWidget {
  const AddGmail({super.key});

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    RegExp email_valid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    return Dialog(
      child: Container(
        height: 260,
        decoration: BoxDecoration(color: Colors.white),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Container(
                height: 30,
                width: double.infinity,
                decoration: BoxDecoration(color: Colors.grey.withOpacity(.3)),
                child: Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Add Email",
                        style: constants.titleStyle,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Icon(Icons.close, size: 30, color: Colors.red),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, top: 10, right: 10),
                child: Text(
                  constants.addPhoneNumber,
                  style: constants.fontStyle,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextFormField(
                    decoration: InputDecoration(hintText: "Enter Email id"),
                    cursorColor: Colors.blue,
                    validator: (value){
                      if(value!.isEmpty){
                        return "Enter your Email";
                      }else if (!email_valid.hasMatch(value)){
                        return "Email should contain some condition";
                      }
                      return null;
                    },
                  ),
                ),
              ),
              SizedBox(height: 20),
              InkWell(
                onTap: () {
                  if (_formKey.currentState!.validate()) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => ProfilePage()),
                    );
                  }
                },
                child: Container(
                  height: 50,
                  width: 320,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.lightBlueAccent, width: 1.5),
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.blue[800],
                  ),
                  child: Text(
                    "GENERATE OTP",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
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