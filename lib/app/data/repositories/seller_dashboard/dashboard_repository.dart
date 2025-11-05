import 'package:dio/dio.dart';
import 'package:prop_mize/app/core/constants/api_constants.dart';
import 'package:prop_mize/app/data/models/seller_dashboard/seller_dashboard_model.dart';

import '../../models/api_response_model.dart';
import '../../services/api/api_services.dart';

class DashboardRepository {

  final ApiServices _apiServices = ApiServices();
  CancelToken? _cancelToken;

  // ---------------------------------------------------------------------------
  // 💻 Fetch Dashboard Data Functions
  // ---------------------------------------------------------------------------
  Future<ApiResponse<SellerDashboardModel>> fetchDashboardData() async {
    try {
      _cancelToken = CancelToken();

      final response = await _apiServices.get(
        ApiConstants.sellerDashboard,
        (json) => SellerDashboardModel.fromJson(json),
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
      return _handleDioError<SellerDashboardModel>(e);
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
      return ApiResponse.success(response.data as T, message: response.message);
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