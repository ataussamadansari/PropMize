import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class CommunicationHelper {
  /// Make a phone call
  static Future<void> makeCall(String? phone) async {
    if (phone == null || phone.isEmpty) {
      Get.snackbar("Error", "Phone number not available");
      return;
    }

    final Uri url = Uri.parse("tel:$phone");
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      Get.snackbar("Error", "Cannot make a call");
    }
  }

  /// Open WhatsApp or WhatsApp Business - whichever is installed
  static Future<void> openWhatsApp(String? phoneNumber, {String message = ""}) async {
    if (phoneNumber == null || phoneNumber.isEmpty) {
      Get.snackbar("Error", "Phone number not available");
      return;
    }

    // Clean and format phone number
    String cleanNumber = _cleanPhoneNumber(phoneNumber);

    if (cleanNumber.isEmpty) {
      Get.snackbar("Error", "Invalid phone number format");
      return;
    }

    debugPrint('📱 Opening WhatsApp for: $cleanNumber');

    // Try different approaches
    await _tryWhatsAppLaunch(cleanNumber, message);
  }

  static String _cleanPhoneNumber(String phone) {
    // Remove all non-digit characters except +
    String cleaned = phone.replaceAll(RegExp(r'[^\d+]'), '');

    // If number doesn't start with country code, assume Indian number
    if (!cleaned.startsWith('+') && !cleaned.startsWith('91')) {
      // Add India country code if missing
      cleaned = '91$cleaned';
    }

    // Remove any leading 0 if present
    if (cleaned.startsWith('0')) {
      cleaned = cleaned.substring(1);
    }

    return cleaned;
  }

  static Future<void> _tryWhatsAppLaunch(String cleanNumber, String message) async {
    final List<Map<String, String>> urlFormats = [
      {
        'name': 'WhatsApp Direct',
        'url': 'https://wa.me/$cleanNumber?text=${Uri.encodeComponent(message)}'
      },
      {
        'name': 'WhatsApp API',
        'url': 'https://api.whatsapp.com/send?phone=$cleanNumber&text=${Uri.encodeComponent(message)}'
      },
      {
        'name': 'WhatsApp Business Direct',
        'url': 'whatsapp://send?phone=$cleanNumber&text=${Uri.encodeComponent(message)}'
      },
      {
        'name': 'WhatsApp Business',
        'url': 'https://wa.business/send?phone=$cleanNumber&text=${Uri.encodeComponent(message)}'
      },
    ];

    // Try each URL format until one works
    for (final format in urlFormats) {
      debugPrint('🔄 Trying: ${format['name']}');

      try {
        final Uri uri = Uri.parse(format['url']!);

        if (await canLaunchUrl(uri)) {
          debugPrint('✅ Success with: ${format['name']}');
          await launchUrl(uri, mode: LaunchMode.externalApplication);
          return; // Exit if successful
        }
      } catch (e) {
        debugPrint('❌ Failed ${format['name']}: $e');
        continue; // Try next format
      }

      // Small delay between attempts
      await Future.delayed(Duration(milliseconds: 100));
    }

    // If all formats fail, try web version as last resort
    debugPrint('🔄 Trying WhatsApp Web as fallback...');
    final Uri webUri = Uri.parse("https://web.whatsapp.com/send?phone=$cleanNumber&text=${Uri.encodeComponent(message)}");

    if (await canLaunchUrl(webUri)) {
      await launchUrl(webUri);
    } else {
      // Final fallback - show error with installation options
      _showWhatsAppError();
    }
  }

  static void _showWhatsAppError() {
    Get.snackbar(
      "WhatsApp Not Found",
      "Please install WhatsApp or WhatsApp Business",
      duration: Duration(seconds: 5),
      mainButton: TextButton(
        onPressed: () {
          _openAppStore();
        },
        child: Text("Install", style: TextStyle(color: Colors.white)),
      ),
    );
  }

  static Future<void> _openAppStore() async {
    // Open Play Store for WhatsApp
    final Uri playStoreUri = Uri.parse(
        "https://play.google.com/store/search?q=whatsapp&c=apps"
    );

    if (await canLaunchUrl(playStoreUri)) {
      await launchUrl(playStoreUri, mode: LaunchMode.externalApplication);
    }
  }
}

/*
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class CommunicationHelper {
  /// Make a phone call
  static Future<void> makeCall(String? phone) async {
    if (phone == null || phone.isEmpty) {
      Get.snackbar("Error", "Phone number not available");
      return;
    }

    final Uri url = Uri.parse("tel:$phone");
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      Get.snackbar("Error", "Cannot make a call");
    }
  }


  static Future<void> openWhatsApp(String? phoneNumber, {String message = ""}) async {
    final Uri uri = Uri.parse("https://wa.me/$phoneNumber?text=${Uri.encodeComponent(message)}");
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      Get.snackbar("Error", "WhatsApp not installed");
    }
  }

}
*/
