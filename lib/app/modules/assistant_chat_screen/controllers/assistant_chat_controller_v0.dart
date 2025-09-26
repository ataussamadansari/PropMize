import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prop_mize/app/core/utils/helpers.dart';
import 'package:prop_mize/app/data/models/ai/ai_start_chat_model.dart';
import 'package:prop_mize/app/data/repositories/ai/chat_repository.dart';
import 'package:prop_mize/app/routes/app_routes.dart';

import '../../../data/models/ai/message_model.dart';


class AssistantChatController extends GetxController {

  final AiChatRepository _aiChatRepository = AiChatRepository();

  // Reactive Variables
  final aiChat = Rxn<AiStartChatModel>();
  final messageModel = Rxn<MessageModel>();
  final RxBool isLoading = false.obs;
  final RxBool hasError = false.obs;
  final RxString errorMessage = "".obs;

  // Message EditText
  var messageET = ''.obs;

  // TextEditingControllers
  late TextEditingController messageController;

  @override
  void onInit()
  {
    super.onInit();
    messageController = TextEditingController();

    // Text change listener
    messageController.addListener(() {
      messageET.value = messageController.text;
    });


    startChat();
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
      AppHelpers.showSnackBar(title: "Catch Error", message: errorMessage.value, isError: true);
    }
    finally
    {
      isLoading.value = false;
    }
  }

  Future<void> sendMessage(String content, String userId, String chatId) async {
    try {
      isLoading.value = true;
      hasError.value = false;
      errorMessage.value = "";

      final response = await _aiChatRepository.sendMessage(content, chatId, userId);
      if (response.success)
      {
        messageModel.value = response.data;
      }
      else
      {
        hasError.value = true;
        errorMessage.value = response.message;
        AppHelpers.showSnackBar(title: "Error", message: response.message, isError: true);
      }

    } catch (e) {
      hasError.value = true;
      errorMessage.value = e.toString();
      AppHelpers.showSnackBar(title: "Catch Error", message: errorMessage.value, isError: true);
    } finally {
      isLoading.value = false;
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
    final userId = aiChat.value?.data?.user ?? "";

    sendMessage(messageET.value.trim(), userId, chatId);
    messageController.clear();
  }

  void startNewChat() {
    startChat();

    // purane messages clear karo
    aiChat.value = null;
    messageModel.value = null;

    // message input field clear karo
    messageController.clear();

    // Loading/Errors reset
    isLoading.value = false;
    hasError.value = false;
    errorMessage.value = '';

    // UI ko refresh karao
    update();
    // ya
    aiChat.refresh();
    messageModel.refresh();
  }


  void goToProfile() {
    Get.toNamed(Routes.profile);
  }
}