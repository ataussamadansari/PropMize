import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prop_mize/app/data/models/ai/ai_list_model/properties.dart';

import '../modules/buyer_modules/assistant_chat_screen/controllers/assistant_chat_controller.dart';

class ChatPropertyItem extends GetView<AssistantChatController> {
  final Properties property;
  const ChatPropertyItem({super.key, required this.property});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => controller.goToProductDetails(property.id!),
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 4),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
        ),
        elevation: 1,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🔹 Property Image
            if (property.images != null && property.images!.isNotEmpty)
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(6)),
                child: Image.network(
                  property.images!.first,
                  height: 150,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    // 🔹 fallback image if network fails
                    return Container(
                      height: 150,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.black.withAlpha(100),
                        borderRadius: const BorderRadius.vertical(top: Radius.circular(6)),
                      ),
                      child: const Icon(Icons.broken_image, size: 50),
                    );
                  },
                ),
              )


            /*ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(6)),
                child: Image.network(
                  property.images!.first,
                  height: 150,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              )*/
            else
              Container(
                height: 150,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.black.withAlpha(100),
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(6)),
                ),
                child: const Icon(Icons.broken_image, size: 50),
              ),

            // 🔹 Property Info
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  Text(
                    property.title ?? "No Title",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 4),

                  // Address
                  Text(
                    // [
                    //   property.address?.area,
                    //   property.address?.city,
                    //   property.address?.state,
                    // ].where((e) => e != null && e.isNotEmpty).join(", "),
                    property.address!,
                    style: context.textTheme.bodySmall,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),

                  const SizedBox(height: 6),

                  // Price
                  Text(
                    property.price != null
                        // ? "${property.currency ?? "₹"} ${property.price}"
                        ? "₹ ${property.price}"
                        : "Price not available",
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Colors.green,
                    ),
                  ),

                  const SizedBox(height: 6),

                  // Features Row
                  /*Row(
                    children: [
                      if (property.bedrooms != null)
                        _iconText(CupertinoIcons.bed_double_fill, "${property.bedrooms}"),
                      if (property.bathrooms != null)
                        _iconText(Icons.bathtub, "${property.bathrooms}"),
                      if (property.area?.value != null)
                        _iconText(Icons.square_foot,
                            "${property.area!.value} ${property.area!.unit ?? "sqft"}"),
                    ],
                  ),*/
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 🔹 Helper Widget
  Widget _iconText(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.only(right: 12),
      child: Row(
        children: [
          Icon(icon, size: 16, color: Colors.grey.shade600),
          const SizedBox(width: 4),
          Text(
            text,
            style: TextStyle(
              fontSize: 13,
              color: Colors.grey.shade700,
            ),
          ),
        ],
      ),
    );
  }
}
