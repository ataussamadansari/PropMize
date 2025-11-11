import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
        DateTime? lastPointerDown;
        bool isScrollGesture = false;

        return Obx(()
            {
                return PopScope(
                    canPop: false, // Control manually when to pop
                    onPopInvokedWithResult: (didPop, result)
                    {
                        // If system already handled pop (like predictive back animation), skip
                        if (didPop) return;

                        final currentIndex = controller.currentIndex.value;

                        if (currentIndex > 0)
                        {
                            // If not on first tab, navigate back to home
                            controller.changePage(0);
                        }
                        else
                        {
                            // Already on home → exit app
                            Navigator.of(context).maybePop();
                        }
                    },
                    child: Listener(
                        onPointerDown: (event)
                        {
                            lastPointerDown = DateTime.now();
                            isScrollGesture = false;
                        },
                        onPointerMove: (event)
                        {
                            if (lastPointerDown != null &&
                                DateTime.now().difference(lastPointerDown!) <
                                    const Duration(milliseconds: 150))
                            {
                                // if (controller.pages.length == 2)
                                // {
                                    isScrollGesture = true;
                                // }
                            }
                        },
                        onPointerUp: (event)
                        {
                            // If user just tapped (not scrolled)
                            if (!isScrollGesture)
                            {
                                // if (controller.pages.length == 2)
                                // {
                                    controller.onUserInteraction();
                                // }
                            }
                        },
                        behavior: HitTestBehavior.translucent,
                        child: Scaffold(
                            key: controller.globalKey,
                            appBar: const SellerMainAppBar(),
                            endDrawer: const SellerDrawer(),
                            body: NotificationListener<ScrollNotification>(
                                onNotification: (scrollInfo)
                                {
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
                                child: controller.pages[controller.currentIndex
                                    .value]
                            ),
                            bottomNavigationBar: SafeArea(child: const SellerBottomNav())
                        )
                    )
                );
            }
        );
    }
}
