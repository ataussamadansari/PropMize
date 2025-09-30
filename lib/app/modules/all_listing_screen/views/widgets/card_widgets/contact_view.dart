import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:prop_mize/app/core/utils/capitalize.dart';
import 'package:prop_mize/app/core/utils/communication_helper.dart';
import 'package:prop_mize/app/core/utils/helpers.dart';
import 'package:prop_mize/app/data/models/properties/properties_model.dart';

import '../../../controllers/all_listing_controller.dart';

class ContactView extends GetView<AllListingController> {
  final Contact contact;

  const ContactView({super.key, required this.contact});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: ElevatedButton.icon(
                onPressed: () => CommunicationHelper.makeCall(contact.phone),
                icon: const Icon(Icons.phone, color: Colors.white),
                label: const Text("Call"),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: ElevatedButton.icon(
                onPressed: () => CommunicationHelper.openWhatsApp(contact.phone, message: "Hello, I am interested"),
                icon: const Icon(FontAwesomeIcons.whatsapp, color: Colors.white),
                label: const Text("WhatsApp"),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.teal),
              ),
            ),
          ],
        ),

        const SizedBox(height: 8),
        Text('Contact: ${contact.name} (${capitalize(contact.type)})', style: context.textTheme.bodySmall),

        const SizedBox(height: 8),
        SizedBox(width: double.infinity, height: 32, child: ElevatedButton(onPressed: () {
          AppHelpers.showSnackBar(icon: CupertinoIcons.bell, title: "Alert", message: "Coming Soon");
        }, child: Text('Contact Seller')))
      ],
    );
  }
}

