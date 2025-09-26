import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/cupertino.dart';
import 'package:prop_mize/app/data/models/ai/message_model.dart';
import 'package:prop_mize/app/global_widgets/chat/received_message_bubble.dart';
import 'package:prop_mize/app/global_widgets/chat/send_message_bubble.dart';
import 'package:prop_mize/app/global_widgets/drawer/drawer_menu_item.dart';
import 'package:prop_mize/app/global_widgets/menu/global_menu_option.dart';

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
                        icon: const Icon(CupertinoIcons.bell)
                    ),
                    GlobalPopupMenuBtn(
                        onSelected: (option)
                        {
                            switch (option)
                            {
                                case GlobalMenuOption.newChat:
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
                            FlutterLogo(size: 80),
                            const SizedBox(height: 15),
                            Text(
                                'Username',
                                textAlign: TextAlign.center,
                                style: context.textTheme.displaySmall
                            ),
                            Text(
                                'example@gmail.com',
                                textAlign: TextAlign.center,
                                style: context.textTheme.labelMedium
                            ),
                            SizedBox(height: 8),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                    Text(
                                        'Buyer',
                                        textAlign: TextAlign.center,
                                        style: context.textTheme.labelSmall?.copyWith(color: Colors.grey)
                                    )
                                ]
                            ),
                            Divider(color: Colors.grey.withAlpha(100)),
                            DrawerMenuItem(leading: CupertinoIcons.person, title: "Profile Manager", subtitle: "View Profile", onTap: ()
                                {
                                    controller.goToProfile();
                                }
                            ),
                            DrawerMenuItem(leading: CupertinoIcons.refresh, title: "Switch to Seller Mode", subtitle: "Switch mode", trailing: "Switch", onTap: ()
                                {
                                }
                            ),
                            DrawerMenuItem(leading: CupertinoIcons.house, title: "Assistant", subtitle: "Buyer dashboard with AI assistant", onTap: ()
                                {
                                }
                            ),
                            DrawerMenuItem(leading: Icons.home_work_outlined, title: "All listing", subtitle: "Explore property listed in my city", onTap: ()
                                {
                                }
                            ),
                            DrawerMenuItem(leading: CupertinoIcons.heart, title: "Saved", subtitle: "Properties saved for later viewing", onTap: ()
                                {
                                }
                            ),
                            DrawerMenuItem(leading: CupertinoIcons.eye, title: "Recently Viewed", subtitle: "Recently viewed properties", onTap: ()
                                {
                                }
                            ),
                            DrawerMenuItem(leading: CupertinoIcons.phone, title: "Contacted", subtitle: "Properties where to you connected ower", onTap: ()
                                {
                                }
                            ),
                            DrawerMenuItem(leading: Icons.add_home_work_outlined, title: "New Projects", subtitle: "New projects in your city", onTap: ()
                                {
                                }
                            ),
                            DrawerMenuItem(leading: CupertinoIcons.book, title: "Buyer's Guide", subtitle: "Buyer's guide and advice", onTap: ()
                                {
                                }
                            ),
                            DrawerMenuItem(leading: Icons.support_agent, title: "Help & Support", subtitle: "Help and support center", onTap: ()
                                {
                                }
                            ),
                            Divider(color: Colors.grey.withAlpha(100)),
                            DrawerMenuItem(leading: Icons.logout, title: "Logout", subtitle: "Sign out of your account", onTap: ()
                                {
                                }
                            )

                        ]
                    )
                )
            ),

            // CHAT BODY
            body: SafeArea(
                child: Column(
                    children: [
                        // Messages
                        Expanded(
                            child: Obx(()
                                {
                                    final startMsg = controller.aiChat.value?.data?.messages ?? [];
                                    // Get the list of messages
                                    // final messages = controller.messageModel.value?.data?.chat?.messages ?? [];

                                    final chatMessages = startMsg.map((e) => e.toChatMessage()).toList();

                                    // ab messages (server se aane wale ChatMessage)
                                    final apiMessages = controller.messageModel.value?.data?.chat?.messages ?? [];

                                    final allMessages = apiMessages.isEmpty ? chatMessages : apiMessages;

                                    // dono ko combine karke ek final list banao
                                    /* final allMessages = [
                                      ...chatMessages,
                                      ...apiMessages,
                                    ];*/


                                    if (controller.isLoading.value)
                                    {
                                        return const Center(child: CircularProgressIndicator());
                                    }

                                    if (controller.hasError.value)
                                    {
                                        return Center(child: Text(controller.errorMessage.value));
                                    }

                                    return ListView.builder(
                                        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                                        itemCount: allMessages.length,
                                        itemBuilder: (context, index)
                                        {
                                            final message = allMessages[index];
                                            // final isUserMessage = message.role == 'assistant';

                                            final isAssistantMessage = controller.isAssistant(message);

                                            return Padding(
                                                padding: const EdgeInsets.symmetric(vertical: 4),
                                                child: isAssistantMessage
                                                    ?
                                                    ReceivedMessageBubble(chatMessage: message)
                                                    :
                                                    SendMessageBubble(chatMessage: message)
                                            );
                                        }
                                    );

                                    /*return ListView.builder(
                                        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                                        itemCount: messages.isNotEmpty ? messages.length : startMsg.length,
                                        itemBuilder: (context, index)
                                        {
                                            final message = messages[index];
                                            final aiMessage = startMsg[index];
                                            final isUserMessage = message.role == 'user';

                                            return Padding(
                                                padding: const EdgeInsets.symmetric(vertical: 4),
                                                child: isUserMessage
                                                    ? SendMessageBubble(chatMessage: message)
                                                    : ReceivedMessageBubble(chatMessage: messages.isNotEmpty ? message : aiMessage)
                                            );
                                        }
                                    );*/
                                }
                            )
                        ),

                        // Input Field
                        Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                            ),
                            child: Row(
                                children: [
                                    Expanded(
                                        child: TextField(
                                            controller: controller.messageController,
                                            textCapitalization: TextCapitalization.sentences,
                                            decoration: InputDecoration(
                                                hintText: "Type your message...",
                                                border: InputBorder.none
                                            )
                                        )
                                    ),
                                    IconButton(
                                        icon: const Icon(Icons.send, color: Colors.blue),
                                        onPressed: controller.onSendMessageButtonPressed
                                    )
                                ]
                            )
                        )
                    ]
                )
            )
        );
    }

}
