import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/v1/notification_controller.dart';

class NotificationView extends GetView<NotificationController>
{

    const NotificationView({super.key});

    @override
    Widget build(BuildContext context)
    {
        return Scaffold(
            appBar: AppBar(
                title: Obx(() => Text(
                        'Notifications ${controller.unreadCount.value > 0 ? '(${controller.unreadCount.value})' : ''}'
                    )
                ),
                actions: [
                    IconButton(
                        icon: const Icon(Icons.refresh),
                        onPressed: controller.refreshNotification
                    ),
                    Obx(() => controller.unreadCount > 0 ?
                            IconButton(
                                icon: const Icon(Icons.done_all),
                                onPressed: controller.markAllAsRead
                            ) : SizedBox.shrink()
                    )
                ]
            ),
            body: Obx(()
                {
                    if (controller.notifications.isEmpty)
                    {
                        return const Center(
                            child: Text('No notifications available.')
                        );
                    }

                    return ListView.builder(
                        itemCount: controller.notifications.length,
                        itemBuilder: (context, index)
                        {
                            final notification = controller.notifications[index];
                            return ListTile(
                                title: Text(notification.title ?? "No Title"),
                                subtitle: Text(notification.message ?? "No Message"),
                                trailing: notification.read! ?
                                    null : Icon(Icons.circle, color: Colors.blue, size: 10),
                                onTap: ()
                                {
                                    controller.markAsRead(notification.id!);
                                }
                            );
                        }
                    );
                }
            )
        );
    }
}
