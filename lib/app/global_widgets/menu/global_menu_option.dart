import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prop_mize/app/modules/assistant_chat_screen/controllers/assistant_chat_controller.dart';

enum GlobalMenuOption {
  newChat, clearChat, history, helpSupport, settings
}

class GlobalPopupMenuBtn extends GetView<AssistantChatController> {
  final Function(GlobalMenuOption) onSelected;

  const GlobalPopupMenuBtn({super.key, required this.onSelected});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<GlobalMenuOption>(
      onSelected: onSelected,
      itemBuilder: (context) {
        final isLoggedIn = controller.currentUserId.value.isNotEmpty;

        final menuItems = <PopupMenuEntry<GlobalMenuOption>>[
          PopupMenuItem<GlobalMenuOption>(
            value: GlobalMenuOption.newChat,
            child: const ListTile(
              leading: Icon(Icons.chat),
              title: Text("New Chat"),
            ),
            onTap: () => controller.startNewChat(),
          ),
          PopupMenuItem<GlobalMenuOption>(
            value: GlobalMenuOption.clearChat,
            child: const ListTile(
              leading: Icon(Icons.clear_all),
              title: Text("Clear Chat"),
            ),
            onTap: () => controller.startNewChat(),
          ),
        ];

        // Only add history if user is logged in
        if (isLoggedIn) {
          menuItems.add(
            PopupMenuItem<GlobalMenuOption>(
              value: GlobalMenuOption.history,
              child: ListTile(
                leading: const Icon(Icons.history),
                title: const Text("History"),
                onTap: () {
                  Future.delayed(
                    const Duration(milliseconds: 0),
                        () {
                      controller.globalKey.currentState?.openEndDrawer();
                      controller.loadChatHistory(); // Load chats
                    },
                  );
                },
              ),
            ),
          );
        }

        // Add the remaining menu items
        menuItems.addAll([
          PopupMenuItem<GlobalMenuOption>(
            value: GlobalMenuOption.helpSupport,
            child: const ListTile(
              leading: Icon(Icons.help_outline),
              title: Text("Help & Support"),
            ),
          ),
          PopupMenuItem<GlobalMenuOption>(
            value: GlobalMenuOption.settings,
            child: const ListTile(
              leading: Icon(Icons.settings),
              title: Text("Settings"),
            ),
          ),
        ]);

        return menuItems;
      },
      icon: const Icon(Icons.more_vert),
    );
  }
}


/*
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prop_mize/app/modules/assistant_chat_screen/controllers/assistant_chat_controller.dart';

enum GlobalMenuOption
{
    newChat, clearChat, history, helpSupport, settings
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
                    ),
                  onTap: () {
                    print("clear");
                  },
                ),

                PopupMenuItem(
                    value: GlobalMenuOption.history,
                    child: ListTile(
                        leading: Icon(Icons.history),
                        title: Text("History")
                    )
                ),
                PopupMenuItem(
                    value: GlobalMenuOption.helpSupport,
                    child: ListTile(
                        leading: Icon(Icons.help_outline),
                        title: Text("Help & Support")
                    )
                ),
                PopupMenuItem(
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
*/
