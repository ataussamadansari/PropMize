import 'package:dio/dio.dart';
import 'package:prop_mize/app/core/constants/api_constants.dart';
import 'package:prop_mize/app/data/models/api_response_model.dart';
import 'package:prop_mize/app/data/models/notification/notification_model.dart';
import 'package:prop_mize/app/data/services/api/api_services.dart';

import '../../models/notification/unread_count.dart';

class NotificationRepository {
    final ApiServices _apiServices = ApiServices();
    CancelToken? _cancelToken;

    Future<ApiResponse<NotificationModel>> fetchNotifications({
        int page = 1,
        int limit = 10
    }) async {
        _cancelToken = CancelToken();
        try {
            final response = await _apiServices.get(
                ApiConstants.notifications,
                    (json) => NotificationModel.fromJson(json),
                cancelToken: _cancelToken,
                queryParameters: {
                    'page': page,
                    'limit': limit
                }
            );

            if (response.statusCode == 200) {
                return ApiResponse.success(
                    response.data!,
                    message: response.message
                );
            } else {
                return ApiResponse.error(
                    response.message,
                    statusCode: response.statusCode,
                    errors: response.errors
                );
            }
        } on DioException catch (e) {
            return ApiResponse.error(
                e.message ?? "Something went wrong",
                statusCode: e.response?.statusCode,
                errors: e.response?.data
            );
        }
    }

    Future<ApiResponse<UnreadCount>> getUnreadCount() async {
        try {
            final response = await _apiServices.get(
                ApiConstants.unreadCount,
                (json) => UnreadCount.fromJson(json),
                cancelToken: _cancelToken
            );

            if (response.statusCode == 200) {
                return ApiResponse.success(
                    response.data!,
                    message: response.message
                );
            } else {
                return ApiResponse.error(
                    response.message,
                    statusCode: response.statusCode,
                    errors: response.errors
                );
            }
        } on DioException catch (e) {
            return ApiResponse.error(
                e.message ?? "Something went wrong",
                statusCode: e.response?.statusCode,
                errors: e.response?.data
            );
        }
    }

    Future<ApiResponse<dynamic>> markAsRead(String notificationId) async {
        try {
            final response = await _apiServices.put(
                ApiConstants.markAsRead.replaceFirst('{id}', notificationId),
                    (json) => json,
            );

            if (response.statusCode == 200) {
                return ApiResponse.success(
                    response.data,
                    message: response.message
                );
            } else {
                return ApiResponse.error(
                    response.message,
                    statusCode: response.statusCode,
                    errors: response.errors
                );
            }
        } on DioException catch (e) {
            return ApiResponse.error(
                e.message ?? "Something went wrong",
                statusCode: e.response?.statusCode,
                errors: e.response?.data
            );
        }
    }

    Future<ApiResponse<dynamic>> markAllAsRead() async {
        try {
            final response = await _apiServices.put(
                ApiConstants.markAllRead,
                    (json) => json,
            );

            if (response.statusCode == 200) {
                return ApiResponse.success(
                    response.data,
                    message: response.message
                );
            } else {
                return ApiResponse.error(
                    response.message,
                    statusCode: response.statusCode,
                    errors: response.errors
                );
            }
        } on DioException catch (e) {
            return ApiResponse.error(
                e.message ?? "Something went wrong",
                statusCode: e.response?.statusCode,
                errors: e.response?.data
            );
        }
    }

    Future<ApiResponse<dynamic>> deleteNotification(String notificationId) async {
        try {
            final response = await _apiServices.delete(
                ApiConstants.deleteNotification.replaceFirst('{id}', notificationId),
                    (json) => json,
            );

            if (response.statusCode == 200) {
                return ApiResponse.success(
                    response.data,
                    message: response.message
                );
            } else {
                return ApiResponse.error(
                    response.message,
                    statusCode: response.statusCode,
                    errors: response.errors
                );
            }
        } on DioException catch (e) {
            return ApiResponse.error(
                e.message ?? "Something went wrong",
                statusCode: e.response?.statusCode,
                errors: e.response?.data
            );
        }
    }

    Future<ApiResponse<dynamic>> clearAllNotifications() async {
        try {
            final response = await _apiServices.delete(
                ApiConstants.clearAllNotifications,
                    (json) => json,
            );

            if (response.statusCode == 200) {
                return ApiResponse.success(
                    response.data,
                    message: response.message
                );
            } else {
                return ApiResponse.error(
                    response.message,
                    statusCode: response.statusCode,
                    errors: response.errors
                );
            }
        } on DioException catch (e) {
            return ApiResponse.error(
                e.message ?? "Something went wrong",
                statusCode: e.response?.statusCode,
                errors: e.response?.data
            );
        }
    }

    void cancelRequest() {
        _cancelToken?.cancel();
    }
}