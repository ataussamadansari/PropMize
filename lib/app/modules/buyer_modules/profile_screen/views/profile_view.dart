import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prop_mize/app/core/themes/app_colors.dart';
import 'package:prop_mize/app/core/utils/profile_tabs.dart';
import 'package:prop_mize/app/global_widgets/profile/tabs_menu_item.dart';
import 'package:prop_mize/app/global_widgets/shimmer/shimmer_profile_view.dart';

import '../controllers/profile_controller.dart';
import 'preference_screen.dart';
import 'profile_screen.dart';

class ProfileView extends GetView<ProfileController>
{
    const ProfileView({super.key});

    @override
    Widget build(BuildContext context)
    {
        return Obx(()
            {
                // ✅ Show shimmer when loading
                if (controller.isLoading.value) 
                {
                    return ShimmerProfileView();
                }

                return Scaffold(
                    appBar: AppBar(
                        title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                                Text('My Profile'),
                                Text('Manage your account settings and preferences', style: context.textTheme.labelSmall?.copyWith(color: Colors.grey))
                            ]
                        )
                    ),
                    body: Stack(
                        children: [
                            Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                /*Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
                                    child: ElevatedButton(
                                        onPressed: ()
                                        {
                                            controller.toggleEnable();
                                        },
                                        child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            spacing: 4,
                                            children: [
                                                Icon(Icons.edit),
                                                Text('Edit Profile')
                                            ]
                                        )
                                    )
                                ),*/

                                    Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
                                        child: Obx(()
                                            {
                                                if (controller.isEnable.value) 
                                                {
                                                    // Save aur Cancel dikhana
                                                    return Row(
                                                        mainAxisAlignment: MainAxisAlignment.end,
                                                        children: [
                                                            ElevatedButton.icon(
                                                                onPressed: ()
                                                                {
                                                                    // Save logic call karo
                                                                    controller.toggleEnable(save: true);
                                                                },
                                                                icon: const Icon(Icons.save),
                                                                label: const Text('Save Changes')
                                                            ),
                                                            const SizedBox(width: 8),
                                                            OutlinedButton(
                                                                onPressed: ()
                                                                {
                                                                    // Cancel dabane par sirf disable kar dena
                                                                    controller.toggleEnable();
                                                                },
                                                                child: Text('Cancel')
                                                            )
                                                        ]
                                                    );
                                                }
                                                else 
                                                {
                                                    // Normal Edit button
                                                    return ElevatedButton.icon(
                                                        onPressed: ()
                                                        {
                                                            controller.toggleEnable();
                                                        },
                                                        icon: const Icon(Icons.edit),
                                                        label: const Text('Edit Profile')
                                                    );
                                                }
                                            }
                                        )
                                    ),

                                    Expanded(
                                        child: Obx(()
                                            {
                                                return IndexedStack(
                                                    index: controller.selectedIndex.value,
                                                    children: const[
                                                        ProfileScreen(),
                                                        PreferencesScreen()
                                                        // ActivityScreen()
                                                    ]
                                                );
                                            }
                                        )
                                    )
                                ]
                            ),

                            Positioned(
                                child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                        // Toggle Button
                                        IconButton(
                                            onPressed: ()
                                            {
                                                controller.toggleTabs(!controller.isVisible.value);
                                            },
                                            style: IconButton.styleFrom(
                                                backgroundColor: AppColors.primary
                                            ),
                                            icon: Obx(() => AnimatedSwitcher(
                                                    duration: const Duration(milliseconds: 300),
                                                    transitionBuilder: (child, animation)
                                                    {
                                                        return RotationTransition(
                                                            turns: child.key == const ValueKey("back")
                                                                ? Tween<double>(begin: 0.5, end: 1).animate(animation) // rotate left
                                                                : Tween<double>(begin: 0.5, end: 0).animate(animation), // rotate right
                                                            child: FadeTransition(opacity: animation, child: child)
                                                        );
                                                    },
                                                    child: Icon(
                                                        controller.isVisible.value
                                                            ? Icons.arrow_back_ios_new
                                                            : Icons.arrow_forward_ios,
                                                        key: ValueKey(controller.isVisible.value ? "back" : "forward")
                                                    // color: AppColors.primary
                                                    )
                                                ))
                                        ),

                                        Obx(()
                                            {
                                                return Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: List.generate(
                                                        ProfileTabs.tabs.length, (index)
                                                        {
                                                            return /*TabsMenuItem(
                                                            title: ProfileTabs.tabs[index]["title"] as String,
                                                            color: ProfileTabs.tabs[index]["color"] as Color,
                                                            icons: ProfileTabs.tabs[index]["icon"] as IconData,
                                                            isExpanded: controller.isVisible.value,
                                                            onTap: ()
                                                            {
                                                                controller.changeTab(index);
                                                            }
                                                        );*/

                                                            AnimatedSlide(
                                                                duration: Duration(milliseconds: 300 + (index * 200)),
                                                                offset: controller.isVisible.value
                                                                    ? Offset(0, 0) // visible
                                                                    : Offset(-1.5, 0), // slide left
                                                                curve: controller.isVisible.value
                                                                    ? Curves.easeOutBack
                                                                    : Curves.easeInBack,
                                                                child: AnimatedOpacity(
                                                                    duration: Duration(milliseconds: 300 + (index * 200)),
                                                                    opacity: controller.isVisible.value ? 1 : 0,
                                                                    child: TabsMenuItem(
                                                                        title: ProfileTabs.tabs[index]["title"] as String,
                                                                        color: ProfileTabs.tabs[index]["color"] as Color,
                                                                        icons: ProfileTabs.tabs[index]["icon"] as IconData,
                                                                        isExpanded: controller.isVisible.value,
                                                                        onTap: ()
                                                                        {
                                                                            controller.changeTab(index);
                                                                        }
                                                                    )
                                                                )
                                                            );
                                                        }
                                                    )
                                                );
                                            }
                                        )
                                    ]
                                )
                            )
                        ]
                    )
                );
            }
        );
    }
}

