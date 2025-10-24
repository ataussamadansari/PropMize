import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/seller_main_controller.dart';
import 'widgets/seller_action_menu.dart';
import 'widgets/seller_body_content.dart';
import 'widgets/seller_bottom_nav.dart';
import 'widgets/seller_drawer.dart';

class SellerMainView extends GetView<SellerMainController>
{
    const SellerMainView({super.key});

    @override
    Widget build(BuildContext context)
    {
        return Scaffold(
            key: controller.scaffoldKey,
            endDrawer: const SellerDrawer(),
            body: SafeArea(
                child: Stack(
                    children: [
                        const SellerBodyContent(),
                        Positioned(
                            top: 0,
                            right: 0,
                            child: SellerActionMenu()
                        )
                    ]
                )
            ),
            bottomNavigationBar: const SellerBottomNav(),
            floatingActionButton: FloatingActionButton(
                onPressed: () => controller.gotoHelpSupport(),
                shape: ShapeBorder.lerp(StadiumBorder(), CircleBorder(), 1),
                child: Icon(Icons.support_agent))
        );
    }
}
