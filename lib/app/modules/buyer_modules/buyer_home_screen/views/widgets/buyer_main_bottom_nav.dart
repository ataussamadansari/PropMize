import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prop_mize/app/core/themes/app_colors.dart';

import '../../controllers/buyer_main_controller.dart';

class BuyerMainBottomNav extends GetView<BuyerMainController>
{
    const BuyerMainBottomNav({super.key});

    @override
    Widget build(BuildContext context)
    {
        return Obx(()
            {
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
                                            type: BottomNavigationBarType.fixed,
                                            currentIndex: controller.currentIndex.value,
                                            onTap: (index)
                                            {
                                                // Skip the center index (2) as it's handled by FAB
                                                if (index != 2) 
                                                {
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
                                                    icon: Icon(CupertinoIcons.phone),
                                                    activeIcon: Icon(CupertinoIcons.phone_fill),
                                                    label: "Contacted"
                                                ),
                                                BottomNavigationBarItem(
                                                    icon: Icon(Icons.favorite_border),
                                                    activeIcon: Icon(Icons.favorite),
                                                    label: "Saved"
                                                ),
                                                // Empty item for center space
                                                BottomNavigationBarItem(
                                                    icon: Opacity(opacity: 0, child: Icon(Icons.chat)),
                                                    label: ""
                                                ),
                                                BottomNavigationBarItem(
                                                    icon: Icon(Icons.remove_red_eye_outlined),
                                                    activeIcon: Icon(Icons.remove_red_eye),
                                                    label: "Recent"
                                                ),
                                                BottomNavigationBarItem(
                                                    icon: Icon(CupertinoIcons.building_2_fill),
                                                    activeIcon: Icon(CupertinoIcons.building_2_fill),
                                                    label: "All Listings"
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
                                    onTap: ()
                                    {
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
                                                        offset: Offset(0, 4)
                                                    )
                                                ]
                                            ),
                                            child: Icon(
                                                controller.currentIndex.value == 2
                                                    ? Icons.chat
                                                    : Icons.chat_outlined,
                                                color: controller.currentIndex.value == 2 ? Colors.white : Theme.of(context).iconTheme.color,
                                                size: 28
                                            )
                                        )
                                    )
                                )
                            )
                        ]
                    )
                );
            }
        );
    }
}

/*
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/buyer_main_controller.dart';

class BuyerMainBottomNav extends GetView<BuyerMainController>
{
    const BuyerMainBottomNav({super.key});

    @override
    Widget build(BuildContext context)
    {
        return Obx(()
            {
                return AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    height: controller.isBottomNavVisible.value ? kBottomNavigationBarHeight + 16 : 0,
                    child: Wrap(
                        children: [
                            BottomNavigationBar(
                                elevation: 0,
                                type: BottomNavigationBarType.fixed,
                                currentIndex: controller.currentIndex.value,
                                onTap: (index)
                                {
                                    controller.changePage(index);
                                },
                                selectedLabelStyle: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: Theme.of(context).primaryColor,
                                    fontSize: 12
                                ),
                                items: [
                                    BottomNavigationBarItem(
                                        icon: Icon(CupertinoIcons.phone),
                                        activeIcon: Icon(CupertinoIcons.phone_fill),
                                        label: "Contacted",
                                    ),
                                    BottomNavigationBarItem(
                                        icon: Icon(Icons.favorite_border),
                                        activeIcon: Icon(Icons.favorite),
                                        label: "Saved"
                                    ),
                                    BottomNavigationBarItem(
                                        icon: Icon(Icons.chat_outlined),
                                        activeIcon: Icon(Icons.chat),
                                        label: "Assistant"
                                    ),
                                    BottomNavigationBarItem(
                                        icon: Icon(Icons.remove_red_eye_outlined),
                                        activeIcon: Icon(Icons.remove_red_eye),
                                        label: "Recent"
                                    ),
                                    BottomNavigationBarItem(
                                        icon: Icon(CupertinoIcons.building_2_fill),
                                        activeIcon: Icon(CupertinoIcons.building_2_fill),
                                        label: "All Listings"
                                    )
                                ]
                            )
                        ]
                    )
                );
            }
        );
    }
}

*/
