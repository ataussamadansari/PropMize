import 'package:flutter/material.dart';
class TabsMenuItem extends StatelessWidget {
  final String title;
  final Color color;
  final IconData icons;
  final VoidCallback onTap;
  final bool isExpanded; // 👈 show/hide control

  const TabsMenuItem({
    super.key,
    required this.title,
    required this.color,
    required this.icons,
    required this.onTap,
    required this.isExpanded,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icons),

            // 👇 Text animation
            AnimatedSize(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              child: AnimatedOpacity(
                opacity: isExpanded ? 1 : 0,
                duration: const Duration(milliseconds: 300),
                child: isExpanded
                    ? Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                )
                    : const SizedBox.shrink(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


/*
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TabsMenuItem extends StatelessWidget {
  final String title;
  final Color color;
  final IconData icons;
  final VoidCallback onTap;
  final bool isExpanded;

  const TabsMenuItem({
    super.key,
    required this.title,
    required this.color,
    required this.icons,
    required this.onTap,
    required this.isExpanded,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 4),
        padding: EdgeInsets.symmetric(vertical: 4, horizontal: 12),
        decoration: BoxDecoration(
          color: color.withAlpha(80),
          borderRadius: BorderRadius.only(topRight: Radius.circular(12), bottomRight: Radius.circular(12))
        ),
        child: Row(
          spacing: 8,
          children: [
            Icon(icons, color: color),
            isExpanded ? Text(title, style: context.textTheme.bodyMedium?.copyWith(color: color, fontWeight: FontWeight.bold)) : SizedBox(),
          ],
        ),
      ),
    );
  }
}
*/
