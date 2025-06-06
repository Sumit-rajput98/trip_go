import 'package:flutter/material.dart';
import 'package:trip_go/View/DashboardV/HomeCategoryPages/profilePage/profile_page.dart';

import '../../../../constants.dart';

class DeleteEmail extends StatefulWidget {
  const DeleteEmail({super.key});

  @override
  State<DeleteEmail> createState() => _DeleteEmailState();
}

class _DeleteEmailState extends State<DeleteEmail> {
  final _formKey = GlobalKey<FormState>();

  RegExp pass_valid = RegExp("^(?=.*[A-Za-z])(?=.*)[A-Za-z]{8,} ");

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        height: 235,
        decoration: BoxDecoration(color: Colors.white),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                        "Delete Contact",
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
                padding: const EdgeInsets.only(left: 15,top: 40),
                child: Text("Enter password",style: TextStyle(
                    fontSize: 17,
                    color: Colors.black.withOpacity(.5)
                ),),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20,right: 20),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextFormField(
                    style: TextStyle(
                      fontSize: 15,
                    ),
                    decoration: InputDecoration(hintText: "Password"),
                    cursorColor: Colors.blue,
                    validator: (value){
                      if(value!.isEmpty){
                        return "Enter password";
                      }else if(!pass_valid.hasMatch(value)){
                        return  " password has eight characters including one uppercase letter, one lowercase letter, and one number or special character";

                      }
                      return null;
                    },
                  ),
                ),
              ),
              SizedBox(height: 25),
              Padding(
                padding: const EdgeInsets.only(left: 15,right: 15),
                child: InkWell(
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
                      "DELETE CONTACT",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
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
