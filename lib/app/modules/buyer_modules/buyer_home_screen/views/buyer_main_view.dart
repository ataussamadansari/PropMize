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
    DateTime? _lastPointerDown;
    bool _isScrollGesture = false;

    return Listener(
      onPointerDown: (event) {
        _lastPointerDown = DateTime.now();
        _isScrollGesture = false;
      },
      onPointerMove: (event) {
        if (_lastPointerDown != null &&
            DateTime.now().difference(_lastPointerDown!) <
                const Duration(milliseconds: 150)) {
          _isScrollGesture = true;
        }
      },
      onPointerUp: (event) {
        // If user just tapped (not scrolled)
        if (!_isScrollGesture) {
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
              controller.handleScrollNotification(scrollInfo);
              return false;
            },
            child: controller.pages[controller.currentIndex.value],
          );
        }),
        bottomNavigationBar: const BuyerMainBottomNav(),
      ),
    );
  }
}

