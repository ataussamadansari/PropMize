import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prop_mize/app/modules/all_listing_screen/controllers/all_listing_controller.dart';

class AllListingAppbar extends GetView<AllListingController> implements PreferredSizeWidget {
  const AllListingAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(onPressed: (){}, icon: Icon(Icons.arrow_back_ios_new));
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
