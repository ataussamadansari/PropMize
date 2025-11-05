import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../core/themes/app_colors.dart';
import '../../controllers/seller_main_controller.dart';

class SellerBottomNav extends GetView<SellerMainController> {
  const SellerBottomNav({super.key});

  @override
  Widget build(BuildContext context) {

    return Obx(() {
      return AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        height: controller.isBottomNavVisible.value ? kBottomNavigationBarHeight + 16 : 0,
          child: Stack(
              clipBehavior: controller.isBottomNavVisible.value ? Clip.none : Clip.hardEdge,
              children: [
                // Main Bottom Navigation Bar
                Positioned.fill(
                    child: Wrap(
                        children: [
                          BottomNavigationBar(
                              elevation: 0,
                              // backgroundColor: Get.theme.scaffoldBackgroundColor,
                              type: BottomNavigationBarType.fixed,
                              currentIndex: controller.currentIndex.value,
                              onTap: (index)
                              {
                                // Skip the center index (2) as it's handled by FAB
                                if (index != 2) {
                                  controller.changePage(index);
                                }
                              },
                              selectedLabelStyle: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Theme.of(context).primaryColor,
                                  fontSize: 12
                              ),
                              items: [
                                BottomNavigationBarItem(
                                  icon: Icon(Icons.home_outlined),
                                  activeIcon: Icon(Icons.home),
                                  label: "Contacted",
                                ),
                                BottomNavigationBarItem(
                                    icon: Icon(Icons.chat_outlined),
                                    activeIcon: Icon(Icons.chat),
                                    label: "Leads"
                                ),
                                // Empty item for center space
                                BottomNavigationBarItem(
                                    icon: Opacity(opacity: 0, child: Icon(Icons.chat)),
                                    label: ""
                                ),
                                BottomNavigationBarItem(
                                    icon: Icon(Icons.home_work_outlined),
                                    activeIcon: Icon(Icons.home_work),
                                    label: "My Property"
                                ),
                                BottomNavigationBarItem(
                                    icon: Icon(Icons.analytics_outlined),
                                    activeIcon: Icon(Icons.analytics),
                                    label: "Analytics"
                                )
                              ]
                          )
                        ]
                    )
                ),

                // Center Floating Action Button for Assistant
                Positioned(
                  left: MediaQuery.of(context).size.width / 2 - 30,
                  bottom: 24,
                  child: GestureDetector(
                    onTap: () {
                      controller.changePage(2); // Assistant page index
                    },
                    child: AnimatedScale(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.linear,
                      alignment: Alignment.bottomCenter,
                      scale: controller.isBottomNavVisible.value ? 1.0 : 0.0,
                      child: Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          color: controller.currentIndex.value == 2 ? AppColors.primary : Theme.of(context).cardColor,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withValues(alpha: 0.3),
                              blurRadius: 8,
                              offset: Offset(0, 4),
                            )
                          ],
                        ),
                        child: AnimatedScale(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                          scale: controller.currentIndex.value == 2 ? 1.3 : 1.0,
                          child: Icon(
                            Icons.add,
                            color: controller.currentIndex.value == 2 ? Colors.white : Theme.of(context).iconTheme.color,
                            size: 28,
                          ),
                        ),
                      ),
                    ),
                    /*child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOutSine,
                      height: controller.isBottomNavVisible.value ? kBottomNavigationBarHeight : 0,
                      child: Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          color: controller.currentIndex.value == 2 ? AppColors.primary : Theme.of(context).cardColor,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withValues(alpha: 0.3),
                              blurRadius: 8,
                              offset: Offset(0, 4),
                            )
                          ],
                        ),
                        child: AnimatedOpacity(
                          duration: Duration(microseconds: 300),
                          opacity: controller.isBottomNavVisible.value ? 1.0 : 0.0,
                          child: Icon(
                            Icons.add,
                            color: controller.currentIndex.value == 2 ? Colors.white : Theme.of(context).iconTheme.color,
                            size: controller.currentIndex.value == 2 ? 40: 28,
                          ), 
                        ),
                      ),
                    ),*/
                  ),
                ),
              ]
          )
      );
    });
  }
}