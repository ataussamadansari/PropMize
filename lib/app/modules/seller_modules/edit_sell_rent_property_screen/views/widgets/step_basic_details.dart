import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prop_mize/app/global_widgets/forms/custom_dropdown_field.dart';
import 'package:prop_mize/app/global_widgets/forms/custom_text_field.dart';
import '../../controllers/edit_sell_rent_property_controller.dart';

class StepBasicDetails extends GetView<EditSellRentPropertyController>
{
    const StepBasicDetails({super.key});

    @override
    Widget build(BuildContext context)
    {
        return Obx(()
            {

                final isPlot = controller.propertyType.value == 'Plot';
                final isCommercialOrOffice = controller.propertyType.value == 'Commercial' ||
                    controller.propertyType.value == 'Office';
                final isResidential = !isPlot && !isCommercialOrOffice; // Apartment, House, Villa

                return Form(
                    key: controller.formKeys[0],
                    child: SingleChildScrollView(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                                /*Row(
                                    children: [
                                        Expanded(
                                            child: Obx(() => CustomDropdownField<String>(
                                                    labelText: "Property Type",
                                                    value: controller.propertyType.value,
                                                    items: const['Apartment', 'House', 'Villa', 'Plot', 'Commercial', 'Office'],
                                                    onChanged: (val) => controller.propertyType.value = val!,
                                                    isRequired: true
                                                ))
                                        ),
                                        const SizedBox(width: 16),
                                        Expanded(
                                            child: Obx(() => CustomDropdownField<String>(
                                                    labelText: "Listing Type",
                                                    value: controller.listingType.value,
                                                    items: const['For Sale', 'For Rent', 'For Lease'],
                                                    onChanged: (val) => controller.listingType.value = val!,
                                                    isRequired: true
                                                ))
                                        )
                                    ]
                                ),
                                const SizedBox(height: 16),*/
                                CustomTextField(
                                    controller: controller.titleController,
                                    labelText: 'Property Title',
                                    hintText: 'e.g. Luxury Apartment in Mumbai',
                                    isRequired: true
                                ),
                                const SizedBox(height: 16),
                                CustomTextField(
                                    controller: controller.descriptionController,
                                    labelText: 'Description',
                                    hintText: 'Describe the property...',
                                    maxLines: 4,
                                    isRequired: true
                                ),
                                const SizedBox(height: 16),

                                // --- REFACTORED AREA SECTION ---
                                _buildAreaInput(
                                    label: "Area *",
                                    controller: controller.areaController,
                                    unitValue: controller.areaUnit
                                ),

                                if(isResidential) ...[
                                  const SizedBox(height: 8),
                                  Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        if (!controller.showBuildUpArea.value)
                                          _buildAddAreaButton("+ Add Built-up Area", ()
                                          {
                                            controller.showBuildUpArea.value = true;
                                          }
                                          ),
                                        if (controller.showBuildUpArea.value) ...[
                                          const SizedBox(height: 8),
                                          _buildAreaInput(
                                              label: "Built-up Area",
                                              controller: controller.buildUpAreaController,
                                              unitValue: controller.buildUpAreaUnit,
                                              // Add the remove functionality
                                              onRemove: ()
                                              {
                                                controller.showBuildUpArea.value = false;
                                                controller.buildUpAreaController.clear();
                                              }
                                          )
                                        ]
                                      ]
                                  ),
                                  Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        if (!controller.showSuperBuildUpArea.value)
                                          _buildAddAreaButton("+ Add Super Built-up Area", ()
                                          {
                                            controller.showSuperBuildUpArea.value = true;
                                          }
                                          ),
                                        if (controller.showSuperBuildUpArea.value) ...[
                                          const SizedBox(height: 8),
                                          _buildAreaInput(
                                              label: "Super Built-up Area",
                                              controller: controller.superBuildUpAreaController,
                                              unitValue: controller.superBuildUpAreaUnit,
                                              // Add the remove functionality
                                              onRemove: ()
                                              {
                                                controller.showSuperBuildUpArea.value = false;
                                                controller.superBuildUpAreaController.clear();
                                              }
                                          )
                                        ]
                                      ]
                                  ),
                                ],
                                const SizedBox(height: 16),
                                CustomTextField(
                                    controller: controller.propertyAgeController,
                                    labelText: "Property Age (Years)",
                                    hintText: "e.g. 5",
                                    isRequired: true,
                                    isNumeric: true
                                ),
                                const SizedBox(height: 16),
                                CustomDropdownField<String>(
                                    labelText: "Furnishing Status",
                                    value: controller.furnishingStatus.value,
                                    items: const['Unfurnished', 'Semi-Furnished', 'Furnished'],
                                    onChanged: (val) => controller.furnishingStatus.value = val!,
                                    isRequired: true

                                ),
                                if(isResidential) ...[
                                    const SizedBox(height: 16),
                                    CustomTextField(
                                        controller: controller.bedroomsController,
                                        labelText: "Bedrooms",
                                        hintText: "e.g. 3",
                                        isNumeric: true
                                    ),
                                    const SizedBox(height: 16),
                                    CustomTextField(
                                        controller: controller.bathroomsController,
                                        labelText: "Bathrooms",
                                        hintText: "e.g. 2",
                                        isNumeric: true
                                    ),
                                    const SizedBox(height: 16),
                                    CustomTextField(
                                        controller: controller.balconiesController,
                                        labelText: "Balconies",
                                        hintText: "e.g. 1",
                                        isNumeric: true
                                    )
                                ],

                                if(isCommercialOrOffice || isResidential) ...[
                                    const SizedBox(height: 16),
                                    CustomTextField(
                                        controller: controller.parkingController,
                                        labelText: "Parking",
                                        hintText: "e.g. 1",
                                        isNumeric: true
                                    )
                                ],

                                if(!isPlot) ...[
                                    const SizedBox(height: 16),
                                    Row(
                                        children: [
                                            Expanded(child: CustomTextField(controller: controller.floorController, labelText: "Floor No.", hintText: "e.g. 3", isNumeric: true)),
                                            const SizedBox(width: 8),
                                            Expanded(child: CustomTextField(controller: controller.totalFloorsController, labelText: "Total Floors", hintText: "e.g. 10", isNumeric: true))
                                        ]
                                    )
                                ]
                            ]
                        )
                    )
                );
            }
        );
    }

    /// Helper widget for the composite area input field (TextField + Dropdown).
    Widget _buildAreaInput({
        required String label,
        required TextEditingController controller,
        required RxString unitValue,
        VoidCallback? onRemove // Make onRemove optional
    })
    {
        return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                        Text.rich(
                            TextSpan(
                                text: label.replaceAll('*', ''),
                                style: const TextStyle(fontWeight: FontWeight.w500),
                                children: label.contains('*')
                                    ? [const TextSpan(text: '*', style: TextStyle(color: Colors.red))]
                                    : []
                            )
                        ),
                        // If onRemove is provided, show the remove button
                        if (onRemove != null)
                        IconButton(
                            icon: const Icon(Icons.close, color: Colors.red, size: 20),
                            onPressed: onRemove,
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints()
                        )
                    ]
                ),
                const SizedBox(height: 8),
                Row(
                    children: [
                        Expanded(
                            flex: 2,
                            child: TextFormField(
                                controller: controller,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                    hintText: 'e.g. 1200',
                                    border: OutlineInputBorder(
                                        borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(8),
                                            bottomLeft: Radius.circular(8)
                                        ),
                                        borderSide: BorderSide(color: Colors.grey.shade300)
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(8),
                                            bottomLeft: Radius.circular(8)
                                        ),
                                        borderSide: BorderSide(color: Colors.grey.shade300)
                                    ),
                                    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10)
                                ),
                                validator: (value)
                                {
                                    if (label.contains('*') && (value == null || value.isEmpty))
                                    {
                                        return 'Area is required.';
                                    }
                                    return null;
                                }
                            )
                        ),
                        Expanded(
                            flex: 1,
                            child: Obx(
                                () => Container(
                                    height: 48, // Match TextFormField height
                                    decoration: BoxDecoration(
                                        border: Border(
                                            top: BorderSide(color: Colors.grey.shade300),
                                            bottom: BorderSide(color: Colors.grey.shade300),
                                            right: BorderSide(color: Colors.grey.shade300)
                                        ),
                                        borderRadius: const BorderRadius.only(
                                            topRight: Radius.circular(8),
                                            bottomRight: Radius.circular(8)
                                        )
                                    ),
                                    child: DropdownButtonHideUnderline(
                                        child: DropdownButton<String>(
                                            isExpanded: true,
                                            value: unitValue.value,
                                            items: ['Sq. Ft.', 'Sq. M.', 'Acre', 'Hectare']
                                                .map((String value) => DropdownMenuItem<String>(
                                                        value: value,
                                                        child: Padding(
                                                            padding: const EdgeInsets.only(left: 12.0),
                                                            child: Text(value, style: const TextStyle(fontSize: 14))
                                                        )
                                                    ))
                                                .toList(),
                                            onChanged: (newValue)
                                            {
                                                if (newValue != null)
                                                {
                                                    unitValue.value = newValue;
                                                }
                                            }
                                        )
                                    )
                                )
                            )
                        )
                    ]
                )
            ]
        );
    }

    /// Helper widget for the "+ Add Area" buttons.
    Widget _buildAddAreaButton(String text, VoidCallback onPressed)
    {
        return TextButton(
            onPressed: onPressed,
            style: TextButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 4),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap
            ),
            child: Text(text, style: TextStyle(color: Get.theme.primaryColor, fontWeight: FontWeight.bold, fontSize: 14))
        );
    }
}
