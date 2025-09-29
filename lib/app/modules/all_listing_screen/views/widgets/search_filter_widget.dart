import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prop_mize/app/modules/all_listing_screen/controllers/all_listing_controller.dart';

class SearchFilterWidget extends GetView<AllListingController> {
  const SearchFilterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Obx(() => TextField(
              controller: controller.searchController,
              decoration: InputDecoration(
                hintText: 'Search properties...',
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                suffixIcon: controller.searchText.value.isNotEmpty
                    ? IconButton(
                  icon: const Icon(Icons.clear, size: 20),
                  onPressed: () {
                    controller.clearSearch();
                  },
                )
                    : null,
              ),
              onChanged: (value) {
                controller.searchText.value = value;
                controller.debouncer.run(() {
                  if (value.isNotEmpty) {
                    controller.searchProperties(value);
                  } else {
                    controller.loadProperties(reset: true); // reset list
                  }
                });
              },
            ),
          ),
        ),
        const SizedBox(width: 8),
        // Search Button
        IconButton(
          onPressed: () {
            if (controller.searchController.text.isNotEmpty) {
              controller.searchProperties(controller.searchController.text);
            }
          },
          icon: Icon(
            Icons.search,
            color: Theme.of(context).primaryColor,
          ),
        ),
        // Filter Button
        IconButton(
          onPressed: () {
            controller.showFilterBottomSheet();
          },
          icon: Icon(
            Icons.filter_list,
            color: Theme.of(context).primaryColor,
          ),
        ),
      ],
    );
  }
}