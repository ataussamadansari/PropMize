import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prop_mize/app/modules/assistant_chat_screen/controllers/assistant_chat_controller.dart';

enum GlobalMenuOption
{
    newChat, clearChat, helpSupport, settings
}

class GlobalPopupMenuBtn extends GetView<AssistantChatController>
{
    final Function(GlobalMenuOption) onSelected;

    const GlobalPopupMenuBtn({super.key, required this.onSelected});

    @override
    Widget build(BuildContext context)
    {
        return PopupMenuButton(itemBuilder: (context) => [
                PopupMenuItem(
                    value: GlobalMenuOption.newChat,
                    child: ListTile(
                        leading: Icon(Icons.chat),
                        title: Text("New Chat")
                    ),
                    onTap: ()
                    {
                        controller.startNewChat();
                    }
                ),
                PopupMenuItem(
                    value: GlobalMenuOption.clearChat,
                    child: ListTile(
                        leading: Icon(Icons.clear_all),
                        title: Text("Clear Chat")
                    )
                ),
                const PopupMenuItem(
                    value: GlobalMenuOption.helpSupport,
                    child: ListTile(
                        leading: Icon(Icons.help_outline),
                        title: Text("Help & Support")
                    )
                ),
                const PopupMenuItem(
                    value: GlobalMenuOption.settings,
                    child: ListTile(
                        leading: Icon(Icons.settings),
                        title: Text("Settings")
                    )
                )
            ],
            icon: const Icon(Icons.more_vert)
        );
    }
}
