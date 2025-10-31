import 'package:dio/dio.dart';
import 'package:prop_mize/app/core/constants/api_constants.dart';
import 'package:prop_mize/app/data/models/leads/lead_details_model.dart';
import 'package:prop_mize/app/data/models/leads/leads_model.dart';

import '../../models/api_response_model.dart';
import '../../services/api/api_services.dart';

class LeadsRepository {

  final ApiServices _apiServices = ApiServices();
  CancelToken? _cancelToken;

  // ---------------------------------------------------------------------------
  // 🔎 Leads Functions
  // ---------------------------------------------------------------------------

  Future<ApiResponse<LeadsModel>> getLeads({int page = 1, int limit = 10}) async {
    try {
      _cancelToken = CancelToken();

      final queryParams =
      {
        'page': page,
        'limit': limit
      };

      final response = await _apiServices.get(
        ApiConstants.leads,
        (json) => LeadsModel.fromJson(json),
        queryParameters: queryParams,
        cancelToken: _cancelToken,
      );

      if(response.success && response.data != null) {
        return _handleApiResponse(response);
      } else {
        return ApiResponse.error(
          response.message,
          statusCode: response.statusCode,
        );
      }
    }
    on DioException catch (e)
    {
      return _handleDioError<LeadsModel>(e);
    }
  }

  // ---------------------------------------------------------------------------
  // View Lead Functions
  // ---------------------------------------------------------------------------
  Future<ApiResponse<LeadDetailsModel>> viewLead(String leadId) async {
    try {
      _cancelToken = CancelToken();

      final response = await _apiServices.get(
        ApiConstants.singleLead.replaceFirst('{id}', leadId),
        (json) => LeadDetailsModel.fromJson(json),
        cancelToken: _cancelToken,
      );

      if(response.success && response.data != null) {
        return _handleApiResponse(response);
      } else {
        return ApiResponse.error(
          response.message,
          statusCode: response.statusCode,
        );
      }
    }
    on DioException catch (e)
    {
      return _handleDioError<LeadDetailsModel>(e);
    }
  }

  // ---------------------------------------------------------------------------
  // ❌ Cancel Ongoing Requests
  // ---------------------------------------------------------------------------
  void cancelRequests()
  {
    if (_cancelToken != null && !_cancelToken!.isCancelled)
    {
      _cancelToken?.cancel('🔴 Request manually cancelled');
    }
  }


  // ---------------------------------------------------------------------------
  // 🧩 Helper Functions
  // ---------------------------------------------------------------------------
  ApiResponse<T> _handleApiResponse<T>(ApiResponse<T> response)
  {
    if (response.statusCode == 200 && response.data != null)
    {
      return ApiResponse.success(response.data!, message: response.message);
    }
    else
    {
      return ApiResponse.error(response.message, statusCode: response.statusCode);
    }
  }

  ApiResponse<T> _handleDioError<T>(DioException e)
  {
    return ApiResponse.error(
        e.message ?? "Something went wrong",
        statusCode: e.response?.statusCode,
        errors: e.response?.data
    );
  }

}