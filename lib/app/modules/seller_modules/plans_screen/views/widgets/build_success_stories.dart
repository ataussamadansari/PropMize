import 'package:flutter/material.dart';

class BuildSuccessStories extends StatelessWidget {
  const BuildSuccessStories({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text('Success Stories', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        _buildStoryItem(
          icon: Icons.person,
          iconColor: Colors.green,
          title: "Increased Sales",
          description: "Our sales increased by 40% after upgrading to the Premium plan.",
        ),
        const SizedBox(height: 16),
        _buildStoryItem(
          icon: Icons.groups,
          iconColor: Colors.blue,
          title: "Better Lead Management",
          description: "We can now handle incoming leads much more efficiently.",
        ),
        const SizedBox(height: 16),
        _buildStoryItem(
          icon: Icons.home_work,
          iconColor: Colors.purple,
          title: "Wider Reach",
          description: "The enterprise features helped us expand our reach to a national level.",
        ),
      ],
    );
  }

  Widget _buildStoryItem({required IconData icon, required Color iconColor, required String title, required String description}) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: iconColor.withValues(alpha: 0.1),
        foregroundColor: iconColor,
        child: Icon(icon),
      ),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(description, style: TextStyle(color: Colors.grey[600])),
    );
  }
}
