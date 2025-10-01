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
