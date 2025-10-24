import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prop_mize/app/core/themes/app_colors.dart';
import '../../controllers/seller_main_controller.dart';

class SellerBottomNav extends StatelessWidget {
  const SellerBottomNav({super.key});

  @override
  Widget build(BuildContext context) {
    final SellerMainController controller = Get.find();

    return Obx(() {
      // Current selected index ke hisab se color change karo
      Color getButtonBackgroundColor() {
        switch (controller.currentTabIndex.value) {
          case 0: // Dashboard
            return AppColors.primary;
          case 1: // Leads
            return Colors.green.shade500;
          case 2: // Sell/Rent
            return Colors.orange.shade500;
          case 3: // Property
            return Colors.purple.shade500;
          case 4: // Profile
            return Colors.red.shade400;
          default:
            return AppColors.primary;
        }
      }

      return CurvedNavigationBar(
        key: controller.bottomNavigationKey,
        index: controller.currentTabIndex.value,
        items: const <Widget>[
          Icon(Icons.dashboard, size: 30, color: Colors.white),
          Icon(Icons.leaderboard_sharp, size: 30, color: Colors.white),
          Icon(Icons.add, size: 30, color: Colors.white),
          Icon(CupertinoIcons.building_2_fill, size: 30, color: Colors.white),
          Icon(Icons.person, size: 30, color: Colors.white),
        ],
        // color: AppColors.primary,
        color: getButtonBackgroundColor(),
        buttonBackgroundColor: getButtonBackgroundColor(),
        backgroundColor: Color(0x00000000),
        animationCurve: Curves.easeInOut,
        animationDuration: const Duration(milliseconds: 600),
        onTap: controller.changeTab,
        letIndexChange: (index) => true,
      );
    });
  }
}