import 'package:get/get.dart';
import 'package:flutter/material.dart';

class HelpAndSupportController extends GetxController {
  final List<Map<String, dynamic>> contactMethods = [
    {
      'title': 'Call Us',
      'subtitle': '24/7 Customer Support',
      'icon': Icons.phone,
      'color': Colors.green,
      'value': '+91 9876543210',
      'action': 'call',
    },
    {
      'title': 'Email Us',
      'subtitle': 'Quick Response Within 24 Hours',
      'icon': Icons.email,
      'color': Colors.blue,
      'value': 'support@propmize.com',
      'action': 'email',
    },
    {
      'title': 'WhatsApp',
      'subtitle': 'Instant Chat Support',
      'icon': Icons.chat,
      'color': Colors.green,
      'value': '+91 9876543210',
      'action': 'whatsapp',
    },
    {
      'title': 'Office Address',
      'subtitle': 'Visit Our Office',
      'icon': Icons.location_on,
      'color': Colors.orange,
      'value': '123 Tech Park, Sector 62\nNoida, Uttar Pradesh 201309\nIndia',
      'action': 'location',
    },
  ];

  final List<Map<String, dynamic>> faqs = [
    {
      'question': 'How to buy property through Propmize?',
      'answer': 'You can browse properties, contact sellers directly, and use our verification services to ensure safe transactions.',
    },
    {
      'question': 'Is property verification available?',
      'answer': 'Yes, we provide complete property verification including legal documents, title check, and physical inspection.',
    },
    {
      'question': 'What are the payment methods?',
      'answer': 'We support multiple payment methods including bank transfer, UPI, and secure escrow services.',
    },
    {
      'question': 'How to list my property for sale?',
      'answer': 'Simply create an account, click on "Sell Property", fill the details, and upload photos. Our team will verify and list it.',
    },
  ];

  void contactSupport(String method, String value) {
    switch (method) {
      case 'call':
      // Implement phone call
        Get.snackbar('Call Support', 'Calling $value');
        break;
      case 'email':
      // Implement email
        Get.snackbar('Email Support', 'Opening email app for $value');
        break;
      case 'whatsapp':
      // Implement WhatsApp
        Get.snackbar('WhatsApp Support', 'Opening WhatsApp for $value');
        break;
      case 'location':
      // Implement maps
        Get.snackbar('Office Location', 'Opening maps for office location');
        break;
    }
  }
}