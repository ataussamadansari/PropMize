import 'package:dio/dio.dart';
import 'package:prop_mize/app/core/constants/api_constants.dart';
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

}
