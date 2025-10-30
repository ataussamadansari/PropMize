/*import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InspectionTips extends StatefulWidget {
  const InspectionTips({super.key});

  @override
  State<InspectionTips> createState() => _InspectionTipsState();
}

class _InspectionTipsState extends State<InspectionTips> {
  int? _expandedIndex;

  final List<Map<String, dynamic>> tips = [
    {
      'title': 'Construction Quality',
      'details': 'Bricks, cement quality, plastering check karein. Walls mein cracks ya dampness toh nahi hai. Construction material ka quality inspect karein.',
      'icon': Icons.construction,
      'color': Colors.orange,
    },
    {
      'title': 'Plumbing & Electrical',
      'details': 'Water pressure, drainage, wiring inspection karein. All taps, pipes, switches aur sockets properly work kar rahe hain ya nahi check karein.',
      'icon': Icons.plumbing,
      'color': Colors.blue,
    },
    {
      'title': 'Natural Light & Ventilation',
      'details': 'Har room mein proper light aur air flow dekhein. Windows ka size aur position sufficient natural light provide kar raha hai ya nahi.',
      'icon': Icons.light_mode,
      'color': Colors.green,
    },
    {
      'title': 'Neighborhood',
      'details': 'Surrounding area, neighbors, security check karein. Nearby facilities like hospitals, schools, markets ki availability verify karein.',
      'icon': Icons.location_city,
      'color': Colors.purple,
    },
    {
      'title': 'Flooring & Tiles',
      'details': 'Tiles fitting, cracks, flooring quality inspect karein. Floor level check karein aur tiles ke beech gaps ya uneven surfaces dekhein.',
      'icon': Icons.square_foot,
      'color': Colors.red,
    },
    {
      'title': 'Windows & Doors',
      'details': 'Proper fitting, locks, and finishing check karein. All windows and doors smoothly open-close ho rahe hain ya nahi test karein.',
      'icon': Icons.door_back_door,
      'color': Colors.teal,
    },
  ];

  void _toggleExpansion(int index) {
    setState(() {
      if (_expandedIndex == index) {
        _expandedIndex = null; // Collapse if same card is clicked
      } else {
        _expandedIndex = index; // Expand the clicked card
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
      child: Column(
        children: [
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: List.generate(tips.length, (index) {
              final isExpanded = _expandedIndex == index;

              return AnimatedContainer(
                duration: const Duration(milliseconds: 400),
                curve: Curves.easeInOut,
                width: isExpanded ? Get.width : (Get.width - 44) / 2,
                child: InspectionTipCard(
                  tip: tips[index],
                  isExpanded: isExpanded,
                  onTap: () => _toggleExpansion(index),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}

class InspectionTipCard extends StatelessWidget {
  final Map<String, dynamic> tip;
  final bool isExpanded;
  final VoidCallback onTap;

  const InspectionTipCard({
    super.key,
    required this.tip,
    required this.isExpanded,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
      margin: EdgeInsets.symmetric(
        horizontal: isExpanded ? 0 : 0,
        vertical: isExpanded ? 4 : 0,
      ),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: (tip['color'] as Color).withOpacity(0.0),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isExpanded
              ? (tip['color'] as Color).withOpacity(0.6)
              : (tip['color'] as Color).withOpacity(0.3),
          width: isExpanded ? 2.5 : 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(isExpanded ? 0.3 : 0.2),
            blurRadius: isExpanded ? 16 : 8,
            spreadRadius: isExpanded ? 0.5 : 0,
            offset: Offset(0, isExpanded ? 6 : 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Row with Icon, Title and Expand Icon
              Row(
                children: [
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: tip['color'] as Color,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: AnimatedScale(
                      duration: const Duration(milliseconds: 300),
                      scale: isExpanded ? 1.2 : 1.0,
                      child: Icon(
                        tip['icon'] as IconData,
                        size: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: AnimatedDefaultTextStyle(
                      duration: const Duration(milliseconds: 300),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: (tip['color'] as Color).withOpacity(0.9),
                        fontSize: isExpanded ? 18 : 14,
                        height: 1.2,
                      ),
                      child: Text(
                        tip['title'],
                        maxLines: isExpanded ? 3 : 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  AnimatedRotation(
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeInOutBack,
                    turns: isExpanded ? 0.5 : 0,
                    child: Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 16,
                      color: (tip['color'] as Color).withOpacity(0.7),
                    ),
                  ),
                ],
              ),

              AnimatedSize(
                duration: const Duration(milliseconds: 400),
                curve: Curves.easeInOut,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 12),

                    // Details - Show more text when expanded
                    AnimatedCrossFade(
                      duration: const Duration(milliseconds: 400),
                      crossFadeState: isExpanded
                          ? CrossFadeState.showSecond
                          : CrossFadeState.showFirst,
                      firstChild: Text(
                        tip['details'],
                        style: TextStyle(
                          color: Colors.grey.shade700,
                          fontSize: 12,
                          height: 1.4,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      secondChild: Text(
                        tip['details'],
                        style: TextStyle(
                          color: Colors.grey.shade700,
                          fontSize: 14,
                          height: 1.6,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Additional info when expanded
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 400),
                transitionBuilder: (Widget child, Animation<double> animation) {
                  return SizeTransition(
                    sizeFactor: animation,
                    axisAlignment: -1.0,
                    child: FadeTransition(
                      opacity: animation,
                      child: child,
                    ),
                  );
                },
                child: isExpanded
                    ? Column(
                  children: [
                    const SizedBox(height: 16),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: (tip['color'] as Color).withOpacity(0.05),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: (tip['color'] as Color).withOpacity(0.2),
                        ),
                      ),
                      child: Row(
                        children: [
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: (tip['color'] as Color),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.lightbulb_outline_rounded,
                              size: 16,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: AnimatedDefaultTextStyle(
                              duration: const Duration(milliseconds: 300),
                              style: TextStyle(
                                color: Colors.grey.shade700,
                                fontSize: 13,
                                fontStyle: FontStyle.italic,
                                height: 1.4,
                              ),
                              child: Text(
                                _getAdditionalTip(tip['title']),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                )
                    : const SizedBox.shrink(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _getAdditionalTip(String title) {
    switch (title) {
      case 'Construction Quality':
        return 'Professional inspector se structural audit karayein for best results';
      case 'Plumbing & Electrical':
        return 'Water leakage test aur electrical load testing zaroor karayein';
      case 'Natural Light & Ventilation':
        return 'Different times par visit karke light conditions check karein';
      case 'Neighborhood':
        return 'Morning aur evening dono time par area visit karein';
      case 'Flooring & Tiles':
        return 'Heavy objects drop karke flooring strength test karein';
      case 'Windows & Doors':
        return 'Rainy season mein water leakage check karein';
      default:
        return 'Professional inspection recommend kiya jata hai';
    }
  }
}*/

// =================
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InspectionTips extends StatefulWidget {
  const InspectionTips({super.key});

  @override
  State<InspectionTips> createState() => _InspectionTipsState();
}

class _InspectionTipsState extends State<InspectionTips> {
  int? _expandedIndex;

  final List<Map<String, dynamic>> tips = [
    {
      'title': 'Construction Quality',
      'details': 'Bricks, cement quality, plastering check karein. Walls mein cracks ya dampness toh nahi hai. Construction material ka quality inspect karein.',
      'icon': Icons.construction,
      'color': Colors.orange,
    },
    {
      'title': 'Plumbing & Electrical',
      'details': 'Water pressure, drainage, wiring inspection karein. All taps, pipes, switches aur sockets properly work kar rahe hain ya nahi check karein.',
      'icon': Icons.plumbing,
      'color': Colors.blue,
    },
    {
      'title': 'Natural Light & Ventilation',
      'details': 'Har room mein proper light aur air flow dekhein. Windows ka size aur position sufficient natural light provide kar raha hai ya nahi.',
      'icon': Icons.light_mode,
      'color': Colors.green,
    },
    {
      'title': 'Neighborhood',
      'details': 'Surrounding area, neighbors, security check karein. Nearby facilities like hospitals, schools, markets ki availability verify karein.',
      'icon': Icons.location_city,
      'color': Colors.purple,
    },
    {
      'title': 'Flooring & Tiles',
      'details': 'Tiles fitting, cracks, flooring quality inspect karein. Floor level check karein aur tiles ke beech gaps ya uneven surfaces dekhein.',
      'icon': Icons.square_foot,
      'color': Colors.red,
    },
    {
      'title': 'Windows & Doors',
      'details': 'Proper fitting, locks, and finishing check karein. All windows and doors smoothly open-close ho rahe hain ya nahi test karein.',
      'icon': Icons.door_back_door,
      'color': Colors.teal,
    },
  ];

  void _toggleExpansion(int index) {
    setState(() {
      if (_expandedIndex == index) {
        _expandedIndex = null; // Collapse if same card is clicked
      } else {
        _expandedIndex = index; // Expand the clicked card
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: List.generate(tips.length, (index) {
            final isExpanded = _expandedIndex == index;

            return SizedBox(
              width: isExpanded ? Get.width : (Get.width - 44) / 2,
              child: InspectionTipCard(
                tip: tips[index],
                isExpanded: isExpanded,
                onTap: () => _toggleExpansion(index),
              ),
            );
          }),
        ),
      ],
    );
  }
}

class InspectionTipCard extends StatelessWidget {
  final Map<String, dynamic> tip;
  final bool isExpanded;
  final VoidCallback onTap;

  const InspectionTipCard({
    super.key,
    required this.tip,
    required this.isExpanded,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: (tip['color'] as Color).withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isExpanded
              ? (tip['color'] as Color).withOpacity(0.6)
              : (tip['color'] as Color).withOpacity(0.1),
          width: isExpanded ? 2 : 1,
        ),
        /*boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(isExpanded ? 0.3 : 0.2),
            blurRadius: isExpanded ? 12 : 8,
            offset: Offset(0, isExpanded ? 4 : 2),
          ),
        ],*/
      ),
      child: Material(
        color: Colors.transparent,
        child: GestureDetector(
          onTap: onTap,
          // borderRadius: BorderRadius.circular(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Row with Icon, Title and Expand Icon
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: tip['color'] as Color,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      tip['icon'] as IconData,
                      size: 20,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      tip['title'],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: (tip['color'] as Color).withOpacity(0.9),
                        fontSize: isExpanded ? 16 : 14,
                      ),
                      maxLines: isExpanded ? 3 : 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  AnimatedRotation(
                    duration: const Duration(milliseconds: 300),
                    turns: isExpanded ? 0.5 : 0,
                    child: Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 16,
                      color: (tip['color'] as Color).withOpacity(0.7),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              // Details - Show more text when expanded
              AnimatedCrossFade(
                duration: const Duration(milliseconds: 300),
                crossFadeState: isExpanded
                    ? CrossFadeState.showSecond
                    : CrossFadeState.showFirst,
                firstChild: Text(
                  tip['details'],
                  style: TextStyle(
                    color: Colors.grey.shade500,
                    fontSize: 12,
                    height: 1.4,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                secondChild: Text(
                  tip['details'],
                  style: TextStyle(
                    color: Colors.grey.shade500,
                    fontSize: 14,
                    height: 1.5,
                  ),
                ),
              ),

              // Additional info when expanded
              if (isExpanded) ...[
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: (tip['color'] as Color).withOpacity(0.05),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: (tip['color'] as Color).withOpacity(0.2),
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.lightbulb_outline_rounded,
                        size: 16,
                        color: (tip['color'] as Color),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          _getAdditionalTip(tip['title']),
                          style: TextStyle(
                            color: Colors.grey.shade700,
                            fontSize: 12,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  String _getAdditionalTip(String title) {
    switch (title) {
      case 'Construction Quality':
        return 'Professional inspector se structural audit karayein for best results';
      case 'Plumbing & Electrical':
        return 'Water leakage test aur electrical load testing zaroor karayein';
      case 'Natural Light & Ventilation':
        return 'Different times par visit karke light conditions check karein';
      case 'Neighborhood':
        return 'Morning aur evening dono time par area visit karein';
      case 'Flooring & Tiles':
        return 'Heavy objects drop karke flooring strength test karein';
      case 'Windows & Doors':
        return 'Rainy season mein water leakage check karein';
      default:
        return 'Professional inspection recommend kiya jata hai';
    }
  }
}