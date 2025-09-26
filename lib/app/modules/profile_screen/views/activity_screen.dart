import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prop_mize/app/global_widgets/profile/activity_card_item.dart';
import 'package:prop_mize/app/modules/profile_screen/controllers/profile_controller.dart';

class ActivityScreen extends GetView<ProfileController>
{
    const ActivityScreen({super.key});
    @override
    Widget build(BuildContext context)
    {
        return Obx(() => ListView(
                padding: EdgeInsets.all(12.0),
                children: [
                    Row(
                        children: [
                            ActivityCardItem(icon: Icons.favorite_border, title: "Saved Properties", value: controller.savedProperties.toString(), color: Colors.blue),
                            ActivityCardItem(icon: Icons.remove_red_eye_outlined, title: "Properties Viewed", value: controller.viewedProperties.toString(), color: Colors.green)
                        ]
                    ),
                    Row(
                        children: [
                            ActivityCardItem(icon: Icons.messenger_outline, title: "Owners Contacted", value: controller.contactedOwners.toString(), color: Colors.purpleAccent),
                            ActivityCardItem(icon: Icons.notifications_none_outlined, title: "Notifications", value: controller.notifications.toString(), color: Colors.orange)
                        ]
                    )
                ]
            ));
    }
}
