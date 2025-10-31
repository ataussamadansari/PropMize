import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prop_mize/app/global_widgets/forms/custom_dropdown_field.dart';
import 'package:prop_mize/app/global_widgets/forms/custom_text_field.dart';

import '../../../../../data/models/properties/lists/near_by_places.dart';
import '../../controllers/sell_rent_property_controller.dart';

class StepMediaPricing extends GetView<SellRentPropertyController> {
  const StepMediaPricing({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: controller.formKeys[2],
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Upload Images *", style: TextStyle(fontWeight: FontWeight.w500)),
            const SizedBox(height: 8),

            Obx(() {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                GestureDetector(
                  onTap: controller.pickImages,
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 32.0, horizontal: 8.0),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade400, style: BorderStyle.solid),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.cloud_upload_outlined, size: 50, color: Colors.grey.shade700),
                        const SizedBox(height: 4),
                        Text(
                          controller.images.isEmpty
                              ?
                          "Drag & drop images here, or click to select"
                              : "You can upload more images",
                          style: TextStyle(color: Colors.grey.shade700),
                        ),
                        Text(
                          "Supported formats: JPG, PNG, WEBP",
                          style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                ),
                  // The upload button
                  const SizedBox(height: 8),
                  // Grid to display picked images
                  if (controller.images.isNotEmpty)
                    SizedBox(
                      height: 120,
                      child: GridView.builder(
                        scrollDirection: Axis.horizontal,
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 1,
                          mainAxisSpacing: 8,
                          crossAxisSpacing: 8,
                        ),
                        itemCount: controller.images.length,
                        itemBuilder: (context, index) {
                          return Stack(
                            fit: StackFit.expand,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                // Use Image.file for local paths
                                child: Image.file(
                                  File(controller.images[index]),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Positioned(
                                top: 4,
                                right: 4,
                                child: GestureDetector(
                                  onTap: () => controller.removeImage(index),
                                  child: Container(
                                    decoration: const BoxDecoration(
                                      color: Colors.black54,
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Icon(
                                      Icons.close,
                                      color: Colors.white,
                                      size: 18,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
              ],
              );
            }),
            /*Container(
              height: 150,
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade400, style: BorderStyle.solid),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.cloud_upload_outlined, size: 40, color: Colors.grey.shade600),
                  const SizedBox(height: 8),
                  Text(
                    "Drag & drop images here, or click to select",
                    style: TextStyle(color: Colors.grey.shade700),
                  ),
                  Text(
                    "Supported formats: JPG, PNG, WEBP",
                    style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
                  ),
                ],
              ),
            ),*/
            const SizedBox(height: 16),
            CustomTextField(
                controller: controller.priceController,
                labelText: "Sale Price (₹) *",
                hintText: "Enter sale price",
                isRequired: true,
                isNumeric: true),
            const SizedBox(height: 24),
            const Divider(),
            const SizedBox(height: 16),
            Text("Contact Information", style: context.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            CustomTextField(
                controller: controller.contactNameController,
                labelText: "Contact Name *",
                hintText: "Owner/Agent Name",
                isRequired: true),
            const SizedBox(height: 16),
            CustomTextField(
                controller: controller.contactPhoneController,
                labelText: "Contact Phone *",
                hintText: "Phone Number",
                isRequired: true,
                isNumeric: true),
            const SizedBox(height: 16),
            CustomTextField(
                controller: controller.contactWhatsappController,
                labelText: "Contact WhatsApp",
                hintText: "WhatsApp Number (optional)",
                isNumeric: true),
            const SizedBox(height: 16),
            Obx(() => CustomDropdownField<String>(
              labelText: "Contact Type *",
              value: controller.contactType.value,
              items: const ['Owner', 'Agent', 'Builder'],
              onChanged: (val) => controller.contactType.value = val!,
              isRequired: true,
            )),
            const SizedBox(height: 24),
            const Divider(),
            const SizedBox(height: 16),

            // --- NEARBY PLACES UI ---
            Text("Nearby Places", style: context.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),

            _buildNearbyPlaceSection<Schools>(
              title: 'Schools',
              icon: Icons.school_outlined,
              showAdd: controller.showAddSchool,
              onAdd: controller.addSchool,
              nameController: controller.schoolNameController,
              distanceController: controller.schoolDistanceController,
              unit: controller.schoolDistanceUnit,
              unitOptions: ['meter', 'km'],
              addedItems: controller.nearbySchools,
              getItemName: (item) => item.name ?? '',
              getItemDetails: (item) => '${item.distance} ${item.unit}',
            ),
            _buildNearbyPlaceSection<Hospitals>(
              title: 'Hospitals',
              icon: Icons.local_hospital_outlined,
              showAdd: controller.showAddHospital,
              onAdd: controller.addHospital,
              nameController: controller.hospitalNameController,
              distanceController: controller.hospitalDistanceController,
              unit: controller.hospitalDistanceUnit,
              unitOptions: ['meter', 'km'],
              addedItems: controller.nearbyHospitals,
              getItemName: (item) => item.name ?? '',
              getItemDetails: (item) => '${item.distance} ${item.unit}',
            ),
            _buildNearbyPlaceSection<Malls>(
              title: 'Shopping Malls',
              icon: Icons.storefront_outlined,
              showAdd: controller.showAddMall,
              onAdd: controller.addMall,
              nameController: controller.mallNameController,
              distanceController: controller.mallDistanceController,
              unit: controller.mallDistanceUnit,
              unitOptions: ['km', 'meter'],
              addedItems: controller.nearbyMalls,
              getItemName: (item) => item.name ?? '',
              getItemDetails: (item) => '${item.distance} ${item.unit}',
            ),
            _buildNearbyPlaceSection<Transport>(
              title: 'Transportation',
              icon: Icons.train_outlined,
              showAdd: controller.showAddTransport,
              onAdd: controller.addTransport,
              nameController: controller.transportNameController,
              distanceController: controller.transportDistanceController,
              unit: controller.transportDistanceUnit,
              unitOptions: ['km', 'meter'],
              addedItems: controller.nearbyTransport,
              getItemName: (item) => item.name ?? '',
              getItemDetails: (item) => '${item.distance} ${item.unit}',
            ),

            const SizedBox(height: 24),
            const Divider(),
            const SizedBox(height: 16),
            CustomTextField(controller: controller.additionalNotesController, labelText: "Additional Notes", maxLines: 3),
          ],
        ),
      ),
    );
  }

  /// A reusable generic widget for each "Nearby Place" category.
  Widget _buildNearbyPlaceSection<T>({
    required String title,
    required IconData icon,
    required RxBool showAdd,
    required VoidCallback onAdd,
    required TextEditingController nameController,
    required TextEditingController distanceController,
    required RxString unit,
    required List<String> unitOptions,
    required RxList<T> addedItems,
    required String Function(T) getItemName,
    required String Function(T) getItemDetails,
  }) {
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Obx(() => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(icon, color: Colors.grey.shade700),
                    const SizedBox(width: 8),
                    Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  ],
                ),
                if (!showAdd.value)
                  TextButton.icon(
                    onPressed: () => showAdd.value = true,
                    icon: const Icon(Icons.add, size: 18),
                    label: const Text('Add'),
                  ),
              ],
            ),
            if (addedItems.isEmpty && !showAdd.value)
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text('No ${title.toLowerCase()} added yet', style: const TextStyle(color: Colors.grey)),
              ),

            // Display added items as chips
            if (addedItems.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Wrap(
                  spacing: 8.0,
                  runSpacing: 4.0,
                  children: addedItems.map((item) => Chip(
                    label: Text('${getItemName(item)} - ${getItemDetails(item)}'),
                    onDeleted: () => addedItems.remove(item),
                    deleteIconColor: Colors.red.shade400,
                    backgroundColor: Colors.blue.shade50,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                      side: BorderSide(color: Colors.blue.shade100),
                    ),
                  )).toList(),
                ),
              ),

            // The form to add a new item
            if (showAdd.value) ...[
              const SizedBox(height: 16),
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Name', border: OutlineInputBorder()),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: TextField(
                      controller: distanceController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(labelText: 'Distance', border: OutlineInputBorder()),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    flex: 1,
                    child: DropdownButtonFormField<String>(
                      value: unit.value,
                      items: unitOptions.map((u) => DropdownMenuItem(value: u, child: Text(u))).toList(),
                      onChanged: (val) => unit.value = val!,
                      decoration: const InputDecoration(border: OutlineInputBorder()),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => showAdd.value = false,
                    child: const Text('Cancel'),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: onAdd,
                    child: const Text('Add'),
                  ),
                ],
              ),
            ],
          ],
        )),
      ),
    );
  }
}


/*
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prop_mize/app/global_widgets/forms/custom_dropdown_field.dart';
import 'package:prop_mize/app/global_widgets/forms/custom_text_field.dart';

import '../../controllers/sell_rent_property_controller.dart';

class StepMediaPricing extends GetView<SellRentPropertyController> {
  const StepMediaPricing({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: controller.formKeys[2],
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Upload Images *", style: TextStyle(fontWeight: FontWeight.w500)),
            const SizedBox(height: 8),
            // A placeholder for image upload UI
            Container(
              height: 150,
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade400, style: BorderStyle.solid),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.cloud_upload_outlined, size: 40, color: Colors.grey),
                  SizedBox(height: 8),
                  Text("Drag & drop images here, or click to select"),
                ],
              ),
            ),
            const SizedBox(height: 16),
            CustomTextField(controller: controller.priceController, labelText: "Sale Price", isRequired: true, isNumeric: true),
            const SizedBox(height: 24),
            const Divider(),
            const SizedBox(height: 16),
            Text("Contact Information", style: context.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            CustomTextField(controller: controller.contactNameController, labelText: "Contact Name", isRequired: true),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(child: CustomTextField(controller: controller.contactPhoneController, labelText: "Contact Phone", isRequired: true, isNumeric: true)),
                const SizedBox(width: 16),
                Expanded(child: CustomTextField(controller: controller.contactWhatsappController, labelText: "Contact Whatsapp", isRequired: true, isNumeric: true)),
              ],
            ),
            const SizedBox(height: 16),
            Obx(() => CustomDropdownField<String>(
              labelText: "Contact Type",
              value: controller.contactType.value,
              items: const ['Owner', 'Agent', 'Builder'],
              onChanged: (val) => controller.contactType.value = val!,
              isRequired: true,
            )),
            const SizedBox(height: 24),
            const Divider(),
            const SizedBox(height: 16),
            CustomTextField(controller: controller.additionalNotesController, labelText: "Additional Notes", maxLines: 3),
            // You can add UI for Nearby Places here
          ],
        ),
      ),
    );
  }
}
*/
