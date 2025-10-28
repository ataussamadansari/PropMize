import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prop_mize/app/core/themes/app_colors.dart';
import 'package:prop_mize/app/core/utils/DateTimeHelper.dart';
import 'package:prop_mize/app/core/utils/capitalize.dart';
import 'package:prop_mize/app/core/utils/helpers.dart';
import 'package:prop_mize/app/data/models/properties/data.dart';
import 'package:prop_mize/app/data/services/storage/current_user_id_services.dart';

import '../../../../../data/services/like/like_services.dart';
import 'card_widgets/card_not_logged.dart';
import 'card_widgets/contact_view.dart';

class PropertyCardWidget extends StatelessWidget {
  final Data property;
  final VoidCallback? onTap;
  // final int index;
  final dynamic controller;

  const PropertyCardWidget({
    super.key,
    required this.property,
    this.onTap,
    // required this.index,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final firstImage = property.images?.isNotEmpty == true ? property.images!.first : '';
    final likeService = Get.find<LikeService>();
    final userIdService = Get.find<CurrentUserIdServices>();

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: onTap ?? () => controller.navigateToPropertyDetails(property.id ?? ''),
        borderRadius: BorderRadius.circular(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Property Image
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                  ),
                  child: Image.network(
                    firstImage,
                    width: double.infinity,
                    height: 200,
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Container(
                        height: 200,
                        color: Colors.grey.shade200,
                        child: const Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    },
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        height: 200,
                        width: double.infinity,
                        color: Colors.black.withAlpha(100),
                        child: const Icon(Icons.broken_image, size: 50),
                      );
                    },
                  ),
                ),

                // Status
                Positioned(
                  left: 8,
                  top: 8,
                  child: Row(
                    children: [
                      // Status
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: _getStatusColor(property.status ?? ''),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          property.status ?? 'Unknown',
                          style: const TextStyle(
                            fontSize: 10,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),

                      const SizedBox(width: 4),

                      // Premium Badge
                      if (property.premium == true)
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Text(
                            'PREMIUM',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),

                // Like-Dislike - FIXED: Use the property passed to widget
                Positioned(
                  right: 8,
                  top: 8,
                  child: Obx(() {
                    // FIX: Use the property passed to the widget, don't try to get from controller
                    final isLiked = likeService.isLiked(property.id!);
                    return IconButton(
                      onPressed: () => likeService.toggleLike(property),
                      style: IconButton.styleFrom(
                        backgroundColor: Colors.grey.withOpacity(0.7), // FIX: withOpacity
                        elevation: 2,
                      ),
                      icon: Icon(
                        isLiked ? Icons.favorite : Icons.favorite_border,
                        color: isLiked ? Colors.red : Colors.black,
                      ),
                    );
                  }),
                ),

                // Featured Badge
                if (property.featured == true)
                  Positioned(
                    bottom: 8,
                    right: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.orange,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Text(
                        'FEATURED',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),

                // Price Tag
                Positioned(
                  bottom: 8,
                  left: 8,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.7), // FIX: withOpacity
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      '${AppHelpers.formatCurrency(property.price ?? 0)} ${property.currency ?? 'INR'}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            // Property Details
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  Text(
                    property.title ?? 'No Title',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),

                  const SizedBox(height: 4),

                  // Location
                  Row(
                    children: [
                      const Icon(Icons.location_on, size: 14, color: Colors.grey),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          '${property.address?.area ?? ''}, ${property.address?.city ?? ''}',
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 8),

                  // Property Features
                  Row(
                    children: [
                      _buildFeatureItem('${property.bedrooms ?? 0} Beds', Icons.bed),
                      _buildFeatureItem('${property.bathrooms ?? 0} Baths', Icons.bathtub),
                      _buildFeatureItem('${property.balconies ?? 0} Balcony', Icons.balcony),
                      if (property.area != null)
                        _buildFeatureItem(
                          '${property.area!.value} ${property.area!.unit}',
                          Icons.aspect_ratio,
                        ),
                    ],
                  ),

                  const SizedBox(height: 8),

                  // Property Type & Listing Type and DateTime
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: AppColors.primary.withOpacity(0.1), // FIX: withOpacity
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          capitalize(property.propertyType ?? 'Unknown'),
                          style: TextStyle(
                            fontSize: 10,
                            color: AppColors.primary,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),

                      const SizedBox(width: 4),

                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: AppColors.primary.withOpacity(0.1), // FIX: withOpacity
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          capitalize(property.listingType ?? 'Unknown'),
                          style: TextStyle(
                            fontSize: 10,
                            color: AppColors.primary,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),

                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Icon(CupertinoIcons.calendar, size: 16),
                            SizedBox(width: 4),
                            Text(
                              DateTimeHelper.formatDateMonth(property.createdAt!),
                              style: context.textTheme.bodySmall,
                            ),
                            const SizedBox(width: 8),
                            Icon(CupertinoIcons.eye, size: 16),
                            SizedBox(width: 4),
                            Text(
                              '${property.views}',
                              style: context.textTheme.bodySmall,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 8),

                  // Contact
                  Obx(() {
                    return userIdService.userId.value == null
                        ? CardNotLogged()
                        : ContactView(contact: property.contact!, property: property);
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureItem(String text, IconData icon) {
    return Expanded(
      child: Row(
        children: [
          Icon(icon, size: 14, color: Colors.grey),
          const SizedBox(width: 4),
          Text(
            text,
            style: const TextStyle(fontSize: 12, color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'active':
        return Colors.green;
      case 'sold':
        return Colors.red;
      case 'rented':
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }
}