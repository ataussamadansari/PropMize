import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prop_mize/app/modules/buyer_modules/buyer_home_screen/views/widgets/buyer_main_app_bar.dart';
import 'package:prop_mize/app/modules/buyer_modules/buyer_home_screen/views/widgets/buyer_main_bottom_nav.dart';
import 'package:prop_mize/app/modules/buyer_modules/buyer_home_screen/views/widgets/buyer_main_drawer.dart';
import 'package:prop_mize/app/modules/buyer_modules/buyer_home_screen/views/widgets/buyer_main_end_drawer.dart';
import '../controllers/buyer_main_controller.dart';

class BuyerMainView extends GetView<BuyerMainController> {
  const BuyerMainView({super.key});

  @override
  Widget build(BuildContext context) {
    DateTime? lastPointerDown;
    bool isScrollGesture = false;

    return Listener(
      onPointerDown: (event) {
        lastPointerDown = DateTime.now();
        isScrollGesture = false;
      },
      onPointerMove: (event) {
        if (lastPointerDown != null &&
            DateTime.now().difference(lastPointerDown!) <
                const Duration(milliseconds: 150)) {
          isScrollGesture = true;
        }
      },
      onPointerUp: (event) {
        // If user just tapped (not scrolled)
        if (!isScrollGesture) {
          controller.onUserInteraction();
        }
      },
      behavior: HitTestBehavior.translucent,
      child: Scaffold(
        key: controller.globalKey,
        appBar: const BuyerMainAppBar(),
        drawer: const BuyerMainDrawer(),
        endDrawer: const BuyerMainEndDrawer(),
        body: Obx(() {
          return NotificationListener<ScrollNotification>(
            onNotification: (scrollInfo) {
              // ✅ Scroll hide/show only for SellRentPropertyView (index 2)
              if (controller.currentIndex.value == 2) {
                controller.handleScrollNotification(scrollInfo);
              } else {
                // Make sure bottom nav stays visible for other screens
                controller.isBottomNavVisible.value = true;
              }
              // controller.handleScrollNotification(scrollInfo);
              return false;
            },
            child: controller.pages[controller.currentIndex.value],
          );
        }),
        bottomNavigationBar: SafeArea(child: const BuyerMainBottomNav()),
      ),
    );
  }


}

