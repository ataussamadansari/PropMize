import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:prop_mize/app/data/models/properties/property_by_id_model.dart';
import 'package:prop_mize/app/modules/product_details_screen/controllers/product_details_controller.dart';

class ContactDetails extends GetView<ProductDetailsController> {
  final Contact contact;
  const ContactDetails({super.key, required this.contact});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      decoration: BoxDecoration(
        border: Border.all(
          color: context.theme.colorScheme.surfaceContainerHighest,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(12.0),
        color: context.theme.cardColor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Contact Person
          SizedBox(
            width: double.infinity,
            child: _InfoBox(
              title: "Contact Person",
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    contact.name ?? "-",
                    style: context.textTheme.bodyLarge
                        ?.copyWith(fontWeight: FontWeight.w600),
                  ),
                  Text(
                    contact.type?.capitalize ?? "",
                    style: context.textTheme.bodySmall
                        ?.copyWith(color: Colors.blue, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 8),

          // Phone Number
          _InfoBox(
            title: "Phone Number",
            background: Colors.greenAccent,
            child: Row(
              children: [
                const Icon(Icons.phone, color: Colors.green),
                const SizedBox(width: 8),
                Text(
                  controller.userId() ? contact.phone ?? "-" : "Login to view",
                  style: context.textTheme.bodyLarge
                      ?.copyWith(color: Colors.green[800]),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),

          // WhatsApp
          _InfoBox(
            title: "WhatsApp",
            background: Colors.greenAccent,
            child: Row(
              children: [
                const Icon(FontAwesomeIcons.whatsapp, color: Colors.green),
                const SizedBox(width: 8),
                Text(
                  controller.userId() ? contact.whatsapp ?? "-" : "Login to view",
                  style: context.textTheme.bodyLarge
                      ?.copyWith(color: Colors.green[800]),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Buttons
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {
                    controller.contact(contact.phone);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  icon: const Icon(Icons.phone),
                  label: const Text("Call Now"),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {
                    controller.whatsapp(contact.whatsapp);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  icon: const Icon(FontAwesomeIcons.whatsapp),
                  label: const Text("WhatsApp"),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class _InfoBox extends StatelessWidget {
  final String title;
  final Widget child;
  final Color? background;
  const _InfoBox({
    required this.title,
    required this.child,
    this.background,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: background?.withOpacity(0.2) ?? Colors.blue.withOpacity(0.2),
        borderRadius: BorderRadius.circular(8),
        border: BoxBorder.all(color: background?.withOpacity(0.3) ?? Colors.blue.withOpacity(0.3), width: 1)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: context.textTheme.bodySmall
                  ?.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          child,
        ],
      ),
    );
  }
}
