import 'package:flutter/material.dart';import 'package:get/get.dart';
import '../../controllers/sell_rent_property_controller.dart';

class StepReviewSubmit extends GetView<SellRentPropertyController> {
  const StepReviewSubmit({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildReviewSection(
            context,
            title: "Basic Details",
            icon: Icons.description,
            children: [
              _buildReviewRow("Property Type:", controller.propertyType.value),
              _buildReviewRow("Listing Type:", controller.listingType.value),
              _buildReviewRow("Title:", controller.titleController.text),
              _buildReviewRow("Description:", controller.descriptionController.text),
              _buildReviewRow("Area:", "${controller.areaController.text} sq. ft."),
              _buildReviewRow("Property Age:", "${controller.propertyAgeController.text} years"),
              _buildReviewRow("Furnishing:", controller.furnishingStatus.value),
            ],
          ),
          const SizedBox(height: 16),
          _buildReviewSection(
            context,
            title: "Location Details",
            icon: Icons.location_on,
            children: [
              _buildReviewRow("Address:", "${controller.streetController.text}, ${controller.areaNameController.text}"),
              _buildReviewRow("City:", controller.cityController.text),
              _buildReviewRow("State:", controller.stateController.text),
              _buildReviewRow("Country:", controller.countryController.text),
            ],
          ),
          const SizedBox(height: 16),
          _buildReviewSection(
            context,
            title: "Pricing & Contact",
            icon: Icons.price_change,
            children: [
              _buildReviewRow("Sale Price:", "₹${controller.priceController.text}"),
              _buildReviewRow("Contact Name:", controller.contactNameController.text),
              _buildReviewRow("Contact Phone:", controller.contactPhoneController.text),
            ],
          ),
          const SizedBox(height: 24),
          const Center(
            child: Text(
              "Please review all details carefully before submitting.",
              style: TextStyle(color: Colors.grey, fontStyle: FontStyle.italic),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildReviewSection(BuildContext context, {required String title, required IconData icon, required List<Widget> children}) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: Theme.of(context).primaryColor),
                const SizedBox(width: 8),
                Text(title, style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
              ],
            ),
            const Divider(height: 20),
            ...children,
          ],
        ),
      ),
    );
  }

  Widget _buildReviewRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black54)),
          const SizedBox(width: 8),
          Expanded(child: Text(value, style: const TextStyle(color: Colors.black87))),
        ],
      ),
    );
  }
}
