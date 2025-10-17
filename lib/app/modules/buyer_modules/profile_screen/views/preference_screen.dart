import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prop_mize/app/global_widgets/profile/custom_container.dart';
import 'package:prop_mize/app/global_widgets/profile/custom_notification_list_item.dart';
import 'package:prop_mize/app/global_widgets/profile/custom_text_form_fields.dart';
import 'package:prop_mize/app/modules/profile_screen/controllers/profile_controller.dart';

class PreferencesScreen extends GetView<ProfileController>
{
    const PreferencesScreen({super.key});
    @override
    Widget build(BuildContext context)
    {
      return Obx(() => ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          CustomContainer(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Notification Preferences',
                  style: context.textTheme.headlineSmall,
                ),
                Text(
                  'Choose how you want to be notified',
                  style: context.textTheme.bodySmall,
                ),
                const SizedBox(height: 12),
                const SizedBox(height: 12),
                CustomNotificationListItem(
                  title: "Email Notifications",
                  subTitle: "Receive updates via email",
                  value: controller.emailNotifications.value,
                  onChanged: (val) => controller.emailNotifications.value = val,
                  isEnable: controller.isEnable.value,
                ),
                CustomNotificationListItem(
                  title: "SMS Notifications",
                  subTitle: "Receive text message alerts",
                  value: controller.smsNotifications.value,
                  onChanged: (val) => controller.smsNotifications.value = val,
                  isEnable: controller.isEnable.value,
                ),
                CustomNotificationListItem(
                  title: "Push Notifications",
                  subTitle: "Receive updates via push",
                  value: controller.pushNotifications.value,
                  onChanged: (val) => controller.pushNotifications.value = val,
                  isEnable: controller.isEnable.value,
                ),
              ],
            ),
          ),

          const SizedBox(height: 12),

          CustomContainer(child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Property Preferences',
                style: context.textTheme.headlineSmall,
              ),
              Text(
                'Set your property search preferences',
                style: context.textTheme.bodySmall,
              ),

              CustomTextFormFields(
                label: "Preferred Property Types",
                hint: "apartment, house, villa...",
                obscureText: false,
                enabled: controller.isEnable.value,
                controller: controller.propertyTypesController,
              ),

              Row(
                children: [
                  Expanded(
                    child: CustomTextFormFields(
                      label: "Min Price",
                      hint: "0",
                      obscureText: false,
                      enabled: controller.isEnable.value,
                      controller: controller.priceMinController,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: CustomTextFormFields(
                      label: "Max Price",
                      hint: "10000",
                      obscureText: false,
                      enabled: controller.isEnable.value,
                      controller: controller.priceMaxController,
                    ),
                  ),
                ],
              ),

              CustomTextFormFields(
                label: "Preferred Locations",
                hint: "City1, City2, City3...",
                obscureText: false,
                enabled: controller.isEnable.value,
                controller: controller.locationsController,
              ),


              /* CustomTextFormFields(label: "Preferred Property Types", hint: "apartment, house, villa...", obscureText: false, enabled: controller.isEnable.value),
              CustomTextFormFields(label: "Price Range", hint: "0-100000", obscureText: false, enabled: controller.isEnable.value),
              CustomTextFormFields(label: "Preferred Locations", hint: "City1, City2, City3...", obscureText: false, enabled: controller.isEnable.value),*/
            ],
          ))
        ],
      ));
    }
}
