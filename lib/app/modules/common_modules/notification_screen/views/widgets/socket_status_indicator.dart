// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:badges/badges.dart' as badges;
//
// import '../../../../../data/services/socket/socket_notification_service.dart';
//
// class SocketStatusIndicator extends StatelessWidget {
//   final SocketNotificationService socketService = Get.find<SocketNotificationService>();
//
//   SocketStatusIndicator({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Obx(() => badges.Badge(
//       badgeContent: Icon(
//         socketService.isConnected.value ? Icons.circle : Icons.circle_outlined,
//         size: 8,
//         color: socketService.isConnected.value ? Colors.green : Colors.red,
//       ),
//       showBadge: true,
//       badgeStyle: const badges.BadgeStyle(
//         badgeColor: Colors.transparent,
//         padding: EdgeInsets.zero,
//       ),
//       child: Icon(
//         Icons.notifications,
//         color: socketService.isConnected.value ? Colors.blue : Colors.grey,
//       ),
//     ));
//   }
// }