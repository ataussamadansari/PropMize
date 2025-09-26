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

  /// Open WhatsApp chat
  static Future<void> openWhatsApp(String? number) async {
    if (number == null || number.isEmpty) {
      Get.snackbar("Error", "WhatsApp number not available");
      return;
    }

    // Remove any + or spaces for wa.me link
    final cleanNumber = number.replaceAll(RegExp(r"[^\d]"), "");

    final Uri url = Uri.parse("https://wa.me/$cleanNumber");
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      Get.snackbar("Error", "Cannot open WhatsApp");
    }
  }
}
