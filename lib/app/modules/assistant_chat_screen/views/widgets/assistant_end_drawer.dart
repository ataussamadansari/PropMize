import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prop_mize/app/modules/assistant_chat_screen/controllers/assistant_chat_controller.dart';

class AssistantEndDrawer extends GetView<AssistantChatController> {
  const AssistantEndDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: MediaQuery.of(context).size.width * 0.7,
      child: SafeArea(
        child: Obx(() {
          final chatHistory = controller.chatHistoryList.value;
          final chats = chatHistory?.data?.chats ?? [];

          return Column(
            children: [
              // ===== Header Buttons =====
              ListTile(
                leading: const Icon(Icons.add),
                title: const Text("New Chat"),
                onTap: () {
                  controller.startNewChat();
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: const Icon(Icons.clear_all),
                title: const Text("Clear All"),
                onTap: () {
                  // TODO: Implement clear all chats
                  Navigator.of(context).pop();
                },
              ),

              const Divider(),

              // ===== Chat List Section =====
              Expanded(
                child: chats.isEmpty
                    ? const Center(
                  child: Text(
                    "No chat history available",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                    ),
                  ),
                )
                    : RefreshIndicator(
                  onRefresh: controller.refreshChatHistory,
                  child: NotificationListener<ScrollNotification>(
                    onNotification: (scrollInfo) {
                      // Auto-load more when reaching end of list
                      if (scrollInfo.metrics.pixels ==
                          scrollInfo.metrics.maxScrollExtent &&
                          controller.hasMoreHistory.value &&
                          !controller.isLoadingHistory.value) {
                        controller.loadMoreChatHistory();
                      }
                      return false;
                    },
                    child: ListView.builder(
                      physics: const AlwaysScrollableScrollPhysics(),
                      itemCount: chats.length +
                          (controller.isLoadingHistory.value ? 1 : 0),
                      itemBuilder: (context, index) {
                        // ===== Loading Footer =====
                        if (index == chats.length) {
                          return const Padding(
                            padding: EdgeInsets.all(12.0),
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          );
                        }

                        // ===== Chat Item =====
                        final chat = chats[index];
                        return ListTile(
                          leading: const Icon(Icons.chat),
                          title: Text(chat.title ?? "Untitled Chat"),
                          subtitle: Text(
                            "${chat.messages?.length ?? 0} messages • ${_formatDate(chat.createdAt)}",
                          ),
                          onTap: () {
                            controller.openChatFromHistory(chat.id ?? "");
                            Navigator.of(context).pop();
                          },
                        );
                      },
                    ),
                  ),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }

  String _formatDate(String? dateString) {
    if (dateString == null) return "Unknown date";
    try {
      final date = DateTime.parse(dateString);
      return "${date.day}/${date.month}/${date.year}";
    } catch (e) {
      return "Invalid date";
    }
  }
}

/*
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prop_mize/app/modules/assistant_chat_screen/controllers/assistant_chat_controller.dart';

class AssistantEndDrawer extends GetView<AssistantChatController> {
  const AssistantEndDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: MediaQuery.of(context).size.width * 0.8,
      child: SafeArea(
        child: Obx(() {
          final chatHistory = controller.chatHistoryList.value;
          final chats = chatHistory?.data?.chats ?? [];

          return Column(
            children: [
              // ===== Header Buttons =====
              ListTile(
                leading: const Icon(Icons.add),
                title: const Text("New Chat"),
                onTap: () {
                  controller.startNewChat();
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: const Icon(Icons.clear_all),
                title: const Text("Clear All"),
                onTap: () {
                  // TODO: Implement clear all chats
                  Navigator.of(context).pop();
                },
              ),

              const Divider(),

              // ===== Chat List Section =====
              Expanded(
                child: chats.isEmpty
                    ? const Center(
                  child: Text(
                    "No chat history available",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                    ),
                  ),
                )
                    : RefreshIndicator(
                  onRefresh: controller.refreshChatHistory,
                  child: NotificationListener<ScrollNotification>(
                    onNotification: (scrollInfo) {
                      // Auto-load more when reaching end of list
                      if (scrollInfo.metrics.pixels ==
                          scrollInfo.metrics.maxScrollExtent &&
                          controller.hasMoreHistory.value &&
                          !controller.isLoadingHistory.value) {
                        controller.loadMoreChatHistory();
                      }
                      return false;
                    },
                    child: ListView.builder(
                      physics: const AlwaysScrollableScrollPhysics(),
                      itemCount: chats.length + 1, // +1 for footer
                      itemBuilder: (context, index) {
                        // Show footer loader or text
                        if (index == chats.length) {
                          if (controller.isLoadingHistory.value) {
                            return const Padding(
                              padding: EdgeInsets.all(12.0),
                              child: Center(
                                  child: CircularProgressIndicator()),
                            );
                          } else if (controller.hasMoreHistory.value) {
                            return TextButton(
                              onPressed:
                              controller.loadMoreChatHistory,
                              child: const Text("Load More"),
                            );
                          } else {
                            return const Padding(
                              padding: EdgeInsets.all(12.0),
                              child: Center(
                                child: Text(
                                  "No more chats",
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ),
                            );
                          }
                        }

                        // ===== Chat Item =====
                        final chat = chats[index];
                        return ListTile(
                          leading: const Icon(Icons.chat),
                          title: Text(chat.title ?? "Untitled Chat"),
                          subtitle: Text(
                            "${chat.messages?.length ?? 0} messages • ${_formatDate(chat.createdAt)}",
                          ),
                          onTap: () {
                            controller.openChatFromHistory(chat.id ?? "");
                            Navigator.of(context).pop();
                          },
                        );
                      },
                    ),
                  ),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }

  String _formatDate(String? dateString) {
    if (dateString == null) return "Unknown date";
    try {
      final date = DateTime.parse(dateString);
      return "${date.day}/${date.month}/${date.year}";
    } catch (e) {
      return "Invalid date";
    }
  }
}
*/
