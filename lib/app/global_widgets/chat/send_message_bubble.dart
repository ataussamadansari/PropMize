import 'package:flutter/material.dart';
import 'package:prop_mize/app/core/themes/app_colors.dart';
import 'package:prop_mize/app/data/models/ai/message_model.dart';

import '../../core/utils/DateTimeHelper.dart';

class SendMessageBubble extends StatelessWidget {
  final ChatMessage chatMessage;

  const SendMessageBubble({
    super.key,
    required this.chatMessage,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.75,
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
          decoration: BoxDecoration(
            color: AppColors.primary, // bubble color
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(8),
              topRight: Radius.circular(0),
              bottomLeft: Radius.circular(8),
              bottomRight: Radius.circular(8),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              // 👇 message text
              Text(
                chatMessage.content ?? "...",
                style: const TextStyle(fontSize: 16, color: Colors.white),
              ),

              // 👇 time bottom right
              Text(
                DateTimeHelper.formatTime(chatMessage.timestamp ?? ""),
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
