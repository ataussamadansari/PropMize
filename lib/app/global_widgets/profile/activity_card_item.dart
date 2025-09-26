import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ActivityCardItem extends StatelessWidget
{
    final IconData icon;
    final String title;
    final String value;
    final Color color;
    const ActivityCardItem({
        super.key,
        required this.icon,
        required this.title,
        required this.value,
        required this.color
    });

    @override
    Widget build(BuildContext context) 
    {
        return Expanded(
            child: Container(
                margin: EdgeInsets.all(4.0),
                padding: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                    color: color.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(8),
                  border: BoxBorder.all(color: color.withOpacity(0.3), width: 1)
                ),
                child: Row(
                    children: [
                        Container(
                            padding: EdgeInsets.all(4.0),
                            decoration: BoxDecoration(color: color.withOpacity(0.25)
                                , borderRadius: BorderRadius.circular(12)
                            ),
                            child: Icon(icon, color: color)
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  value,
                                  style: context.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  title,
                                  style: context.textTheme.bodySmall,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ]
                          ),
                        )
                    ]
                )
            )
        );
    }
}
