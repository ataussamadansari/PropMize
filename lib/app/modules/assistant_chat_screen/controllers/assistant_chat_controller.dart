import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prop_mize/app/core/utils/helpers.dart';
import 'package:prop_mize/app/data/models/ai/ai_start_chat_model.dart' hide Data;
import 'package:prop_mize/app/data/models/ai/chat_history_model.dart';
import 'package:prop_mize/app/data/repositories/ai/chat_repository.dart';
import 'package:prop_mize/app/routes/app_routes.dart';

import '../../../data/models/ai/message_model.dart' hide Data;
import '../../../data/services/storage_services.dart';
import '../../auth_screen/controllers/auth_controller.dart';
import '../../auth_screen/views/auth_bottom_sheet.dart';

class AssistantChatController extends GetxController
{
    final AuthController authController = Get.find<AuthController>();

    final AiChatRepository _aiChatRepository = AiChatRepository();

    GlobalKey<ScaffoldState> globalKey = GlobalKey<ScaffoldState>();

    // Reactive Variables
    final chatHistoryList = Rxn<ChatHistoryModel>();
    final aiChat = Rxn<AiStartChatModel>();
    final messageModel = Rxn<MessageModel>();
    final RxBool isLoading = false.obs;
    final RxBool hasError = false.obs;
    final RxString errorMessage = "".obs;

    final RxBool isSendingMessage = false.obs;

    // User ID from StorageServices
    RxString get currentUserId => StorageServices.to.userId;

    // Message EditText
    var messageET = ''.obs;

    // TextEditingControllers
    late TextEditingController messageController;
    final ScrollController scrollController = ScrollController();

    // Pagination for chat history
    final RxInt currentHistoryPage = 1.obs;
    final RxBool hasMoreHistory = true.obs;
    final RxBool isLoadingHistory = false.obs;

    // 👇 show/hide scroll-to-bottom btn
    final RxBool showScrollToBottom = false.obs;

    @override
    void onInit() 
    {
        super.onInit();
        messageController = TextEditingController();

        // Text change listener
        messageController.addListener(()
            {
                messageET.value = messageController.text;
            }
        );

        // Scroll listener
        scrollController.addListener(()
            {
                if (scrollController.offset <
                    scrollController.position.maxScrollExtent - 100) 
                {
                    showScrollToBottom.value = true; // upar gya
                }
                else 
                {
                    showScrollToBottom.value = false; // niche h
                }
            }
        );

        // 🔹 Observe login/logout changes
        ever(StorageServices.to.userId, (String userId)
            {
                if (userId.isNotEmpty) 
                {
                    showScrollToBottom.value = false;
                    startNewChat();
                }
                else 
                {
                    showScrollToBottom.value = false;
                    startNewChat();
                }
            }
        );

        _initializeAfterBuild();
    }

    // ✅ FIX: Build complete hone ke baad initialize karo
    void _initializeAfterBuild() 
    {
        Future.delayed(Duration.zero, ()
            {
                startChat();
                // ✅ FIX: AuthController.me() ko safely call karo
                _loadUserProfile();
            }
        );
    }

    // ✅ FIX: Safe profile loading
    void _loadUserProfile() 
    {
        try
        {
            // ✅ Check if user is logged in before calling me()
            final token = StorageServices.to.getToken();
            if (token != null && token.isNotEmpty) 
            {
                authController.me();
                loadChatHistory();
            }
        }
        catch (e)
        {
            AppHelpers.showSnackBar(title: "Error", message: e.toString(), isError: true);
        }
    }

    Future<void> startChat() async
    {
        try
        {
            isLoading.value = true;
            hasError.value = false;
            errorMessage.value = "";

            final response = await _aiChatRepository.startChat("Hello");

            if (response.success) 
            {
                aiChat.value = response.data;
                hasError.value = false; // 👈 explicitly set false
                scrollToBottom();
            }
            else 
            {
                hasError.value = true;
                errorMessage.value = response.message;
                AppHelpers.showSnackBar(title: "Error", message: response.message, isError: true);
            }
        }
        catch (e)
        {
            hasError.value = true;
            errorMessage.value = e.toString();
            AppHelpers.showSnackBar(title: "Error", message: errorMessage.value, isError: true);
        }
        finally
        {
            isLoading.value = false;
        }
    }

    Future<void> sendMessage(
        String content, String userId, String chatId) async
    {
        if (isSendingMessage.value) return; // prevent sending multiple

        // 👇 Agar error hai to pehle clear karo
        if (hasError.value) 
        {
            hasError.value = false;
            errorMessage.value = "";
        }

        try
        {
            isLoading.value = true;
            hasError.value = false;
            isSendingMessage.value = true;
            errorMessage.value = "";

            final response =
                await _aiChatRepository.sendMessage(content, chatId, userId);
            if (response.success) 
            {
                messageModel.value = response.data;
                hasError.value = false; // 👈 success pe error clear
                scrollToBottom();
            }
            else 
            {
                hasError.value = true;
                errorMessage.value = response.message;
                AppHelpers.showSnackBar(title: "Error", message: response.message, isError: true);
            }
        }
        catch (e)
        {
            hasError.value = true;
            errorMessage.value = e.toString();
            AppHelpers.showSnackBar(title: "Error", message: errorMessage.value, isError: true);
        }
        finally
        {
            isLoading.value = false;
            isSendingMessage.value = false;
        }
    }

    // ============
    // ✅ Chat History with ChatHistoryModel
    Future<void> loadChatHistory({bool reset = true}) async
    {
        try
        {
            if (reset) 
            {
                isLoadingHistory.value = true;
                currentHistoryPage.value = 1;
                hasMoreHistory.value = true;
            }
            else 
            {
                if (!hasMoreHistory.value || isLoadingHistory.value) return;
                isLoadingHistory.value = true;
            }

            hasError.value = false;
            errorMessage.value = "";

            final res = await _aiChatRepository.chatHistory(
                page: currentHistoryPage.value,
                limit: 10
            );

            if (res.success && res.data != null) 
            {
                final newData = res.data!.data!; // Data type: Data

                if (reset || chatHistoryList.value == null) 
                {
                    // Reset case
                    chatHistoryList.value = ChatHistoryModel(success: true, data: newData);
                }
                else 
                {
                    // Append case
                    final oldChats = chatHistoryList.value?.data?.chats ?? [];
                    final combinedChats = [...oldChats, ...?newData.chats];

                    chatHistoryList.value = ChatHistoryModel(
                        success: true,
                        data: Data(
                            chats: combinedChats,
                            pagination: newData.pagination
                        )
                    );
                }

                // Pagination check
                final currentPage = newData.pagination?.page ?? 1;
                final totalPages = newData.pagination?.pages ?? 1;
                hasMoreHistory.value = currentPage < totalPages;

                if (!reset) currentHistoryPage.value++;
            }
            else 
            {
                hasError.value = true;
                errorMessage.value = res.message;
                AppHelpers.showSnackBar(
                    title: "Error",
                    message: res.message,
                    isError: true
                );
            }
        }
        catch (e)
        {
            hasError.value = true;
            errorMessage.value = e.toString();
            AppHelpers.showSnackBar(
                title: "Error",
                message: errorMessage.value,
                isError: true
            );
        }
        finally
        {
            isLoadingHistory.value = false;
        }
    }

    // Load more chat history
    Future<void> loadMoreChatHistory() async
    {
        await loadChatHistory(reset: false);
    }

    // Refresh chat history
    Future<void> refreshChatHistory() async
    {
        await loadChatHistory(reset: true);
    }

    // Open a specific chat from history
    Future<void> openChatFromHistory(String chatId)
    async {
        try {
          isLoading.value = true;
          hasError.value = false;
          errorMessage.value = "";

          final response = await _aiChatRepository.getChatById(chatId);

          if (response.success) {
            aiChat.value = response.data;
            scrollToBottom();
          } else {
            hasError.value = true;
            errorMessage.value = response.message;
            AppHelpers.showSnackBar(
              title: "Error",
              message: response.message,
              isError: true
            );
          }
        }  catch (e)
        {
          hasError.value = true;
          errorMessage.value = e.toString();
          AppHelpers.showSnackBar(
              title: "Error",
              message: errorMessage.value,
              isError: true
          );
        }
        finally
        {
          isLoading.value = false;
          isLoadingHistory.value = false;
        }
    }

    // ===========

    // 👇 Improved error clear function
    void clearError() 
    {
        hasError.value = false;
        errorMessage.value = "";
    }

    void startNewChat() 
    {
        // 👇 Pehle error clear karo
        clearError();

        aiChat.value = null;
        messageModel.value = null;
        messageController.clear();

        isLoading.value = false;

        // Phir naya chat start karo
        startChat();
    }

    // cancel chat
    void cancelChat() 
    {
        _aiChatRepository.cancelChat();
    }

    @override
    void onClose() 
    {
        messageController.dispose();
        scrollController.dispose();
        _aiChatRepository.cancelChat();
        super.onClose();
    }

    // Role
    bool isAssistant(ChatMessage message) 
    {
        return message.role?.toLowerCase() == "assistant";
    }

    bool isUser(ChatMessage message) 
    {
        return message.role?.toLowerCase() == "user";
    }

    // functions
    void onSendMessageButtonPressed() 
    {
        if (messageET.value.trim().isEmpty) return;

        final chatId = aiChat.value?.data?.id ?? "";
        final userId = StorageServices.to.userId.value.isEmpty ? aiChat.value?.data?.user ?? "guest" : currentUserId;

        sendMessage(messageET.value.trim(), userId.toString(), chatId);
        messageController.clear();
        scrollToBottom(force: true);
    }

    // 👇 scroll helper
    void scrollToBottom({bool force = false}) 
    {
        Future.delayed(const Duration(milliseconds: 300), ()
            {
                if (scrollController.hasClients) 
                {
                    scrollController.animateTo(
                        scrollController.position.maxScrollExtent,
                        duration: const Duration(milliseconds: 400),
                        curve: Curves.easeOut
                    );
                }
            }
        );
    }

    // Bottom sheet
    void showBottomSheet() 
    {
        Get.bottomSheet(
            AuthBottomSheet(),
            isScrollControlled: true,
            backgroundColor: Colors.transparent
        );
    }

    // Navigation functions
    void goToProductDetails(String id) 
    {
        Get.toNamed('/product/$id');
    }

    void goToAllListing() 
    {
        Get.toNamed(Routes.allListing);
    }

    void goToSavedProperties() 
    {
        Get.toNamed(Routes.saveProperties);
    }

    void goToContacted() 
    {
        Get.toNamed(Routes.contacted);
    }

    void goToProfile() 
    {
        Get.toNamed(Routes.profile);
    }
}
