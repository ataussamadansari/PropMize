// ✅ Success dialog show karne ka method
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showLeadSuccessDialog({
  required String propertyName,
  required String sellerName,
  required String leadStatus,
  required String leadId,
}) {
  Get.dialog(
    AlertDialog(
      title: Row(
        children: [
          Icon(Icons.check_circle, color: Colors.green, size: 30),
          SizedBox(width: 10),
          Text("Lead Created Successfully! 🎉"),
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("✅ Your interest has been recorded"),
          SizedBox(height: 12),
          _buildInfoRow("Property:", propertyName),
          _buildInfoRow("Seller:", sellerName),
          _buildInfoRow("Status:", leadStatus),
          _buildInfoRow("Lead ID:", leadId.substring(0, 8)),
          SizedBox(height: 16),
          Text(
            "The seller will contact you shortly.",
            style: TextStyle(
              fontStyle: FontStyle.italic,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Get.back(),
          child: Text("OK"),
        ),
        ElevatedButton(
          onPressed: () {
            Get.back();
            // Yahan aap leads list par navigate kar sakte hain
            // Get.toNamed(Routes.myLeads);
          },
          child: Text("View My Leads"),
        ),
      ],
    ),
  );
}

Widget _buildInfoRow(String label, String value) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.grey[700],
          ),
        ),
        SizedBox(width: 8),
        Expanded(
          child: Text(
            value,
            style: TextStyle(color: Colors.grey[800]),
          ),
        ),
      ],
    ),
  );
}