import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prop_mize/app/modules/seller_modules/dashboard_screen/controllers/dashboard_controller.dart';

class DashboardView extends GetView<DashboardController> {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // ✅ App Bar with Profile
          SliverAppBar(
            expandedHeight: 200.0,
            floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Row(
                children: [
                  CircleAvatar(
                    radius: 18,
                    backgroundImage: NetworkImage(
                      'https://propmize.com/_next/image?url=https%3A%2F%2Flh3.googleusercontent.com%2Fa%2FACg8ocKJEQNP236NG0Key44vviPZ5pAYTkmp2OM6-hXZJKRMlKojEw%3Ds96-c&w=48&q=75',
                    ),
                  ),
                  SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Hello, John!',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        'Welcome back',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              background: Image.network(
                'https://propmize.com/_next/image?url=https%3A%2F%2Flh3.googleusercontent.com%2Fa%2FACg8ocKJEQNP236NG0Key44vviPZ5pAYTkmp2OM6-hXZJKRMlKojEw%3Ds96-c&w=48&q=75',
                fit: BoxFit.cover,
              ),
            ),
            actions: [
              IconButton(
                icon: Icon(Icons.notifications_none, color: Colors.white),
                onPressed: () {
                  // Navigate to notifications
                },
              ),
            ],
          ),

          // ✅ Stats Cards Section
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Dashboard Overview',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 16),
                  GridView.count(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    crossAxisCount: 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 1.2,
                    children: [
                      _buildStatCard(
                        title: 'Total Listings',
                        value: '24',
                        icon: Icons.list_alt,
                        percentage: '+12%',
                        color: Colors.blue,
                      ),
                      _buildStatCard(
                        title: 'Total Views',
                        value: '1.2K',
                        icon: Icons.remove_red_eye,
                        percentage: '+8%',
                        color: Colors.green,
                      ),
                      _buildStatCard(
                        title: 'Inquiries',
                        value: '18',
                        icon: Icons.chat_bubble_outline,
                        percentage: '+5%',
                        color: Colors.orange,
                      ),
                      _buildStatCard(
                        title: 'Revenue',
                        value: '₹2.4L',
                        icon: Icons.currency_rupee,
                        percentage: '+15%',
                        color: Colors.purple,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // ✅ Recent Inquiries Section
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Recent Inquiries',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      // View all inquiries
                    },
                    child: Text('View All'),
                  ),
                ],
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
                  (context, index) {
                return _buildInquiryItem(index);
              },
              childCount: 3, // Show only 3 recent inquiries
            ),
          ),

          // ✅ Top Properties Section
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Top Performing Properties',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      // View all properties
                    },
                    child: Text('View All'),
                  ),
                ],
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
                  (context, index) {
                return _buildPropertyItem(index);
              },
              childCount: 2, // Show only 2 top properties
            ),
          ),

          // ✅ Quick Actions Section
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Quick Actions',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 12),
                  _buildQuickActionCard(
                    icon: Icons.add_circle_outline,
                    title: 'Add New Property',
                    description: 'List your property for sale or rent',
                    onTap: () {
                      // Add property logic
                    },
                  ),
                  SizedBox(height: 12),
                  _buildQuickActionCard(
                    icon: Icons.workspace_premium,
                    title: 'Upgrade to Premium',
                    description: 'Get premium features and more visibility',
                    onTap: () {
                      // Upgrade logic
                    },
                  ),
                  SizedBox(height: 12),
                  _buildQuickActionCard(
                    icon: Icons.analytics_outlined,
                    title: 'View Analytics',
                    description: 'Check detailed performance reports',
                    onTap: () {
                      // Analytics logic
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ✅ Stat Card Widget
  Widget _buildStatCard({
    required String title,
    required String value,
    required IconData icon,
    required String percentage,
    required Color color,
  }) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(icon, color: color, size: 20),
                ),
                Text(
                  percentage,
                  style: TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
            SizedBox(height: 12),
            Text(
              value,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            SizedBox(height: 4),
            Text(
              title,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ✅ Inquiry Item Widget
  Widget _buildInquiryItem(int index) {
    final inquiries = [
      {'name': 'Raj Sharma', 'property': '3BHK Apartment', 'time': '2 hours ago'},
      {'name': 'Priya Patel', 'property': '2BHK Flat', 'time': '5 hours ago'},
      {'name': 'Amit Kumar', 'property': 'Villa', 'time': '1 day ago'},
    ];

    final inquiry = inquiries[index];

    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.blue[100],
          child: Text(inquiry['name']![0]),
        ),
        title: Text(inquiry['name']!),
        subtitle: Text(inquiry['property']!),
        trailing: Text(
          inquiry['time']!,
          style: TextStyle(fontSize: 12, color: Colors.grey),
        ),
        onTap: () {
          // Handle inquiry tap
        },
      ),
    );
  }

  // ✅ Property Item Widget
  Widget _buildPropertyItem(int index) {
    final properties = [
      {'name': 'Luxury Villa', 'location': 'Mumbai', 'views': '450', 'price': '₹2.5Cr'},
      {'name': '3BHK Apartment', 'location': 'Delhi', 'views': '320', 'price': '₹1.2Cr'},
    ];

    final property = properties[index];

    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: ListTile(
        leading: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.grey[200],
          ),
          child: Icon(Icons.home_work_outlined, color: Colors.grey[600]),
        ),
        title: Text(property['name']!),
        subtitle: Text(property['location']!),
        trailing: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              property['price']!,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              '${property['views']} views',
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
        onTap: () {
          // Handle property tap
        },
      ),
    );
  }

  // ✅ Quick Action Card Widget
  Widget _buildQuickActionCard({
    required IconData icon,
    required String title,
    required String description,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 2,
      child: ListTile(
        leading: Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.blue.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: Colors.blue, size: 24),
        ),
        title: Text(
          title,
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        subtitle: Text(description),
        trailing: Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
      ),
    );
  }
}