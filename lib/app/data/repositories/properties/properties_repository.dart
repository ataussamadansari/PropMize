import 'package:dio/dio.dart';
import 'dart:convert';
import 'dart:io';
import 'package:prop_mize/app/data/models/properties/analytics/analytics_model.dart';
import 'package:prop_mize/app/data/models/properties/my_property/my_property_model.dart';
import '../../../core/constants/api_constants.dart';
import '../../../data/models/api_response_model.dart';
import '../../../data/models/like/like_model.dart';
import '../../../data/models/properties/contacted_seller/contacted_seller_model.dart';
import '../../../data/models/properties/contacted_seller/contacted_seller_request.dart';
import '../../../data/models/properties/contacted_seller/my_inquiries.dart';
import '../../../data/models/properties/properties_model.dart';
import '../../../data/models/properties/property_by_id_model.dart';
import '../../../data/services/api/api_services.dart';

class PropertiesRepository
{
    final ApiServices _apiServices = ApiServices();
    CancelToken? _cancelToken;

    // ---------------------------------------------------------------------------
    // 🏠 Get All Properties (Paginated + Filtered)
    // ---------------------------------------------------------------------------
    Future<ApiResponse<PropertiesModel>> getProperties({
        int page = 1,
        int limit = 10,
        Map<String, dynamic>? filters
    }) async
    {
        try
        {
            _cancelToken = CancelToken();

            final queryParams =
                {
                    'page': page,
                    'limit': limit,
                    if (filters != null) ...filters
                };

            final response = await _apiServices.get(
                ApiConstants.properties,
                (data) => PropertiesModel.fromJson(data),
                queryParameters: queryParams,
                cancelToken: _cancelToken
            );

            return _handleApiResponse(response);
        }
        on DioException catch (e)
        {
            return _handleDioError<PropertiesModel>(e);
        }
    }

    // ---------------------------------------------------------------------------
    // 🔍 Search Properties
    // ---------------------------------------------------------------------------
    Future<ApiResponse<PropertiesModel>> searchProperties({
        required String query,
        int page = 1,
        int limit = 10,
        Map<String, dynamic>? filters
    }) async
    {
        try
        {
            _cancelToken = CancelToken();

            final queryParams =
                {
                    'q': query,
                    'page': page,
                    'limit': limit,
                    if (filters != null) ...filters
                };

            final response = await _apiServices.get(
                ApiConstants.searchProperties,
                (data) => PropertiesModel.fromJson(data),
                queryParameters: queryParams,
                cancelToken: _cancelToken
            );

            return _handleApiResponse(response);
        }
        on DioException catch (e)
        {
            return _handleDioError<PropertiesModel>(e);
        }
    }

    // ---------------------------------------------------------------------------
    // 🧩 Get Properties By Filters
    // ---------------------------------------------------------------------------
    Future<ApiResponse<PropertiesModel>> getPropertiesByFilters({
        required Map<String, dynamic> filters,
        int page = 1,
        int limit = 10
    }) async
    {
        try
        {
            _cancelToken = CancelToken();

            final queryParams =
                {
                    'page': page,
                    'limit': limit,
                    ...filters
                };

            final response = await _apiServices.get(
                ApiConstants.properties,
                (data) => PropertiesModel.fromJson(data),
                queryParameters: queryParams,
                cancelToken: _cancelToken
            );

            return _handleApiResponse(response);
        }
        on DioException catch (e)
        {
            return _handleDioError<PropertiesModel>(e);
        }
    }

    // ---------------------------------------------------------------------------
    // 🏡 Get Property By ID
    // ---------------------------------------------------------------------------
    Future<ApiResponse<PropertyByIdModel>> getPropertyById(String id) async
    {
        try
        {
            _cancelToken = CancelToken();

            final url = ApiConstants.singleProperty.replaceFirst("{id}", id);

            final response = await _apiServices.get(
                url,
                (data) => PropertyByIdModel.fromJson(data),
                cancelToken: _cancelToken
            );

            return _handleApiResponse(response);
        }
        on DioException catch (e)
        {
            return _handleDioError<PropertyByIdModel>(e);
        }
    }

    // ---------------------------------------------------------------------------
    // 📞 Contacted Seller
    // ---------------------------------------------------------------------------
    Future<ApiResponse<ContactedSellerModel>> contactedSeller(ContactedSellerRequest request) async
    {
        try
        {
            final response = await _apiServices.post(
                ApiConstants.leads,
                (data) => ContactedSellerModel.fromJson(data),
                data: request.toJson(),
                cancelToken: _cancelToken
            );

            return _handleApiResponse(response);
        }
        on DioException catch (e)
        {
            return _handleDioError<ContactedSellerModel>(e);
        }
        catch (e)
        {
            return ApiResponse.error("❌ Failed to contact seller: ${e.toString()}");
        }
    }

    // ---------------------------------------------------------------------------
    // ❤️ Like / Dislike Property
    // ---------------------------------------------------------------------------
    Future<ApiResponse<LikeModel>> like(String id) async
    {
        try
        {
            _cancelToken = CancelToken();
            final url = ApiConstants.likeProperty.replaceFirst("{id}", id);

            final response = await _apiServices.post(
                url,
                (data) => LikeModel.fromJson(data),
                cancelToken: _cancelToken
            );

            return _handleApiResponse(response);
        }
        on DioException catch (e)
        {
            return _handleDioError<LikeModel>(e);
        }
    }

    // ---------------------------------------------------------------------------
    // 💾 Get Liked Properties
    // ---------------------------------------------------------------------------
    Future<ApiResponse<PropertiesModel>> getLikedProperties({
        int page = 1,
        int limit = 10
    }) async
    {
        try
        {
            _cancelToken = CancelToken();

            final queryParams =
                {
                    'page': page,
                    'limit': limit
                };

            final response = await _apiServices.get(
                ApiConstants.likedProperties,
                (data) => PropertiesModel.fromJson(data),
                queryParameters: queryParams,
                cancelToken: _cancelToken
            );

            return _handleApiResponse(response);
        }
        on DioException catch (e)
        {
            return _handleDioError<PropertiesModel>(e);
        }
    }

    // ---------------------------------------------------------------------------
    // 👁️ Get Recent Viewed Properties
    // ---------------------------------------------------------------------------
    Future<ApiResponse<PropertiesModel>> getRecentViewedProperties() async
    {
        try
        {
            _cancelToken = CancelToken();

            final response = await _apiServices.get(
                ApiConstants.recentlyViewed,
                (data) => PropertiesModel.fromJson(data),
                cancelToken: _cancelToken
            );

            return _handleApiResponse(response);
        }
        on DioException catch (e)
        {
            return _handleDioError<PropertiesModel>(e);
        }
    }

    // ---------------------------------------------------------------------------
    // 📬 Get Contacted Leads (My Inquiries)
    // ---------------------------------------------------------------------------
    Future<ApiResponse<MyInquiries>> getContactedLeads({
        int page = 1,
        int limit = 10
    }) async
    {
        try
        {
            _cancelToken = CancelToken();

            final queryParams =
                {
                    'page': page,
                    'limit': limit
                };

            final response = await _apiServices.get(
                ApiConstants.myInquiries,
                (data) => MyInquiries.fromJson(data),
                queryParameters: queryParams,
                cancelToken: _cancelToken
            );

            return _handleApiResponse(response);
        }
        on DioException catch (e)
        {
            return _handleDioError<MyInquiries>(e);
        }
    }

    // ---------------------------------------------------------------------------
    // 💾 Get My Properties
    // ---------------------------------------------------------------------------
    Future<ApiResponse<MyPropertyModel>> getMyProperties({
        int page = 1,
        int limit = 10
    }) async
    {
        try
        {
            _cancelToken = CancelToken();

            final queryParams =
                {
                    'page': page,
                    'limit': limit
                };

            final response = await _apiServices.get(
                ApiConstants.myProperties,
                (data) => MyPropertyModel.fromJson(data),
                queryParameters: queryParams,
                cancelToken: _cancelToken
            );

            return _handleApiResponse(response);
        }
        on DioException catch (e)
        {
            return _handleDioError<MyPropertyModel>(e);
        }
    }
    // ---------------------------------------------------------------------------
    // 💾 Get Analytics Properties
    // ---------------------------------------------------------------------------
    Future<ApiResponse<AnalyticsModel>> analyticsProperty({
        String period = '30d'
    }) async
    {
        try
        {
            _cancelToken = CancelToken();

            final queryParams =
                {
                    'period': period
                };

            final response = await _apiServices.get(
                ApiConstants.sellerPropertiesAnalytics,
                (data) => AnalyticsModel.fromJson(data),
                queryParameters: queryParams,
                cancelToken: _cancelToken
            );

            return _handleApiResponse(response);
        }
        on DioException catch (e)
        {
            return _handleDioError<AnalyticsModel>(e);
        }
    }

    // ---------------------------------------------------------------------------
    // 💾 Create Property
    // ---------------------------------------------------------------------------
    Future<ApiResponse<PropertyByIdModel>> createProperty(Map<String, dynamic> payload) async
    {
        try
        {
            _cancelToken = CancelToken();

            // 1. Extract image paths and remove them from the main payload
            final List<String> imagePaths = List<String>.from(payload.remove('images') ?? []);

            // 2. Create MultipartFile objects from paths
            final List<MultipartFile> imageFiles = [];
            for (final path in imagePaths) {
                final fileName = path.split('/').last;
                imageFiles.add(await MultipartFile.fromFile(path, filename: fileName));
            }

            // 3. Create FormData and add image files
            final formData = FormData.fromMap({
                'images': imageFiles,
            });

            // 4. Add all other payload fields to the FormData
            // Complex objects (Maps, Lists) must be sent as JSON encoded strings
            payload.forEach((key, value) {
                if (value != null) {
                    if (value is Map || value is List) {
                        formData.fields.add(MapEntry(key, json.encode(value)));
                    } else {
                        formData.fields.add(MapEntry(key, value.toString()));
                    }
                }
            });

            // 5. Use the post method from ApiServices, but pass FormData
            // Make sure your ApiServices().post can handle a 'data' of type dynamic
            final response = await _apiServices.post(
                ApiConstants.properties,
                    (data) => PropertyByIdModel.fromJson(data),
                data: formData,
                cancelToken: _cancelToken,
            );

            return _handleApiResponse(response);
        }
        on DioException catch (e)
        {
            return _handleDioError<PropertyByIdModel>(e);
        }
        catch (e)
        {
            return ApiResponse.error("❌ Failed to create property: ${e.toString()}");
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
