import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../data/services/socket/v1/socket_service.dart';

class SocketStatusIndicator extends StatelessWidget {
  final SocketService socketService = Get.find<SocketService>();

  SocketStatusIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: _getStatusColor(),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            _getStatusIcon(),
            size: 12,
            color: Colors.white,
          ),
          const SizedBox(width: 4),
          Text(
            _getStatusText(),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 10,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    ));
  }

  Color _getStatusColor() {
    switch (socketService.connectionStatus.value) {
      case 'connected':
        return Colors.green;
      case 'connecting':
        return Colors.orange;
      case 'error':
      case 'timeout':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  IconData _getStatusIcon() {
    switch (socketService.connectionStatus.value) {
      case 'connected':
        return Icons.circle;
      case 'connecting':
        return Icons.refresh;
      case 'error':
        return Icons.error;
      case 'timeout':
        return Icons.timer_off;
      default:
        return Icons.circle_outlined;
    }
  }

  String _getStatusText() {
    switch (socketService.connectionStatus.value) {
      case 'connected':
        return 'Live';
      case 'connecting':
        return 'Connecting';
      case 'error':
        return 'Error';
      case 'timeout':
        return 'Timeout';
      default:
        return 'Offline';
    }
  }
}