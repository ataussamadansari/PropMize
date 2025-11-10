import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prop_mize/app/core/themes/app_colors.dart';
import 'package:prop_mize/app/global_widgets/is_login_screen/not_logged_screen.dart';
import '../../../../global_widgets/shimmer/shimmer_loader.dart';
import '../../../common_modules/all_listing_screen/views/widgets/property_card_widget.dart';
import '../controllers/recent_viewed_controller.dart';

class RecentViewedView extends GetView<RecentViewedController> {
  const RecentViewedView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        // ------------------ AUTH CHECK ------------------
        if (!controller.isAuthenticated) {
          return NotLoggedScreen(
            heading: 'Recent Viewed Properties',
            message: 'Login to view your recently viewed properties.',
            onPressed: controller.showAuthBottomSheet,
          );
        }

        // ------------------ LOADING STATE ------------------
        if (controller.isLoading.value && controller.properties.isEmpty)
        {
          return ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              itemCount: 5,
              itemBuilder: (context, index) => const ShimmerLoader()
          );
        }

        // ------------------ ERROR STATE ------------------
        if (controller.hasError.value) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, color: Colors.red, size: 50),
                  const SizedBox(height: 12),
                  Text(
                    controller.errorMessage.value,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton.icon(
                    onPressed: controller.loadRecentViedProperties,
                    icon: const Icon(Icons.refresh),
                    label: const Text("Retry"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          );
        }

        // ------------------ EMPTY STATE ------------------
        if (controller.properties.isEmpty) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.history, size: 80, color: Colors.grey),
                  const SizedBox(height: 16),
                  const Text(
                    "No recently viewed properties",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Browse properties to start building your recent views list.",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey.shade600),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: controller.loadRecentViedProperties,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                    ),
                    child: const Text("Refresh"),
                  ),
                ],
              ),
            ),
          );
        }

        // ------------------ PROPERTY LIST ------------------
        return RefreshIndicator(
          onRefresh: () => controller.loadRecentViedProperties(reset: true),
          color: AppColors.primary,
          child: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: controller.properties.length,
            itemBuilder: (context, index) {
              final property = controller.properties[index];
              return PropertyCardWidget(
                property: property,
                controller: controller,
                onTap: () => controller.navigateToPropertyDetails(property.id ?? ''),
              );
            },
          ),
        );
      }),
    );
  }
}


/*
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prop_mize/app/global_widgets/is_login_screen/not_logged_screen.dart';

import '../controllers/recent_viewed_controller.dart';


class RecentViewedView extends GetView<RecentViewedController> {
  const RecentViewedView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx( () {

        if(!controller.isAuthenticated){
          return NotLoggedScreen(
            heading: 'Recent Viewed Properties',
            message: 'Login to view your recently viewed properties.',
            onPressed: controller.showAuthBottomSheet,
          );
        }

          return ListView(
            children: [
              SizedBox(
                height: 1000,
                child: Center(
                  child: Text(
                    'Recent Viewed Screen',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              )
            ],
          );
        }
      ),
    );
  }

}*/
