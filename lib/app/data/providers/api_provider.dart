import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart' as getx;
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../../core/constants/api_constants.dart';
import '../services/storage_services.dart';

class ApiProvider {
  static ApiProvider? _instance;
  late Dio _dio;
  final _storageService = getx.Get.find<StorageServices>();

  ApiProvider._internal() {
    _dio = Dio();
    _initializeInterceptors();
  }

  factory ApiProvider() {
    _instance ??= ApiProvider._internal();
    return _instance!;
  }

  void _initializeInterceptors() {
    _dio.options = BaseOptions(
      baseUrl: ApiConstants.baseUrl,
      connectTimeout: Duration(milliseconds: ApiConstants.connectTimeout),
      receiveTimeout: Duration(milliseconds: ApiConstants.receiveTimeout),
      sendTimeout: Duration(milliseconds: ApiConstants.sendTimeout),
      headers: {
        'Content-Type': ApiConstants.contentType,
        'Accept': ApiConstants.contentType
      }
    );

    // Request Interceptor
    _dio.interceptors.add(
      InterceptorsWrapper(onRequest: (options, handler) async {
        final token = _storageService.getToken();
        if(token != null) {
          options.headers[ApiConstants.authorization] = 'Bearer $token';
        }

        // Add language headers
        final language = _storageService.getLanguage() ?? 'en';
        options.headers[ApiConstants.acceptLanguage] = language;

        // check connectivity
        final connectivity = Connectivity().checkConnectivity();
        if(connectivity == ConnectivityResult.none) {
          throw DioException(
              requestOptions: options,
              error: "No Internet connection",
              type: DioExceptionType.connectionError
          );
        }

        handler.next(options);
      },
      onResponse: (response, handler) {
        handler.next(response);
      },
      onError: (error, handler) async {
        if (error.response?.statusCode == 401) {
          await _handleTokenExpiration();
        }
        handler.next(error);
      }
      )
    );

    // logger Interceptor (only for debug mode)
    if (getx.Get.isLogEnable) {
      _dio.interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseHeader: true,
        responseBody: true,
        error: true,
        compact: true
      ));
    }
  }

  Future<void> _handleTokenExpiration() async {
    _storageService.removeToken();
    // Navigate to login screen or perform other actions
    getx.Get.offAllNamed('/login');
  }

  // Create API call
  Future<Response> get(String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      final response = await _dio.get(
        path,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken
      );
      return response;
    } catch (e) {
      throw _handleError(e);
    }
  }

  // Genric Post call
  Future<Response> post(String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      final response = await _dio.post(
          path,
          data: data,
          queryParameters: queryParameters,
          options: options,
          cancelToken: cancelToken
      );
      return response;
    } catch (e) {
      throw _handleError(e);
    }
  }

  // Genric Put call
  Future<Response> put(String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      final response = await _dio.put(
          path,
          data: data,
          queryParameters: queryParameters,
          options: options,
          cancelToken: cancelToken
      );
      return response;
    } catch (e) {
      throw _handleError(e);
    }
  }

  // Genric Delete call
  Future<Response> delete(String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      final response = await _dio.delete(
          path,
          data: data,
          queryParameters: queryParameters,
          options: options,
          cancelToken: cancelToken
      );
      return response;
    } catch (e) {
      throw _handleError(e);
    }
  }

  _handleError(dynamic error) {
    if (error is DioException) {
      switch (error.type) {
        case DioExceptionType.connectionTimeout:
          return Exception('Connection timeout');
        case DioExceptionType.sendTimeout:
          return Exception('Send timeout');
        case DioExceptionType.receiveTimeout:
          return Exception('Receive timeout');
        case DioExceptionType.badResponse:
          return Exception(_handleStatusCode(error.response?.statusCode));
        case DioExceptionType.cancel:
          return Exception('Request canceled');
        case DioExceptionType.unknown:
          return Exception('Unknown error');
        default:
          return Exception('Something went wrong');
      }
    }
  }

  _handleStatusCode(int? statusCode) {
    switch(statusCode) {
      case 400: return 'Bad Request';
      case 401: return 'Unauthorized';
      case 403: return 'Forbidden';
      case 404: return 'Not Found';
      case 409: return 'Conflict';
      case 500: return 'Internal Server Error';
      case 502: return 'Bad Gateway';
      case 503: return 'Service Unavailable';
      default: return 'Something went wrong';

    }
  }

}