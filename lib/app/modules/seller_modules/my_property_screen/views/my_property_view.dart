import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../../data/models/properties/data.dart';
import '../../../../global_widgets/shimmer/shimmer_my_property_view.dart';

import '../../seller_main_screen/controllers/seller_main_controller.dart';
import '../controllers/my_property_controller.dart';

class MyPropertyView extends GetView<MyPropertyController>
{
    const MyPropertyView({super.key});

    @override
    Widget build(BuildContext context)
    {
        return RefreshIndicator(
          onRefresh: () => controller.loadMyProperties(isRefresh: true),
          child: Scaffold(
              body: Obx(()
                  {
                      if (controller.isLoading.value && controller.properties.isEmpty)
                      {
                          return const ShimmerMyPropertyView();
                      }

                      if (controller.hasError.value && controller.properties.isEmpty)
                      {
                          return Center(
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                      Text(
                                          controller.errorMessage.value,
                                          style: const TextStyle(color: Colors.red),
                                          textAlign: TextAlign.center
                                      ),
                                      const SizedBox(height: 16),
                                      ElevatedButton(
                                          onPressed: () => controller.loadMyProperties(isRefresh: true),
                                          child: const Text("Retry")
                                      )
                                  ]
                              )
                          );
                      }

                      if (controller.properties.isEmpty)
                      {
                          return _buildEmptyState(context);
                      }

                      // Use NotificationListener to detect scroll-to-end events
                      return NotificationListener<ScrollNotification>(
                          onNotification: (notification)
                          {
                              // Check if the user has scrolled to the end of the list
                              if (notification is ScrollEndNotification &&
                                  notification.metrics.extentAfter == 0 &&
                                  !controller.isLoadMore.value &&
                                  controller.hasMore.value)
                              {
                                  // Trigger loading more properties
                                  controller.loadMyProperties();
                              }
                              // Return false to allow the notification to continue to bubble up
                              return false;
                          },
                          child: ListView.builder(
                              padding: const EdgeInsets.all(12.0),
                              itemCount: controller.properties.length + (controller.isLoadMore.value ? 1 : 0),
                              itemBuilder: (context, index)
                              {
                                  // If this is the last item, show the loading indicator
                                  if (index == controller.properties.length)
                                  {
                                      return const Center(
                                          child: Padding(
                                              padding: EdgeInsets.all(16.0),
                                              child: CircularProgressIndicator()
                                          )
                                      );
                                  }
                                  // Otherwise, build the property card
                                  final property = controller.properties[index];
                                  return _buildPropertyCard(context, property);
                              }
                          )
                      );
                  }
              )
          ),
        );
    }

    /// Builds a card to display a single property's information.
    Widget _buildPropertyCard(BuildContext context, Data property)
    {
        final currencyFormat = NumberFormat.currency(locale: 'en_IN', symbol: '₹', decimalDigits: 0);

        return GestureDetector(
            onTap: () => controller.navigateToPropertyDetails(property.id!),
            child: Card(
                elevation: 3,
                margin: const EdgeInsets.only(bottom: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                clipBehavior: Clip.antiAlias,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                        // Property Image with Status Badge
                        Stack(
                            children: [
                                CachedNetworkImage(
                                    imageUrl: property.images!.isNotEmpty ? property.images!.first : 'https://via.placeholder.com/400x200?text=No+Image',
                                    height: 180,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                    placeholder: (context, url) => Container(
                                        height: 180,
                                        color: Colors.grey[300],
                                        child: const Center(child: CircularProgressIndicator())
                                    ),
                                    errorWidget: (context, url, error) => Container(
                                        height: 180,
                                        color: Colors.grey[200],
                                        child: const Icon(Icons.broken_image, color: Colors.grey, size: 50)
                                    )
                                ),
                                Positioned(
                                    right: 6,
                                    child: Chip(
                                        label: Text(
                                            property.status?.capitalizeFirst ?? 'Unknown',
                                            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12)
                                        ),
                                        backgroundColor: property.status == "active" ? Colors.green.withValues(alpha: 0.8) : Colors.grey.withValues(alpha: 0.8),
                                        padding: const EdgeInsets.symmetric(horizontal: 4),
                                        visualDensity: VisualDensity.compact
                                    )
                                )
                            ]
                        ),

                        // Property Details
                        Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                    Text(
                                        property.title ?? 'No Title',
                                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis
                                    ),
                                    if (property.description != null && property.description!.isNotEmpty) ...[
                                        const SizedBox(height: 4),
                                        Text(
                                            property.description!,
                                            style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis
                                        )
                                    ],
                                    const SizedBox(height: 12),
                                    Row(
                                        children: [
                                            _buildInfoIcon(Icons.villa_outlined, property.propertyType?.capitalizeFirst ?? 'N/A'),
                                            const SizedBox(width: 16),
                                            _buildInfoIcon(Icons.local_offer_outlined, property.listingType?.capitalizeFirst ?? 'N/A')
                                        ]
                                    ),
                                    const SizedBox(height: 8),
                                    Row(
                                        children: [
                                            _buildInfoIcon(Icons.square_foot_outlined, '${property.area!.value?.toString() ?? 'N/A'} sqft'),
                                            const SizedBox(width: 16),
                                            _buildInfoIcon(Icons.location_on_outlined, property.address?.city ?? 'N/A')
                                        ]
                                    ),
                                    const Divider(height: 24),
                                    Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                            Text(
                                                currencyFormat.format(property.price ?? 0),
                                                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blue)
                                            ),
                                            Text(
                                                property.pricing!.priceNegotiable! ? '(Negotiable)' : '',
                                                style: TextStyle(fontSize: 12, color: Colors.grey[700])
                                            ),
                                            SizedBox(width: 8.0),
                                            Spacer(),
                                            Text(
                                                DateFormat.yMMMd().format(DateTime.parse(property.createdAt ?? DateTime.now().toIso8601String())),
                                                style: const TextStyle(fontSize: 12, color: Colors.grey)
                                            )
                                        ]
                                    )
                                ]
                            )
                        ),

                        // Action Buttons
                        Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                            child: Row(
                                children: [
                                    Expanded(
                                        child: ElevatedButton.icon(
                                            onPressed: ()
                                            {
                                                controller.gotoEditProperty(property);
                                            },
                                            icon: const Icon(Icons.edit, size: 18),
                                            label: const Text("Edit"),
                                            style: ElevatedButton.styleFrom(
                                                foregroundColor: Colors.white,
                                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))
                                            )
                                        )
                                    ),
                                    const SizedBox(width: 12),
                                    IconButton(
                                        onPressed: ()
                                        {
                                            _deleteDialog(context, property.id!);
                                        },
                                        icon: const Icon(Icons.delete_outline, color: Colors.red),
                                        style: IconButton.styleFrom(
                                            backgroundColor: Colors.red.withValues(alpha: 0.1),
                                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))
                                        )
                                    )
                                ]
                            )
                        )
                    ]
                )
            )
        );
    }

    /// Helper widget to build an icon with text for property details.
    Widget _buildInfoIcon(IconData icon, String text)
    {
        return Row(
            children: [
                Icon(icon, color: Colors.grey[600], size: 16),
                const SizedBox(width: 6),
                Text(text, style: TextStyle(fontSize: 14, color: Colors.grey[800]))
            ]
        );
    }

    void _deleteDialog(BuildContext context, String propertyId)
    {
        showCupertinoDialog(
            context: context,
            builder: (context)
            {
                return CupertinoAlertDialog(
                    title: const Text('Delete Property'),
                    content: const Text('Are you sure you want to delete this property? This action cannot be undone.'),
                    actions: [
                        CupertinoDialogAction(
                            isDestructiveAction: true,
                            child: const Text("Cancel"),
                            onPressed: ()
                            {
                                Navigator.of(context).pop();
                            }
                        ),
                        CupertinoDialogAction(
                            isDefaultAction: true,
                            onPressed: () async
                            {
                                Navigator.pop(context, controller.deleteProperty(propertyId));
                                // await controller.deleteProperty(propertyId);
                                // Navigator.of(context).pop(); // Close the dialog
                            },
                            child: const Text('Delete')
                        )
                    ]
                );
            }
        );
    }

    // Builds a visually appealing empty state widget when no properties are found.
    /*Widget _buildEmptyState(BuildContext context) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              const Text(
                "No Properties Found",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                "You haven't listed any properties yet. Tap the button below to add your first one!",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              ElevatedButton.icon(
                onPressed: () {
                  // Navigate to the add property screen
                  Get.find<SellerMainController>().gotoAddProperty();
                },
                icon: const Icon(Icons.add_home_work_outlined),
                label: const Text("Add New Property"),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }*/

    // Builds a visually appealing empty state widget when no properties are found.
    Widget _buildEmptyState(BuildContext context) 
    {
        return Container(
            // ✅ 1. Add a decoration for the background
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [
                        Theme.of(context).scaffoldBackgroundColor,
                        Colors.white,
                        Theme.of(context).primaryColor.withValues(alpha: 0.05)
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter
                )
            ),
            child: Center(
                child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                            // ✅ 2. Add a subtle shadow/glow effect to the image
                            Container(
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                        BoxShadow(
                                            color: Theme.of(context).primaryColor.withValues(alpha: 0.1),
                                            blurRadius: 50,
                                            spreadRadius: 20
                                        )
                                    ]
                                ),
                                child: Image.asset(
                                    'assets/images/property.png',
                                    height: MediaQuery.of(context).size.height * 0.25
                                )
                            ),
                            const SizedBox(height: 24),
                            const Text(
                                "No Properties Found",
                                style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold
                                ),
                                textAlign: TextAlign.center
                            ),
                            const SizedBox(height: 8),
                            Text(
                                "You haven't listed any properties yet. Tap the button below to add your first one!",
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey[600]
                                ),
                                textAlign: TextAlign.center
                            ),
                            const SizedBox(height: 32),
                            ElevatedButton.icon(
                                onPressed: ()
                                {
                                    // Navigate to the add property screen
                                    Get.find<SellerMainController>().gotoAddProperty();
                                },
                                icon: const Icon(Icons.add_home_work_outlined),
                                label: const Text("Add New Property"),
                                style: ElevatedButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                                    textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12)
                                    )
                                )
                            ),
                            const SizedBox(height: 32),
                            ElevatedButton.icon(
                                onPressed: ()
                                {
                                    controller.refreshProperties();
                                },
                                icon: const Icon(Icons.refresh),
                                label: const Text("Refresh"),
                            ),
                        ]
                    )
                )
            )
        );
    }
}

