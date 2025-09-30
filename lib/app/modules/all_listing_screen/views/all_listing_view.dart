import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:prop_mize/app/core/themes/app_colors.dart';
import 'package:prop_mize/app/modules/all_listing_screen/controllers/all_listing_controller.dart';
import 'package:prop_mize/app/modules/all_listing_screen/views/widgets/property_card_widget.dart';
import 'package:prop_mize/app/modules/all_listing_screen/views/widgets/search_filter_widget.dart';

class AllListingView extends GetView<AllListingController>
{
    const AllListingView({super.key});

    @override
    Widget build(BuildContext context) 
    {
        return Scaffold(
            body: Stack(
                children: [
                    // Back Button
                    Positioned(
                        top: 36,
                        left: 4,
                        child: IconButton(
                            onPressed: ()
                            {
                                Get.back();
                            },
                            style: IconButton.styleFrom(
                                backgroundColor: AppColors.primary.withAlpha(100)
                            ),
                            icon: const Icon(Icons.arrow_back)
                        )
                    ),

                    // Content
                    Padding(
                        padding: const EdgeInsets.only(top: 100.0),
                        child: Column(
                            children: [
                                // Header
                                Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                                    child: Column(
                                        children: [
                                            Text(
                                                "Discover Your Dream Property",
                                                textAlign: TextAlign.center,
                                                style: context.textTheme.headlineLarge
                                            ),
                                            const SizedBox(height: 8),
                                            Text(
                                                "Browse through our curated collection of premium properties tailored to your needs",
                                                textAlign: TextAlign.center,
                                                style: context.textTheme.bodySmall
                                            ),
                                            const SizedBox(height: 20),

                                            // Search & Filter
                                            const SearchFilterWidget(),
                                            const SizedBox(height: 16)
                                        ]
                                    )
                                ),

                                // Properties List
                                Expanded(
                                    child: Obx(()
                                        {
                                            if (controller.isLoading.value && controller.properties.isEmpty) 
                                            {
                                                return const Center(child: CircularProgressIndicator());
                                            }

                                            if (controller.hasError.value && controller.properties.isEmpty) 
                                            {
                                                return Center(
                                                    child: Column(
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        children: [
                                                            const Icon(Icons.error_outline, size: 64, color: Colors.grey),
                                                            const SizedBox(height: 16),
                                                            Text(
                                                                controller.errorMessage.value,
                                                                textAlign: TextAlign.center,
                                                                style: const TextStyle(color: Colors.grey)
                                                            ),
                                                            const SizedBox(height: 16),
                                                            ElevatedButton(
                                                                onPressed: controller.loadProperties,
                                                                child: const Text('Try Again')
                                                            )
                                                        ]
                                                    )
                                                );
                                            }

                                            if (controller.properties.isEmpty) 
                                            {
                                                return Center(
                                                    child: Column(
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        children: [
                                                            SvgPicture.asset('assets/svg_icons/404 Error-cuate.svg', width: double.infinity, height: 200)
                                                        ]
                                                    )
                                                );
                                            }

                                            return NotificationListener<ScrollNotification>(
                                                onNotification: (scrollNotification)
                                                {
                                                    if (scrollNotification is ScrollEndNotification &&
                                                        scrollNotification.metrics.pixels ==
                                                            scrollNotification.metrics.maxScrollExtent &&
                                                        controller.hasMore.value) 
                                                    {
                                                        controller.loadMoreProperties();
                                                    }
                                                    return false;
                                                },
                                                child: ListView.builder(
                                                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                                                    itemCount: controller.properties.length + (controller.hasMore.value ? 1 : 0),
                                                    itemBuilder: (context, index)
                                                    {
                                                        if (index == controller.properties.length) 
                                                        {
                                                            return const Padding(
                                                                padding: EdgeInsets.symmetric(vertical: 16.0),
                                                                child: Center(
                                                                    child: CircularProgressIndicator()
                                                                )
                                                            );
                                                        }

                                                        final property = controller.properties[index];
                                                        return PropertyCardWidget(properties: property, index: index, controller: controller);
                                                    }
                                                )
                                            );
                                        }
                                    )
                                )
                            ]
                        )
                    )
                ]
            ),

            // Floating Action Button for Clear Filters
            floatingActionButton: Obx(()
                {
                    if (controller.selectedPropertyTypes.isNotEmpty ||
                        // controller.minPriceController.text.isNotEmpty ||
                        // controller.maxPriceController.text.isNotEmpty ||
                        controller.minPrice.value > 0 ||
                        controller.maxPrice.value < 10000000 ||

                        controller.selectedBedrooms.isNotEmpty ||
                        controller.selectedBathrooms.isNotEmpty ||
                        controller.showFeaturedOnly.value ||
                        controller.showPremiumOnly.value) 
                    {
                        return FloatingActionButton(
                            onPressed: controller.clearFilters,
                            backgroundColor: AppColors.primary,
                            child: const Icon(Icons.clear_all, color: Colors.white)
                        );
                    }
                    return const SizedBox.shrink();
                }
            )
        );
    }
}
