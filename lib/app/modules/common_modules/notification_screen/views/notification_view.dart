// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../../../../data/models/notification/notification_model.dart';
// import '../controllers/notification_controller.dart';
//
// class NotificationView extends StatelessWidget {
//   final NotificationController controller = Get.put(NotificationController());
//
//   NotificationView({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey[50],
//       appBar: AppBar(
//         title: Obx(() => Text(
//           'Notifications ${controller.unreadCount > 0 ? '(${controller.unreadCount})' : ''}',
//           style: const TextStyle(
//             fontWeight: FontWeight.w600,
//             fontSize: 18,
//           ),
//         )),
//         backgroundColor: Colors.white,
//         elevation: 1,
//         shadowColor: Colors.black12,
//         actions: [
//           // Mark all as read button
//           Obx(() => controller.unreadCount > 0
//               ? IconButton(
//             icon: const Icon(Icons.mark_email_read_outlined),
//             onPressed: controller.markAllAsRead,
//             tooltip: 'Mark all as read',
//           )
//               : const SizedBox.shrink()),
//
//           // Clear all button
//           PopupMenuButton<String>(
//             icon: const Icon(Icons.more_vert),
//             onSelected: (value) {
//              if (value == 'refresh') {
//                 controller.refreshNotifications();
//               }
//             },
//             itemBuilder: (BuildContext context) => [
//               const PopupMenuItem<String>(
//                 value: 'refresh',
//                 child: Row(
//                   children: [
//                     Icon(Icons.refresh, size: 20, color: Colors.blue),
//                     SizedBox(width: 8),
//                     Text('Refresh'),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//       body: _buildBody(),
//     );
//   }
//
//   Widget _buildBody() {
//     return Obx(() {
//       if (controller.isLoading.value && controller.notifications.isEmpty) {
//         return _buildLoadingState();
//       }
//
//       if (controller.notifications.isEmpty) {
//         return _buildEmptyState();
//       }
//
//       return _buildNotificationList();
//     });
//   }
//
//   Widget _buildLoadingState() {
//     return const Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           CircularProgressIndicator(),
//           SizedBox(height: 16),
//           Text(
//             'Loading notifications...',
//             style: TextStyle(
//               color: Colors.grey,
//               fontSize: 16,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildEmptyState() {
//     return Center(
//       child: Padding(
//         padding: const EdgeInsets.all(32.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(
//               Icons.notifications_off_outlined,
//               size: 80,
//               color: Colors.grey[400],
//             ),
//             const SizedBox(height: 20),
//             Text(
//               'No Notifications',
//               style: TextStyle(
//                 fontSize: 20,
//                 fontWeight: FontWeight.w600,
//                 color: Colors.grey[700],
//               ),
//             ),
//             const SizedBox(height: 12),
//             Text(
//               'You\'re all caught up! We\'ll notify you when something new arrives.',
//               textAlign: TextAlign.center,
//               style: TextStyle(
//                 fontSize: 14,
//                 color: Colors.grey[500],
//                 height: 1.4,
//               ),
//             ),
//             const SizedBox(height: 24)
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildNotificationList() {
//     return NotificationListener<ScrollNotification>(
//       onNotification: (ScrollNotification scrollInfo) {
//         if (!controller.isLoading.value &&
//             scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent &&
//             controller.hasMore.value) {
//           controller.loadMoreNotifications();
//           return true;
//         }
//         return false;
//       },
//       child: Column(
//         children: [
//           // Unread count banner
//           Obx(() => controller.unreadCount > 0
//               ? Container(
//             width: double.infinity,
//             padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//             color: Colors.blue[50],
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Icon(Icons.circle, size: 8, color: Colors.blue[700]),
//                 const SizedBox(width: 8),
//                 Text(
//                   '${controller.unreadCount} unread notification${controller.unreadCount > 1 ? 's' : ''}',
//                   style: TextStyle(
//                     color: Colors.blue[700],
//                     fontWeight: FontWeight.w500,
//                     fontSize: 14,
//                   ),
//                 ),
//                 const Spacer(),
//                 TextButton(
//                   onPressed: controller.markAllAsRead,
//                   child: Text(
//                     'MARK ALL READ',
//                     style: TextStyle(
//                       color: Colors.blue[700],
//                       fontWeight: FontWeight.w600,
//                       fontSize: 12,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           )
//               : const SizedBox.shrink()),
//
//           // Notifications list
//           Expanded(
//             child: RefreshIndicator(
//               onRefresh: () async {
//                 await controller.refreshNotifications();
//               },
//               child: ListView.separated(
//                 padding: const EdgeInsets.all(16),
//                 itemCount: controller.notifications.length + 1,
//                 separatorBuilder: (context, index) => const SizedBox(height: 8),
//                 itemBuilder: (context, index) {
//                   if (index == controller.notifications.length) {
//                     return controller.isLoading.value
//                         ? const Padding(
//                       padding: EdgeInsets.all(16.0),
//                       child: Center(
//                         child: CircularProgressIndicator(),
//                       ),
//                     )
//                         : controller.hasMore.value
//                         ? _buildLoadMoreButton()
//                         : _buildEndOfList();
//                   }
//
//                   final notification = controller.notifications[index];
//                   return _buildNotificationItem(notification);
//                 },
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildNotificationItem(Data notification) {
//     return Card(
//       elevation: 1,
//       shadowColor: Colors.black12,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(12),
//       ),
//       color: notification.read! ? Colors.white : Colors.blue[50],
//       child: InkWell(
//         onTap: () => controller.handleNotificationAction(notification),
//         borderRadius: BorderRadius.circular(12),
//         child: Padding(
//           padding: EdgeInsets.only(left: 8.0, bottom: 8.0, top: 8.0),
//           child: Row(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // Notification Icon
//               Container(
//                 width: 40,
//                 height: 40,
//                 decoration: BoxDecoration(
//                   color: _getIconColor(notification.type).withOpacity(0.1),
//                   shape: BoxShape.circle,
//                 ),
//                 child: Icon(
//                   _getNotificationIcon(notification.type),
//                   color: _getIconColor(notification.type),
//                   size: 20,
//                 ),
//               ),
//               const SizedBox(width: 12),
//
//               // Notification Content
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Row(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Expanded(
//                           child: Text(
//                             notification.title ?? 'No Title',
//                             style: TextStyle(
//                               fontWeight: notification.read!
//                                   ? FontWeight.w500
//                                   : FontWeight.w600,
//                               fontSize: 15,
//                               color: notification.read!
//                                   ? Colors.grey[800]
//                                   : Colors.black,
//                             ),
//                             maxLines: 2,
//                             overflow: TextOverflow.ellipsis,
//                           ),
//                         ),
//                         if (!notification.read!)
//                           Container(
//                             width: 8,
//                             height: 8,
//                             decoration: const BoxDecoration(
//                               color: Colors.blue,
//                               shape: BoxShape.circle,
//                             ),
//                           ),
//                       ],
//                     ),
//                     const SizedBox(height: 4),
//                     Text(
//                       notification.message ?? 'No Message',
//                       style: TextStyle(
//                         fontSize: 14,
//                         color: notification.read!
//                             ? Colors.grey[600]
//                             : Colors.grey[700],
//                         height: 1.3,
//                       ),
//                       maxLines: 3,
//                       overflow: TextOverflow.ellipsis,
//                     ),
//                     const SizedBox(height: 8),
//                     Row(
//                       children: [
//                         Icon(
//                           Icons.access_time_outlined,
//                           size: 14,
//                           color: Colors.grey[400],
//                         ),
//                         const SizedBox(width: 4),
//                         Text(
//                           _formatDate(notification.createdAt),
//                           style: TextStyle(
//                             fontSize: 12,
//                             color: Colors.grey[500],
//                           ),
//                         ),
//                         const Spacer(),
//                         if (notification.type != null)
//                           Container(
//                             padding: const EdgeInsets.symmetric(
//                               horizontal: 8,
//                               vertical: 2,
//                             ),
//                             decoration: BoxDecoration(
//                               color: _getIconColor(notification.type).withOpacity(0.1),
//                               borderRadius: BorderRadius.circular(12),
//                             ),
//                             child: Text(
//                               _formatType(notification.type!),
//                               style: TextStyle(
//                                 fontSize: 10,
//                                 color: _getIconColor(notification.type),
//                                 fontWeight: FontWeight.w500,
//                               ),
//                             ),
//                           ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//
//               // Action Menu
//               PopupMenuButton<String>(
//                 icon: Icon(
//                   Icons.more_vert_outlined,
//                   color: Colors.grey[500],
//                 ),
//                 onSelected: (value) {
//                   if (value == 'mark_read' && !notification.read!) {
//                     controller.markAsRead(notification);
//                   } else if (value == 'delete') {
//                     _showDeleteDialog(notification);
//                   }
//                 },
//                 itemBuilder: (BuildContext context) => [
//                   if (!notification.read!)
//                     PopupMenuItem<String>(
//                       value: 'mark_read',
//                       child: Row(
//                         children: [
//                           Icon(Icons.mark_email_read_outlined,
//                               size: 18, color: Colors.blue),
//                           SizedBox(width: 8),
//                           Text('Mark as read'),
//                         ],
//                       ),
//                     ),
//                   PopupMenuItem<String>(
//                     value: 'delete',
//                     child: Row(
//                       children: [
//                         Icon(Icons.delete_outline,
//                             size: 18, color: Colors.red),
//                         SizedBox(width: 8),
//                         Text('Delete'),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildLoadMoreButton() {
//     return Padding(
//       padding: const EdgeInsets.all(16.0),
//       child: ElevatedButton(
//         onPressed: controller.loadMoreNotifications,
//         style: ElevatedButton.styleFrom(
//           backgroundColor: Colors.white,
//           foregroundColor: Colors.blue,
//           elevation: 0,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(8),
//             side: BorderSide(color: Colors.blue.shade200),
//           ),
//         ),
//         child: const Text('Load More Notifications'),
//       ),
//     );
//   }
//
//   Widget _buildEndOfList() {
//     return const Padding(
//       padding: EdgeInsets.all(16.0),
//       child: Column(
//         children: [
//           Icon(Icons.check_circle_outline,
//               size: 40, color: Colors.green),
//           SizedBox(height: 8),
//           Text(
//             "You're all caught up!",
//             style: TextStyle(
//               color: Colors.grey,
//               fontWeight: FontWeight.w500,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   void _showDeleteDialog(Data notification) {
//     Get.dialog(
//       AlertDialog(
//         title: const Text('Delete Notification'),
//         content: const Text('Are you sure you want to delete this notification?'),
//         actions: [
//           TextButton(
//             onPressed: () => Get.back(),
//             child: const Text('Cancel'),
//           ),
//           TextButton(
//             onPressed: () {
//               Get.back();
//               controller.deleteNotification(notification);
//             },
//             child: const Text(
//               'Delete',
//               style: TextStyle(color: Colors.red),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   IconData _getNotificationIcon(String? type) {
//     switch (type?.toLowerCase()) {
//       case 'property':
//         return Icons.home_outlined;
//       case 'lead':
//         return Icons.leaderboard_outlined;
//       case 'chat':
//         return Icons.chat_outlined;
//       case 'alert':
//         return Icons.warning_amber_outlined;
//       case 'info':
//         return Icons.info_outlined;
//       case 'success':
//         return Icons.check_circle_outlined;
//       case 'error':
//         return Icons.error_outlined;
//       case 'payment':
//         return Icons.payment_outlined;
//       default:
//         return Icons.notifications_outlined;
//     }
//   }
//
//   Color _getIconColor(String? type) {
//     switch (type?.toLowerCase()) {
//       case 'property':
//         return Colors.green;
//       case 'lead':
//         return Colors.orange;
//       case 'chat':
//         return Colors.blue;
//       case 'alert':
//         return Colors.red;
//       case 'info':
//         return Colors.blue;
//       case 'success':
//         return Colors.green;
//       case 'error':
//         return Colors.red;
//       case 'payment':
//         return Colors.purple;
//       default:
//         return Colors.grey;
//     }
//   }
//
//   String _formatType(String type) {
//     return type.toUpperCase();
//   }
//
//   String _formatDate(String? dateString) {
//     if (dateString == null) return '';
//     try {
//       final date = DateTime.parse(dateString);
//       final now = DateTime.now();
//       final difference = now.difference(date);
//
//       if (difference.inMinutes < 1) {
//         return 'Just now';
//       } else if (difference.inHours < 1) {
//         return '${difference.inMinutes}m ago';
//       } else if (difference.inDays < 1) {
//         return '${difference.inHours}h ago';
//       } else if (difference.inDays < 7) {
//         return '${difference.inDays}d ago';
//       } else {
//         return '${date.day}/${date.month}/${date.year}';
//       }
//     } catch (e) {
//       return dateString;
//     }
//   }
// }