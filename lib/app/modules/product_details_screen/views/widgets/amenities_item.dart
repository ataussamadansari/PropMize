import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AmenitiesItem extends StatelessWidget {
  final List<String>? amenities;
  const AmenitiesItem({super.key, required this.amenities});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final itemWidth = (screenWidth - 70) / 2;

    return Container(
      padding: const EdgeInsets.all(12.0),
      margin: const EdgeInsets.symmetric(horizontal: 16.0),
      decoration: BoxDecoration(
        border: Border.all(color: context.theme.colorScheme.surfaceContainerHighest, width: 1),
        borderRadius: BorderRadius.circular(8.0),
        color: context.theme.cardColor,
      ),
      child: Wrap(
        spacing: 12, // horizontal spacing
        runSpacing: 12, // vertical spacing
        children: amenities!.map((amenity) {
          return SizedBox(
            width: itemWidth, // item width
            child: AmenitiesSubItem(title: amenity, icon: CupertinoIcons.star),
          );
        }).toList(),
      ),
    );
  }
}

class AmenitiesSubItem extends StatelessWidget {
  final String? title;
  final IconData? icon;
  const AmenitiesSubItem({super.key, this.title, this.icon});

  // Helper to convert text to "identifier-like" string
  String get iconName {
    if (title == null) return '';
    return title!.toLowerCase().replaceAll(' ', '_');
  }

  @override
  Widget build(BuildContext context) {
    IconData displayIcon = icon ?? CupertinoIcons.star; // default icon

    // Optionally, map certain text to icons manually
    final iconMapping = <String, IconData>{
      'swimming_pool': Icons.pool,
      'wifi': Icons.wifi,
      'parking': Icons.local_parking,
      'gym': Icons.fitness_center,
      'cctv': CupertinoIcons.video_camera,
      'security': Icons.security,
      'fire_safety': Icons.fire_truck,
      'sports_facility': CupertinoIcons.sportscourt,
      'children\'s_play_area': CupertinoIcons.sportscourt,
    };

    if (iconMapping.containsKey(iconName)) {
      displayIcon = iconMapping[iconName]!;
    }

    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        border: Border.all(color: context.theme.colorScheme.surfaceContainerHighest, width: 1),
        borderRadius: BorderRadius.circular(8.0),
        color: context.theme.cardColor,
      ),
      child: Row(
        children: [
          Icon(displayIcon, size: 32, color: Colors.blue),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              title ?? "",
              style: context.textTheme.bodyMedium,
            ),
          ),
        ],
      ),
    );
  }
}


/*class AmenitiesSubItem extends StatelessWidget {
  final String? title;
  final IconData? icon;
  const AmenitiesSubItem({super.key, this.title, this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        border: Border.all(color: context.theme.colorScheme.surfaceContainerHighest, width: 1),
        borderRadius: BorderRadius.circular(8.0),
        color: context.theme.cardColor,
      ),
      child: Row(
        children: [
          Icon(icon ?? CupertinoIcons.star, size: 32, color: Colors.blue),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              title ?? "",
              style: context.textTheme.bodyMedium,
            ),
          ),
        ],
      ),
    );
  }
}*/



/*
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AmenitiesItem extends StatelessWidget
{
    final List<String>? amenities;
    const AmenitiesItem({super.key, required this.amenities});

    @override
    Widget build(BuildContext context)
    {
        return Container(
            padding: EdgeInsets.all(12.0),
            margin: EdgeInsets.symmetric(horizontal: 16.0),
            decoration: BoxDecoration(
                border: BoxBorder.all(color: context.theme.colorScheme.surfaceContainerHighest, width: 1),
                borderRadius: BorderRadius.circular(8.0),
                color: context.theme.cardColor
            ),
            child: Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                    for (var amenity in amenities!)
                        AmenitiesSubItem(title: amenity, icon: Icons.star)
                ]
            )
        );

    }
}

class AmenitiesSubItem extends StatelessWidget
{
    final String? title;
    final IconData? icon;
    const AmenitiesSubItem({super.key, this.title, this.icon});

    @override
    Widget build(BuildContext context)
    {
        return Container(
            padding: EdgeInsets.all(8.0),
            decoration: BoxDecoration(
                border: BoxBorder.all(color: context.theme.colorScheme.surfaceContainerHighest, width: 1),
                borderRadius: BorderRadius.circular(8.0),
                color: context.theme.cardColor
            ),
            child: Row(
                children: [
                    Icon(icon ?? Icons.home, size: 32, color: Colors.blue), 
                    Text(title!, style: context.textTheme.bodyMedium)
                ]
            )
        );
    }
}
*/
