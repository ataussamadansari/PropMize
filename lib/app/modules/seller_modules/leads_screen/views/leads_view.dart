import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prop_mize/app/core/utils/DateTimeHelper.dart';
import 'package:prop_mize/app/data/models/leads/leads_model.dart';
import 'package:prop_mize/app/global_widgets/shimmer/shimmer_list_view.dart';

import '../controllers/leads_controller.dart';


class LeadsView extends GetView<LeadsController>
{
  const LeadsView({super.key});

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
        body: Column(
            children: [
              _buildFilterControls(context),
              Expanded(
                  child: Obx(()
                  {
                    if (controller.isLoading.value)
                    {
                      return const ShimmerListView();
                    }

                    if (controller.hasError.value && controller.filteredLeads.isEmpty)
                    {
                      return _buildErrorWidget();
                    }

                    if (controller.filteredLeads.isEmpty)
                    {
                      return const Center(
                          child: Text(
                              "No leads match your criteria.",
                              style: TextStyle(fontSize: 16, color: Colors.grey)
                          )
                      );
                    }

                    // Listen for scroll notifications to trigger loading more
                    return NotificationListener<ScrollNotification>(
                      onNotification: (ScrollNotification scrollInfo) {
                        if (!controller.isLoading.value &&
                            !controller.isLoadMore.value &&
                            scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
                          controller.loadLeadsData();
                        }
                        return true;
                      },
                      child: RefreshIndicator(
                        onRefresh: (){
                          return controller.loadLeadsData(isRefresh: true);
                        },
                        child: ListView.builder(
                            padding: const EdgeInsets.all(8.0),
                            itemCount: controller.filteredLeads.length + (controller.isLoadMore.value ? 1 : 0),
                            itemBuilder: (context, index)
                            {
                              // If it's the last item and we are loading more, show a progress indicator
                              if (index == controller.filteredLeads.length) {
                                return const Center(
                                  child: Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: CircularProgressIndicator(),
                                  ),
                                );
                              }
                              final lead = controller.filteredLeads[index];
                              return _buildLeadCard(lead);
                            }
                        ),
                      ),
                    );
                  }
                  )
              )
            ]
        )
    );
  }

  /// Builds the search bar and status filter dropdown.
  Widget _buildFilterControls(BuildContext context)
  {
    return Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
                'Seller Leads',
                style: context.textTheme.headlineLarge
            ),
            Text(
                'Manage inquiries from interested buyers.',
                style: context.textTheme.bodySmall
            ),
            SizedBox(height: 24),
            Row(
                children: [
                  Expanded(
                      child: TextField(
                          controller: controller.searchController,
                          decoration: InputDecoration(
                              hintText: 'Search leads...',
                              prefixIcon: const Icon(Icons.search, size: 20),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(color: Colors.grey.shade300)
                              ),
                              contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 12)
                          )
                      )
                  ),
                  const SizedBox(width: 10),
                  Obx(
                          () => Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: Colors.grey.shade300)
                          ),
                          child: DropdownButton<String>(
                              value: controller.selectedStatus.value,
                              underline: const SizedBox.shrink(),
                              icon: const Icon(Icons.filter_list, size: 20),
                              onChanged: (newValue) => controller.changeStatus(newValue),
                              items: controller.statusOptions.map((status)
                              {
                                return DropdownMenuItem(
                                    value: status,
                                    child: Text(status)
                                );
                              }
                              ).toList()
                          )
                      )
                  )
                ]
            ),
          ],
        )
    );
  }

  /// Builds the card widget to display individual lead information.
  Widget _buildLeadCard(Data lead)
  {
    final status = lead.status?.toLowerCase() ?? 'new';
    final statusColor = switch(status) {
      'new' => Colors.blue,
      'contacted' => Colors.orange,
      'interested' => Colors.greenAccent,
      'not-interested' => Colors.amber,
      'converted' => Colors.green,
      'lost' => Colors.red,
      'rejected' => Colors.deepOrange,
      _ => Colors.grey,
    };

    final statusText = switch(status) {
      'new' => 'New',
      'contacted' => 'Contacted',
      'interested' => 'Interested',
      'not-interested' => 'Not Interested',
      'converted' => 'Converted',
      'lost' => 'Lost',
      'rejected' => 'Rejected',
      _ => status, // default case
    };

    final statusIcon = switch(status) {
      'new' => Icons.fiber_new,
      'contacted' => Icons.phone,
      'interested' => Icons.thumb_up,
      'not-interested' => Icons.thumb_down,
      'converted' => Icons.check_circle,
      'lost' => Icons.error,
      'rejected' => Icons.cancel,
      _ => Icons.info,
    };

    return Card(
        elevation: 1.5,
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
            padding: const EdgeInsets.only(left: 12.0, right: 12.0, top: 12.0),
            child: Column(
                children: [
                  Row(
                      children: [
                        Expanded(
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                      lead.buyer!.name!,
                                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                      "Property: ${lead.property?.title ?? "N/A"}",
                                      style: TextStyle(color: Colors.grey[600]),
                                      overflow: TextOverflow.ellipsis
                                  )
                                ]
                            )
                        ),
                        Chip(
                            label: Text(
                                statusText,
                                style: const TextStyle(color: Colors.white, fontSize: 12)
                            ),
                            backgroundColor: statusColor,
                            padding: const EdgeInsets.symmetric(horizontal: 4),
                            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            visualDensity: VisualDensity.compact
                        )
                      ]
                  ),
                  const SizedBox(height: 8),
                  // const Divider(height: 1),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                            "Created: ${DateTimeHelper.formatDateMonth(lead.createdAt!)}",
                            style: const TextStyle(color: Colors.grey, fontSize: 12)
                        ),
                        TextButton(
                            onPressed: ()
                            {
                              controller.viewLeadDetails(lead.id!);
                            },
                            child: const Text("View Details")
                        ),
                      ]
                  )
                ]
            )
        )
    );
  }

  /// Builds the error widget with a retry button.
  Widget _buildErrorWidget()
  {
    return Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                  controller.errorMessage.value,
                  style: const TextStyle(color: Colors.red, fontSize: 16),
                  textAlign: TextAlign.center
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                  onPressed: () => controller.loadLeadsData(isRefresh: true),
                  child: const Text("Retry")
              )
            ]
        )
    );
  }
}


/*import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prop_mize/app/core/utils/DateTimeHelper.dart';

import '../controllers/lead_details_controller.dart';
import '../../../../data/models/leads/leads_model.dart';

class LeadsView extends GetView<LeadsController>
{
    const LeadsView({super.key});

    @override
    Widget build(BuildContext context) 
    {
        return Scaffold(
            appBar: AppBar(
                title: const Text('Seller Leads'),
                centerTitle: false,
                actions: [
                    IconButton(
                        icon: const Icon(Icons.refresh),
                        onPressed: () => controller.loadLeadsData()
                    )
                ]
            ),
            body: Column(
                children: [
                    _buildFilterControls(),
                    Expanded(
                        child: Obx(()
                            {
                                if (controller.isLoading.value) 
                                {
                                    // return const ShimmerListView();
                                    return const Center(
                                        child: CircularProgressIndicator()
                                    );
                                }

                                if (controller.hasError.value) 
                                {
                                    return _buildErrorWidget();
                                }

                                if (controller.filteredLeads.isEmpty) 
                                {
                                    return const Center(
                                        child: Text(
                                            "No leads match your criteria.",
                                            style: TextStyle(fontSize: 16, color: Colors.grey)
                                        )
                                    );
                                }

                                return ListView.builder(
                                    padding: const EdgeInsets.all(8.0),
                                    itemCount: controller.filteredLeads.length,
                                    itemBuilder: (context, index)
                                    {
                                        final lead = controller.filteredLeads[index];
                                        return _buildLeadCard(lead);
                                    }
                                );
                            }
                        )
                    )
                ]
            )
        );
    }

    /// Builds the search bar and status filter dropdown.
    Widget _buildFilterControls() 
    {
        return Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
                children: [
                    Expanded(
                        child: TextField(
                            controller: controller.searchController,
                            decoration: InputDecoration(
                                hintText: 'Search leads...',
                                prefixIcon: const Icon(Icons.search, size: 20),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: BorderSide(color: Colors.grey.shade300)
                                ),
                                contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 12)
                            )
                        )
                    ),
                    const SizedBox(width: 10),
                    Obx(
                        () => Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: Colors.grey.shade300)
                            ),
                            child: DropdownButton<String>(
                                value: controller.selectedStatus.value,
                                underline: const SizedBox.shrink(),
                                icon: const Icon(Icons.filter_list, size: 20),
                                onChanged: (newValue) => controller.changeStatus(newValue),
                                items: controller.statusOptions.map((status)
                                    {
                                        return DropdownMenuItem(
                                            value: status,
                                            child: Text(status)
                                        );
                                    }
                                ).toList()
                            )
                        )
                    )
                ]
            )
        );
    }

    /// Builds the card widget to display individual lead information.
    Widget _buildLeadCard(Data lead) 
    {
        final status = lead.status?.toLowerCase() ?? 'new';
        final statusColor = status == 'converted'
            ? Colors.green
            : (status == 'new' ? Colors.orange : Colors.deepOrange);

        return Card(
            elevation: 1.5,
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Padding(
                padding: const EdgeInsets.only(left: 12.0, right: 12.0, top: 12.0),
                child: Column(
                    children: [
                        Row(
                            children: [
                                Expanded(
                                    child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                            Text(
                                                lead.buyer!.name!,
                                                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)
                                            ),
                                            const SizedBox(height: 4),
                                            Text(
                                                "Property: ${lead.property!.title}",
                                                style: TextStyle(color: Colors.grey[600]),
                                                overflow: TextOverflow.ellipsis
                                            )
                                        ]
                                    )
                                ),
                                Chip(
                                    label: Text(
                                        lead.status!.capitalizeFirst!,
                                        style: const TextStyle(color: Colors.white, fontSize: 12)
                                    ),
                                    backgroundColor: statusColor,
                                    padding: const EdgeInsets.symmetric(horizontal: 4),
                                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                    visualDensity: VisualDensity.compact
                                )
                            ]
                        ),
                        const SizedBox(height: 8),
                        const Divider(height: 1),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                                Text(
                                    "Created: ${DateTimeHelper.formatDateMonth(lead.createdAt!)}",
                                    style: const TextStyle(color: Colors.grey, fontSize: 12)
                                ),
                                Row(
                                    children: [
                                        TextButton(
                                            onPressed: ()
                                            {
                                                // TODO: Implement View Details action
                                            },
                                            child: const Text("View Details")
                                        ),
                                        const SizedBox(width: 8),
                                        TextButton(
                                            style: TextButton.styleFrom(foregroundColor: Colors.red),
                                            onPressed: ()
                                            {
                                                // TODO: Implement Delete action
                                            },
                                            child: const Text("Delete")
                                        )
                                    ]
                                )
                            ]
                        )
                    ]
                )
            )
        );
    }

    /// Builds the error widget with a retry button.
    Widget _buildErrorWidget() 
    {
        return Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                    Text(
                        controller.errorMessage.value,
                        style: const TextStyle(color: Colors.red, fontSize: 16),
                        textAlign: TextAlign.center
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                        onPressed: () => controller.loadLeadsData(),
                        child: const Text("Retry")
                    )
                ]
            )
        );
    }
}*/

/*
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:prop_mize/app/core/utils/DateTimeHelper.dart';

import '../../../../core/themes/app_colors.dart';
import '../controllers/lead_details_controller.dart';
import '../../../../data/models/leads/leads_model.dart';

class LeadsView extends GetView<LeadsController> {
  const LeadsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Leads'),
        centerTitle: true,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          // Show a shimmer loading effect while data is being fetched
          // return const ShimmerListView();
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (controller.hasError.value) {
          // Show an error message if something went wrong
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  controller.errorMessage.value,
                  style: const TextStyle(color: Colors.red, fontSize: 16),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () => controller.loadLeadsData(),
                  child: const Text("Retry"),
                ),
              ],
            ),
          );
        }

        if (controller.leadsModel.value!.data!.isEmpty) {
          // Show a message if there are no leads
          return const Center(
            child: Text(
              "You have no leads yet.",
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
          );
        }

        // Display the list of leads
        return ListView.builder(
          padding: const EdgeInsets.all(8.0),
          itemCount: controller.leadsModel.value!.count!,
          itemBuilder: (context, index) {
            final lead = controller.leadsModel.value!.data![index];
            return _buildLeadCard(lead);
          },
        );
      }),
    );
  }

  /// Builds a card widget to display individual lead information.
  Widget _buildLeadCard(Data lead) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                // Buyer's avatar
                Container(
                  padding: EdgeInsets.all(4.0),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.primary.withValues(alpha: 0.1)
                  ),
                  child: Icon(
                      Icons.people_outline_outlined,
                      size: 32,
                      color: AppColors.primary
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Buyer's name
                      Text(
                        lead.buyer!.name!,
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      // Property title
                      Text(
                        "For: ${lead.property!.title}",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                // Status chip
                Chip(
                  label: Text(
                    lead.status!.capitalizeFirst!,
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  backgroundColor: AppColors.primary,
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                ),
              ],
            ),
            const SizedBox(height: 12),
            const Divider(),
            const SizedBox(height: 8),
            // Lead creation date and message
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Received: ${DateTimeHelper.formatDate(lead.createdAt!)}",
                  style: const TextStyle(color: Colors.grey, fontSize: 12),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              lead.message!,
              style: TextStyle(fontSize: 14, color: Colors.grey[800]),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
*/
