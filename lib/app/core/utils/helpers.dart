import 'package:get/get.dart';
import 'package:flutter/material.dart';

class AppHelpers {

  static void showSnackBar({
    IconData? icon,
    required String title,
    required String message,
    bool? isError,
    Duration duration = const Duration(seconds: 3),
    String? actionLabel, // optional button label
    VoidCallback? onActionTap, // button tap callback
  }) {
    Get.snackbar(
      title,
      message,
      // snackPosition: SnackPosition.BOTTOM,
      backgroundColor: isError == true ? Colors.red[200] : isError == false ? Colors.green[200] : null,
      icon: Icon(
        isError == true ? Icons.error : isError == false ? Icons.check_circle : icon,
        color: isError == true ? Colors.red : isError == false ? Colors.green : null,
      ),
      margin: const EdgeInsets.all(16),
      borderRadius: 8,
      duration: duration,
      dismissDirection: DismissDirection.horizontal,
      mainButton: actionLabel != null && onActionTap != null
          ? TextButton(
        onPressed: () {
          onActionTap();
          if (Get.isSnackbarOpen) Get.back();
        },
        child: Text(
          actionLabel,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      )
          : null,
    );
  }


  /* static void showSnackBar({
    required String title,
    required String message,
    bool isError = false,
    Duration duration = const Duration(seconds: 3)
  }) {
    Get.snackbar(
      title,
      message,
      // snackPosition: SnackPosition.BOTTOM,
      // dismissDirection: DismissDirection.horizontal,
      backgroundColor: isError ? Colors.red[200] : Colors.green[200],
      icon: Icon(
        isError ? Icons.error : Icons.check_circle,
        color: isError ? Colors.red : Colors.green,
      ),
      margin: const EdgeInsets.all(16),
      borderRadius: 8,
      duration: duration,
    );
  }*/

  static void showLoadingDialog({String message = "Loading..."}) {
    Get.dialog(AlertDialog(content: Row(
      children: [
        const CircularProgressIndicator(),
        const SizedBox(width: 16),
        Text(message)
      ],
    )),
        barrierDismissible: false
    );
  }
}