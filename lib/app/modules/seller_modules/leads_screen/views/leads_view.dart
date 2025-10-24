import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/leads_controller.dart';


class LeadsView extends GetView<LeadsController> {
  const LeadsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Leads"),
      ),
    );
  }

}