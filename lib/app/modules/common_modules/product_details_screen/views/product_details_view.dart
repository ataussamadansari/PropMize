import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../../core/themes/app_colors.dart';
import '../../../../global_widgets/status_card_item.dart';
import '../controllers/product_details_controller.dart';
import '../views/widgets/amenities_item.dart';
import '../views/widgets/contact_details.dart';
import 'widgets/description_item.dart';
import '../views/widgets/feature_item.dart';
import 'widgets/full_screen_image_gallery.dart';
import 'widgets/location_details.dart';
import 'widgets/pricing_card_item.dart';
import 'widgets/property_history.dart';
import 'widgets/property_overview.dart';

import '../../../../data/services/like/like_services.dart';
import '../../../../global_widgets/shimmer/properties_details/product_details_shimmer.dart';
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
        final ScrollController scrollController = ScrollController();
        final likeService = Get.find<LikeService>();

        return Scaffold(
            appBar: AppBar(
                title: Text("Product Details"),
                actions: [
                    IconButton(
                        icon: const Icon(Icons.history),
                        onPressed: ()
                        {
                            if (controller.details != null)
                            {
                                showModalBottomSheet(
                                    context: context,
                                    isScrollControlled: true,
                                    backgroundColor: Colors.transparent,
                                    builder: (context) => const PropertyHistorySheet()
                                );
                            }
                            else
                            {
                                Get.snackbar("Info", "Property details are not loaded yet");
                            }
                        }
                    )
                ]
            ),
            body: Obx(()
                {
                    if (controller.isLoading.value)
                    {
                        return const ProductDetailsShimmer();
                    }
                    if (controller.hasError.value)
                    {
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            spacing: 8,
                            children: [
                              SvgPicture.asset('assets/icons/404 Error-cuate.svg', width: 200,),
                              Text(controller.errorMessage.value),
                              ElevatedButton(
                                  onPressed: () => controller.getProductDetails(controller.productId),
                                  child: const Text("Retry")
                              )
                            ],
                          ),
                        );
                    }

                    final details = controller.details?.data;
                    if (details == null) return const Center(child: Text("No data available"));


                    debugPrint(
                        '👁️ pricing: ${details.pricing!.basePrice}, \n price: ${details.price}'
                    );

                    return NotificationListener<ScrollUpdateNotification>(
                        onNotification: (notification)
                        {
                            // Check if the contact section is visible
                            final renderObject = controller.contactKey.currentContext?.findRenderObject();
                            if (renderObject is RenderBox)
                            {
                                final position = renderObject.localToGlobal(Offset.zero);
                                final screenHeight = MediaQuery.of(context).size.height;

                                // If the contact section is visible on screen, hide the bottom bar
                                if (position.dy < screenHeight && position.dy + renderObject.size.height > 0)
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
                        child: ListView(
                            controller: scrollController,
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
                                                                    child: CircularProgressIndicator()
                                                                )
                                                            );
                                                        },
                                                        errorBuilder: (context, error, stackTrace)
                                                        {
                                                            return Container(
                                                                color: Colors.black.withAlpha(100),
                                                                width: double.infinity,
                                                                child:
                                                                const Icon(Icons.broken_image_rounded, size: 60)
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

                                        // Like-Dislike
                                        Positioned(
                                            right: 8,
                                            top: 8,
                                            child: Obx(()
                                                {
                                                    final isLiked = likeService.isLiked(details.id!);
                                                    return IconButton(
                                                        onPressed: () => likeService.toggleLike(details),
                                                        style: IconButton.styleFrom(
                                                            backgroundColor: Colors.grey.withValues(alpha: 0.7),

                                                            elevation: 2
                                                        ),
                                                        icon: Icon(
                                                            isLiked ? Icons.favorite : Icons.favorite_border,
                                                            color: isLiked ? Colors.red : Colors.black
                                                        )
                                                    );
                                                }
                                            )
                                        ),

                                      /*Positioned(
                                            right: 12,
                                            top: 12,
                                            child: Obx(() => AnimatedScale(
                                                    scale: controller.isLiked.value ? 1.2 : 1.0,
                                                    duration: const Duration(milliseconds: 200),
                                                    child: IconButton(
                                                        onPressed: controller.toggleLike,
                                                        style: IconButton.styleFrom(
                                                            backgroundColor: Colors.grey.withOpacity(0.7),
                                                            elevation: 2
                                                        ),
                                                        icon: Icon(
                                                            controller.isLiked.value
                                                                ? Icons.favorite
                                                                : Icons.favorite_border,
                                                            color: controller.isLiked.value ? Colors.red : Colors.black
                                                        )
                                                    )
                                                ))
                                        ),*/

                                        // 🔹 Prev Button
                                        Positioned(
                                            left: 10,
                                            top: 200,
                                            child: IconButton(
                                                style: IconButton.styleFrom(
                                                    backgroundColor: Colors.grey.withValues(alpha: 0.5),
                                                    elevation: 2
                                                ),
                                                icon: const Icon(
                                                    Icons.arrow_back_ios_new,
                                                    // color: AppColors.greyDark,
                                                    size: 24
                                                ),
                                                onPressed: ()
                                                {
                                                    carouselController.previousPage(
                                                        duration: const Duration(milliseconds: 300),
                                                        curve: Curves.easeIn
                                                    );
                                                }
                                            )
                                        ),

                                        // 🔹 Next Button
                                        Positioned(
                                            right: 10,
                                            top: 200,
                                            child: IconButton(
                                                style: IconButton.styleFrom(
                                                    backgroundColor: Colors.grey.withValues(alpha: 0.5),
                                                    elevation: 8
                                                ),
                                                icon: const Icon(
                                                    Icons.arrow_forward_ios,
                                                    // color: AppColors.black,
                                                    size: 24
                                                ),
                                                onPressed: ()
                                                {
                                                    carouselController.nextPage(
                                                        duration: const Duration(milliseconds: 300),
                                                        curve: Curves.easeIn
                                                    );
                                                }
                                            )
                                        )
                                    ]
                                ),

                                // 🔹 Indicators (Dots)
                                if (details.images != null && details.images!.isNotEmpty)
                                Obx(() => Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: details.images!
                                            .asMap()
                                            .entries
                                            .map((entry)
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
                                PricingCardItem(pricing: details.pricing, price: details.price, currency: details.currency),

                                // Property Overview
                                const SizedBox(height: 8),
                                Container(
                                    margin: const EdgeInsets.symmetric(horizontal: 20.0),
                                    child: Text("Property Overview",
                                        style: context.textTheme.displaySmall
                                            ?.copyWith(color: AppColors.textSecondary))
                                ),
                                const SizedBox(height: 8),
                                PropertyOverView(data: details),

                                // Description
                                const SizedBox(height: 8),
                                Container(
                                    margin: const EdgeInsets.symmetric(horizontal: 20.0),
                                    child: Text("Description",
                                        style: context.textTheme.displaySmall
                                            ?.copyWith(color: AppColors.textSecondary))
                                ),
                                const SizedBox(height: 8),
                                DescriptionItem(description: details.description),

                                // Amenities
                                if (details.amenities!.isNotEmpty) ...[
                                    const SizedBox(height: 8),
                                    Container(
                                        margin: const EdgeInsets.symmetric(horizontal: 20.0),
                                        child: Text("Amenities",
                                            style: context.textTheme.displaySmall
                                                ?.copyWith(color: AppColors.textSecondary))
                                    ),
                                    const SizedBox(height: 8),
                                    AmenitiesItem(amenities: details.amenities)
                                ],

                                // Features
                                const SizedBox(height: 8),
                                Container(
                                    margin: const EdgeInsets.symmetric(horizontal: 20.0),
                                    child: Text("Features",
                                        style: context.textTheme.displaySmall
                                            ?.copyWith(color: AppColors.textSecondary))
                                ),
                                const SizedBox(height: 8),
                                FeatureItem(features: details.features!),

                                // Contact Details - Add key here
                                const SizedBox(height: 8),
                                Container(
                                    margin: const EdgeInsets.symmetric(horizontal: 20.0),
                                    child: Text("Contact Details",
                                        style: context.textTheme.displaySmall
                                            ?.copyWith(color: AppColors.textSecondary))
                                ),
                                // Add the key to the ContactDetails widget
                                KeyedSubtree(
                                    key: controller.contactKey,
                                    child: ContactDetails(contact: details.contact!)
                                ),

                                // Location Details
                                const SizedBox(height: 8),
                                Container(
                                    margin: const EdgeInsets.symmetric(horizontal: 20.0),
                                    child: Text("Location Details",
                                        style: context.textTheme.displaySmall
                                            ?.copyWith(color: AppColors.textSecondary))
                                ),
                                const SizedBox(height: 8),
                                LocationDetails(address: details.address, nearbyPlaces: details.nearbyPlaces)
                            ]
                        )
                    );
                }
            ),

            bottomSheet: Obx(()
                {
                    final contact = controller.details?.data?.contact;
                    if (contact == null || !controller.showFloatingContact.value)
                    {
                        return const SizedBox.shrink();
                    }
                    return AnimatedSwitcher(
                        duration: const Duration(milliseconds: 300),
                        transitionBuilder: (child, animation) => SizeTransition(
                            sizeFactor: animation,
                            child: child
                        ),
                        child: ContactBottomBar(contact: contact)
                    );
                }
            )

        );
    }
}
