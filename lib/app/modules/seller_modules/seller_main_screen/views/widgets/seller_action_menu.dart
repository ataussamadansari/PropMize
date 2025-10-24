import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import '../../../../../routes/app_routes.dart';
import '../../controllers/seller_main_controller.dart';

class SellerActionMenu extends StatelessWidget {
  const SellerActionMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final SellerMainController controller = Get.find();

    return Container(
      padding: EdgeInsets.only(left: 16.0),
      decoration: BoxDecoration(
        color: context.theme.cardColor,
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(12))
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Premium Plan Badge
          _buildPremiumBadge(),

          // Notifications
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () => Get.toNamed(Routes.notification),
          ),

          // Menu icon for END DRAWER
          IconButton(
            icon: const Icon(FontAwesomeIcons.barsStaggered, size: 20),
            onPressed: () {
              controller.openDrawer(); // Use controller method
            },
          ),
        ],
      ),
    );
  }

  Widget _buildPremiumBadge() {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.amber,
        shape: BoxShape.circle,
      ),
      child: const Icon(FontAwesomeIcons.crown, size: 16, color: Colors.white),
    );
  }
}