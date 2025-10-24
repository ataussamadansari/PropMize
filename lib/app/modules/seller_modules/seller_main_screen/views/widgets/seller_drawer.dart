import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prop_mize/app/modules/seller_modules/dashboard_screen/controllers/dashboard_controller.dart';
import 'package:prop_mize/app/routes/app_routes.dart';

import '../../../../../core/utils/helpers.dart';
import '../../../../../data/services/storage/storage_services.dart';
import '../../../../../global_widgets/drawer/drawer_menu_item.dart';
import '../../../../buyer_modules/assistant_chat_screen/views/widgets/drawer/header_view.dart';
import '../../../../common_modules/auth_screen/controllers/auth_controller.dart';

class SellerDrawer extends GetView<DashboardController> {
  const SellerDrawer({super.key});

  @override
  Widget build(BuildContext context) {
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
                          // HeaderView(isLoggedIn: isLoggedIn, user: user, avatarUrl: avatarUrl),

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
                                    : controller.showBottomSheet();
                              }
                          ),
                          DrawerMenuItem(
                              leading: Icons.home_work_outlined,
                              title: "All listing",
                              subtitle: "Explore property listed in my city",
                              onTap: ()
                              {
                                controller.globalKey.currentState?.closeDrawer();
                                controller.goToAllListing();
                              }
                          ),


                          DrawerMenuItem(
                              leading: CupertinoIcons.book,
                              title: "Seller's Guide",
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
                              onTap: () => controller.goToHelpSupport()
                          ),
                          Divider(color: Colors.grey.withAlpha(100)),

                          DrawerMenuItem(
                              leading: Icons.logout,
                              title: StorageServices.to.userId.value.isEmpty ? "Login" : "Logout",
                              subtitle: StorageServices.to.userId.value.isEmpty
                                  ? "Sign in to your account"
                                  : "Sign out of your account",
                              onTap: () async
                              {
                                controller.globalKey.currentState?.closeDrawer();

                                if (StorageServices.to.userId.value.isEmpty)
                                {
                                  controller.showBottomSheet();
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