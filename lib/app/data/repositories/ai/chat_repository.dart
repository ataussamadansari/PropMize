import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:prop_mize/app/core/constants/api_constants.dart';
import 'package:prop_mize/app/data/models/ai/chat_history_model.dart';
import 'package:prop_mize/app/data/models/ai/message_model.dart';
import 'package:prop_mize/app/data/models/api_response_model.dart';
import 'package:prop_mize/app/data/services/api_services.dart';

import '../../models/ai/ai_start_chat_model.dart';

class AiChatRepository
{
    final ApiServices _apiServices = ApiServices();
    CancelToken? _cancelToken;


    /// Start a new AI Chat
    Future<ApiResponse<AiStartChatModel>> startChat(String initialMessage) async
    {
        try
        {
            _cancelToken = CancelToken();

            final response = await _apiServices.post<AiStartChatModel>(
                ApiConstants.aiChat,
                (data) => AiStartChatModel.fromJson(data),
                data: 
                {
                    "initialMessage": initialMessage
                },
                cancelToken: _cancelToken
            );

            if (response.statusCode == 200 && response.data != null) 
            {
                return ApiResponse.success(
                    response.data!,
                    message: response.message
                );
            }
            else 
            {
                return ApiResponse.error(
                    response.message,
                    statusCode: response.statusCode
                );
            }
        }
        on DioException catch (e)
        {
            return ApiResponse.error(
                e.message ?? "Something went wrong",
                statusCode: e.response?.statusCode,
                errors: e.response?.data
            );
        }
    }

    /// Message
    Future<ApiResponse<MessageModel>> sendMessage(String message, String chatId, String userId) async {
        try {
            _cancelToken = CancelToken();

            // URL me chatId replace kar do
            final url = ApiConstants.sendMessage.replaceFirst("{id}", chatId);

            final response = await _apiServices.post(
                url,
                (data) => MessageModel.fromJson(data),
                data: {
                    "content": message,
                    "userId": userId,
                },
                cancelToken: _cancelToken
            );

            if (response.statusCode == 200 && response.data != null)
            {
                return ApiResponse.success(
                    response.data!,
                    message: response.message
                );
            }
            else
            {
                return ApiResponse.error(
                    response.message,
                    statusCode: response.statusCode
                );
            }

        } on DioException catch (e)
        {
            return ApiResponse.error(
                e.message ?? "Something went wrong",
                statusCode: e.response?.statusCode,
                errors: e.response?.data
            );
        }
    }

    /// Chat History
    Future<ApiResponse<ChatHistoryModel>> chatHistory({
        int page = 1,
        int limit = 10,
    }) async
    {
        try {
            _cancelToken = CancelToken();

            final Map<String, dynamic> queryParams = {
                'page': page,
                'limit': limit,
            };

            final response = await _apiServices.get<ChatHistoryModel>(
                ApiConstants.allChats,
                    (data) => ChatHistoryModel.fromJson(data),
                queryParameters: queryParams,
                cancelToken: _cancelToken
            );

            if (response.statusCode == 200 && response.data != null)
            {
                return ApiResponse.success(
                    response.data!,
                    message: response.message
                );
            }
            else
            {
                return ApiResponse.error(
                    response.message,
                    statusCode: response.statusCode
                );
            }
        }
        on DioException catch (e)
        {
            return ApiResponse.error(
                e.message ?? "Something went wrong",
                statusCode: e.response?.statusCode,
                errors: e.response?.data
            );
        }
    }


    /// Get Single Chat History (if you need to load a specific chat)
    Future<ApiResponse<AiStartChatModel>> getChatById(String chatId) async {
        try {
            _cancelToken = CancelToken();

            final url = ApiConstants.getChat.replaceAll('{id}', chatId);

            debugPrint("url: $url");

            final response = await _apiServices.get<AiStartChatModel>(
                url,
                    (data) => AiStartChatModel.fromJson(data),
                cancelToken: _cancelToken
            );

            if (response.statusCode == 200 && response.data != null)
            {
                return ApiResponse.success(
                    response.data!,
                    message: response.message
                );
            }
            else
            {
                return ApiResponse.error(
                    response.message,
                    statusCode: response.statusCode
                );
            }
        }
        on DioException catch (e)
        {
            return ApiResponse.error(
                e.message ?? "Something went wrong",
                statusCode: e.response?.statusCode,
                errors: e.response?.data
            );
        }
    }

    Future<ApiResponse<MessageModel>> deleteById(String chatId) async {
        try {
            _cancelToken = CancelToken();

            final url = ApiConstants.chatDeleteById.replaceAll('{id}', chatId);
            final response = await _apiServices.delete(
                url,
                (data) => MessageModel.fromJson(data),
                cancelToken: _cancelToken
            );

            if (response.success && response.data!= null) {
                return ApiResponse.success(response.data!, message: response.message);
            } else {
                return ApiResponse.error(response.message, statusCode: response.statusCode);
            }

        } on DioException catch (e) {
            return ApiResponse.error(
                e.message ?? "Something went wrong",
                statusCode: e.response?.statusCode,
                errors: e.response?.data
            );
        }
    }

    Future<ApiResponse<bool>> deleteAll() async {
        try {
            _cancelToken = CancelToken();

            final response = await _apiServices.delete(
                ApiConstants.chatAllDelete,
                    (data) => null,
                cancelToken: _cancelToken
            );

            if (response.success) {
                return ApiResponse.success(response.success, message: response.message);
            } else {
                return ApiResponse.error(
                    response.message,
                    statusCode: response.statusCode,
                    errors: response.data
                );
            }
        }
        on DioException catch (e) {
            return ApiResponse.error(
                e.message ?? "Something went wrong",
                statusCode: e.response?.statusCode,
                errors: e.response?.data
            );
        }
    }


    Future<void> cancelChat() async {
        _cancelToken?.cancel();
    }

}
