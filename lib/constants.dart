
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class constants{
  /*static var primaryColor = const Color(0xff296e48);*/
  static var appBarColor = Colors.blue;
  static var blackColor = Colors.black;
  static var descriptionColor = Colors.black87.withOpacity(.7);

  //Onbording text
  static var titleOne = "Delhi to Mumbai";
  static var PrimaryColor = Colors.blue;
  static var subTitleOne = "29Apr | 15:00-21:25 | 06h 25m";
  static var descriptionOne = "Economy 1-Stops";
  static var titleTwo = " Travellers";
  static var subTitleTwo = "Name should be same as in Goverment ID proof";
  static var descriptionTwo = "Adult";
  static var titleThree = "Contact Information";
  static var descriptionThree = "Your mobile number will be used only for flight related communication";
  static var titleFour = " USe GST for this booking (OPTIONAL)";
  static var descriptionFour = "To claim credit of GST charged by airlines/TripGo,please enter your company's GST number";

  static final List<Map<String, dynamic>> delToBomFlights = [
    {
      "flightNo": "6E-519",
      "departure": "23:30",
      "arrival": "01:45",
      "duration": "2h 15m",
      "stops": "Nonstop",
      "price": "5,552",
      "logo": "https://flight.easemytrip.com/Content/AirlineLogon/6E.png",
    },
    {
      "flightNo": "AI-2441",
      "departure": "14:20",
      "arrival": "16:40",
      "duration": "2h 20m",
      "stops": "Nonstop",
      "price": "5,698",
      "logo": "https://flight.easemytrip.com/Content/AirlineLogon/AI.png",
    },
    {
      "flightNo": "AI-2592",
      "departure": "14:30",
      "arrival": "15:15",
      "duration": "0h 45m",
      "stops": "Nonstop",
      "price": "5,698",
      "logo": "https://flight.easemytrip.com/Content/AirlineLogon/AI.png",
    },
    {
      "flightNo": "6E-2153",
      "departure": "21:00",
      "arrival": "01:10",
      "duration": "4h 10m",
      "stops": "1-stop",
      "price": "5,820",
      "logo": "https://flight.easemytrip.com/Content/AirlineLogon/6E.png",
    },
  ];

 static final List<Map<String, dynamic>> bomToDelFlights = [
    {
      "flightNo": "IX-1240",
      "departure": "18:25",
      "arrival": "10:20",
      "duration": "15h 55m",
      "stops": "1-stop",
      "price": "6,794",
      "logo": "https://flight.easemytrip.com/Content/AirlineLogon/IX.png",
    },
    {
      "flightNo": "6E-2007",
      "departure": "23:45",
      "arrival": "02:00",
      "duration": "2h 15m",
      "stops": "Nonstop",
      "price": "6,898",
      "logo": "https://flight.easemytrip.com/Content/AirlineLogon/6E.png",
    },
    {
      "flightNo": "AI-2591",
      "departure": "07:40",
      "arrival": "11:15",
      "duration": "3h 35m",
      "stops": "1-stop",
      "price": "7,852",
      "logo": "https://flight.easemytrip.com/Content/AirlineLogon/AI.png",
    },
    {
      "flightNo": "AI-2426",
      "departure": "19:00",
      "arrival": "21:10",
      "duration": "2h 15m",
      "stops": "Nonstop",
      "price": "7,861",
      "logo": "https://flight.easemytrip.com/Content/AirlineLogon/AI.png",
    },
  ];

  static var fontStyle = GoogleFonts.poppins(
    fontSize: 15, color: Colors.black.withOpacity(.6),
  );
  static var titleStyle = GoogleFonts.poppins(
    fontSize: 15, color: Colors.black,
  );
  //Onbording text
  static var addPhoneNumber = "One OTP will be sen to new mobile number & Another one will be sent on your primary Email ID/Mobile Number";
  static var changePassword = " We have sent OTP to username@gmail.com ";

  static Color themeColor1= Color(0xff1B499F);
  static Color themeColor2= Color(0xffF73130);

  static Color lightThemeColor1= Color(0xff1B499F).withOpacity(0.6);
  static Color ultraLightThemeColor1= Color(0xff1B499F).withOpacity(0.1);
  }