import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/cupertino.dart';
import 'package:prop_mize/app/core/utils/helpers.dart';
import 'package:prop_mize/app/data/models/ai/message_model.dart';

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
            appBar: AppBar(
                title: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                        Image.asset('assets/images/logo.png', width: 40),
                        const SizedBox(width: 8),
                        const Text('PropMize')
                    ]
                ),
                actions: [
                    IconButton(
                        onPressed: ()
                        {
                        },
                        icon: const Icon(CupertinoIcons.bell)),
                    GlobalPopupMenuBtn(onSelected: (option)
                        {
                            switch (option)
                            {
                                case GlobalMenuOption.newChat:
                                    controller.startNewChat();
                                    break;
                                case GlobalMenuOption.clearChat:
                                    break;
                                case GlobalMenuOption.helpSupport:
                                    break;
                                case GlobalMenuOption.settings:
                                    break;
                            }
                        }
                    )
                ]
            ),

            drawer: Drawer(
                child: SafeArea(
                    child: ListView(
                        children: [
                            Obx(()
                                {
                                    final isLoggedIn = controller.currentUserId.value.isNotEmpty;
                                    return Column(
                                        children: [
                                            isLoggedIn ? Column(
                                                    children: [
                                                        if (controller.authController.profile.value?.data != null) ...[

                                                          FlutterLogo(size: 80),
                                                          const SizedBox(height: 15),
                                                          Text(
                                                              controller.authController.profile.value?.data?.name ?? "Not Available", textAlign: TextAlign.center,
                                                              style: context.textTheme.displaySmall
                                                          ),

                                                          Text(
                                                              controller.authController.profile.value?.data?.email ?? "Not Provider",
                                                              textAlign: TextAlign.center,
                                                              style: context.textTheme.labelMedium
                                                          ),
                                                          SizedBox(height: 8),
                                                          Text(
                                                              capitalize(controller.authController.profile.value?.data?.role ?? "Not Available"),
                                                              textAlign: TextAlign.center,
                                                              style: context.textTheme.labelMedium?.copyWith(fontWeight: FontWeight.w600)
                                                          )
                                                        ],
                                                    ]
                                                ) : SizedBox.shrink(),

                                            Divider(color: Colors.grey.withAlpha(100)),
                                            isLoggedIn ? DrawerMenuItem(
                                                    leading: CupertinoIcons.person,
                                                    title: "Profile Manager",
                                                    subtitle: "View Profile",
                                                    onTap: ()
                                                    {
                                                        controller.goToProfile();
                                                    }
                                                ) : SizedBox.shrink(),
                                            DrawerMenuItem(
                                                leading: CupertinoIcons.refresh,
                                                title: "Switch to Seller Mode",
                                                subtitle: "Switch mode",
                                                trailing: "Switch",
                                                onTap: ()
                                                {
                                                  isLoggedIn ? "" : AppHelpers.showSnackBar(title: "Alert", message: "Please login to switch to seller mode");
                                                }
                                            ),
                                            DrawerMenuItem(
                                                leading: Icons.home_work_outlined,
                                                title: "All listing",
                                                subtitle: "Explore property listed in my city",
                                                onTap: ()
                                                {
                                                }
                                            ),
                                            isLoggedIn ? DrawerMenuItem(
                                                leading: CupertinoIcons.heart,
                                                title: "Saved",
                                                subtitle: "Properties saved for later viewing",
                                                onTap: ()
                                                {
                                                }
                                            ) : SizedBox.shrink(),
                                            isLoggedIn ? DrawerMenuItem(
                                                leading: CupertinoIcons.eye,
                                                title: "Recently Viewed",
                                                subtitle: "Recently viewed properties",
                                                onTap: ()
                                                {
                                                }
                                            ) : SizedBox.shrink(),
                                            isLoggedIn ? DrawerMenuItem(
                                                leading: CupertinoIcons.phone,
                                                title: "Contacted",
                                                subtitle: "Properties where to you connected ower",
                                                onTap: ()
                                                {
                                                }
                                            ) : SizedBox.shrink(),
                                            DrawerMenuItem(
                                                leading: Icons.add_home_work_outlined,
                                                title: "New Projects",
                                                subtitle: "New projects in your city",
                                                onTap: ()
                                                {
                                                }
                                            ),
                                            DrawerMenuItem(
                                                leading: CupertinoIcons.book,
                                                title: "Buyer's Guide",
                                                subtitle: "Buyer's guide and advice",
                                                onTap: ()
                                                {
                                                }
                                            ),
                                            DrawerMenuItem(
                                                leading: Icons.support_agent,
                                                title: "Help & Support",
                                                subtitle: "Help and support center",
                                                onTap: ()
                                                {
                                                    // controller.globalKey.currentState?.closeDrawer();
                                                }
                                            ),
                                            Divider(color: Colors.grey.withAlpha(100)),

                                            DrawerMenuItem(
                                                leading: Icons.logout,
                                                title: StorageServices.to.userId.value.isEmpty ? "Login" : "Logout",
                                                subtitle: StorageServices.to.userId.value.isEmpty
                                                    ? "Sign in to your account"
                                                    : "Sign out of your account",
                                                onTap: ()
                                                {
                                                    if (StorageServices.to.userId.value.isEmpty)
                                                    {
                                                        Get.bottomSheet(
                                                            const AuthBottomSheet(),
                                                            isScrollControlled: true,
                                                            backgroundColor: Colors.transparent
                                                        );
                                                    }
                                                    else
                                                    {
                                                        controller.authController.logout();
                                                    }
                                                }
                                            )
                                        ]
                                    );
                                }
                            )
                        ]
                    )
                )
            ),

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
