import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class MessageCardItem extends StatelessWidget {
    final IconData? leadingData;
    final String? leadingSvg;
    final bool isSvg;
    final String title;
    final String message;
    final Color color;

    const MessageCardItem({
        super.key,
        this.leadingData,
        this.leadingSvg,
        required this.isSvg,
        required this.title,
        required this.message,
        required this.color
    });

    @override
    Widget build(BuildContext context) {
        return LayoutBuilder(
            builder: (context, constraints) {
                final isMobile = constraints.maxWidth < 600;
                final isTablet = constraints.maxWidth >= 600 && constraints.maxWidth < 1200;

                return Container(
                    padding: EdgeInsets.all(isMobile ? 12 : 16),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.grey.shade300, width: 1),
                        color: Theme.of(context).colorScheme.surface.withValues(alpha: 0.5),
                        boxShadow: [
                            BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                blurRadius: 8,
                                offset: const Offset(0, 2),
                            ),
                        ],
                    ),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                            // ✅ ICON CONTAINER
                            Container(
                                padding: EdgeInsets.all(isMobile ? 10 : 12),
                                width: isMobile ? 60 : 70,
                                height: isMobile ? 60 : 70,
                                decoration: BoxDecoration(
                                    color: color.withOpacity(0.15),
                                    shape: BoxShape.circle,
                                ),
                                child: Center(
                                    child: isSvg
                                        ? SvgPicture.asset(
                                        leadingSvg!,
                                        color: color,
                                        width: isMobile ? 25 : 30,
                                        height: isMobile ? 25 : 30,
                                    )
                                        : Icon(
                                        leadingData,
                                        color: color,
                                        size: isMobile ? 30 : 35,
                                    ),
                                ),
                            ),

                            const SizedBox(height: 12),

                            // ✅ TITLE
                            Text(
                                title,
                                style: context.textTheme.titleLarge?.copyWith(
                                    fontSize: isMobile ? 16 : 18,
                                    fontWeight: FontWeight.w600,
                                ),
                                textAlign: TextAlign.center,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                            ),

                            const SizedBox(height: 8),

                            // ✅ MESSAGE
                            Text(
                                message,
                                style: context.textTheme.bodyMedium?.copyWith(
                                    fontSize: isMobile ? 13 : 14,
                                    color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                                ),
                                textAlign: TextAlign.center,
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                            ),
                        ],
                    ),
                );
            },
        );
    }
}

/*
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class MessageCardItem extends StatelessWidget
{
    final IconData? leadingData;
    final String? leadingSvg;
    final bool isSvg;
    final String title;
    final String message;
    final Color color;

    const MessageCardItem({
        super.key,
        this.leadingData,
        this.leadingSvg,
        required this.isSvg,
        required this.title,
        required this.message,
        required this.color
    });

    @override
    Widget build(BuildContext context)
    {
        return Container(
            padding: EdgeInsets.all(12.0),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: BoxBorder.all(color: Colors.grey, width: 1)
            ),
            child: Column(
                spacing: 8,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                    Container(
                        padding: EdgeInsets.all(12.0),
                        width: 70,
                        height: 70,
                        decoration: BoxDecoration(
                            color: color.withValues(alpha:0.2),
                            shape: BoxShape.circle
                        ),
                        child: Center(child: isSvg ? SvgPicture.asset(leadingSvg!, color: color, width: 30, height: 30,) : Icon(leadingData, color: color, size: 35))
                    ),
                    Text(title, style: context.textTheme.displaySmall),
                    Text(message, style: context.textTheme.bodyMedium, textAlign: TextAlign.center)
                ]
            )
        );
    }
}
*/
