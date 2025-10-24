import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/seller_main_controller.dart';

class SellerBodyContent extends StatelessWidget {
  const SellerBodyContent({super.key});

  @override
  Widget build(BuildContext context) {
    final SellerMainController controller = Get.find();

    return Obx(() {
      final screens = controller.screens;
      final index = controller.currentTabIndex.value;

      if (screens.isEmpty) {
        return const Center(child: CircularProgressIndicator());
      }

      // Prevent RangeError if index > screens.length
      if (index >= screens.length) {
        return const Center(child: Text("Invalid tab index"));
      }

      return screens[index];
    });
  }
}
