import 'package:flutter/material.dart';
import 'package:trip_go/View/DashboardV/HomeCategoryPages/profilePage/profile_page.dart';

import '../../../../constants.dart';

class AddMobileNumber extends StatelessWidget {
  const AddMobileNumber({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    return Dialog(
      child: Container(
        height: 250,
        decoration: BoxDecoration(color: Colors.white),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              Container(
                height: 30,
                width: double.infinity,
                decoration: BoxDecoration(color: Colors.grey.withOpacity(.3)),
                child: Padding(
                  padding: const EdgeInsets.only(left: 15,),
                  child:
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Add Mobile Number",
                        style: constants.titleStyle,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Icon(Icons.close, size: 30, color: Colors.red,),
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Text(
                  constants.addPhoneNumber,
                  style: constants.fontStyle,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 20),
                child: Row(
                  children: [
                    Container(
                      height: 50,
                      width: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextField(
                        decoration: InputDecoration(

                          hintText: "+91",
                          labelText: "C-code",
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          labelStyle: TextStyle(color: Colors.blue),

                        ),
                        cursorColor: Colors.blue,
                      ),

                    ),
                    VerticalDivider(),
                    Expanded(
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),

                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: TextFormField(
                            decoration: InputDecoration(

                              hintText: "Enter Mobile Number",
                            ), style: TextStyle(
                            fontSize: 18,
                            color: Colors.grey,
                          ),
                            cursorColor: Colors.blue,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Number can't be empty ";
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30,),
              InkWell(
                onTap: () {
                  if (formKey.currentState!.validate()) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => ProfilePage()),
                    );
                  }
                },
                child: Container(
                  height: 50,
                  width: 330,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: Colors.lightBlueAccent,
                        width: 1.5
                    ),
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