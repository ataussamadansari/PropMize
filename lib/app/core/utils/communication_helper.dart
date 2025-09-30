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
