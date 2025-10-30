import 'package:flutter/material.dart';

class StateCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  const StateCard({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // ✅ Left side text column
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min, // prevents overflow
                children: [
                  FittedBox(
                    fit: BoxFit.scaleDown, // scales down text if space is tight
                    child: Text(
                      value,
                      style: TextStyle(
                        fontSize: width < 380 ? 20 : 24, // responsive font
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: width < 380 ? 12 : 14,
                      color: Colors.grey[600],
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),

            // ✅ Right side icon container
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                icon,
                color: color,
                size: width < 380 ? 18 : 22,
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

class BuildStateCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;
  const BuildStateCard({super.key,
    required this.title,
    required this.value,
    required this.icon,
    required this.color});

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
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
                  ),
                  Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          color: color.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12)
                      ),
                      child: Icon(icon, color: color)
                  ),
                ]
            )
        )
    );
  }
}
*/
