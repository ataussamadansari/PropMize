import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ContactMethodCard extends StatelessWidget {
  final Map<String, dynamic> contact;
  final VoidCallback onTap;

  const ContactMethodCard({
    super.key,
    required this.contact,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: contact['color'].withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    contact['icon'],
                    size: 24,
                    color: contact['color'],
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  contact['title'],
                  style: context.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 4),
                Text(
                  contact['subtitle'],
                  style: Get.textTheme.bodySmall?.copyWith(
                    color: Colors.grey.shade600,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                Text(
                  contact['value'],
                  style: Get.textTheme.bodySmall?.copyWith(
                    color: contact['color'],
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}