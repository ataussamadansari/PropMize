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

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prop_mize/app/data/services/storage_services.dart';
import 'package:prop_mize/app/routes/app_routes.dart';

class SplashController extends GetxController
{
    final _isInitialized = false.obs;
    final token = "".obs;
    final role = "".obs;

    @override
    void onInit()
    {
        super.onInit();
        initializeApp();
    }

    void initializeApp() async
    {
        // Simulate some initialization work
   /* Future.delayed(const Duration(seconds: 3), () {
      _isInitialized.value = true;
    });*/

        // ✅ Simulate some initialization work
        await Future.delayed(const Duration(seconds: 2));

        // ✅ Wait for StorageServices to be ready
        await _waitForStorageServices();

        _isInitialized.value = true;
    }

    Future<void> _waitForStorageServices() async
    {
        // ✅ Wait for StorageServices to be fully initialized
        while (!Get.isRegistered<StorageServices>())
        {
            await Future.delayed(const Duration(milliseconds: 100));
        }

        // ✅ Additional delay to ensure storage is ready
        await Future.delayed(const Duration(milliseconds: 500));
    }

    /*@override
    void onReady()
    {
        super.onReady();
        // Use ever to listen for initialization completion
        ever(_isInitialized, (isInitialized)
            {
                if (isInitialized)
                {
                    final token = StorageServices.to.getToken();
                    final role = StorageServices.to.read('role');

                    if (token != null)
                    {
                        // ✅ Delay navigation till after first frame
                        WidgetsBinding.instance.addPostFrameCallback((_)
                            {
                                role == "buyer"
                                    ? navigateHomeToAssistantChat()
                                    : navigateHomeToDashboard();
                            }
                        );
                    }
                    else
                    {
                        WidgetsBinding.instance.addPostFrameCallback((_)
                            {
                                Get.offAllNamed(Routes.home);
                            }
                        );
                    }
                    // Get.offAllNamed(Routes.home);
                }
            }
        );
    }*/

    @override
    void onReady() {
        super.onReady();
        ever(_isInitialized, (isInitialized) async {
            if (isInitialized) {
                final token = StorageServices.to.getToken();
                final role = StorageServices.to.read('role');

                print("🔹 SplashController -> token: $token | role: $role");

                if (token != null && token.isNotEmpty) {
                    print("✅ Token found! Navigating based on role...");
                    Future.delayed(Duration(milliseconds: 300), () {
                        if (role == "buyer") {
                            print("➡️ Navigating to AssistantChat");
                            Get.offAllNamed(Routes.assistantChat);
                        } else if (role == "seller") {
                            print("➡️ Navigating to Dashboard");
                            Get.offAllNamed(Routes.dashboard);
                        } else {
                            print("⚠️ Role not found, navigating to Home");
                            Get.offAllNamed(Routes.home);
                        }
                    });
                } else {
                    print("❌ Token null, navigating to Home");
                    Future.delayed(Duration(milliseconds: 300), () {
                        Get.offAllNamed(Routes.home);
                    });
                }
            }
        });
    }



    void navigateHomeToAssistantChat()
    {
        WidgetsBinding.instance.addPostFrameCallback((_)
            {
                Get.offAllNamed(Routes.assistantChat);
            }
        );
    }

    void navigateHomeToDashboard()
    {
        WidgetsBinding.instance.addPostFrameCallback((_)
            {
                Get.offAllNamed(Routes.dashboard);
            }
        );
    }
}
