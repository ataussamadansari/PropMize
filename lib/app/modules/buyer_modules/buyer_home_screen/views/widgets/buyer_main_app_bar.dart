import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:prop_mize/app/modules/buyer_modules/buyer_home_screen/controllers/buyer_main_controller.dart';
import '../../../../common_modules/notification_screen/controllers/v1/notification_controller.dart';

class BuyerMainAppBar extends GetView<BuyerMainController> implements PreferredSizeWidget
{
  const BuyerMainAppBar({super.key});

  @override
  Widget build(BuildContext context)
  {
    final NotificationController notificationController = Get.find<NotificationController>();
    return AppBar(
        elevation: 0, // Remove shadow
        scrolledUnderElevation: 0, // Remove elevation when scrolled

        leading: IconButton(onPressed: ()
        {
          debugPrint("Drawer Key: ${controller.globalKey}");
          if (controller.globalKey.currentState != null)
          {
            controller.globalKey.currentState!.openDrawer();
          }
        }, icon: Icon(FontAwesomeIcons.barsStaggered)),
        title: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/logo.png', width: 40),
              const SizedBox(width: 8),
              const Text('PropMize')
            ]
        ),
        actions: [
          // Notification Icon with Badge
          Obx(()
          {
            final unreadCount = notificationController.unreadCount.value;

            return badges.Badge(
                position: badges.BadgePosition.topEnd(top: 5, end: 5),
                badgeContent: Text(
                    unreadCount > 99
                        ? '99+'
                        : unreadCount.toString(),
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold
                    )
                ),
                showBadge: unreadCount > 0,
                badgeStyle: badges.BadgeStyle(
                    badgeColor: Colors.red.shade500,
                    padding: const EdgeInsets.all(5),
                    borderSide: const BorderSide(color: Colors.white, width: 1.5),
                    borderRadius: BorderRadius.circular(10)
                ),
                child: IconButton(
                    onPressed: ()
                    {
                      controller.gotoNotificationScreen();
                    },
                    icon: const Icon(
                        FontAwesomeIcons.bell
                    ),
                    tooltip: 'Notifications'
                )
            );
          }
          ),

          Obx((){
            return controller.currentIndex.value == 2 ? IconButton(
                onPressed: ()
                {
                  if (controller.globalKey.currentState != null)
                  {
                    controller.globalKey.currentState!.openEndDrawer();
                  }
                },
                icon: const Icon(FontAwesomeIcons.ellipsisVertical)
            ) : const SizedBox.shrink();
          })
        ]
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
