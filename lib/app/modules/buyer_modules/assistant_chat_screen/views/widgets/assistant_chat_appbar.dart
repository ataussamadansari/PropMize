import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../assistant_chat_screen/controllers/assistant_chat_controller.dart';


class AssistantChatAppbar extends GetView<AssistantChatController> implements PreferredSizeWidget {
  const AssistantChatAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
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
              onPressed: () {},
              icon: const Icon(CupertinoIcons.bell)
          ),
          IconButton(
              onPressed: () {
                if (controller.globalKey.currentState != null) {
                  controller.globalKey.currentState!.openEndDrawer();
                }
              },
              icon: const Icon(Icons.more_vert)
          ),
          /*GlobalPopupMenuBtn(onSelected: (option)
          {
            switch (option)
            {
              case GlobalMenuOption.newChat:
                break;
              case GlobalMenuOption.clearChat:
                break;
              case GlobalMenuOption.history:
                break;
              case GlobalMenuOption.helpSupport:
                break;
              case GlobalMenuOption.settings:
                break;
            }
          }
          )*/
        ]
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
