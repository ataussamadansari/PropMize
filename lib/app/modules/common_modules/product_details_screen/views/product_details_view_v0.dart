/*
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prop_mize/app/core/themes/app_colors.dart';
import 'package:prop_mize/app/global_widgets/status_card_item.dart';
import 'package:prop_mize/app/modules/product_details_screen/controllers/product_details_controller.dart';
import 'package:prop_mize/app/modules/product_details_screen/views/widgets/amenities_item.dart';
import 'package:prop_mize/app/modules/product_details_screen/views/widgets/contact_details.dart';
import 'package:prop_mize/app/modules/product_details_screen/views/widgets/description_item.dart';
import 'package:prop_mize/app/modules/product_details_screen/views/widgets/feature_item.dart';
import 'package:prop_mize/app/modules/product_details_screen/views/widgets/full_screen_image_gallery.dart';
import 'package:prop_mize/app/modules/product_details_screen/views/widgets/pricing_card_item.dart';
import 'package:prop_mize/app/modules/product_details_screen/views/widgets/property_overview.dart';
import 'package:visibility_detector/visibility_detector.dart';

import 'widgets/contact_bottom_bar.dart';

class ProductDetailsView extends GetView<ProductDetailsController>
{
    const ProductDetailsView({super.key});

    @override
    Widget build(BuildContext context)
    {
        final CarouselSliderController carouselController =
            CarouselSliderController();
        final RxInt currentIndex = 0.obs;

        return Scaffold(
            appBar: AppBar(title: const Text("Product Details")),
            body: NotificationListener<ScrollNotification>(
                onNotification: (scrollInfo)
                {
                    if (controller.contactKey.currentContext != null)
                    {
                        final box = controller.contactKey.currentContext!.findRenderObject() as RenderBox;
                        final offset = box.localToGlobal(Offset.zero);

                        final screenHeight = MediaQuery.of(context).size.height;

                        // 👉 Agar widget screen ke beech ya niche aa gaya
                        if (offset.dy < screenHeight - 200 && offset.dy > kToolbarHeight)
                        {
                            controller.showFloatingContact.value = false;
                        }
                        else
                        {
                            controller.showFloatingContact.value = true;
                        }
                    }
                    return true;
                },

                child: Obx(()
                    {
                        if (controller.isLoading.value)
                        {
                            return const Center(child: CircularProgressIndicator());
                        }
                        if (controller.hasError.value)
                        {
                            return Center(child: Text(controller.errorMessage.value));
                        }

                        final details = controller.details!.data!;

                        return ListView(
                            children: [
                                if (details.images != null && details.images!.isNotEmpty)
                                Stack(
                                    children: [
                                        // 🔹 Carousel
                                        CarouselSlider.builder(
                                            carouselController: carouselController,
                                            itemCount: details.images!.length,
                                            itemBuilder: (context, index, realIndex)
                                            {
                                                final imageUrl = details.images![index];
                                                return GestureDetector(
                                                    onTap: ()
                                                    {
                                                        // 👇 Fullscreen zoom view
                                                        Get.to(() => FullscreenImageGallery(
                                                                images: details.images!, initialIndex: index));
                                                    },
                                                    child: Image.network(
                                                        imageUrl,
                                                        width: double.infinity,
                                                        fit: BoxFit.cover,
                                                        loadingBuilder: (context, child, progress)
                                                        {
                                                            if (progress == null) return child;
                                                            return Container(
                                                                color: Colors.grey.shade200,
                                                                child: const Center(
                                                                    child: CircularProgressIndicator())
                                                            );
                                                        },
                                                        errorBuilder: (context, error, stackTrace)
                                                        {
                                                            return Container(
                                                                color: Colors.grey.shade200,
                                                                child: const Icon(Icons.broken_image, size: 60)
                                                            );
                                                        }
                                                    )
                                                );
                                            },
                                            options: CarouselOptions(
                                                height: 400,
                                                viewportFraction: 1,
                                                autoPlay: true,
                                                onPageChanged: (index, reason)
                                                {
                                                    currentIndex.value = index;
                                                }
                                            )
                                        ),

                                        // 🔹 Prev Button
                                        Positioned(
                                            left: 10,
                                            top: 200,
                                            child: IconButton(
                                                style: IconButton.styleFrom(
                                                    backgroundColor: Colors.white.withOpacity(0.5),
                                                    elevation: 2
                                                ),
                                                icon: const Icon(
                                                    Icons.arrow_back_ios_new,
                                                    color: AppColors.greyDark,
                                                    size: 24),
                                                onPressed: ()
                                                {
                                                    carouselController.previousPage(
                                                        duration: const Duration(milliseconds: 300),
                                                        curve: Curves.easeIn);
                                                }
                                            )
                                        ),

                                        // 🔹 Next Button
                                        Positioned(
                                            right: 10,
                                            top: 200,
                                            child: IconButton(
                                                style: IconButton.styleFrom(
                                                    backgroundColor: Colors.white.withOpacity(0.5),
                                                    elevation: 8
                                                ),
                                                icon: const Icon(
                                                    Icons.arrow_forward_ios,
                                                    color: AppColors.greyDark,
                                                    size: 24
                                                ),
                                                onPressed: ()
                                                {
                                                    carouselController.nextPage(
                                                        duration: const Duration(milliseconds: 300),
                                                        curve: Curves.easeIn);
                                                }
                                            )
                                        )
                                    ]
                                ),

                                // 🔹 Indicators (Dots)
                                if (details.images != null && details.images!.isNotEmpty)
                                Obx(() => Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: details.images!.asMap().entries.map((entry)
                                            {
                                                return GestureDetector(
                                                    onTap: () => carouselController.animateToPage(entry.key),
                                                    child: Container(
                                                        width: 8.0,
                                                        height: 8.0,
                                                        margin: const EdgeInsets.symmetric(
                                                            horizontal: 3.0, vertical: 10.0),
                                                        decoration: BoxDecoration(
                                                            shape: BoxShape.circle,
                                                            color: currentIndex.value == entry.key
                                                                ? Colors.blueAccent
                                                                : Colors.grey
                                                        )
                                                    )
                                                );
                                            }
                                        ).toList()
                                    )),

                                // 🔹 Title
                                Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                                    child: Text(
                                        details.title!,
                                        style: context.textTheme.headlineLarge!
                                            .copyWith(fontWeight: FontWeight.bold)
                                    )
                                ),

                                const SizedBox(height: 8),

                                // 🔹 Address
                                Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                                    child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                            const Icon(Icons.location_on_outlined,
                                                size: 20, color: Colors.blue),
                                            const SizedBox(width: 4),
                                            Expanded(
                                                child: Text(
                                                    controller.fullAddress,
                                                    style: context.textTheme.bodyMedium
                                                )
                                            )
                                        ]
                                    )
                                ),

                                const SizedBox(height: 8),

                                // 🔹 Status / Property Type / Listing Type
                                Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                                    child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                            StatusCardItem(title: details.status!),
                                            StatusCardItem(title: details.propertyType!),
                                            StatusCardItem(title: details.listingType!)
                                        ]
                                    )
                                ),

                                // Pricing
                                const SizedBox(height: 8),
                                PricingCardItem(pricing: details.pricing, price: details.price),

                                // Property Overview
                                const SizedBox(height: 8),
                                Container(
                                    margin: EdgeInsets.symmetric(horizontal: 20.0),
                                    child: Text("Property Overview", style: context.textTheme.displaySmall?.copyWith(color: AppColors.textSecondary))
                                ),
                                const SizedBox(height: 8),
                                PropertyOverView(data: details),

                                // Description
                                const SizedBox(height: 8),
                                Container(
                                    margin: EdgeInsets.symmetric(horizontal: 20.0),
                                    child: Text("Description", style: context.textTheme.displaySmall?.copyWith(color: AppColors.textSecondary))
                                ),
                                const SizedBox(height: 8),
                                DescriptionItem(description: details.description),

                                // Amenities
                                if (details.amenities!.isNotEmpty) ...[
                                    const SizedBox(height: 8),
                                    Container(
                                        margin: EdgeInsets.symmetric(horizontal: 20.0),
                                        child: Text("Amenities", style: context.textTheme.displaySmall?.copyWith(color: AppColors.textSecondary))
                                    ),
                                    const SizedBox(height: 8),
                                    AmenitiesItem(amenities: details.amenities)
                                ],

                                // Features
                                const SizedBox(height: 8),
                                Container(
                                    margin: EdgeInsets.symmetric(horizontal: 20.0),
                                    child: Text("Features", style: context.textTheme.displaySmall?.copyWith(color: AppColors.textSecondary))
                                ),
                                const SizedBox(height: 8),
                                FeatureItem(features: details.features!),

                                // Contact Details
                                const SizedBox(height: 8),
                                Container(
                                    margin: EdgeInsets.symmetric(horizontal: 20.0),
                                    child: Text("Contact Details", style: context.textTheme.displaySmall?.copyWith(color: AppColors.textSecondary))
                                ),
                                const SizedBox(height: 8),

                                VisibilityDetector(
                                    key: const Key("contact_details_visibility"),
                                    onVisibilityChanged: (visibilityInfo)
                                    {
                                        var visiblePercentage = visibilityInfo.visibleFraction * 100;
                                        // agar contact widget 50% ya usse zyada screen me visible hai, bottomSheet hide
                                        if (visiblePercentage > 90)
                                        {
                                            controller.showFloatingContact.value = false;
                                        }
                                        else 
                                        {
                                            controller.showFloatingContact.value = true;
                                        }
                                    },
                                    child: ContactDetails(contact: details.contact!)
                                )

                            ]

                        );
                    }
                )
            ),
            // 🔹 Floating bottomSheet
            bottomSheet: Obx(() => AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    transitionBuilder: (child, animation) => SizeTransition(
                        sizeFactor: animation,
                        child: child
                    ),
                    child: controller.showFloatingContact.value
                        ? ContactBottomBar(contact: controller.details!.data!.contact!)
                        : const SizedBox.shrink()
                ))

        );
    }
}

*/
