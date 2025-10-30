import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:prop_mize/app/core/utils/communication_helper.dart';

import '../../../../../data/models/leads/lead_details_model.dart';
import '../../controllers/lead_details_controller.dart';
import 'status_update_bottom_sheet.dart';

class ContactBox extends StatelessWidget {
  final Data lead;
  const ContactBox({super.key, required this.lead});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 8.0,
      children: [
        SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton.icon(
                onPressed: () => _showStatusUpdateSheet(context),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                ),
                icon: Icon(Icons.remove_red_eye_outlined),
                label: Text("Update Lead Status")
            )
        ),
        Row(
          children: [
            Expanded(
              child: ElevatedButton.icon(
                onPressed: () {
                  CommunicationHelper.makeCall(lead.buyer!.phone!);
                },
                icon: const Icon(Icons.phone),
                label: const Text("Call"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                ),
              ),
            ),
            const SizedBox(width: 16.0),
            Expanded(
              child: ElevatedButton.icon(
                onPressed: () {
                  CommunicationHelper.openWhatsApp(lead.buyer!.phone!);
                },
                icon: const Icon(FontAwesomeIcons.whatsapp),
                label: const Text("Whatsapp"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  void _showStatusUpdateSheet(BuildContext context) {
    final controller = Get.find<LeadDetailsController>();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => StatusUpdateBottomSheet(
        currentStatus: lead.status ?? "New",
        onStatusUpdate: (newStatus) {
          controller.updateLeadStatus(newStatus);
        },
      ),
    );
  }
}
