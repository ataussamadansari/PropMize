import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import 'package:prop_mize/app/data/models/properties/property_by_id_model.dart';
import 'package:prop_mize/app/modules/product_details_screen/controllers/product_details_controller.dart';

class ContactBottomBar extends GetView<ProductDetailsController> {
  final Contact contact;
  const ContactBottomBar({super.key, required this.contact});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: context.theme.cardColor,
        border: Border(
          top: BorderSide(
            color: context.theme.colorScheme.surfaceContainerHighest,
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton.icon(
              onPressed: () {
                controller.contact(contact.phone);
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue
              ),
              icon: const Icon(Icons.call),
              label: const Text("Call"),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: ElevatedButton.icon(
              onPressed: () {
                controller.whatsapp(contact.whatsapp);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green
              ),
              icon: const Icon(FontAwesomeIcons.whatsapp),
              label: const Text("WhatsApp"),
            ),
          ),
        ],
      ),
    );
  }
}
