import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prop_mize/app/core/themes/app_colors.dart';
import 'package:prop_mize/app/core/utils/helpers.dart';
import 'package:prop_mize/app/modules/all_listing_screen/controllers/all_listing_controller.dart';

class FilterBottomSheet extends GetView<AllListingController>
{
     const FilterBottomSheet({super.key});

    @override
    Widget build(BuildContext context) 
    {
        return Container(
            height: Get.height * 0.6,
            padding: EdgeInsets.all(16),
            decoration:  BoxDecoration(
                color: context.theme.cardColor,
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
                                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)
                            ),
                            IconButton(
                                onPressed: ()
                                {
                                    Get.back();
                                    controller.removeFocus();
                                },
                                icon: const Icon(Icons.close)
                            )
                        ]
                    ),

                    Expanded(
                        child: ListView(
                            children: [
                                // Property Type
                                _buildSingleSelectSection(
                                    'Property Type',
                                    ['Apartment', 'Villa', 'House', 'Plot', 'Commercial'],
                                    controller.selectedPropertyTypes
                                ),

                                const SizedBox(height: 16),

                                // Price Range
                                _buildPriceRangeSection(),

                                const SizedBox(height: 16),

                                // Bedrooms
                                _buildSingleSelectSection(
                                    'Bedrooms',
                                    ['1', '2', '3', '4', '5'],
                                    controller.selectedBedrooms,
                                    suffix: '+ Beds'
                                ),

                                const SizedBox(height: 16),

                                // Bathrooms
                                _buildSingleSelectSection(
                                    'Bathrooms',
                                    ['1', '2', '3', '4', '5'],
                                    controller.selectedBathrooms,
                                    suffix: '+'
                                ),

                                const SizedBox(height: 16)
                            ]
                        )
                    ),

                    // Apply Button
                    SizedBox(
                        width: double.infinity,
                        height: 50,
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

    // ---------------- Single Select ----------------
    Widget _buildSingleSelectSection(
        String title, List<String> options, RxList<String> selectedOption,
        {String suffix = ''}) 
    {
        return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
                Text(title,
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                const SizedBox(height: 8),
                Wrap(
                    spacing: 8,
                    children: options.map((option)
                        {
                            return Obx(()
                                {
                                    final isSelected = selectedOption.isNotEmpty &&
                                        selectedOption.first == option.toLowerCase();
                                    return ChoiceChip(
                                        label: Text(option + suffix),
                                        selected: isSelected,
                                        onSelected: (selected)
                                        {
                                            selectedOption.clear();
                                            if (selected) selectedOption.add(option.toLowerCase());
                                        },
                                        selectedColor: AppColors.primary,
                                        labelStyle: TextStyle(
                                            color: isSelected ? Colors.white : Colors.grey)
                                    );
                                }
                            );
                        }
                    ).toList()
                )
            ]
        );
    }

    // ---------------- Price Range ----------------
    Widget _buildPriceRangeSection() 
    {
        return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
                const Text('Price Range',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                const SizedBox(height: 8),
                // Slider widget me
                Obx(() => Column(
                        children: [
                            RangeSlider(
                                values: RangeValues(controller.minPrice.value, controller.maxPrice.value),
                                min: 0,
                                max: 10000000,
                                divisions: 2000,
                                activeColor: AppColors.primary,
                                labels: RangeLabels(
                                    '${AppHelpers.formatCurrency(controller.minPrice.value)} ${'INR'}',
                                    '${AppHelpers.formatCurrency(controller.maxPrice.value)} ${'INR'}'
                                    // '₹${controller.minPrice.value.toInt()}',
                                    // '₹${controller.maxPrice.value.toInt()}'
                                ),
                                onChanged: (values)
                                {
                                    controller.minPrice.value = values.start;
                                    controller.maxPrice.value = values.end;
                                }
                            ),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                    Text('Min: ${AppHelpers.formatCurrency(controller.minPrice.value)}'),
                                    Text('Max: ${AppHelpers.formatCurrency(controller.maxPrice.value)}')
                                    // Text('Min: ₹${controller.minPrice.value.toInt()}'),
                                    // Text('Max: ₹${controller.maxPrice.value.toInt()}')
                                ]
                            )
                        ]
                    ))
            ]
        );
    }
}
