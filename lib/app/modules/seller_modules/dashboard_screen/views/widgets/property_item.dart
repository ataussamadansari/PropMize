import 'package:flutter/material.dart';
import 'package:prop_mize/app/core/themes/app_colors.dart';
import 'package:prop_mize/app/data/models/seller_dashboard/seller_dashboard_model.dart';

class PropertyItem extends StatelessWidget {
  final TopProperties topProperties;

  const PropertyItem({
    super.key,
    required this.topProperties,
  });

  @override
  Widget build(BuildContext context) {
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
                      color: AppColors.primary.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12)
                  ),
                  child: Icon(Icons.apartment, color: AppColors.primary, size: 20)
              ),
              const SizedBox(width: 12),
              Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                          topProperties.title!,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 14
                          )
                      ),
                      Row(
                          spacing: 4,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.remove_red_eye, size: 14, color: Colors.grey[600]),
                                  const SizedBox(width: 4),
                                  Text(
                                      "${topProperties.views} views",
                                      style: TextStyle(fontSize: 12, color: Colors.grey[600])
                                  )
                                ]
                            ),
                            const SizedBox(height: 4),
                            Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.chat_bubble_outline, size: 14, color: Colors.grey[600]),
                                  const SizedBox(width: 4),
                                  Text(
                                      "${topProperties.leads} inquiries",
                                      style: TextStyle(fontSize: 12, color: Colors.grey[600])
                                  )
                                ]
                            )
                          ]
                      )
                    ],
                  )
              ),
              SizedBox(width: 8,),
              Icon(Icons.trending_up, color: Colors.green,),
            ]
        )
    );
  }
}


