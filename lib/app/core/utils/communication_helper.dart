import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class CommunicationHelper {
  /// 📞 Make a phone call
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

  /// 💬 Open WhatsApp or WhatsApp Business with choice if both exist
  static Future<void> openWhatsApp(String? phoneNumber, {String message = ""}) async {
    if (phoneNumber == null || phoneNumber.isEmpty) {
      Get.snackbar("Error", "Phone number not available");
      return;
    }

    String cleanNumber = _cleanPhoneNumber(phoneNumber);

    if (cleanNumber.isEmpty) {
      Get.snackbar("Error", "Invalid phone number format");
      return;
    }

    debugPrint('📱 Checking WhatsApp availability for: $cleanNumber');

    bool hasWhatsApp = await canLaunchUrl(Uri.parse("whatsapp://send?phone=$cleanNumber"));
    bool hasBusiness = await canLaunchUrl(Uri.parse("whatsapp-business://send?phone=$cleanNumber"));

    debugPrint("✅ WhatsApp installed: $hasWhatsApp | Business installed: $hasBusiness");

    if (hasWhatsApp && hasBusiness) {
      _showAppChoiceDialog(cleanNumber, message);
    } else if (hasBusiness) {
      await _launchWhatsAppApp(
          "whatsapp-business://send?phone=$cleanNumber&text=${Uri.encodeComponent(message)}");
    } else if (hasWhatsApp) {
      await _launchWhatsAppApp(
          "whatsapp://send?phone=$cleanNumber&text=${Uri.encodeComponent(message)}");
    } else {
      await _tryWhatsAppLaunch(cleanNumber, message);
    }
  }

  /// 🧹 Clean phone number and add country code if missing
  static String _cleanPhoneNumber(String phone) {
    // Remove all non-digit characters except +
    String cleaned = phone.replaceAll(RegExp(r'[^\d+]'), '');

    // If number doesn't start with +91, assume Indian number
    if (!cleaned.startsWith('+') && !cleaned.startsWith('91')) {
      cleaned = '91$cleaned';
    }

    // Remove leading 0 if any
    if (cleaned.startsWith('0')) {
      cleaned = cleaned.substring(1);
    }

    return cleaned;
  }

  /// 🪟 Bottom sheet to choose app
  static Future<void> _showAppChoiceDialog(String number, String message) async {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Wrap(
          children: [
            const Center(
              child: Text(
                "Choose WhatsApp App",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 16),
            ListTile(
              leading: const Icon(Icons.chat, color: Colors.green),
              title: const Text("WhatsApp"),
              onTap: () {
                Get.back();
                _launchWhatsAppApp(
                    "whatsapp://send?phone=$number&text=${Uri.encodeComponent(message)}");
              },
            ),
            ListTile(
              leading: const Icon(Icons.business_center, color: Colors.teal),
              title: const Text("WhatsApp Business"),
              onTap: () {
                Get.back();
                _launchWhatsAppApp(
                    "whatsapp-business://send?phone=$number&text=${Uri.encodeComponent(message)}");
              },
            ),
          ],
        ),
      ),
    );
  }

  /// 🚀 Launch WhatsApp or Business app
  static Future<void> _launchWhatsAppApp(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      _showWhatsAppError();
    }
  }

  /// 🔄 Try all fallback formats (API / Web / etc.)
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
        'name': 'WhatsApp Web',
        'url': 'https://web.whatsapp.com/send?phone=$cleanNumber&text=${Uri.encodeComponent(message)}'
      },
    ];

    for (final format in urlFormats) {
      try {
        final Uri uri = Uri.parse(format['url']!);
        if (await canLaunchUrl(uri)) {
          debugPrint('✅ Success: ${format['name']}');
          await launchUrl(uri, mode: LaunchMode.externalApplication);
          return;
        }
      } catch (e) {
        debugPrint('❌ Failed ${format['name']}: $e');
      }
      await Future.delayed(const Duration(milliseconds: 100));
    }

    _showWhatsAppError();
  }

  /// ⚠️ Show WhatsApp install snackbar
  static void _showWhatsAppError() {
    Get.snackbar(
      "WhatsApp Not Found",
      "Please install WhatsApp or WhatsApp Business",
      duration: const Duration(seconds: 5),
      mainButton: TextButton(
        onPressed: _openAppStore,
        child: const Text("Install", style: TextStyle(color: Colors.white)),
      ),
    );
  }

  /// 🏪 Open Play Store for WhatsApp
  static Future<void> _openAppStore() async {
    final Uri playStoreUri = Uri.parse(
        "https://play.google.com/store/search?q=whatsapp&c=apps");
    if (await canLaunchUrl(playStoreUri)) {
      await launchUrl(playStoreUri, mode: LaunchMode.externalApplication);
    }
  }
}


/*
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

*/
