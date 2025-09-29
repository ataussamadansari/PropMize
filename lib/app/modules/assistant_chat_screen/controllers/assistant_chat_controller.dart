import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prop_mize/app/core/utils/helpers.dart';
import 'package:prop_mize/app/data/models/ai/ai_start_chat_model.dart';
import 'package:prop_mize/app/data/repositories/ai/chat_repository.dart';
import 'package:prop_mize/app/routes/app_routes.dart';

import '../../../data/models/ai/message_model.dart';
import '../../../data/services/storage_services.dart';
import '../../auth_screen/controllers/auth_controller.dart';

class AssistantChatController extends GetxController {
  final AuthController authController = Get.find<AuthController>();

  final AiChatRepository _aiChatRepository = AiChatRepository();

  GlobalKey<ScaffoldState> globalKey = GlobalKey<ScaffoldState>();

  // Reactive Variables
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

  // 👇 show/hide scroll-to-bottom btn
  final RxBool showScrollToBottom = false.obs;

  @override
  void onInit() {
    super.onInit();
    messageController = TextEditingController();

    // Text change listener
    messageController.addListener(() {
      messageET.value = messageController.text;
    });

    // Scroll listener
    scrollController.addListener(() {
      if (scrollController.offset <
          scrollController.position.maxScrollExtent - 100) {
        showScrollToBottom.value = true; // upar gya
      } else {
        showScrollToBottom.value = false; // niche h
      }
    });

    // 🔹 Observe login/logout changes
    ever(StorageServices.to.userId, (String userId) {
      if (userId.isNotEmpty) {
        showScrollToBottom.value = false;
        startNewChat();
      } else {
        showScrollToBottom.value = false;
        startNewChat();
      }
    });

    startChat();

    authController.me();
  }

  Future<void> startChat() async {
    try {
      isLoading.value = true;
      hasError.value = false;
      errorMessage.value = "";

      final response = await _aiChatRepository.startChat("Hello");

      if (response.success) {
        aiChat.value = response.data;
        scrollToBottom();
      } else {
        hasError.value = true;
        errorMessage.value = response.message;
        AppHelpers.showSnackBar(title: "Error", message: response.message, isError: true);
      }
    } catch (e) {
      hasError.value = true;
      errorMessage.value = e.toString();
      AppHelpers.showSnackBar(title: "Error", message: errorMessage.value, isError: true);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> sendMessage(
      String content, String userId, String chatId) async {
    if (isSendingMessage.value) return; // prevent sending multiple
    try {
      isLoading.value = true;
      hasError.value = false;
      isSendingMessage.value = true;
      errorMessage.value = "";

      final response =
      await _aiChatRepository.sendMessage(content, chatId, userId);
      if (response.success) {
        messageModel.value = response.data;
        scrollToBottom();
      } else {
        hasError.value = true;
        errorMessage.value = response.message;
        AppHelpers.showSnackBar(title: "Error", message: response.message, isError: true);
      }
    } catch (e) {
      hasError.value = true;
      errorMessage.value = e.toString();
      AppHelpers.showSnackBar(title: "Error", message: errorMessage.value, isError: true);
    } finally {
      isLoading.value = false;
      isSendingMessage.value = false;
    }
  }

  // Role
  bool isAssistant(ChatMessage message) {
    return message.role?.toLowerCase() == "assistant";
  }

  bool isUser(ChatMessage message) {
    return message.role?.toLowerCase() == "user";
  }

  // functions
  void onSendMessageButtonPressed() {
    if (messageET.value.trim().isEmpty) return;

    final chatId = aiChat.value?.data?.id ?? "";
    final userId = StorageServices.to.userId.value.isEmpty ? aiChat.value?.data?.user ?? "guest" : currentUserId;

    sendMessage(messageET.value.trim(), userId.toString(), chatId);
    messageController.clear();
    scrollToBottom(force: true);
  }

  void startNewChat() {
    startChat();

    aiChat.value = null;
    messageModel.value = null;
    messageController.clear();

    isLoading.value = false;
    hasError.value = false;
    errorMessage.value = '';

    update();
    aiChat.refresh();
    messageModel.refresh();
  }

  // 👇 scroll helper
  void scrollToBottom({bool force = false}) {
    Future.delayed(const Duration(milliseconds: 300), () {
      if (scrollController.hasClients) {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeOut,
        );
      }
    });
  }

  // Navigation functions
  void goToProductDetails(String id) {
    Get.toNamed('/product/$id');
  }

  void goToAllListing() {
    Get.toNamed(Routes.allListing);
  }

  void goToProfile() {
    Get.toNamed(Routes.profile);
  }
}
