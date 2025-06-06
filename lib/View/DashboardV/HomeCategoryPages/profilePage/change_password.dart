import 'package:flutter/material.dart';
import 'package:trip_go/View/DashboardV/HomeCategoryPages/profilePage/profile_page.dart';

import '../../../../constants.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}
final _formKey = GlobalKey<FormState>();
final passWord = TextEditingController();
final cnfPassWord = TextEditingController();
RegExp pass_valid = RegExp("^(?=.*[A-Za-z])(?=.*)[A-Za-z]{8,} ");
class _ChangePasswordState extends State<ChangePassword> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        child: Container(
          height: 460,
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
                          "Update Password",
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
                  padding: const EdgeInsets.all(15),
                  child: Center(
                    child: Text(constants.changePassword,style:constants.titleStyle,),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Container(
                    child: TextFormField(
                      decoration: InputDecoration(hintText: "Enter OTP"),
                      cursorColor: Colors.blue,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter OTP ";
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Text("Create/Change password",style: constants.titleStyle,),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20,right: 20),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextFormField(
                      style: constants.fontStyle,
                      decoration: InputDecoration(hintText: "Password"),
                      cursorColor: Colors.blue,
                      validator: (value){
                        if(value!.isEmpty){
                          return "Enter password";
                        }else if(!pass_valid.hasMatch(value)){
                          return  "Password contain atleast(<7,A,a,@)";

                        }
                        return null;
                      },
                    ),
                  ),
                ),
                SizedBox(height: 20,),
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Text("Confirm password",style: constants.titleStyle,),
                ),

                Padding(
                  padding: const EdgeInsets.only(left: 20,right: 20),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextFormField(
                      style:constants.fontStyle,
                      decoration: InputDecoration(hintText: "Password"),
                      cursorColor: Colors.blue,
                      validator: (value){
                        if(value!.isEmpty){
                          return "Confirm your password";
                        }else if(passWord.text!=cnfPassWord.text){
                          return "Wrong Password Try Again";
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                SizedBox(height: 30,),
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
                        "UPDATE CONTACT",
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
      ),
    );
  }
}