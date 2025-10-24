import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prop_mize/app/core/themes/app_colors.dart';

import '../controllers/dashboard_controller.dart';

class DashboardView extends GetView<DashboardController>
{
    const DashboardView({super.key});

    @override
    Widget build(BuildContext context) 
    {
        return Scaffold(
            body: Obx(() {
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
                        _buildTopProperties(),
                        const SizedBox(height: 24),

                        // Quick Actions
                        _buildQuickActions()
                    ]
                );
              }
            )
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
                ),

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
        return GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 1.2,
            children: [
                _buildStatCard(
                    title: "Total Listing",
                    value: "24",
                    icon: Icons.list_alt,
                    color: Colors.blue
                ),
                _buildStatCard(
                    title: "Total Views",
                    value: "1.2K",
                    icon: Icons.remove_red_eye,
                    color: Colors.green
                ),
                _buildStatCard(
                    title: "Inquiries",
                    value: "48",
                    icon: Icons.chat_bubble_outline,
                    color: Colors.orange
                ),
                _buildStatCard(
                    title: "Revenue",
                    value: "₹2.4L",
                    icon: Icons.currency_rupee,
                    color: Colors.purple
                )
            ]
        );
    }

    Widget _buildStatCard({
        required String title,
        required String value,
        required IconData icon,
        required Color color
    }) 
    {
        return Card(
            elevation: 2,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                        Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                color: color.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(12)
                            ),
                            child: Icon(icon, color: color, size: 20)
                        ),
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                                Text(
                                    value,
                                    style: const TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.w700
                                    )
                                ),
                                const SizedBox(height: 4),
                                Text(
                                    title,
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey[600]
                                    )
                                )
                            ]
                        )
                    ]
                )
            )
        );
    }

    Widget _buildRecentInquiries() 
    {
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
                                    "Recent Inquiries",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600
                                    )
                                ),
                                TextButton(
                                    onPressed: ()
                                    {
                                        // Navigate to all inquiries
                                    },
                                    child: Text(
                                        "View All",
                                        style: TextStyle(color: AppColors.primary)
                                    )
                                )
                            ]
                        ),
                        const SizedBox(height: 12),
                        _buildInquiryItem(
                            image: "https://picsum.photos/id/233/200/300",
                            propertyName: "3BHK Luxury Apartment",
                            buyerName: "Rahul Sharma",
                            date: "2 hours ago",
                            status: "New",
                            statusColor: Colors.orange
                        ),
                        _buildInquiryItem(
                            image: "https://picsum.photos/id/235/200/300",
                            propertyName: "2BHK in HSR Layout",
                            buyerName: "Priya Singh",
                            date: "1 day ago",
                            status: "Contacted",
                            statusColor: Colors.blue
                        ),
                        _buildInquiryItem(
                            image: "https://picsum.photos/id/237/200/300",
                            propertyName: "Villa in Koramangala",
                            buyerName: "Amit Kumar",
                            date: "2 days ago",
                            status: "Interested",
                            statusColor: Colors.green
                        )
                    ]
                )
            )
        );
    }

    Widget _buildInquiryItem({
        required String image,
        required String propertyName,
        required String buyerName,
        required String date,
        required String status,
        required Color statusColor
    }) 
    {
        return Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.grey.withValues(alpha: 0.1),
                border: Border.all(color: Colors.grey.withAlpha(100))
            ),
            child: Row(
                children: [
                    CircleAvatar(
                        radius: 20,
                        backgroundImage: NetworkImage(image)
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                                Text(
                                    propertyName,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14
                                    )
                                ),
                                Text(
                                    buyerName,
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey[600]
                                    )
                                )
                            ]
                        )
                    ),
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                            Text(
                                date,
                                style: TextStyle(
                                    fontSize: 11,
                                    color: Colors.grey[500]
                                )
                            ),
                            const SizedBox(height: 4),
                            Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                    color: statusColor.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(8)
                                ),
                                child: Text(
                                    status,
                                    style: TextStyle(
                                        fontSize: 10,
                                        color: statusColor,
                                        fontWeight: FontWeight.w600
                                    )
                                )
                            )
                        ]
                    )
                ]
            )
        );
    }

    Widget _buildTopProperties() 
    {
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
                                        // Navigate to all properties
                                    },
                                    child: Text(
                                        "View All",
                                        style: TextStyle(color: AppColors.primary)
                                    )
                                )
                            ]
                        ),
                        const SizedBox(height: 12),
                        _buildPropertyItem(
                            icon: Icons.apartment,
                            propertyName: "Skyline Residency",
                            views: "450",
                            inquiries: "23"
                        ),
                        _buildPropertyItem(
                            icon: Icons.house,
                            propertyName: "Green Valley Villa",
                            views: "380",
                            inquiries: "18"
                        ),
                        _buildPropertyItem(
                            icon: Icons.business,
                            propertyName: "Tech Park Office",
                            views: "290",
                            inquiries: "15"
                        )
                    ]
                )
            )
        );
    }

    Widget _buildPropertyItem({
        required IconData icon,
        required String propertyName,
        required String views,
        required String inquiries
    }) 
    {
        return Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.grey.withValues(alpha: 0.1),
                border: Border.all(color: Colors.grey.withAlpha(100))
            ),
            child: Row(
                children: [
                    Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            color: AppColors.primary.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12)
                        ),
                        child: Icon(icon, color: AppColors.primary, size: 20)
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                        child: Text(
                            propertyName,
                            style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 14
                            )
                        )
                    ),
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                            Row(
                                children: [
                                    Icon(Icons.remove_red_eye, size: 14, color: Colors.grey[600]),
                                    const SizedBox(width: 4),
                                    Text(
                                        "$views views",
                                        style: TextStyle(fontSize: 12, color: Colors.grey[600])
                                    )
                                ]
                            ),
                            const SizedBox(height: 4),
                            Row(
                                children: [
                                    Icon(Icons.chat_bubble_outline, size: 14, color: Colors.grey[600]),
                                    const SizedBox(width: 4),
                                    Text(
                                        "$inquiries inquiries",
                                        style: TextStyle(fontSize: 12, color: Colors.grey[600])
                                    )
                                ]
                            )
                        ]
                    )
                ]
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
                    color: AppColors.primary.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppColors.primary.withOpacity(0.2))
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
