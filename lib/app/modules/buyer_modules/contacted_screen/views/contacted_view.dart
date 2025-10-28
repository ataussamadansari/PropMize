import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prop_mize/app/core/utils/helpers.dart';
import 'package:prop_mize/app/global_widgets/is_login_screen/not_logged_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../contacted_screen/views/widgets/shimmer_contacted_view.dart';
import '../../contacted_screen/controllers/contacted_controller.dart';

class ContactedView extends GetView<ContactedController> {
  const ContactedView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {

        // ✅ Loading state
        if (controller.isLoading.value && controller.contactedLeads.isEmpty) {
          return const ShimmerContactedView();
        }

        // ✅ Error state
        if (controller.hasError.value) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  controller.errorMessage.value, // 👈 FIXED: remove quotes!
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.red),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: controller.refreshContacted,
                  child: const Text('Retry'),
                ),
              ],
            ),
          );
        }

        if(!controller.isUserAuthenticated) {
          return NotLoggedScreen(
            heading: 'Get started',
            message: 'Keep track of all the properties you’ve contacted.',
            onPressed: () => controller.showAuthBottomSheet(),
          );
        }

        // ✅ Empty state
        if (controller.isUserAuthenticated && controller.contactedLeads.isEmpty) {
          return const Center(
            child: Text(
              'No contacted leads found',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          );
        }

        // ✅ Data list
        return RefreshIndicator(
          onRefresh: controller.refreshContacted,
          child: ListView.builder(
            padding: const EdgeInsets.only(bottom: 16.0),
            itemCount: controller.contactedLeads.length +
                (controller.hasMore.value ? 1 : 0),
            itemBuilder: (context, index) {
              if (index == controller.contactedLeads.length) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  controller.loadMore();
                });
                return const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Center(child: CircularProgressIndicator()),
                );
              }

              final lead = controller.contactedLeads[index];
              final property = lead.property;
              final seller = lead.seller;

              return Card.outlined(
                margin:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                elevation: 1,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Property row
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildPropertyImage(property),
                          const SizedBox(width: 12),
                          _buildPropertyDetails(property),
                        ],
                      ),
                      const SizedBox(height: 12),
                      if (seller != null) _buildSellerInfo(seller),
                      const SizedBox(height: 12),
                      _buildStatusRow(lead),
                      const SizedBox(height: 8),
                      if (lead.message?.isNotEmpty ?? false)
                        Text(
                          lead.message!,
                          style: const TextStyle(fontSize: 12),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      const SizedBox(height: 8),
                      Text(
                        'Contacted: ${_formatDate(lead.createdAt)}',
                        style:
                        const TextStyle(fontSize: 10, color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      }),
    );
  }

  Widget _buildPropertyImage(property) {
    if (property?.images?.isNotEmpty ?? false) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: CachedNetworkImage(
          imageUrl: property!.images!.first,
          width: 80,
          height: 80,
          fit: BoxFit.cover,
          placeholder: (_, __) => Container(
            width: 80,
            height: 80,
            color: Colors.grey[300],
            child: const Icon(Icons.home, color: Colors.grey),
          ),
          errorWidget: (_, __, ___) => Container(
            width: 80,
            height: 80,
            color: Colors.grey[300],
            child: const Icon(Icons.home, color: Colors.grey),
          ),
        ),
      );
    }
    return Container(
      width: 80,
      height: 80,
      color: Colors.grey[300],
      child: const Icon(Icons.home, color: Colors.grey),
    );
  }

  Widget _buildPropertyDetails(property) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            property?.title ?? 'No Title',
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 4),
          if (property?.price != null)
            Text(
              '₹ ${AppHelpers.formatCurrency(property!.price!)}',
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.green,
              ),
            ),
          const SizedBox(height: 4),
          Text(
            '${property?.address?.city ?? ''}, ${property?.address?.state ?? ''}',
            style: const TextStyle(fontSize: 12, color: Colors.grey),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _buildSellerInfo(seller) {
    return Row(
      children: [
        CircleAvatar(
          radius: 16,
          backgroundImage:
          seller.avatar != null ? CachedNetworkImageProvider(seller.avatar!) : null,
          child: seller.avatar == null
              ? const Icon(Icons.person, size: 16)
              : null,
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                seller.name ?? 'Unknown Seller',
                style: const TextStyle(
                    fontSize: 14, fontWeight: FontWeight.w500),
              ),
              Text(
                seller.phone ?? 'No phone',
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildStatusRow(lead) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _statusChip(lead.status?.toUpperCase() ?? 'UNKNOWN', _getStatusColor(lead.status)),
        _statusChip(lead.priority?.toUpperCase() ?? 'MEDIUM', _getPriorityColor(lead.priority)),
        if (lead.leadScore != null)
          Text('Score: ${lead.leadScore}',
              style:
              const TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
      ],
    );
  }

  Widget _statusChip(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration:
      BoxDecoration(color: color, borderRadius: BorderRadius.circular(4)),
      child: Text(text,
          style: const TextStyle(
              fontSize: 10, color: Colors.white, fontWeight: FontWeight.bold)),
    );
  }

  Color _getStatusColor(String? status) {
    switch (status?.toLowerCase()) {
      case 'new':
        return Colors.blue;
      case 'contacted':
        return Colors.orange;
      case 'converted':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  Color _getPriorityColor(String? priority) {
    switch (priority?.toLowerCase()) {
      case 'high':
        return Colors.red;
      case 'medium':
        return Colors.orange;
      case 'low':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  String _formatDate(String? dateString) {
    if (dateString == null) return 'Unknown date';
    try {
      final date = DateTime.parse(dateString);
      return '${date.day}/${date.month}/${date.year}';
    } catch (_) {
      return 'Invalid date';
    }
  }
}


/*import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prop_mize/app/core/utils/helpers.dart';
import 'package:prop_mize/app/global_widgets/is_login_screen/not_logged_screen.dart';
import '../../contacted_screen/controllers/contacted_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../contacted_screen/views/widgets/shimmer_contacted_view.dart';

class ContactedView extends GetView<ContactedController> {
  const ContactedView({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      // appBar: AppBar(
      //   elevation: 0, // Remove shadow
      //   scrolledUnderElevation: 0, // Remove elevation when scrolled
      //   title: const Text('Contacted Leads'),
      // ),
      body: Obx(() {

        // ✅ User authentication check
        if (!controller.isUserAuthenticated) {
          return NotLoggedScreen(
            heading: 'Get started',
            message: 'Keep track of all the properties you’ve contacted.',
          );
        }

        if (controller.isLoading.value && controller.contactedLeads.isEmpty) {
          return ShimmerContactedView();
        }

        if (controller.hasError.value) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'controller.errorMessage.value',
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.red),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () => controller.refresh(),
                  child: const Text('Retry'),
                ),
              ],
            ),
          );
        }

        if (controller.contactedLeads.isEmpty) {
          return const Center(
            child: Text(
              'No contacted leads found',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          );
        }

        return RefreshIndicator(
          onRefresh: () => controller.refresh(),
          child: ListView.builder(
            padding: EdgeInsets.only(bottom: 16.0),
            itemCount: controller.contactedLeads.length + (controller.hasMore.value ? 1 : 0),
            itemBuilder: (context, index) {

              // Load more indicator
              if (index == controller.contactedLeads.length) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  controller.loadMore();
                });
                return const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Center(child: CircularProgressIndicator()),
                );
              }

              final lead = controller.contactedLeads[index];
              final property = lead.property;
              final seller = lead.seller;

              return Card.outlined(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                elevation: 1,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Property Image and Basic Info
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Property Image
                          if (property?.images?.isNotEmpty ?? false)
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: CachedNetworkImage(
                                imageUrl: property!.images!.first,
                                width: 80,
                                height: 80,
                                fit: BoxFit.cover,
                                placeholder: (context, url) => Container(
                                  width: 80,
                                  height: 80,
                                  color: Colors.grey[300],
                                  child: const Icon(Icons.home, color: Colors.grey),
                                ),
                                errorWidget: (context, url, error) => Container(
                                  width: 80,
                                  height: 80,
                                  color: Colors.grey[300],
                                  child: const Icon(Icons.home, color: Colors.grey),
                                ),
                              ),
                            )
                          else
                            Container(
                              width: 80,
                              height: 80,
                              color: Colors.grey[300],
                              child: const Icon(Icons.home, color: Colors.grey),
                            ),

                          const SizedBox(width: 12),

                          // Property Details
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  property?.title ?? 'No Title',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 4),
                                if (property?.price != null)
                                  Text(
                                    '₹ ${AppHelpers.formatCurrency(property!.price!)}',
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.green,
                                    ),
                                  ),
                                const SizedBox(height: 4),
                                Text(
                                  '${property?.address?.city ?? ''}, ${property?.address?.state ?? ''}',
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 12),

                      // Seller Info
                      if (seller != null)
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 16,
                              backgroundImage: seller.avatar != null
                                  ? CachedNetworkImageProvider(seller.avatar!)
                                  : null,
                              child: seller.avatar == null
                                  ? const Icon(Icons.person, size: 16)
                                  : null,
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    seller.name ?? 'Unknown Seller',
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Text(
                                    seller.phone ?? 'No phone',
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),

                      const SizedBox(height: 12),

                      // Lead Status and Info
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: _getStatusColor(lead.status),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              lead.status?.toUpperCase() ?? 'UNKNOWN',
                              style: const TextStyle(
                                fontSize: 10,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),

                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: _getPriorityColor(lead.priority),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              lead.priority?.toUpperCase() ?? 'MEDIUM',
                              style: const TextStyle(
                                fontSize: 10,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),

                          if (lead.leadScore != null)
                            Text(
                              'Score: ${lead.leadScore}',
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                        ],
                      ),

                      const SizedBox(height: 8),

                      // Message
                      if (lead.message != null && lead.message!.isNotEmpty)
                        Text(
                          lead.message!,
                          style: const TextStyle(
                            fontSize: 12,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),

                      const SizedBox(height: 8),

                      // Date
                      Text(
                        'Contacted: ${_formatDate(lead.createdAt)}',
                        style: const TextStyle(
                          fontSize: 10,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      }),
    );
  }


  Color _getStatusColor(String? status) {
    switch (status?.toLowerCase()) {
      case 'new':
        return Colors.blue;
      case 'contacted':
        return Colors.orange;
      case 'converted':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  Color _getPriorityColor(String? priority) {
    switch (priority?.toLowerCase()) {
      case 'high':
        return Colors.red;
      case 'medium':
        return Colors.orange;
      case 'low':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  String _formatDate(String? dateString) {
    if (dateString == null) return 'Unknown date';
    try {
      final date = DateTime.parse(dateString);
      return '${date.day}/${date.month}/${date.year}';
    } catch (e) {
      return 'Invalid date';
    }
  }
}*/

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:prop_mize/app/core/utils/helpers.dart';
// import 'package:prop_mize/app/modules/contacted_screen/controllers/contacted_controller.dart';
// import 'package:cached_network_image/cached_network_image.dart';
//
// class ContactedView extends GetView<ContactedController> {
//   const ContactedView({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Contacted Leads'),
//       ),
//       body: Obx(() {
//         if (controller.isLoading.value) {
//           return const Center(child: CircularProgressIndicator());
//         }
//
//         if (controller.hasError.value) {
//           return Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text(
//                   'Error: ${controller.errorMessage.value}',
//                   textAlign: TextAlign.center,
//                   style: const TextStyle(color: Colors.red),
//                 ),
//                 const SizedBox(height: 16),
//                 ElevatedButton(
//                   onPressed: () => controller.refresh(),
//                   child: const Text('Retry'),
//                 ),
//               ],
//             ),
//           );
//         }
//
//         if (controller.contactedLeads.isEmpty) {
//           return const Center(
//             child: Text(
//               'No contacted leads found',
//               style: TextStyle(fontSize: 16, color: Colors.grey),
//             ),
//           );
//         }
//
//         return RefreshIndicator(
//           onRefresh: () => controller.refresh(),
//           child: ListView.builder(
//             itemCount: controller.contactedLeads.length + (controller.hasMore.value ? 1 : 0),
//             itemBuilder: (context, index) {
//               // Load more indicator
//               if (index == controller.contactedLeads.length) {
//                 WidgetsBinding.instance.addPostFrameCallback((_) {
//                   controller.loadMore();
//                 });
//                 return const Padding(
//                   padding: EdgeInsets.all(16.0),
//                   child: Center(child: CircularProgressIndicator()),
//                 );
//               }
//
//
//               final lead = controller.contactedLeads[index];
//               final property = lead.property;
//               final seller = lead.seller;
//
//               return Card(
//                 margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//                 child: Padding(
//                   padding: const EdgeInsets.all(16.0),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       // Property Image and Basic Info
//                       Row(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           // Property Image
//                           if (property?.images?.isNotEmpty ?? false)
//                             ClipRRect(
//                               borderRadius: BorderRadius.circular(8),
//                               child: CachedNetworkImage(
//                                 imageUrl: property!.images!.first,
//                                 width: 80,
//                                 height: 80,
//                                 fit: BoxFit.cover,
//                                 placeholder: (context, url) => Container(
//                                   width: 80,
//                                   height: 80,
//                                   color: Colors.grey[300],
//                                   child: const Icon(Icons.home, color: Colors.grey),
//                                 ),
//                                 errorWidget: (context, url, error) => Container(
//                                   width: 80,
//                                   height: 80,
//                                   color: Colors.grey[300],
//                                   child: const Icon(Icons.home, color: Colors.grey),
//                                 ),
//                               ),
//                             )
//                           else
//                             Container(
//                               width: 80,
//                               height: 80,
//                               color: Colors.grey[300],
//                               child: const Icon(Icons.home, color: Colors.grey),
//                             ),
//
//                           const SizedBox(width: 12),
//
//                           // Property Details
//                           Expanded(
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   property?.title ?? 'No Title',
//                                   style: const TextStyle(
//                                     fontSize: 16,
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                   maxLines: 2,
//                                   overflow: TextOverflow.ellipsis,
//                                 ),
//                                 const SizedBox(height: 4),
//                                 if (property?.price != null)
//                                   Text(
//                                     '₹ ${AppHelpers.formatCurrency(property!.price!)}',
//                                     style: const TextStyle(
//                                       fontSize: 14,
//                                       fontWeight: FontWeight.w600,
//                                       color: Colors.green,
//                                     ),
//                                   ),
//                                 const SizedBox(height: 4),
//                                 Text(
//                                   '${property?.address?.city ?? ''}, ${property?.address?.state ?? ''}',
//                                   style: const TextStyle(
//                                     fontSize: 12,
//                                     color: Colors.grey,
//                                   ),
//                                   maxLines: 1,
//                                   overflow: TextOverflow.ellipsis,
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//
//                       const SizedBox(height: 12),
//
//                       // Seller Info
//                       if (seller != null)
//                         Row(
//                           children: [
//                             CircleAvatar(
//                               radius: 16,
//                               backgroundImage: seller.avatar != null
//                                   ? CachedNetworkImageProvider(seller.avatar!)
//                                   : null,
//                               child: seller.avatar == null
//                                   ? const Icon(Icons.person, size: 16)
//                                   : null,
//                             ),
//                             const SizedBox(width: 8),
//                             Expanded(
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Text(
//                                     seller.name ?? 'Unknown Seller',
//                                     style: const TextStyle(
//                                       fontSize: 14,
//                                       fontWeight: FontWeight.w500,
//                                     ),
//                                   ),
//                                   Text(
//                                     seller.phone ?? 'No phone',
//                                     style: const TextStyle(
//                                       fontSize: 12,
//                                       color: Colors.grey,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//
//                       const SizedBox(height: 12),
//
//                       // Lead Status and Info
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Container(
//                             padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//                             decoration: BoxDecoration(
//                               color: _getStatusColor(lead.status),
//                               borderRadius: BorderRadius.circular(4),
//                             ),
//                             child: Text(
//                               lead.status?.toUpperCase() ?? 'UNKNOWN',
//                               style: const TextStyle(
//                                 fontSize: 10,
//                                 color: Colors.white,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                           ),
//
//                           Container(
//                             padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//                             decoration: BoxDecoration(
//                               color: _getPriorityColor(lead.priority),
//                               borderRadius: BorderRadius.circular(4),
//                             ),
//                             child: Text(
//                               lead.priority?.toUpperCase() ?? 'MEDIUM',
//                               style: const TextStyle(
//                                 fontSize: 10,
//                                 color: Colors.white,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                           ),
//
//                           if (lead.leadScore != null)
//                             Text(
//                               'Score: ${lead.leadScore}',
//                               style: const TextStyle(
//                                 fontSize: 12,
//                                 fontWeight: FontWeight.w500,
//                               ),
//                             ),
//                         ],
//                       ),
//
//                       const SizedBox(height: 8),
//
//                       // Message
//                       if (lead.message != null && lead.message!.isNotEmpty)
//                         Text(
//                           lead.message!,
//                           style: const TextStyle(
//                             fontSize: 12,
//                           ),
//                           maxLines: 2,
//                           overflow: TextOverflow.ellipsis,
//                         ),
//
//                       const SizedBox(height: 8),
//
//                       // Date
//                       Text(
//                         'Contacted: ${_formatDate(lead.createdAt)}',
//                         style: const TextStyle(
//                           fontSize: 10,
//                           color: Colors.grey,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               );
//             },
//           ),
//         );
//       }),
//     );
//   }
//
//   Color _getStatusColor(String? status) {
//     switch (status?.toLowerCase()) {
//       case 'new':
//         return Colors.blue;
//       case 'contacted':
//         return Colors.orange;
//       case 'converted':
//         return Colors.green;
//       default:
//         return Colors.grey;
//     }
//   }
//
//   Color _getPriorityColor(String? priority) {
//     switch (priority?.toLowerCase()) {
//       case 'high':
//         return Colors.red;
//       case 'medium':
//         return Colors.orange;
//       case 'low':
//         return Colors.green;
//       default:
//         return Colors.grey;
//     }
//   }
//
//   String _formatDate(String? dateString) {
//     if (dateString == null) return 'Unknown date';
//     try {
//       final date = DateTime.parse(dateString);
//       return '${date.day}/${date.month}/${date.year}';
//     } catch (e) {
//       return 'Invalid date';
//     }
//   }
// }