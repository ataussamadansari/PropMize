import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/my_property_controller.dart';


class MyPropertyView extends GetView<MyPropertyController> {
  const MyPropertyView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("MyProperty"),
      ),
    );
  }
}