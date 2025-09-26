
import 'package:dio/dio.dart';
import 'package:prop_mize/app/core/constants/api_constants.dart';
import 'package:prop_mize/app/data/models/api_response_model.dart';
import 'package:prop_mize/app/data/models/properties/property_by_id_model.dart';
import 'package:prop_mize/app/data/services/api_services.dart';

import '../../models/like/like_model.dart';

class PropertiesRepository
{
    final ApiServices _apiServices = ApiServices();
    CancelToken? _cancelToken;

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

            if (response.statusCode == 200 && response.data != null) {
                return ApiResponse.success(
                    response.data!,
                    message: response.message
                );
            } else {
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

            if (res.statusCode == 200 && res.data != null) {
                return ApiResponse.success(
                    res.data!,
                    message: res.message
                );
            } else {
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

}
