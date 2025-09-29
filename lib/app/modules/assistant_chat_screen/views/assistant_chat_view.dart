import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/cupertino.dart';
import 'package:prop_mize/app/core/themes/app_colors.dart';
import 'package:prop_mize/app/core/utils/helpers.dart';
import 'package:prop_mize/app/data/models/ai/message_model.dart';
import 'package:prop_mize/app/modules/assistant_chat_screen/views/widgets/assistant_chat_appbar.dart';
import 'package:prop_mize/app/modules/assistant_chat_screen/views/widgets/assistant_chat_drawer.dart';

import '../../../core/utils/capitalize.dart';
import '../../../data/services/storage_services.dart';
import '../../../global_widgets/chat/received_message_bubble.dart';
import '../../../global_widgets/chat/send_message_bubble.dart';
import '../../../global_widgets/drawer/drawer_menu_item.dart';
import '../../../global_widgets/menu/global_menu_option.dart';
import '../../../global_widgets/typing_indicator.dart';
import '../../auth_screen/views/auth_bottom_sheet.dart';
import '../controllers/assistant_chat_controller.dart';

class AssistantChatView extends GetView<AssistantChatController>
{
    const AssistantChatView({super.key});

    @override
    Widget build(BuildContext context)
    {
        return Scaffold(
            key: controller.globalKey,
            appBar: AssistantChatAppbar(),
            drawer: AssistantChatDrawer(),

            // CHAT BODY
            body: SafeArea(
                child: Stack(
                    children: [
                        Column(
                            children: [
                                // Messages
                                Expanded(
                                    child: Obx(()
                                        {
                                            final startMsg =
                                                controller.aiChat.value?.data?.messages ?? [];

                                            final chatMessages =
                                                startMsg.map((e) => e.toChatMessage()).toList();

                                            // ab messages (server se aane wale ChatMessage)
                                            final apiMessages = controller
                                                .messageModel.value?.data?.chat?.messages ??
                                                [];

                                            final allMessages =
                                                apiMessages.isEmpty ? chatMessages : apiMessages;


                                            return ListView.builder(
                                                controller: controller.scrollController,
                                                padding: const EdgeInsets.symmetric(
                                                    vertical: 8, horizontal: 12),
                                                itemCount: allMessages.length +
                                                    (controller.isLoading.value ? 1 : 0), // 👈 loading msg add
                                                itemBuilder: (context, index)
                                                {
                                                    if (index == allMessages.length &&
                                                        controller.isLoading.value)
                                                    {
                                                        // 👇 Loading bubble (last msg ke niche)
                                                        return Padding(
                                                            padding: const EdgeInsets.symmetric(vertical: 8),
                                                            child: TypingIndicator()
                                                        );
                                                    }

                                                    final message = allMessages[index];
                                                    final isAssistantMessage =
                                                        controller.isAssistant(message);

                                                    return Padding(
                                                        padding:
                                                        const EdgeInsets.symmetric(vertical: 4),
                                                        child: isAssistantMessage
                                                            ? ReceivedMessageBubble(
                                                                chatMessage: message
                                                            )
                                                            : SendMessageBubble(chatMessage: message)
                                                    );
                                                }
                                            );
                                        }
                                    )
                                ),

                                // Input Field
                                Obx(()
                                    {
                                        bool sending = controller.isSendingMessage.value;
                                        bool hasText = controller.messageET.value.trim().isNotEmpty;

                                        return Container(
                                            padding: const EdgeInsets.all(12),
                                            child: Row(
                                                children: [
                                                    Expanded(
                                                        child: TextField(
                                                            controller: controller.messageController,
                                                            enabled: !sending,
                                                            textCapitalization: TextCapitalization.sentences,
                                                            decoration: InputDecoration(
                                                                hintText: sending ? "Sending..." : "Type your message...",
                                                                border: InputBorder.none
                                                            )
                                                        )
                                                    ),

                                                    // Show Send button only if there is text
                                                    if (hasText)
                                                    IconButton(
                                                        icon: Icon(CupertinoIcons.paperplane, color: sending ? Colors.grey : Colors.blue),
                                                        onPressed: sending ? null : controller.onSendMessageButtonPressed
                                                    )
                                                ]
                                            )
                                        );
                                    }
                                )

                            ]
                        ),

                        // 👇 Floating scroll-to-bottom button
                        Obx(()
                            {
                                return controller.showScrollToBottom.value
                                    ? Positioned(
                                        bottom: 70,
                                        right: 20,
                                        child: FloatingActionButton(
                                            mini: true,
                                            backgroundColor: Colors.blue,
                                            onPressed: () =>
                                            controller.scrollToBottom(force: true),
                                            child: const Icon(Icons.arrow_downward,
                                                color: Colors.white)
                                        )
                                    )
                                    : const SizedBox.shrink();
                            }
                        )
                    ]
                )
            )
        );
    }
}
