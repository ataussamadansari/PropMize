/*
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prop_mize/app/core/themes/app_colors.dart';
import 'package:prop_mize/app/modules/all_listing_screen/controllers/all_listing_controller.dart';

class FilterBottomSheet extends GetView<AllListingController>
{
  const FilterBottomSheet({super.key});

  @override
  Widget build(BuildContext context)
  {
    return Container(
        height: Get.height * 0.6,
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20)
            )
        ),
        child: Column(
            children: [
              // Header
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                        'Filters',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold
                        )
                    ),
                    IconButton(
                        onPressed: () => Get.back(),
                        icon: const Icon(Icons.close)
                    )
                  ]
              ),

              Expanded(
                  child: ListView(
                      children: [
                        // Property Type
                        _buildFilterSection(
                            'Property Type',
                            [
                              'Apartment',
                              'Villa',
                              'House',
                              'Plot',
                              'Commercial'
                            ],
                            controller.selectedPropertyTypes
                        ),

                        const SizedBox(height: 16),

                        // Price Range
                        _buildPriceRangeSection(),

                        const SizedBox(height: 16),

                        // Bedrooms
                        _buildBedroomsSection(),

                        const SizedBox(height: 16),

                        // Bathrooms
                        _buildBathroomSection(),

                        const SizedBox(height: 16)

                        // Other Filters
                        // _buildOtherFiltersSection(),
                      ]
                  )
              ),

              // Apply Button
              Container(
                  width: double.infinity,
                  height: 50,
                  margin: const EdgeInsets.only(top: 16),
                  child: ElevatedButton(
                      onPressed: ()
                      {
                        controller.applyFilters();
                        Get.back();
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)
                          )
                      ),
                      child: const Text(
                          'Apply Filters',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold
                          )
                      )
                  )
              )
            ]
        )
    );
  }

  Widget _buildFilterSection(String title, List<String> options, RxList<String> selectedOptions) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        Obx(() => Wrap(
          spacing: 8,
          runSpacing: 8,
          children: options.map((option) {
            final optionLower = option.toLowerCase();
            final isSelected = selectedOptions.contains(optionLower);

            return FilterChip(
              label: Text(option), // show capitalized
              selected: isSelected,
              onSelected: (selected) {
                if (selected) {
                  selectedOptions.add(optionLower); // store lowercase
                } else {
                  selectedOptions.remove(optionLower);
                }
              },
              selectedColor: AppColors.primary,
              checkmarkColor: Colors.white,
            );
          }).toList(),
        )),
      ],
    );
  }

  Widget _buildPriceRangeSection()
  {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
              'Price Range',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600
              )
          ),
          const SizedBox(height: 8),
          Row(
              children: [
                Expanded(
                    child: TextField(
                        controller: controller.minPriceController,
                        decoration: const InputDecoration(
                            labelText: 'Min Price',
                            border: OutlineInputBorder()
                        ),
                        keyboardType: TextInputType.number
                    )
                ),
                const SizedBox(width: 16),
                Expanded(
                    child: TextField(
                        controller: controller.maxPriceController,
                        decoration: const InputDecoration(
                            labelText: 'Max Price',
                            border: OutlineInputBorder()
                        ),
                        keyboardType: TextInputType.number
                    )
                )
              ]
          )
        ]
    );
  }

  Widget _buildBedroomsSection()
  {
    final bedrooms = ['1', '2', '3', '4', '5'];
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
              'Bedrooms',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600
              )
          ),
          const SizedBox(height: 8),
          Obx(() => Wrap(
              spacing: 8,
              children: bedrooms.map((beds)
              {
                final isSelected = controller.selectedBedrooms.contains(beds);
                return FilterChip(
                    label: Text('$beds+ Beds'),
                    selected: isSelected,
                    onSelected: (selected)
                    {
                      if (selected)
                      {
                        controller.selectedBedrooms.add(beds);
                      }
                      else
                      {
                        controller.selectedBedrooms.remove(beds);
                      }
                    },
                    selectedColor: AppColors.primary,
                    checkmarkColor: Colors.white
                );
              }
              ).toList()
          ))
        ]
    );
  }

  Widget _buildBathroomSection()
  {
    final bathrooms = ['1', '2', '3', '4', '5'];
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
              'Bathrooms',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600
              )
          ),
          const SizedBox(height: 8),
          Obx(() => Wrap(
              spacing: 8,
              children: bathrooms.map((beds)
              {
                final isSelected = controller.selectedBathrooms.contains(beds);
                return FilterChip(
                    label: Text('$beds+'),
                    selected: isSelected,
                    onSelected: (selected)
                    {
                      if (selected)
                      {
                        controller.selectedBathrooms.add(beds);
                      }
                      else
                      {
                        controller.selectedBathrooms.remove(beds);
                      }
                    },
                    selectedColor: AppColors.primary,
                    checkmarkColor: Colors.white
                );
              }
              ).toList()
          ))
        ]
    );
  }

  Widget _buildOtherFiltersSection()
  {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
              'Other Filters',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600
              )
          ),
          const SizedBox(height: 8),
          Row(
              children: [
                Obx(() => Checkbox(
                    value: controller.showFeaturedOnly.value,
                    onChanged: (value)
                    {
                      controller.showFeaturedOnly.value = value ?? false;
                    }
                )),
                const Text('Featured Only')
              ]
          ),
          Row(
              children: [
                Obx(() => Checkbox(
                    value: controller.showPremiumOnly.value,
                    onChanged: (value)
                    {
                      controller.showPremiumOnly.value = value ?? false;
                    }
                )),
                const Text('Premium Only')
              ]
          )
        ]
    );
  }
}
*/
