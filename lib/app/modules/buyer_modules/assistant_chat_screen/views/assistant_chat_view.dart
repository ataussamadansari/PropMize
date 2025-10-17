import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/cupertino.dart';
import 'package:prop_mize/app/core/themes/app_colors.dart';
import 'package:prop_mize/app/core/utils/helpers.dart';
import 'package:prop_mize/app/data/models/ai/message_model.dart';
import 'package:prop_mize/app/global_widgets/shimmer/shimmer_chat_view.dart';
import 'package:prop_mize/app/modules/assistant_chat_screen/views/widgets/assistant_chat_appbar.dart';
import 'package:prop_mize/app/modules/assistant_chat_screen/views/widgets/assistant_chat_drawer.dart';
import 'package:prop_mize/app/modules/assistant_chat_screen/views/widgets/assistant_end_drawer.dart';

import '../../../global_widgets/chat/received_message_bubble.dart';
import '../../../global_widgets/chat/send_message_bubble.dart';
import '../../../global_widgets/typing_indicator.dart';
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
            drawer: const AssistantChatDrawer(),
            endDrawer: const AssistantEndDrawer(),

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
                                            if (controller.isChatLoading.value) 
                                            {
                                                return Center(
                                                    child: ShimmerChatView()
                                                );
                                            }

                                            // 👇 Agar error hai to error widget show karo
                                            if (controller.hasError.value)
                                            {
                                                return Center(
                                                    child: Padding(
                                                        padding: const EdgeInsets.all(20.0),
                                                        child: Column(
                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                            children: [
                                                                Icon(
                                                                    Icons.error_outline,
                                                                    color: Colors.red,
                                                                    size: 50
                                                                ),
                                                                SizedBox(height: 16),
                                                                Text(
                                                                    controller.errorMessage.value,
                                                                    textAlign: TextAlign.center,
                                                                    style: TextStyle(
                                                                        color: Colors.red,
                                                                        fontSize: 16
                                                                    )
                                                                ),
                                                                SizedBox(height: 20),
                                                                ElevatedButton(
                                                                    onPressed: ()
                                                                    {
                                                                        controller.messageId.value.isNotEmpty ?
                                                                            controller.loadChatById(controller.messageId.value) :
                                                                            controller.startNewChat();
                                                                    },
                                                                    style: ElevatedButton.styleFrom(
                                                                        backgroundColor: AppColors.primary,
                                                                        foregroundColor: Colors.white
                                                                    ),
                                                                    child: Text('Retry')
                                                                )
                                                            ]
                                                        )
                                                    )
                                                );
                                            }

                                            final startMsg =
                                                controller.aiChat.value?.data?.messages ?? [];

                                            final chatMessages = startMsg;

                                            return ListView.builder(
                                                controller: controller.scrollController,
                                                padding: const EdgeInsets.symmetric(
                                                    vertical: 8, horizontal: 12),
                                                itemCount: startMsg.length + (controller.isLoading.value ? 1 : 0),
                                                itemBuilder: (context, index)
                                                {
                                                    if (index == chatMessages.length &&
                                                        controller.isLoading.value)
                                                    {
                                                        // 👇 Loading bubble (last msg ke niche)
                                                        return Padding(
                                                            padding: const EdgeInsets.symmetric(vertical: 8),
                                                            child: TypingIndicator()
                                                        );
                                                    }

                                                    final message = chatMessages[index];
                                                    final isAssistantMessage =
                                                        controller.isAssistant(message);

                                                    return Padding(
                                                        padding: const EdgeInsets.symmetric(vertical: 4),
                                                        child: isAssistantMessage
                                                            ? ReceivedMessageBubble(chatMessage: message)
                                                            : SendMessageBubble(chatMessage: message)
                                                    );
                                                }
                                            );
                                        }
                                    )
                                ),

                                // Input Field - YEH WALA PART SAME RAHEGA
                                Obx(()
                                    {
                                        bool sending = controller.isSendingMessage.value;
                                        bool hasText = controller.messageET.value.trim().isNotEmpty;

                                        return Container(
                                            padding: const EdgeInsets.symmetric(horizontal: 12.0),
                                            child: Row(
                                                children: [
                                                    Expanded(
                                                        child: TextField(
                                                            controller: controller.messageController,
                                                            enabled: !sending && !controller.hasError.value, // 👈 error ke time disable
                                                            textCapitalization: TextCapitalization.sentences,
                                                            decoration: InputDecoration(
                                                                hintText: sending
                                                                    ? "Sending..."
                                                                    : controller.hasError.value
                                                                        ? "Fix error to continue..." // 👈 error message
                                                                        : "Type your message...",
                                                                border: InputBorder.none
                                                            )
                                                        )
                                                    ),

                                                    // 👇 Single button that toggles Send ↔ Cancel
                                                    IconButton(
                                                        style: IconButton.styleFrom(
                                                            backgroundColor: sending
                                                                ? Colors.grey.shade500
                                                                : AppColors.primary
                                                        ),
                                                        icon: Icon(
                                                            // sending ? Icons.stop : CupertinoIcons.paperplane,
                                                            CupertinoIcons.paperplane,
                                                            /*color: sending
                                                                ? Colors.red
                                                                : (hasText ? AppColors.white : Colors.grey) */
                                                            color: AppColors.white
                                                        ),
                                                        onPressed: ()
                                                        {
                                                          hasText ? controller.onSendMessageButtonPressed() : null;
                                                           /* if (sending)
                                                            {
                                                                // controller.cancelChat();
                                                            }
                                                            else if (hasText && !controller.hasError.value)
                                                            { // 👈 error ke time send na ho
                                                                controller.onSendMessageButtonPressed();
                                                            }*/
                                                        }
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
                                return controller.showScrollToBottom.value &&
                                    !controller.hasError.value // 👈 error ke time hide
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
