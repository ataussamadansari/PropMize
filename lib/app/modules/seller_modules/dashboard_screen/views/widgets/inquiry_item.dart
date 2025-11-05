import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prop_mize/app/core/themes/app_colors.dart';
import 'package:prop_mize/app/core/utils/DateTimeHelper.dart';
import 'package:prop_mize/app/data/models/seller_dashboard/seller_dashboard_model.dart';

class InquiryItem extends StatelessWidget {
  final RecentLeads recentLeads;

  const InquiryItem({
    super.key,
    required this.recentLeads,
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
                padding: EdgeInsets.all(4.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.primary.withValues(alpha: 0.1)
                ),
                child: Icon(
                    Icons.people_outline_outlined,
                    size: 32,
                    color: AppColors.primary
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                            recentLeads.property?.title ?? 'No Title',
                            style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 14
                            )
                        ),
                        Text(
                            recentLeads.buyer!.name!,
                            style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey[600]
                            )
                        ),
                        Text(
                            DateTimeHelper.formatDateMonth(recentLeads.createdAt!),
                            style: TextStyle(
                                fontSize: 11,
                                color: Colors.grey[500]
                            )
                        ),
                      ]
                  )
              ),
              Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                      color: _getStatusColor(recentLeads.status!).withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(8)
                  ),
                  child: Text(
                      recentLeads.status!.capitalizeFirst!,
                      style: TextStyle(
                          fontSize: 10,
                          color: _getStatusColor(recentLeads.status!),
                          fontWeight: FontWeight.w600
                      )
                  )
              )
            ]
        )
    );
  }

  Color _getStatusColor(String status) {
    return switch(status) {
      'new' => Colors.blue,
      'contacted' => Colors.orange,
      'interested' => Colors.greenAccent,
      'not-interested' => Colors.amber,
      'converted' => Colors.green,
      'lost' => Colors.red,
      'rejected' => Colors.deepOrange,
      _ => Colors.blue,
    };
  }
}


