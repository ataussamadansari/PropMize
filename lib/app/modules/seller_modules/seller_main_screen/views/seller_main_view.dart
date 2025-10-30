import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prop_mize/app/global_widgets/shimmer/shimmer_dashboard_view.dart';
import 'widgets/seller_bottom_nav.dart';
import 'widgets/seller_main_app_bar.dart';
import '../controllers/seller_main_controller.dart';
import 'widgets/seller_drawer.dart';

class SellerMainView extends GetView<SellerMainController>
{
    const SellerMainView({super.key});

    @override
    Widget build(BuildContext context)
    {
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
                appBar: const SellerMainAppBar(),
                endDrawer: const SellerDrawer(),
                body: Obx(() {

                    return NotificationListener<ScrollNotification>(
                        onNotification: (scrollInfo) {
                            controller.handleScrollNotification(scrollInfo);
                            return false;
                        },
                        child: controller.pages[controller.currentIndex.value],
                    );
                }),
                bottomNavigationBar: const SellerBottomNav(),
            ),
        );

    }
}
