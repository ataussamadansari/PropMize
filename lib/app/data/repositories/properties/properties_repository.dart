
import 'package:dio/dio.dart';
import 'package:prop_mize/app/core/constants/api_constants.dart';
import 'package:prop_mize/app/data/models/api_response_model.dart';
import 'package:prop_mize/app/data/models/properties/properties_model.dart';
import 'package:prop_mize/app/data/models/properties/property_by_id_model.dart';
import 'package:prop_mize/app/data/services/api_services.dart';

import '../../models/like/like_model.dart';

class PropertiesRepository
{
    final ApiServices _apiServices = ApiServices();
    CancelToken? _cancelToken;

    /// Get all properties with pagination and filters
    Future<ApiResponse<PropertiesModel>> getProperties({
        int page = 1,
        int limit = 5,
        Map<String, dynamic>? filters
    }) async
    {
        try
        {
            _cancelToken = CancelToken();

            // Build query parameters
            final Map<String, dynamic> queryParams =
                {
                    'page': page,
                    'limit': limit
                };

            // Add filters if provided
            if (filters != null)
            {
                queryParams.addAll(filters);
            }

            final response = await _apiServices.get(
                ApiConstants.properties,
                (data) => PropertiesModel.fromJson(data),
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

    /// Get properties with search
    Future<ApiResponse<PropertiesModel>> searchProperties({
        required String query,
        int page = 1,
        int limit = 10,
        Map<String, dynamic>? filters // add this
    }) async
    {
        try
        {
            _cancelToken = CancelToken();

            final Map<String, dynamic> queryParams =
                {
                    'q': query,
                    'page': page,
                    'limit': limit,
                    if (filters != null) ...filters // merge filters
                };

            final response = await _apiServices.get(
                ApiConstants.searchProperties,
                (data) => PropertiesModel.fromJson(data),
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

    /// Get properties by filters
    Future<ApiResponse<PropertiesModel>> getPropertiesByFilters({
        required Map<String, dynamic> filters,
        int page = 1,
        int limit = 10
    }) async
    {
        try
        {
            _cancelToken = CancelToken();

            final Map<String, dynamic> queryParams =
                {
                    'page': page,
                    'limit': limit
                };
            filters.addAll(queryParams);
            // queryParams.addAll(filters);

            final response = await _apiServices.get(
                ApiConstants.properties,
                (data) => PropertiesModel.fromJson(data),
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

    Future<ApiResponse<PropertyByIdModel>> getPropertyById(String id) async
    {
        try
        {
            _cancelToken = CancelToken();

            // URL me chatId replace kar do
            final url = ApiConstants.singleProperty.replaceFirst("{id}", id);

            final response = await _apiServices.get(
                url,
                (data) => PropertyByIdModel.fromJson(data),
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

    /// Like - Dislike
    Future<ApiResponse<LikeModel>> like(String id) async
    {
        try
        {
            _cancelToken = CancelToken();

            // URL me chatId replace kar do
            final url = ApiConstants.likeProperty.replaceFirst("{id}", id);

            final res = await _apiServices.post(
                url,
                (data) => LikeModel.fromJson(data),
                cancelToken: _cancelToken
            );

            if (res.statusCode == 200 && res.data != null)
            {
                return ApiResponse.success(
                    res.data!,
                    message: res.message
                );
            }
            else
            {
                return ApiResponse.error(
                    res.message,
                    statusCode: res.statusCode
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

    /// Liked Properties
    Future<ApiResponse<PropertiesModel>> getLikedProperties({
        int page = 1,
        int limit = 10
    }) async
    {
        try
        {
            _cancelToken = CancelToken();

            final Map<String, dynamic> queryParams =
            {
                'page': page,
                'limit': limit
            };

            final res = await _apiServices.get(
                ApiConstants.likedProperties,
                (data) => PropertiesModel.fromJson(data),
                queryParameters: queryParams,
                cancelToken: _cancelToken
            );

            if (res.statusCode == 200 && res.data != null)
            {
                return ApiResponse.success(
                    res.data!,
                    message: res.message
                );
            }
            else
            {
                return ApiResponse.error(
                    res.message,
                    statusCode: res.statusCode
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

    /// Cancel ongoing requests
    void cancelRequests()
    {
        _cancelToken?.cancel('Request cancelled');
    }
}
