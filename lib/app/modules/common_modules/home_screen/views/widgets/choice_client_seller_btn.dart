import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChoiceClientSellerBtn extends StatelessWidget {
  final IconData leadingIcon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const ChoiceClientSellerBtn({
    super.key,
    required this.leadingIcon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 600;

        return Card(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(12),
            child: Container(
              padding: EdgeInsets.all(isMobile ? 16 : 20),
              child: Row(
                children: [
                  // ✅ ICON
                  Container(
                    padding: EdgeInsets.all(isMobile ? 12 : 16),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      leadingIcon,
                      color: Theme.of(context).colorScheme.primary,
                      size: isMobile ? 24 : 28,
                    ),
                  ),

                  const SizedBox(width: 16),

                  // ✅ TEXT CONTENT
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: context.textTheme.titleLarge?.copyWith(
                            fontSize: isMobile ? 16 : 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          subtitle,
                          style: context.textTheme.bodyMedium?.copyWith(
                            fontSize: isMobile ? 13 : 14,
                            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // ✅ ARROW ICON
                  Icon(
                    Icons.arrow_forward_ios,
                    size: isMobile ? 16 : 18,
                    color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}