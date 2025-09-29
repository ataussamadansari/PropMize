import 'dart:io';

import 'package:dio/dio.dart';
import 'package:prop_mize/app/core/constants/api_constants.dart';
import 'package:prop_mize/app/data/models/api_response_model.dart';
import 'package:prop_mize/app/data/models/user/send_otp/send_otp_request.dart';
import 'package:prop_mize/app/data/models/user/user_me.dart';
import 'package:prop_mize/app/data/models/user/verify_otp/verify_otp_request.dart';
import 'package:prop_mize/app/data/models/user/verify_otp/verify_otp_response.dart';

import '../../models/user/send_otp/send_otp_response.dart';
import '../../services/api_services.dart';

class AuthRepository
{
    final ApiServices _apiServices = ApiServices();
    CancelToken? _cancelToken;

    Future<ApiResponse<SendOtpResponse>> sendOtp(SendOtpRequest request) async
    {
        try
        {
            final res = await _apiServices.post<SendOtpResponse>(
                ApiConstants.sendOtp,
                (data) => SendOtpResponse.fromJson(data),
                data: request.toJson(),
                cancelToken: _cancelToken
            );
            return res;
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

    Future<ApiResponse<VerifyOtpResponse>> verifyOtp(VerifyOtpRequest request) async
    {
        try
        {
            final response = await _apiServices.post<VerifyOtpResponse>(
                ApiConstants.verifyOtp,
                (data) => VerifyOtpResponse.fromJson(data),
                data: request.toJson(),
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

    // Me
    Future<ApiResponse<UserMe>> me() async
    {
        try
        {
            final response = await _apiServices.get(
                ApiConstants.me, 
                (data) => UserMe.fromJson(data),
                cancelToken: _cancelToken);

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

    // Update User
    /*Future<ApiResponse<UserMe>> updateDetails(Map<String, dynamic> data) async {
        try {
            final response = await _apiServices.put<UserMe>(
                ApiConstants.updateProfile,
                    (json) => UserMe.fromJson(json),
                data: data,
                cancelToken: _cancelToken,
            );

            if (response.statusCode == 200 && response.data != null) {
                return ApiResponse.success(
                    response.data!,
                    message: response.message,
                );
            } else {
                return ApiResponse.error(
                    response.message,
                    statusCode: response.statusCode,
                );
            }
        } on DioException catch (e) {
            return ApiResponse.error(
                e.message ?? "Something went wrong",
                statusCode: e.response?.statusCode,
                errors: e.response?.data,
            );
        }
    }*/

    Future<ApiResponse<UserMe>> updateDetails(Map<String, dynamic> data, {File? image}) async {
        try {
            FormData formData = FormData.fromMap(data);

            // Agar image hai to add kar do
            if (image != null) {
                formData.files.add(
                    MapEntry(
                        "avatar",
                        await MultipartFile.fromFile(image.path, filename: image.path.split("/").last),
                    ),
                );
            }

            final response = await _apiServices.put<UserMe>(
                ApiConstants.updateProfile,
                    (json) => UserMe.fromJson(json),
                data: formData,
                cancelToken: _cancelToken,
            );

            if (response.statusCode == 200 && response.data != null) {
                return ApiResponse.success(
                    response.data!,
                    message: response.message,
                );
            } else {
                return ApiResponse.error(
                    response.message,
                    statusCode: response.statusCode,
                );
            }
        } on DioException catch (e) {
            return ApiResponse.error(
                e.message ?? "Something went wrong",
                statusCode: e.response?.statusCode,
                errors: e.response?.data,
            );
        }
    }


}
