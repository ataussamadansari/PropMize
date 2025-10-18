import 'package:dio/dio.dart';

import '../../models/api_response_model.dart';
import '../../providers/api_provider.dart';

class ApiServices {
    final ApiProvider _apiProvider = ApiProvider();

    // generic method to handle API calls
    Future<ApiResponse<T>> handleApiCall<T>(
        Future<Response> Function() apiCall,
        T Function(dynamic) fromJson
        ) async
    {
        try
        {
            final response = await apiCall();

            if (response.statusCode == 200 || response.statusCode == 201)
            {
                final data = fromJson(response.data);
                return ApiResponse.success(data);
            }
            else
            {
                // 👇 Server se aaya hua actual error message use karo
                final errorMessage = _extractErrorMessage(response.data);
                return ApiResponse.error(
                    errorMessage ?? "Request failed with status: ${response.statusCode}",
                    statusCode: response.statusCode
                );
            }
        }
        on DioException catch (e)
        {
            // 👇 DioException se detailed error message extract karo
            final errorMessage = _extractDioErrorMessage(e);
            return ApiResponse.error(
                errorMessage,
                statusCode: e.response?.statusCode
            );
        }
        catch (e)
        {
            return ApiResponse.error(e.toString());
        }
    }

    // 👇 DioException se detailed error message extract karne ka method
    String _extractDioErrorMessage(DioException e) {
        // Agar response mein server ne koi message diya hai to use karo
        if (e.response != null && e.response!.data != null) {
            final serverMessage = _extractErrorMessage(e.response!.data);
            if (serverMessage != null) {
                return serverMessage;
            }
        }

        // Agar server message nahi hai to DioException ka message use karo
        if (e.message != null && e.message!.isNotEmpty) {
            return e.message!;
        }

        // Default messages based on error type
        switch (e.type) {
            case DioExceptionType.connectionTimeout:
                return "Connection timeout occurred";
            case DioExceptionType.sendTimeout:
                return "Send timeout occurred";
            case DioExceptionType.receiveTimeout:
                return "Receive timeout occurred";
            case DioExceptionType.badCertificate:
                return "Bad certificate";
            case DioExceptionType.badResponse:
                return "Bad response from server";
            case DioExceptionType.cancel:
                return "Request was cancelled";
            case DioExceptionType.connectionError:
                return "Connection error - please check your internet";
            case DioExceptionType.unknown:
                return "Unknown error occurred";
        }
    }

    // 👇 Server response se error message extract karne ka method
    String? _extractErrorMessage(dynamic responseData) {
        try {
            if (responseData is Map<String, dynamic>) {
                // Common error response formats
                if (responseData['message'] != null) {
                    return responseData['message'].toString();
                }
                if (responseData['error'] != null) {
                    return responseData['error'].toString();
                }
                if (responseData['errors'] != null) {
                    // Agar multiple errors hain to first error show karo
                    final errors = responseData['errors'];
                    if (errors is Map && errors.isNotEmpty) {
                        final firstError = errors.values.first;
                        if (firstError is List) {
                            return firstError.first.toString();
                        }
                        return firstError.toString();
                    }
                }
            }
            return null;
        } catch (e) {
            return null;
        }
    }

    // generic method to handle List API calls
    Future<ApiResponse<List<T>>> handleListApiCall<T>(
        Future<Response> Function() apiCall,
        T Function(dynamic) fromJson
        ) async
    {
        try
        {
            final response = await apiCall();

            if (response.statusCode == 200 || response.statusCode == 201)
            {
                final List<dynamic> jsonList = response.data;
                final List<T> dataList = jsonList.map((json) => fromJson(json as Map<String, dynamic>)).toList();
                return ApiResponse.success(dataList);
            }
            else
            {
                final errorMessage = _extractErrorMessage(response.data);
                return ApiResponse.error(
                    errorMessage ?? "Request failed with status: ${response.statusCode}",
                    statusCode: response.statusCode
                );
            }
        }
        on DioException catch (e)
        {
            final errorMessage = _extractDioErrorMessage(e);
            return ApiResponse.error(
                errorMessage,
                statusCode: e.response?.statusCode
            );
        }
        catch (e)
        {
            return ApiResponse.error(e.toString());
        }
    }

    // specific GET method for API calls
    Future<ApiResponse<T>> get<T>(
        String endPint,
        T Function(dynamic) fromJson, {
            Map<String, dynamic>? queryParameters,
            CancelToken? cancelToken
        }) async
    {
        return handleApiCall<T>(
                () => _apiProvider.get(
                endPint,
                queryParameters: queryParameters,
                cancelToken: cancelToken
            ),
            fromJson
        );
    }

    // specific Post method for List
    Future<ApiResponse<List<T>>> getList<T>(
        String endPint,
        T Function(dynamic) fromJson, {
            Map<String, dynamic>? queryParameters,
            CancelToken? cancelToken
        }) async
    {
        return handleListApiCall<T>(
                () => _apiProvider.get(
                endPint,
                queryParameters: queryParameters,
                cancelToken: cancelToken
            ),
            fromJson
        );
    }

    // specific POST method
    Future<ApiResponse<T>> post<T>(
        String endPint,
        T Function(dynamic) fromJson, {
            dynamic data,
            Map<String, dynamic>? queryParameters,
            CancelToken? cancelToken
        }) async
    {
        return handleApiCall<T>(
                () => _apiProvider.post(
                endPint,
                data: data,
                queryParameters: queryParameters,
                cancelToken: cancelToken
            ),
            fromJson
        );
    }

    // specific PUT method
    Future<ApiResponse<T>> put<T>(
        String endPint,
        T Function(dynamic) fromJson, {
            dynamic data,
            Map<String, dynamic>? queryParameters,
            CancelToken? cancelToken
        }) async
    {
        return handleApiCall<T>(
                () => _apiProvider.put(
                endPint,
                data: data,
                queryParameters: queryParameters,
                cancelToken: cancelToken
            ),
            fromJson
        );
    }

    // specific DELETE method
    Future<ApiResponse<T>> delete<T>(
        String endPint,
        T Function(dynamic) fromJson, {
            dynamic data,
            Map<String, dynamic>? queryParameters,
            CancelToken? cancelToken
        }) async
    {
        return handleApiCall<T>(
                () => _apiProvider.delete(
                endPint,
                data: data,
                queryParameters: queryParameters,
                cancelToken: cancelToken
            ),
            fromJson
        );
    }
}
