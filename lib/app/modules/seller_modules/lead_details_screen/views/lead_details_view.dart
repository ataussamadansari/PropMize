import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prop_mize/app/core/themes/app_colors.dart';
import 'package:prop_mize/app/data/models/leads/lead_details_model.dart';
import 'package:prop_mize/app/global_widgets/shimmer/shimmer_lead_details_view.dart';

import '../../../../core/utils/DateTimeHelper.dart';
import '../controllers/lead_details_controller.dart';
import 'widgets/contact_box.dart';

class LeadDetailsView extends GetView<LeadDetailsController> {
  const LeadDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(() {
          if (controller.isLoading.value || controller.leadDetails.value == null) {
            return const Text("Lead Details");
          }
          final leadName = controller.leadDetails.value!.data!.buyer!.name ?? "N/A";
          return Text("Details for $leadName");
        }),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const ShimmerLeadDetailsView();
        }

        if (controller.hasError.value) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(controller.errorMessage.value, style: const TextStyle(color: Colors.red)),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () => controller.retryFetch(),
                  child: const Text("Retry"),
                ),
              ],
            ),
          );
        }

        final lead = controller.leadDetails.value!.data!;
        return SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildInfoChips(lead),
              const SizedBox(height: 24),
              // _buildActionButtons(),
              // const SizedBox(height: 24),
              _buildBuyerInfoCard(lead),
              const SizedBox(height: 24),
              // _buildFollowUpCard(),
              // const SizedBox(height: 24),
              ContactBox(lead: lead),
              const SizedBox(height: 24),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildInfoChips(Data lead) {
    return Wrap(
      spacing: 8.0,
      children: [
        _buildChip("Status: ${lead.status!.capitalizeFirst}", Colors.purple),
        _buildChip("Priority: ${lead.priority!.capitalizeFirst}", Colors.amber.shade700),
        _buildChip("Source: ${lead.source!.capitalizeFirst}", Colors.green),
        _buildChip(
          "Created: ${DateTimeHelper.formatDate(lead.createdAt!)}",
          Colors.blueGrey,
        ),
      ],
    );
  }

  Widget _buildChip(String label, Color color) {
    return Chip(
      label: Text(label, style: const TextStyle(color: Colors.white, fontSize: 14)),
      backgroundColor: color,
      padding: const EdgeInsets.all(8.0),
      visualDensity: VisualDensity.compact,
    );
  }

  Widget _buildActionButtons() {
    return SizedBox(
      height: 50,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          OutlinedButton(
              onPressed: () {},
              child: const Text("Update Status")
          ),
          const SizedBox(width: 8),
          OutlinedButton(
              onPressed: () {},
              child: const Text("Add Follow-up")
          ),
          const SizedBox(width: 8),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary),
            child: const Text("Converted", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  Widget _buildBuyerInfoCard(Data lead) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Buyer Information", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const Divider(height: 24),
            _buildInfoRow("Name:", lead.buyer?.name ?? 'N/A'),
            _buildInfoRow("Email:", lead.buyer?.email ?? 'N/A'),
            _buildInfoRow("Phone:", lead.buyer?.phone ?? 'N/A'),
            const SizedBox(height: 12),
            _buildInfoRow("Initial Message:", lead.message ?? 'No message provided.'),
            _buildInfoRow("Contact Method:", lead.buyerContact?.contactMethod ?? 'N/A'),
          ],
        ),
      ),
    );
  }

  Widget _buildFollowUpCard() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Follow-up History", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const Divider(height: 24),
            // This is static data as per the UI image. You can replace it with a ListView.builder if you have a list of follow-ups.
            _buildInfoRow("Date:", "Oct 23, 2025 10:22"),
            _buildInfoRow("Method:", "Phone"),
            _buildInfoRow("Status:", "Scheduled"),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
          const SizedBox(width: 8),
          Expanded(child: Text(value, style: TextStyle(color: Colors.grey.shade700))),
        ],
      ),
    );
  }
}
