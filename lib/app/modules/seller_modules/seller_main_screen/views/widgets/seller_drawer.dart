import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:prop_mize/app/global_widgets/shimmer/header_profile_shimmer.dart';

import '../../../../../global_widgets/drawer/drawer_menu_item.dart';
import '../../controllers/seller_main_controller.dart';
import 'drawers/drawer_header.dart';

class SellerDrawer extends GetView<SellerMainController>
{
    const SellerDrawer({super.key});

    @override
    Widget build(BuildContext context)
    {
        return Drawer(
            child: SafeArea(
                child: ListView(
                    children: [
                        Obx(()
                            {
                                final isLoggedIn = controller.currentUserId.value.isNotEmpty;
                                final userId = controller.currentUserId.value;
                                final user = controller.authController.profile.value?.data;
                                final avatarUrl = user?.avatar ?? "";

                                return Column(
                                    children: [
                                        controller.isLoading.value ? HeaderProfileShimmer() : HeaderView(isLoggedIn: isLoggedIn, user: user, avatarUrl: avatarUrl),

                                        Divider(color: Colors.grey.withAlpha(100)),
                                        isLoggedIn ? DrawerMenuItem(
                                                leading: CupertinoIcons.person,
                                                title: "Profile Manager",
                                                subtitle: "View Profile",
                                                onTap: ()
                                                {
                                                    controller.globalKey.currentState?.closeEndDrawer();
                                                    controller.goToProfile();
                                                }
                                            ) : SizedBox.shrink(),
                                        DrawerMenuItem(
                                            leading: CupertinoIcons.refresh,
                                            title: "Switch to Buyer Mode",
                                            subtitle: "Switch mode",
                                            trailing: "Switch",
                                            onTap: ()
                                            {
                                                isLoggedIn ? controller.authController.role(userId, "buyer")
                                                    : null;
                                            }
                                        ),

                                        DrawerMenuItem(
                                            selected: controller.currentIndex.value == 0,
                                            leading: Icons.home,
                                            title: "Dashboard",
                                            subtitle: "Manage your property and leads",
                                            onTap: ()
                                            {
                                                controller.globalKey.currentState?.closeEndDrawer();
                                                controller.currentIndex.value = 0;
                                            }
                                        ),

                                        DrawerMenuItem(
                                            selected: controller.currentIndex.value == 2,
                                            leading: Icons.add,
                                            title: "Sell/Rent Properties",
                                            subtitle: "List your property & reach genuine buyers/tenants",
                                            onTap: ()
                                            {
                                                controller.globalKey.currentState?.closeEndDrawer();
                                                controller.currentIndex.value = 2;
                                            }
                                        ),

                                        DrawerMenuItem(
                                            selected: controller.currentIndex.value == 3,
                                            leading: Icons.home_work_outlined,
                                            title: "My Property",
                                            subtitle: "Manage your property listing",
                                            onTap: ()
                                            {
                                                controller.globalKey.currentState?.closeEndDrawer();
                                                controller.currentIndex.value = 3;
                                            }
                                        ),

                                        DrawerMenuItem(
                                            leading: Icons.home_work_outlined,
                                            title: "All listing",
                                            subtitle: "Explore property listed in my city",
                                            onTap: ()
                                            {
                                                controller.globalKey.currentState?.closeEndDrawer();
                                                controller.goToAllListing();
                                            }
                                        ),
                                        DrawerMenuItem(
                                            selected: controller.currentIndex.value == 4,
                                            leading: Icons.analytics_outlined,
                                            title: "Analytics",
                                            subtitle: "Property and leads analytics",
                                            onTap: ()
                                            {
                                                controller.globalKey.currentState?.closeEndDrawer();
                                                controller.currentIndex.value = 4;
                                            }
                                        ),
                                        DrawerMenuItem(
                                            selected: controller.currentIndex.value == 1,
                                            leading: Icons.inbox_outlined,
                                            title: "Leads",
                                            subtitle: "Manage property inquiry leads",
                                            onTap: ()
                                            {
                                                controller.globalKey.currentState?.closeEndDrawer();
                                                controller.currentIndex.value = 1;
                                            }
                                        ),
                                        DrawerMenuItem(
                                            leading: FontAwesomeIcons.crown,
                                            title: "Plans",
                                            subtitle: "Subscription plan and billing",
                                            onTap: ()
                                            {
                                                controller.globalKey.currentState!.closeEndDrawer();
                                                controller.goToPlan();
                                            }
                                        ),

                                        DrawerMenuItem(
                                            leading: CupertinoIcons.book,
                                            title: "Seller's Guide",
                                            subtitle: "Guide for selling properties",
                                            onTap: ()
                                            {
                                                controller.globalKey.currentState!.closeEndDrawer();
                                                controller.goToSellerGuide();
                                            }
                                        ),
                                        DrawerMenuItem(
                                            leading: Icons.support_agent,
                                            title: "Help & Support",
                                            subtitle: "Help and support center",
                                            onTap: ()
                                            {
                                                // controller.globalKey.currentState?.closeEndDrawer();
                                                controller.goToHelpSupport();
                                            }
                                        ),
                                        Divider(color: Colors.grey.withAlpha(100)),

                                        DrawerMenuItem(
                                            leading: Icons.logout,
                                            title: !controller.isLoggedIn ? "Login" : "Logout",
                                            subtitle: !controller.isLoggedIn
                                                ? "Sign in to your account"
                                                : "Sign out of your account",
                                            onTap: ()
                                            {
                                                controller.globalKey.currentState?.closeEndDrawer();

                                                if (!controller.isLoggedIn)
                                                {
                                                    // controller.showAuthBottomSheet();
                                                }
                                                else
                                                {
                                                    controller.logout();
                                                }
                                            }
                                        )
                                    ]
                                );
                            }
                        )
                    ]
                )
            )
        );
    }
}
