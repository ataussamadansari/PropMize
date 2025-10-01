import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prop_mize/app/core/themes/app_colors.dart';
import 'package:prop_mize/app/core/utils/DateTimeHelper.dart';
import 'package:prop_mize/app/data/models/ai/message_model.dart';
import 'package:prop_mize/app/modules/assistant_chat_screen/controllers/assistant_chat_controller.dart';

import '../chat_property_item.dart';

class ReceivedMessageBubble extends GetView<AssistantChatController>
{
    final ChatMessage chatMessage;

    const ReceivedMessageBubble({
        super.key,
        required this.chatMessage
    });

    @override
    Widget build(BuildContext context)
    {
        return Align(
            alignment: Alignment.topLeft, // 👈 left side bubble
            child: ConstrainedBox(
                constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * 0.8 // bubble width limit
                ),
                child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                    decoration: BoxDecoration(
                        color: Colors.grey.withValues(alpha: 0.1),
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(0),
                            topRight: Radius.circular(8),
                            bottomLeft: Radius.circular(8),
                            bottomRight: Radius.circular(8)
                        )
                    ),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                            // 👇 message text
                            Text(
                                chatMessage.content ?? "...",
                                // style: const TextStyle(fontSize: 16, color: Colors.black87)
                                style: context.textTheme.bodyLarge
                            ),

                            SizedBox(height: 8),

                            // 👇 Suggested Properties
                            if (chatMessage.properties != null &&
                                chatMessage.properties!.isNotEmpty) ...[
                                Text(
                                    "Suggested Properties",
                                    style: context.textTheme.labelMedium!.copyWith(
                                        color: Colors.grey.shade600,
                                        fontWeight: FontWeight.bold
                                    )
                                ),
                                const SizedBox(height: 6),

                                // 🔹 Render each property card
                                Column(
                                    children: [
                                        for (final prop in chatMessage.properties!)
                                            ChatPropertyItem(property: Property.fromJson(prop))
                                    ]
                                )
                            ],

                            if (chatMessage.suggestions != null && chatMessage.properties!.isNotEmpty) ...[
                              SizedBox(height: 8),
                              Text("Quick Replies:",
                                  style: context.textTheme.bodySmall),
                              SizedBox(height: 8),
                            ],

                            Wrap(
                                spacing: 6, // horizontal spacing
                                runSpacing: 6, // vertical spacing if it wraps
                                children: [
                                    for (var reply in chatMessage.suggestions ?? [])
                                        GestureDetector(
                                            onTap: ()
                                            {
                                                controller.messageController.text = reply;
                                            },
                                            child: Container(
                                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                                                decoration: BoxDecoration(
                                                    color: Colors.blue.withValues(alpha:0.1),
                                                    borderRadius: BorderRadius.circular(8)
                                                ),
                                                child: Text(
                                                    reply,
                                                    style: context.textTheme.labelSmall!.copyWith(color: AppColors.primary)
                                                )
                                            )
                                        )
                                ]
                            ),

                            // 👇 time bottom right
                            Align(
                                alignment: AlignmentGeometry.bottomRight,
                                child: Text(
                                    DateTimeHelper.formatTime(chatMessage.timestamp ?? ""),
                                    style: context.textTheme.bodySmall
                                )
                            )
                        ]
                    )
                )
            )
        );
    }
}
