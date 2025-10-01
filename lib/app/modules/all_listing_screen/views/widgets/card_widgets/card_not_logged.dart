import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/all_listing_controller.dart';

class CardNotLogged extends GetView<AllListingController> {

  const CardNotLogged({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: Colors.orange),
        borderRadius: BorderRadius.circular(8.0),
        color: Colors.orange.withAlpha(100)
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(CupertinoIcons.shield, color: Colors.orange),
          Text('Sign in to view contact details', style: TextStyle(color: Colors.orange),)
        ],
      ),
    );
  }
}

