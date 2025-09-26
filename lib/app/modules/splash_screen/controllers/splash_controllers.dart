/*
import 'package:get/get.dart';
import 'package:prop_mize/app/routes/app_routes.dart';
import '../../../data/services/storage_services.dart';

class SplashController extends GetxController {
  final _isInitialized = false.obs;

  @override
  void onInit() {
    super.onInit();
    initializeApp();
  }

  void initializeApp() async {
    // Simulate some initialization work
    await Future.delayed(const Duration(seconds: 2));

    // Check if token exists
    final token = StorageServices.to.getToken();

    if (token != null && token.isNotEmpty) {
      // Token exists → go to Home
      Get.offAllNamed(Routes.home);
    } else {
      // No token → go to Auth
      Get.offAllNamed(Routes.auth);
    }

    _isInitialized.value = true;
  }

  @override
  void onReady() {
    super.onReady();
    ever(_isInitialized, (isInitialized) {
      // Already handled in initializeApp, but can add extra logic if needed
    });
  }
}
*/


import 'package:get/get.dart';
import 'package:prop_mize/app/routes/app_routes.dart';

class SplashController extends GetxController {
  final _isInitialized = false.obs;

  @override
  void onInit() {
    super.onInit();
    initializeApp();
  }

  void initializeApp() {
    // Simulate some initialization work
    Future.delayed(const Duration(seconds: 3), () {
      _isInitialized.value = true;
    });
  }

  @override
  void onReady() {
    super.onReady();
    // Use ever to listen for initialization completion
    ever(_isInitialized, (isInitialized) {
      if (isInitialized) {
        Get.offAllNamed(Routes.home);
      }
    });
  }
}
