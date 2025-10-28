import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../data/services/storage/storage_services.dart';
import '../../../assistant_chat_screen/views/widgets/drawer/header_view.dart';

import '../../../../../core/utils/helpers.dart';
import '../../../../../global_widgets/drawer/drawer_menu_item.dart';
import '../../controllers/buyer_main_controller.dart';

class BuyerMainDrawer extends GetView<BuyerMainController>
{
    const BuyerMainDrawer({super.key});

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
                                        HeaderView(isLoggedIn: isLoggedIn, user: user, avatarUrl: avatarUrl),

                                        Divider(color: Colors.grey.withAlpha(100)),
                                        isLoggedIn ? DrawerMenuItem(
                                                leading: CupertinoIcons.person,
                                                title: "Profile Manager",
                                                subtitle: "View Profile",
                                                onTap: ()
                                                {
                                                    controller.globalKey.currentState?.closeDrawer();
                                                    controller.goToProfile();
                                                }
                                            ) : SizedBox.shrink(),
                                        DrawerMenuItem(
                                            leading: CupertinoIcons.refresh,
                                            title: "Switch to Seller Mode",
                                            subtitle: "Switch mode",
                                            trailing: "Switch",
                                            onTap: ()
                                            {
                                                isLoggedIn ? controller.authController.role(userId, "seller")
                                                    : controller.showAuthBottomSheet();
                                            }
                                        ),
                                        DrawerMenuItem(
                                            selected: controller.currentIndex.value == 2,
                                            leading: Icons.home_work_outlined,
                                            title: "Assistant Chat",
                                            subtitle: "Get property suggestions",
                                            onTap: ()
                                            {
                                                controller.globalKey.currentState?.closeDrawer();
                                                controller.currentIndex.value = 2;
                                            }
                                        ),
                                        DrawerMenuItem(
                                            selected: controller.currentIndex.value == 4,
                                            leading: Icons.home_work_outlined,
                                            title: "All listing",
                                            subtitle: "Explore property listed in my city",
                                            onTap: ()
                                            {
                                                controller.globalKey.currentState?.closeDrawer();
                                                controller.currentIndex.value = 4;
                                                // controller.goToAllListing();
                                            }
                                        ),
                                        isLoggedIn ? DrawerMenuItem(
                                                selected: controller.currentIndex.value == 1,
                                                leading: CupertinoIcons.heart,
                                                title: "Saved",
                                                subtitle: "Properties saved for later viewing",
                                                onTap: ()
                                                {
                                                    controller.globalKey.currentState?.closeDrawer();
                                                    // controller.goToSavedProperties();
                                                    controller.currentIndex.value = 1;
                                                }
                                            ) : SizedBox.shrink(),
                                        isLoggedIn ? DrawerMenuItem(
                                                selected: controller.currentIndex.value == 3,
                                                leading: CupertinoIcons.eye,
                                                title: "Recently Viewed",
                                                subtitle: "Recently viewed properties",
                                                onTap: ()
                                                {
                                                    controller.globalKey.currentState?.closeDrawer();
                                                    controller.currentIndex.value = 3;
                                                }
                                            ) : SizedBox.shrink(),
                                        isLoggedIn ? DrawerMenuItem(
                                                selected: controller.currentIndex.value == 0,
                                                leading: CupertinoIcons.phone,
                                                title: "Contacted",
                                                subtitle: "Properties where to you connected ower",
                                                onTap: ()
                                                {
                                                    controller.globalKey.currentState?.closeDrawer();
                                                    controller.currentIndex.value = 0;
                                                    // controller.goToContacted();
                                                }
                                            ) : SizedBox.shrink(),
                                        /*DrawerMenuItem(
                                            leading: Icons.add_home_work_outlined,
                                            title: "New Projects",
                                            subtitle: "New projects in your city",
                                            onTap: ()
                                            {
                                                // controller.globalKey.currentState?.closeDrawer();
                                                AppHelpers.showSnackBar(icon: CupertinoIcons.bell, title: "Alert", message: "Coming Soon...");
                                            }
                                        ),*/
                                        DrawerMenuItem(
                                            leading: CupertinoIcons.book,
                                            title: "Buyer's Guide",
                                            subtitle: "Buyer's guide and advice",
                                            onTap: ()
                                            {
                                                // controller.globalKey.currentState?.closeDrawer();
                                                AppHelpers.showSnackBar(icon: CupertinoIcons.bell, title: "Alert", message: "Coming Soon...");
                                            }
                                        ),
                                        DrawerMenuItem(
                                            leading: Icons.support_agent,
                                            title: "Help & Support",
                                            subtitle: "Help and support center",
                                            onTap: ()
                                            {
                                                // controller.globalKey.currentState?.closeDrawer();
                                                AppHelpers.showSnackBar(icon: CupertinoIcons.bell, title: "Alert", message: "Coming Soon...");
                                            }
                                        ),
                                        Divider(color: Colors.grey.withAlpha(100)),

                                        DrawerMenuItem(
                                            leading: Icons.logout,
                                            title: StorageServices.to.userId.value.isEmpty ? "Login" : "Logout",
                                            subtitle: StorageServices.to.userId.value.isEmpty
                                                ? "Sign in to your account"
                                                : "Sign out of your account",
                                            onTap: ()
                                            {
                                                controller.globalKey.currentState?.closeDrawer();

                                                if (StorageServices.to.userId.value.isEmpty)
                                                {
                                                    controller.showAuthBottomSheet();
                                                }
                                                else
                                                {
                                                    controller.authController.logout();
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
