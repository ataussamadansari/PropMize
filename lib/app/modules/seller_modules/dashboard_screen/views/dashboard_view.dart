import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prop_mize/app/core/themes/app_colors.dart';
import 'package:prop_mize/app/core/utils/number_count_helper.dart';
import 'package:prop_mize/app/global_widgets/shimmer/shimmer_dashboard_view.dart';
import 'package:prop_mize/app/modules/seller_modules/dashboard_screen/views/widgets/state_card.dart';

import '../../seller_main_screen/controllers/seller_main_controller.dart';
import '../controllers/dashboard_controller.dart';
import 'widgets/inquiry_item.dart';
import 'widgets/property_item.dart';

class DashboardView extends GetView<DashboardController>
{
    const DashboardView({super.key});

    @override
    Widget build(BuildContext context)
    {
        return RefreshIndicator(
          onRefresh: () => controller.refreshDashboard(),

          child: Scaffold(
              body: Obx(()
                  {
                      if (controller.isLoading.value)
                      {
                          return ListView(
                              children: [
                                  ShimmerDashboardView()
                              ]
                          );
                      }

                      if (controller.hasError.value)
                      {
                          return Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                  Text(
                                      controller.errorMessage.value,
                                      style: TextStyle(
                                          color: Colors.red,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500
                                      )
                                  ),
                                  const SizedBox(height: 16),
                                  ElevatedButton(
                                      onPressed: ()
                                      {
                                          controller.loadDashboardData();
                                      },
                                      child: const Text("Retry")
                                  )
                              ]
                          );
                      }

                      return ListView(
                          padding: const EdgeInsets.all(16.0),
                          children: [
                              // Welcome Header
                              _buildWelcomeHeader(),
                              const SizedBox(height: 24),

                              // Stats Cards
                              _buildStatsCards(),
                              const SizedBox(height: 24),

                              // Recent Inquiries
                              _buildRecentInquiries(),
                              const SizedBox(height: 24),

                              // Top Performing Properties
                              _buildTopProperties()
                          ]
                      );
                  }
              )
          ),
        );
    }

    Widget _buildWelcomeHeader()
    {
        return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

                Text(
                    "Hello,",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w300,
                        color: Colors.grey[600]
                    )
                ),
                Text(
                    controller.authController.profile.value?.data != null ? controller.authController.profile.value!.data!.name! : "User",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primary
                    )
                ),

                Text(
                    "Welcome back!",
                    style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w300,
                        color: Colors.grey[600]
                    )
                )

                /*Text(
                    "to Propmize",
                    style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.w700,
                        color: AppColors.primary
                    )
                )*/
            ]
        );
    }

    Widget _buildStatsCards() 
    {
        final stats = controller.sellerDashboardModel.value?.data?.stats;
        final cards = [
            StateCard(
                title: "Total Listing",
                value: NumberCountHelper.formatCount(stats?.totalProperties ?? 0),
                icon: Icons.list_alt_rounded,
                color: Colors.blue.shade700
            ),
            StateCard(
                title: "Total Views",
                value: NumberCountHelper.formatCount(stats?.totalViews ?? 0),
                icon: Icons.remove_red_eye_outlined,
                color: Colors.green.shade700
            ),
            StateCard(
                title: "Inquiries",
                value: NumberCountHelper.formatCount(stats?.totalLeads ?? 0),
                icon: Icons.chat_bubble_outline_rounded,
                color: Colors.orange.shade800
            ),
            StateCard(
                title: "Revenue",
                value: "₹${NumberCountHelper.formatCount(240000)}",
                icon: Icons.currency_rupee_rounded,
                color: Colors.purple.shade700
            )
        ];

        return GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                // Each item will have a maximum width, allowing the grid to show more columns on wider screens.
                maxCrossAxisExtent: 200.0,
                mainAxisSpacing: 12.0,
                crossAxisSpacing: 12.0,
                // Adjust aspect ratio for a slightly taller, more balanced look.
                childAspectRatio: 1.8
            ),
            itemCount: cards.length,
            itemBuilder: (context, index)
            {
                return cards[index];
            }
        );
    }

    Widget _buildRecentInquiries() 
    {
        final recentLeads = controller.sellerDashboardModel.value?.data?.recentLeads ?? [];

        return Card(
            elevation: 2,
            clipBehavior: Clip.antiAlias,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                                Text(
                                    "Recent Inquiries",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600
                                    )
                                ),
                                TextButton(
                                    onPressed: ()
                                    {
                                        Get.find<SellerMainController>().viewAllInquiries();
                                    },
                                    child: Text(
                                        "View All",
                                        style: TextStyle(color: AppColors.primary)
                                    )
                                )
                            ]
                        ),
                        const SizedBox(height: 12),
                        if (recentLeads.isEmpty) ...[
                            Text(
                                "No recent inquiries",
                                style: TextStyle(color: Colors.grey)
                            )
                        ]

                        else
                        ...recentLeads.take(5).map((lead) => InquiryItem(recentLeads: lead))
                    ]
                )
            )
        );
    }

    Widget _buildTopProperties() 
    {
        final topProperties = controller.sellerDashboardModel.value?.data?.topProperties ?? [];

        return Card(
            elevation: 2,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                                Text(
                                    "Top Performing Properties",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600
                                    )
                                ),
                                TextButton(
                                    onPressed: ()
                                    {
                                        Get.find<SellerMainController>().viewAllMyProperties();
                                    },
                                    child: Text(
                                        "View All",
                                        style: TextStyle(color: AppColors.primary)
                                    )
                                )
                            ]
                        ),
                        const SizedBox(height: 12),
                        if (topProperties.isEmpty)
                        Text(
                            "No properties data available",
                            style: TextStyle(color: Colors.grey)
                        )
                        else
                        ...topProperties
                            .where((p) => p.views!.isGreaterThan(0) && p.leads!.isGreaterThan(0))
                            .take(5)
                            .map((property) => PropertyItem(topProperties: property))
                    ]
                )
            )
        );
    }

    Widget _buildQuickActions()
    {
        return Card(
            elevation: 2,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                        Text(
                            "Quick Actions",
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600
                            )
                        ),
                        const SizedBox(height: 16),
                        GridView.count(
                            crossAxisCount: 2,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            crossAxisSpacing: 12,
                            mainAxisSpacing: 12,
                            childAspectRatio: 2.5,
                            children: [
                                _buildQuickActionItem(
                                    title: "Add Property",
                                    icon: Icons.add_circle_outline,
                                    onTap: ()
                                    {
                                        // Navigate to add property
                                    }
                                ),
                                _buildQuickActionItem(
                                    title: "My Properties",
                                    icon: Icons.apartment,
                                    onTap: ()
                                    {
                                        // Navigate to my properties
                                    }
                                ),
                                _buildQuickActionItem(
                                    title: "Leads",
                                    icon: Icons.leaderboard,
                                    onTap: ()
                                    {
                                        // Navigate to leads
                                    }
                                ),
                                _buildQuickActionItem(
                                    title: "Analytics",
                                    icon: Icons.analytics,
                                    onTap: ()
                                    {
                                        // Navigate to analytics
                                    }
                                )
                            ]
                        )
                    ]
                )
            )
        );
    }

    Widget _buildQuickActionItem({
        required String title,
        required IconData icon,
        required VoidCallback onTap
    })
    {
        return InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(12),
            child: Container(
                decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.05),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppColors.primary.withValues(alpha: 0.2))
                ),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                        Icon(icon, color: AppColors.primary, size: 18),
                        const SizedBox(width: 8),
                        Text(
                            title,
                            style: TextStyle(
                                color: AppColors.primary,
                                fontWeight: FontWeight.w600,
                                fontSize: 14
                            )
                        )
                    ]
                )
            )
        );
    }
}
