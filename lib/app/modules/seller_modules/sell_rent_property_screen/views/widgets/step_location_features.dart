import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prop_mize/app/global_widgets/forms/custom_dropdown_field.dart';
import 'package:prop_mize/app/global_widgets/forms/custom_text_field.dart';

import '../../controllers/sell_rent_property_controller.dart';

class StepLocationFeatures extends GetView<SellRentPropertyController> {
  const StepLocationFeatures({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: controller.formKeys[1],
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomTextField(controller: controller.streetController, labelText: "Street", isRequired: true),
            const SizedBox(height: 16),
            CustomTextField(controller: controller.areaNameController, labelText: "Area", isRequired: true),
            const SizedBox(height: 16),
            CustomTextField(controller: controller.cityController, labelText: "City", isRequired: true),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(child: CustomTextField(controller: controller.stateController, labelText: "State", isRequired: true)),
                const SizedBox(width: 16),
                Expanded(child: CustomTextField(controller: controller.zipCodeController, labelText: "Zip Code", isRequired: true, isNumeric: true)),
              ],
            ),
            const SizedBox(height: 16),
            CustomTextField(controller: controller.countryController, labelText: "Country", isRequired: true),
            const SizedBox(height: 16),
            CustomTextField(controller: controller.landmarkController, labelText: "Landmark (optional)"),
            const SizedBox(height: 24),
            const Divider(),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: Obx(() => CustomDropdownField<String>(
                    labelText: "Facing",
                    value: controller.facing.value,
                    items: const ['North', 'South', 'East', 'West', 'North-East', 'North-West', 'South-East', 'South-West'],
                    onChanged: (val) => controller.facing.value = val!,
                  )),
                ),
                const SizedBox(width: 16),
                Expanded(child: CustomTextField(controller: controller.flooringTypeController, labelText: "Flooring Type")),
              ],
            ),
            const SizedBox(height: 16),
            CustomTextField(controller: controller.waterSupplyController, labelText: "Water Supply"),
            const SizedBox(height: 24),
            Text("Other Features", style: context.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            _buildFeaturesCheckboxes(),
            Text("Select Amenities", style: context.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            _buildAmenitiesCheckboxes(),
          ],
        ),
      ),
    );
  }

  Widget _buildFeaturesCheckboxes() {
    return Obx(
          () => Wrap(
        spacing: 8.0,
        runSpacing: 4.0,
        children: [
          _buildCheckbox("Power Backup", controller.powerBackup),
          _buildCheckbox("Swimming Pool", controller.swimmingPool),
          _buildCheckbox("Servant Room", controller.servantRoom),
          _buildCheckbox("Pooja Room", controller.poojaRoom),
          _buildCheckbox("Study Room", controller.studyRoom),
          _buildCheckbox("Store Room", controller.storeRoom),
          _buildCheckbox("Gym", controller.gym),
          _buildCheckbox("Lift", controller.lift),
          _buildCheckbox("Security", controller.security),
        ],
      ),
    );
  }

  // UPDATED: This now uses the new list-based logic
  Widget _buildAmenitiesCheckboxes() {
    return Obx(
          () => Wrap(
        spacing: 16.0,
        runSpacing: 0,
        // Loop through the list of available amenities from the controller
        children: controller.availableAmenities.map((amenity) {
          // Build a checkbox for each amenity string
          return _buildAmenityCheckbox(amenity);
        }).toList(),
      ),
    );
  }

  /*Widget _buildAmenitiesCheckboxes() {
    return Obx(
          () => Wrap(
        spacing: 8.0,
        runSpacing: 4.0,
        children: [
          _buildCheckbox("Power Backup", controller.amenitiesPowerBackup),
          _buildCheckbox("Garden", controller.garden),
          _buildCheckbox("Children's Play Area", controller.childPlayArea),
          _buildCheckbox("Club House", controller.clubHouse),
          _buildCheckbox("Parking", controller.parking),
          _buildCheckbox("CCTV", controller.cctv),
          _buildCheckbox("Fire Safety", controller.fireSafety),
          _buildCheckbox("Intercom", controller.intercom),
          _buildCheckbox("Wifi", controller.wifi),
          _buildCheckbox("Community Hall", controller.communityHall),
          _buildCheckbox("Jogging Track", controller.joggingTrack),
          _buildCheckbox("Sports Facility", controller.sportFacility),
        ],
      ),
    );
  }*/

  // NEW: This is for the 'amenities' list of strings
  Widget _buildAmenityCheckbox(String title) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Checkbox(
          // Check if the title string is in the controller's list
          value: controller.amenities.contains(title),
          onChanged: (bool? isChecked) {
            if (isChecked == true) {
              // If checked, add the amenity to the list
              controller.amenities.add(title);
            } else {
              // If unchecked, remove the amenity from the list
              controller.amenities.remove(title);
            }
          },
        ),
        Text(title),
      ],
    );
  }


  Widget _buildCheckbox(String title, RxBool value) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Checkbox(
          value: value.value,
          onChanged: (bool? newValue) {
            value.value = newValue ?? false;
          },
        ),
        Text(title),
      ],
    );
  }
}
