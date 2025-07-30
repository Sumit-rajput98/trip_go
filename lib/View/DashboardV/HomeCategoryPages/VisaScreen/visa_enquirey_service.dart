import 'dart:io';
import 'package:flutter/material.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

class VisaEnquiryService {
  Future<void> sendVisaEnquiryEmail({
    required String name,
    required String email,
    required String phone,
    required String subject,
    required String message,
  }) async {
    String username = 'sumitrajput96938@gmail.com';
    String password = '_';
    final smtpServer = gmail(username, password);

   
    final supportMessage =
        Message()
          ..from = Address(username, 'TripGo Visa Enquiry')
          ..recipients.add('sk1572947@gmail.com')
          ..subject = 'Visa Enquiry from $name'
          ..text = '''
Name: $name
Email: $email
Phone: $phone
Subject: $subject

Message:
$message
''';

    // Email to user (HTML with logo)
    final logoFile = File(
      'C:/Users/sumit/prj/trip_go/assets/images/trip_go.png',
    );
    final userMessage =
        Message()
          ..from = Address(username, 'TripGo Team')
          ..recipients.add(email)
          ..subject = 'Thanks for contacting TripGo!'
          ..html = '''
      <div style="font-family: Arial, sans-serif; padding: 20px;">
        <div style="text-align: center;">
      <img src="https://tripgoonline.com/Images/tripgoo.png" alt="TripGo Logo" width="140"/>
    </div>
        <h2>Hello $name,</h2>
        <p>Thanks for contacting <strong>TripGo</strong>. We’ve received your enquiry and one of our representatives will get back to you shortly.</p>
        <hr>
        <p><strong>Your Submitted Details:</strong></p>
        <p><b>Email:</b> $email<br>
           <b>Phone:</b> $phone<br>
           <b>Subject:</b> $subject<br>
           <b>Message:</b> $message</p>
        <br>
        <p>Best regards,<br/>TripGo Support Team</p>
      </div>
      ''';

    try {
      await send(supportMessage, smtpServer);
      await send(userMessage, smtpServer);
      debugPrint('✅ Emails sent to support and user successfully.');
    } catch (e) {
      debugPrint('❌ Failed to send email: $e');
      rethrow;
    }
  }
}
