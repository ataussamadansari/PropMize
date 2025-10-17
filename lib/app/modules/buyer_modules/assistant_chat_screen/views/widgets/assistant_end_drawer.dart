import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prop_mize/app/core/themes/app_colors.dart';
import 'package:prop_mize/app/core/utils/DateTimeHelper.dart';
import 'package:prop_mize/app/global_widgets/shimmer/shimmer_history_loader.dart';
import '../../../assistant_chat_screen/controllers/assistant_chat_controller.dart';

class AssistantEndDrawer extends GetView<AssistantChatController>
{
    const AssistantEndDrawer({super.key});

    @override
    Widget build(BuildContext context)
    {
        return Drawer(
            width: MediaQuery.of(context).size.width * 0.7,
            child: SafeArea(
                child: Obx(()
                    {
                        final chatHistory = controller.chatHistoryList.value;
                        final chats = chatHistory?.data?.chats ?? [];
                        final activeChatId = controller.aiChat.value?.data?.id;
                        final isLoggedIn = controller.currentUserId.value.isNotEmpty;

                        return Column(
                            children: [
                                // ===== Header Buttons =====
                                ListTile(
                                    leading: const Icon(Icons.add),
                                    title: const Text("New Chat"),
                                    onTap: ()
                                    {
                                        controller.startNewChat();
                                        Navigator.of(context).pop();
                                    }
                                ),

                                const Divider(),

                                // ===== Chat List Section =====
                                isLoggedIn ?
                                    Expanded(
                                        child: controller.isLoadingHistory.value ? ShimmerHistoryLoader() : chats.isEmpty
                                            ? const Center(
                                                child: Text(
                                                    "No chat history available",
                                                    style: TextStyle(
                                                        color: Colors.grey,
                                                        fontSize: 16
                                                    )
                                                )
                                            )
                                            : RefreshIndicator(
                                                onRefresh: controller.refreshChatHistory,
                                                child: NotificationListener<ScrollNotification>(
                                                    onNotification: (scrollInfo)
                                                    {
                                                        // Auto-load more when reaching end of list
                                                        if (scrollInfo.metrics.pixels ==
                                                            scrollInfo.metrics.maxScrollExtent &&
                                                            controller.hasMoreHistory.value &&
                                                            !controller.isLoadingHistory.value)
                                                        {
                                                            controller.loadMoreChatHistory();
                                                        }
                                                        return false;
                                                    },
                                                    child: ListView.builder(
                                                        physics: const AlwaysScrollableScrollPhysics(),
                                                        itemCount: chats.length +
                                                            (controller.isLoadingHistory.value ? 1 : 0),
                                                        itemBuilder: (context, index)
                                                        {
                                                            // ===== Loading Footer =====
                                                            if (index == chats.length)
                                                            {
                                                                return const Padding(
                                                                    padding: EdgeInsets.all(12.0),
                                                                    child: Center(
                                                                        child: ShimmerHistoryLoader()
                                                                    )
                                                                );
                                                            }

                                                            // ===== Chat Item =====
                                                            final chat = chats[index];
                                                            return InkWell(
                                                                onTap: ()
                                                                {
                                                                    if (chat.id == activeChatId) return;
                                                                    controller.loadChatById(chat.id ?? "", byHistory: true);
                                                                    Navigator.of(context).pop();
                                                                },
                                                                child: Container(
                                                                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                                                                    decoration: BoxDecoration(
                                                                        color: chat.id == activeChatId ? Colors.grey.withAlpha(100) : null,
                                                                        borderRadius: BorderRadius.circular(8)
                                                                    ),
                                                                    child: Row(
                                                                        children: [
                                                                            const Icon(CupertinoIcons.chat_bubble_text, color: AppColors.primary),
                                                                            const SizedBox(width: 8),

                                                                            // ✅ Wrap texts in Expanded to prevent overflow
                                                                            Expanded(
                                                                                child: Column(
                                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                                    children: [
                                                                                        Text(
                                                                                            chat.title ?? "Untitled Chat",
                                                                                            overflow: TextOverflow.ellipsis,
                                                                                            maxLines: 1,
                                                                                            style: context.textTheme.bodyMedium!.copyWith(color: AppColors.primary, fontWeight: FontWeight.w600)
                                                                                        ),
                                                                                        Text(
                                                                                            "${chat.messages?.length ?? 0} messages",
                                                                                            style: const TextStyle(fontSize: 12, color: Colors.grey),
                                                                                            overflow: TextOverflow.ellipsis
                                                                                        ),
                                                                                        Text(
                                                                                            DateTimeHelper.formatFull(chat.createdAt!),
                                                                                            style: const TextStyle(fontSize: 10, color: Colors.grey),
                                                                                            overflow: TextOverflow.ellipsis
                                                                                        )
                                                                                    ]
                                                                                )
                                                                            ),

                                                                            // ✅ Wrap trailing icon with SizedBox to limit space
                                                                            if(chat.id != activeChatId)
                                                                            SizedBox(
                                                                                width: 32,
                                                                                child: IconButton(
                                                                                    padding: EdgeInsets.zero,
                                                                                    onPressed: ()
                                                                                    {
                                                                                        // controller.deleteChatById(chat.id!);
                                                                                        _confirmDeleteChat(context, chat.id!);
                                                                                    },
                                                                                    // icon: const Icon(Icons.more_vert),
                                                                                    icon: const Icon(Icons.delete)
                                                                                )
                                                                            )
                                                                        ]
                                                                    )
                                                                )
                                                            );
                                                        }
                                                    )
                                                )
                                            )
                                    ) : Center(
                                        child: Padding(
                                            padding: const EdgeInsets.all(24.0),
                                            child: Column(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                    const Icon(
                                                        CupertinoIcons.lock_circle,
                                                        size: 80,
                                                        color: Colors.grey
                                                    ),
                                                    const SizedBox(height: 16),
                                                    const Text(
                                                        "You're not logged in",
                                                        style: TextStyle(
                                                            fontSize: 20,
                                                            fontWeight: FontWeight.bold,
                                                            color: Colors.black87
                                                        )
                                                    ),
                                                    const SizedBox(height: 8),
                                                    const Text(
                                                        "Please log in to view your chat history and continue your previous conversations.",
                                                        textAlign: TextAlign.center,
                                                        style: TextStyle(
                                                            color: Colors.grey,
                                                            fontSize: 14
                                                        )
                                                    ),
                                                    const SizedBox(height: 20),
                                                    ElevatedButton.icon(
                                                        onPressed: ()
                                                        {
                                                            controller.showBottomSheet();
                                                        },
                                                        icon: const Icon(Icons.login),
                                                        label: const Text("Login Now"),
                                                        style: ElevatedButton.styleFrom(
                                                            backgroundColor: Colors.blueAccent,
                                                            shape: RoundedRectangleBorder(
                                                                borderRadius: BorderRadius.circular(12)
                                                            ),
                                                            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12)
                                                        )
                                                    )
                                                ]
                                            )
                                        )
                                    )
                            ]
                        );
                    }
                )
            )
        );
    }

    void _confirmDeleteChat(BuildContext context, String chatId)
    {
        showCupertinoDialog(context: context, builder: (context)
            {
                return CupertinoAlertDialog(
                    title: const Text("Delete Chat"),
                    content: const Text("Are you sure you want to delete this chat?"),
                    actions: [
                        CupertinoDialogAction(
                            isDestructiveAction: true,
                            child: const Text("Cancel"),
                            onPressed: ()
                            {
                                Navigator.of(context).pop();
                            }
                        ),
                        CupertinoDialogAction(
                            isDefaultAction: true,
                            child: const Text("Delete"),
                            onPressed: ()
                            async
                            {
                                // if (await controller.deleteChatById(chatId))
                                // {
                                Navigator.pop(context, controller.deleteChatById(chatId));
                                // }
                            }
                        )
                    ]
                );
            }
        );
    }
}

