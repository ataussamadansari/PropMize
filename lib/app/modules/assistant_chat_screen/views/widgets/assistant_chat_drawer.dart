import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prop_mize/app/modules/assistant_chat_screen/controllers/assistant_chat_controller.dart';
import 'package:prop_mize/app/modules/assistant_chat_screen/views/widgets/drawer/header_view.dart';

import '../../../../core/themes/app_colors.dart';
import '../../../../core/utils/capitalize.dart';
import '../../../../core/utils/helpers.dart';
import '../../../../data/services/storage_services.dart';
import '../../../../global_widgets/drawer/drawer_menu_item.dart';
import '../../../../global_widgets/menu/global_menu_option.dart';
import '../../../auth_screen/views/auth_bottom_sheet.dart';

class AssistantChatDrawer extends GetView<AssistantChatController> implements PreferredSizeWidget
{
    const AssistantChatDrawer({super.key});

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
                                                isLoggedIn ? AppHelpers.showSnackBar(icon: CupertinoIcons.bell, title: "Alert", message: "Coming Soon...") : AppHelpers.showSnackBar(icon: CupertinoIcons.bell, title: "Alert", message: "Please login to switch to seller mode");
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
                                        isLoggedIn ? DrawerMenuItem(
                                                leading: CupertinoIcons.heart,
                                                title: "Saved",
                                                subtitle: "Properties saved for later viewing",
                                                onTap: ()
                                                {
                                                    controller.globalKey.currentState?.closeDrawer();
                                                }
                                            ) : SizedBox.shrink(),
                                        isLoggedIn ? DrawerMenuItem(
                                                leading: CupertinoIcons.eye,
                                                title: "Recently Viewed",
                                                subtitle: "Recently viewed properties",
                                                onTap: ()
                                                {
                                                    controller.globalKey.currentState?.closeDrawer();
                                                }
                                            ) : SizedBox.shrink(),
                                        isLoggedIn ? DrawerMenuItem(
                                                leading: CupertinoIcons.phone,
                                                title: "Contacted",
                                                subtitle: "Properties where to you connected ower",
                                                onTap: ()
                                                {
                                                    controller.globalKey.currentState?.closeDrawer();
                                                }
                                            ) : SizedBox.shrink(),
                                        DrawerMenuItem(
                                            leading: Icons.add_home_work_outlined,
                                            title: "New Projects",
                                            subtitle: "New projects in your city",
                                            onTap: ()
                                            {
                                                controller.globalKey.currentState?.closeDrawer();
                                            }
                                        ),
                                        DrawerMenuItem(
                                            leading: CupertinoIcons.book,
                                            title: "Buyer's Guide",
                                            subtitle: "Buyer's guide and advice",
                                            onTap: ()
                                            {
                                                controller.globalKey.currentState?.closeDrawer();
                                            }
                                        ),
                                        DrawerMenuItem(
                                            leading: Icons.support_agent,
                                            title: "Help & Support",
                                            subtitle: "Help and support center",
                                            onTap: ()
                                            {
                                                controller.globalKey.currentState?.closeDrawer();
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
                                                    Get.bottomSheet(
                                                        AuthBottomSheet(),
                                                        isScrollControlled: true,
                                                        backgroundColor: Colors.transparent
                                                    );
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

    @override
    Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
