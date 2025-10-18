import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prop_mize/app/core/utils/helpers.dart';
import 'package:prop_mize/app/data/models/ai/ai_list_model/messages.dart';
import 'package:prop_mize/app/data/models/ai/ai_start_chat_model.dart';
import 'package:prop_mize/app/data/models/ai/chat_history_model.dart';
import 'package:prop_mize/app/data/repositories/ai/chat_repository.dart';
import 'package:prop_mize/app/routes/app_routes.dart';

import '../../../../data/models/ai/message_model.dart' hide Data;
import '../../../../data/models/ai/message_model_v1.dart' hide Data;
import '../../../../data/services/storage/storage_services.dart';
import '../../auth_screen/controllers/auth_controller.dart';
import '../../auth_screen/views/auth_bottom_sheet.dart';

class AssistantChatController extends GetxController
{
    // ===== Dependencies =====
    final AuthController authController = Get.find<AuthController>();
    final AiChatRepository _aiChatRepository = AiChatRepository();

    // ===== Keys =====
    final GlobalKey<ScaffoldState> globalKey = GlobalKey<ScaffoldState>();

    // ===== Reactive Variables =====
    final chatHistoryList = Rxn<ChatHistoryModel>();
    final aiChat = Rxn<AiStartChatModel>();
    final messageModel = Rxn<MessageModelV1>();
    final RxBool isLoading = false.obs;
    final RxBool isChatLoading = false.obs;
    final RxBool hasError = false.obs;
    final RxString errorMessage = "".obs;
    final RxBool isSendingMessage = false.obs;

    // ===== Scroll & Input =====
    final ScrollController scrollController = ScrollController();
    late TextEditingController messageController;
    final messageET = ''.obs;
    final messageId = ''.obs;
    final RxBool showScrollToBottom = false.obs;

    // ===== Pagination =====
    final RxInt currentHistoryPage = 1.obs;
    final RxBool hasMoreHistory = true.obs;
    final RxBool isLoadingHistory = false.obs;


    // ===== Duplicate Prevention =====
    final RxBool hasChatStarted = false.obs; // ✅ ensures startChat() runs once

    // ===== Real time sync =======
    final RxBool isSyncing = false.obs;
    Timer? _chatRefreshTimer;

    // ===== Computed Getters =====
    RxString get currentUserId => StorageServices.to.userId;

    // =====================================================
    //                   LIFECYCLE METHODS
    // =====================================================
    @override
    void onInit()
    {
        super.onInit();
        _initializeControllers();
        _setupListeners();
        _initializeAfterBuild();
    }

    void _initializeControllers()
    {
        messageController = TextEditingController();
    }

    void _setupListeners()
    {
        // Text change listener
        messageController.addListener(()
            {
                messageET.value = messageController.text;
            }
        );

        // Scroll listener for "scroll to bottom" button
        scrollController.addListener(()
            {
                showScrollToBottom.value =
                scrollController.offset < scrollController.position.maxScrollExtent - 100;
            }
        );

        /*// Observe login/logout changes (but prevent duplicate start)
        ever(StorageServices.to.userId, (String userId)
            {
                if (userId.isNotEmpty)
                {
                    startNewChat();
                }
            }
        );*/

        // Observe login/logout changes
        ever(StorageServices.to.userId, (String userId)
            {
                if (userId.isNotEmpty)
                {
                    final token = StorageServices.to.getToken();
                    final chatId = StorageServices.to.getChatId();
                    if (token != null && token.isNotEmpty)
                    {
                        // ✅ Agar user login kare aur chatId already hai to use karo
                        if (chatId != null && chatId.isNotEmpty) 
                        {
                            loadChatById(chatId);
                        }
                        else 
                        {
                            startNewChat();
                        }
                    }
                }
                else
                {
                    startNewChat();
                }
            }
        );

    }

    void _initializeAfterBuild()
    {
        Future.delayed(Duration.zero, () async
            {
                await _loadUserProfile();

                // ✅ Simple logic: Agar chatId stored hai to use karo, nahi to naya banao
                final storedChatId = StorageServices.to.getChatId();

                if (storedChatId != null && storedChatId.isNotEmpty)
                {
                    // ✅ Reuse existing chat
                    await loadChatById(storedChatId);
                    hasChatStarted.value = true;
                }
                else
                {
                    // ✅ Otherwise start a fresh chat
                    await startChat();
                }
            }
        );
    }

    /*void _initializeAfterBuild()
    {
        Future.delayed(Duration.zero, ()
            {
                if (StorageServices.to.chatId.isEmpty)
                {
                    startChat();
                }
                _loadUserProfile();
            }
        );
    }*/

    /// Load user profile (if token available) and then load chat history.
    Future<void> _loadUserProfile() async
    {
        try
        {

            isChatLoading.value = true;

            final token = StorageServices.to.getToken();
            if (token != null && token.isNotEmpty)
            {
                // call your auth controller to fetch profile (await optional)
                await authController.me();

                // then load chat history for the signed-in user
                await loadChatHistory();
            }
        }
        catch (e)
        {
            // show a friendly error and keep the controller stable
            AppHelpers.showSnackBar(title: "Error", message: e.toString(), isError: true);
        } finally {
            isChatLoading.value = false;
        }
    }

    @override
    void onClose()
    {
        messageController.dispose();
        scrollController.dispose();
        _aiChatRepository.cancelChat();
        _chatRefreshTimer?.cancel();
        super.onClose();
    }

    // =====================================================
    //                   CORE CHAT LOGIC
    // =====================================================

    /// Start a new chat session with the AI
    Future<void> startChat() async
    {
        if (hasChatStarted.value) return; // ✅ prevent duplicate call
        hasChatStarted.value = true;

        try
        {
            isChatLoading.value = true;
            clearError();

            final response = await _aiChatRepository.startChat("Hello");

            if (response.success)
            {
                aiChat.value = response.data;
                messageId.value = response.data?.data?.id ?? "";
                // ✅ Store this chatId for future reuse
                StorageServices.to.setChatId(messageId.value);
                scrollToBottom();
                final token = StorageServices.to.getToken();
                if (token != null && token.isNotEmpty)
                {
                    await loadChatHistory();
                }
            }
            else
            {
                _setError(response.message);
            }
        }
        catch (e)
        {
            _setError(e.toString());
        }
        finally
        {
            isChatLoading.value = false;
        }
    }

    /// Manually start a new chat (like ChatGPT "+ New Chat")
    void startNewChat() async
    {
        hasChatStarted.value = false;
        clearError();
        aiChat.value = null;
        messageModel.value = null;
        messageController.clear();
        isLoading.value = false;

        // ✅ Purani chatId clear karo aur nayi start karo
        StorageServices.to.removeChatId();
        await startChat();
    }

    /// Send user message to AI
    Future<void> sendMessage(String content, String userId, String chatId) async
    {
        scrollToBottom();
        if (isSendingMessage.value) return;
        if (content.trim().isEmpty) return;

        clearError();
        isSendingMessage.value = true;
        _setLoading(true);

        try
        {
            final response = await _aiChatRepository.sendMessage(content, chatId, userId);

            // ✅ Check if response is cancellation
            if (response.message.toLowerCase().contains("cancelled") == true)
            {
                return;
            }

            if (response.success)
            {
                messageModel.value = response.data;
                // reload chat messages
                if (chatId.isNotEmpty)
                {
                    await loadChatById(chatId);
                }

                final token = StorageServices.to.getToken();
                if (token != null && token.isNotEmpty)
                {
                    await loadChatHistory();
                }
                scrollToBottom(force: true);
            }
            else
            {
                _setError(response.message);
            }
        }
        catch (e)
        {
            _setError(e.toString());
        }
        finally
        {
            _setLoading(false);
            isSendingMessage.value = false;
        }
    }

    /// Load an existing chat by its ID
    Future<void> loadChatById(String chatId, {bool byHistory = false}) async
    {
        if (byHistory)
        {
            isChatLoading.value = true;
            messageId.value = chatId;
        }

        try
        {
            isChatLoading.value = true;
            clearError();

            final response = await _aiChatRepository.getChatById(chatId);

            if (response.success)
            {

                StorageServices.to.setChatId(chatId);
                aiChat.value = response.data;
                scrollToBottom();
                showScrollToBottom.value = false;
            }
            else
            {
                _setError(response.message);
            }
        }
        catch (e)
        {
            _setError(e.toString());
        }
        finally
        {
            isChatLoading.value = false;
        }
    }

    // delete chat by id
    Future<bool> deleteChatById(String chatId) async
    {
        try
        {
            hasError.value = false;
            errorMessage.value = "";
            isLoadingHistory.value = true;
            final response = await _aiChatRepository.deleteById(chatId);

            if (response.success)
            {
                await loadChatHistory();
                return true;
            }
            else
            {
                _setError(response.message);
                return false;
            }
        }
        catch (e)
        {
            _setError(e.toString());
            return false;
        }
        finally
        {
            isLoadingHistory.value = false;
        }
    }

    // clear all chats
    Future<bool> clearAllChats() async
    {
        try
        {
            hasError.value = false;
            errorMessage.value = "";
            isLoadingHistory.value = true;
            final response = await _aiChatRepository.deleteAll();

            if (response.success)
            {
                await loadChatHistory();
                return true;
            }
            else
            {
                _setError(response.message);
                return false;
            }
        }
        catch (e)
        {
            _setError(e.toString());
            return false;
        }
        finally
        {
            isLoadingHistory.value = false;
        }
    }

    // =====================================================
    //                   CHAT HISTORY
    // =====================================================

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

            clearError();

            final res = await _aiChatRepository.chatHistory(
                page: currentHistoryPage.value,
                limit: 10
            );

            if (res.success && res.data != null)
            {
                final newData = res.data!.data!;

                if (reset || chatHistoryList.value == null)
                {
                    chatHistoryList.value = ChatHistoryModel(success: true, data: newData);
                }
                else
                {
                    final oldChats = chatHistoryList.value?.data?.chats ?? [];

                    // Remove duplicates
                    final newChats = newData.chats
                        ?.where((chat) => !oldChats.any((old) => old.id == chat.id))
                        .toList() ??
                        [];

                    final combinedChats = [...oldChats, ...newChats];

                    chatHistoryList.value = ChatHistoryModel(
                        success: true,
                        data: Data(
                            chats: combinedChats,
                            pagination: newData.pagination
                        )
                    );
                }

                // Pagination update
                final currentPage = newData.pagination?.page ?? 1;
                final totalPages = newData.pagination?.pages ?? 1;
                hasMoreHistory.value = currentPage < totalPages;

                if (!reset) currentHistoryPage.value++;
            }
            else
            {
                _setError(res.message);
            }
        }
        catch (e)
        {
            _setError(e.toString());
        }
        finally
        {
            isLoadingHistory.value = false;
        }
    }


    Future<void> refreshChatHistory() async => loadChatHistory(reset: true);
    Future<void> loadMoreChatHistory() async => loadChatHistory(reset: false);

    // =====================================================
    //                   HELPERS
    // =====================================================

    void _setLoading(bool loading) => isLoading.value = loading;

    void _setError(String message)
    {
        hasError.value = true;
        errorMessage.value = message;
        AppHelpers.showSnackBar(title: "Error", message: message, isError: true);
    }

    void clearError()
    {
        hasError.value = false;
        errorMessage.value = "";
    }

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

    // void cancelChat() => _aiChatRepository.cancelChat();

    /// ✅ IMPROVED: Cancel with better handling
    void cancelChat()
    {
        _aiChatRepository.cancelChat();
        isSendingMessage.value = false;
        isLoading.value = false;
        errorMessage.value = '';
        hasError.value = false;
    }

    // =====================================================
    //                   ROLE CHECKS
    // =====================================================

    bool isAssistant(Messages message) =>
    message.role?.toLowerCase() == "assistant";

    bool isUser(ChatMessage message) => message.role?.toLowerCase() == "user";

    // =====================================================
    //                   UI ACTIONS
    // =====================================================

    void onSendMessageButtonPressed()
    {
        if (messageET.value.trim().isEmpty) return;

        final chatId = aiChat.value?.data?.id ?? "";
        final userId = StorageServices.to.userId.value.isEmpty
            ? aiChat.value?.data?.user ?? "guest"
            : currentUserId.value;

        sendMessage(messageET.value.trim(), userId, chatId);
        messageController.clear();
    }

    void showBottomSheet()
    {
        Get.bottomSheet(
            AuthBottomSheet(),
            isScrollControlled: true,
            backgroundColor: Colors.transparent
        );
    }

    // =====================================================
    //                   NAVIGATION
    // =====================================================

    void goToProductDetails(String id) => Get.toNamed('/product/$id');
    void goToAllListing() => Get.toNamed(Routes.allListing);
    void goToSavedProperties() => Get.toNamed(Routes.saveProperties);
    void goToContacted() => Get.toNamed(Routes.contacted);
    void goToProfile() => Get.toNamed(Routes.profile);
}
