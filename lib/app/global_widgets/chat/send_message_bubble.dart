import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prop_mize/app/core/themes/app_colors.dart';
import 'package:prop_mize/app/data/models/ai/ai_list_model/messages.dart';
import 'package:prop_mize/app/modules/buyer_modules/assistant_chat_screen/controllers/assistant_chat_controller.dart';

import '../../core/utils/DateTimeHelper.dart';

class SendMessageBubble extends GetView<AssistantChatController> {
  final Messages chatMessage;

  const SendMessageBubble({
    super.key,
    required this.chatMessage,
  });

  @override
  Widget build(BuildContext context) {

    final isLoggedIn = controller.currentUserId.value.isNotEmpty;
    final user = controller.authController.profile.value?.data;
    final avatarUrl = (isLoggedIn && (user?.avatar?.isNotEmpty ?? false))
        ? user!.avatar!
        : "https://cdn-icons-png.flaticon.com/512/847/847969.png";

    return Align(
      alignment: Alignment.topRight,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ConstrainedBox(
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
                    // style: const TextStyle(fontSize: 16, color: Colors.white),
                    style: context.textTheme.bodyMedium!.copyWith(
                      color: Colors.white
                    ),
                  ),

                  // 👇 time bottom right
                  Text(
                    DateTimeHelper.formatTime(chatMessage.timestamp ?? ""),
                    style: context.textTheme.bodySmall!.copyWith(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 4),
          CircleAvatar(
            radius: 14,
            backgroundColor: Colors.grey.withValues(alpha: 0.2),
            backgroundImage: NetworkImage(avatarUrl),
          ),
        ],
      ),
    );
  }
}
