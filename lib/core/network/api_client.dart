import 'package:dio/dio.dart';
import 'package:doktor_randevu/core/error/exception.dart';
import 'package:doktor_randevu/core/network/api_response.dart';
import 'package:doktor_randevu/core/network/error_response.dart';
import 'package:doktor_randevu/core/network/urls.dart';

import '../util/local_storage.dart';

class ApiClient {
  final Dio dio = Dio(BaseOptions(baseUrl: Urls.baseUrl));

  static final ApiClient _singletone = ApiClient._();

  factory ApiClient() => _singletone;

  ApiClient._() {
    _createInterceptor();
  }
  Dio get dioI => dio;
  _createInterceptor() {
    dio.interceptors.add(
      InterceptorsWrapper(
        onError: (e, handler) async {
          if (e.response != null && e.response?.data != null) {
            if (e.response?.statusCode == 401) {
              final errorModel = ErrorResponse.fromJson(e.response!.data);
              if (errorModel.code == 419) {
                final isRefreshed = await _refreshToken();
                if (isRefreshed) {
                  final options = e.response!.requestOptions;
                  options.headers['X-Token'] = await LocalStorage.getToken();
                  final response = await dioI.request(
                    options.path,
                    options: Options(method: options.method, headers: options.headers),
                    data: options.data,
                    queryParameters: options.queryParameters,
                  );
                  return handler.resolve(response);
                }
              }
            }
            handler.resolve(e.response!);
          } else {
            handler.next(e);
          }
        },
        onRequest: (options, handler) async {
          if (options.path.contains(Urls.refreshToken)) {
            return handler.next(options);
          }
          final token = await LocalStorage.getToken();
          if (token != null && token != '') {
            options.headers.addAll({"Accept": 'application/json', 'Content-Type': 'application/json', 'X-Token': token, 'X-Company-Login': "DoktorRandevu"});
          }
          options.responseType = ResponseType.json;
          return handler.next(options);
        },
        onResponse: (e, handler) {
          if (e.statusCode == 200) {
            handler.next(e);
          } else {
            throw AppException();
          }
        },
      ),
    );
  }

  Future<bool> _refreshToken() async {
    try {
      final refreshToken = await LocalStorage.getRefreshToken(); // Get the refresh token from local storage
      final companyLogin = "DoktorRandevu"; // Replace with your actual company login
      // Prepare request data
      final requestData = {
        'company': companyLogin,
        'refresh_token': refreshToken,
      };

      // Make the POST request to refresh the token
      final response = await dio.post(
        Urls.refreshToken,
        data: requestData,
      );
      if (response.statusCode == 200) {
        final newToken = response.data['token'];
        await LocalStorage.setToken(newToken);
        return true;
      }
    } on DioException catch (e) {
      // Handle specific error cases
      if (e.response?.statusCode == 400) {
        print("Bad Request: ${e.response?.data}"); // Handle bad request
      } else if (e.response?.statusCode == 403) {
        print("Access Denied: ${e.response?.data}"); // Handle access denied
      } else {
        print("Failed to refresh token: ${e.message}"); // General error handling
      }
    }
    return false; // Return false if refresh fails
  }

  Future<ApiResponse<T>> getRequest<T>(String endpoint, {Map<String, dynamic>? parameters, required T Function(dynamic) fromJson}) async {
    try {
      ApiResponse<T> apiResponse = ApiResponse<T>(status: ApiResult.Loading);
      final response = await dioI.get(endpoint, queryParameters: parameters);
      return _handleResponse(response, fromJson);
    } catch (e) {
      if (e is DioException) {
        return _handleError(e);
      } else {
        // Handle any non-Dio-related exceptions
        print("Unknown error: $e");
        return ApiResponse<T>(
          status: ApiResult.Error,
          message: "Unknown error: $e",
        );
      }
    }
  }

  Future<ApiResponse<T>?> postRequest<T>(String endpoint, {Map<String, dynamic>? parameters, required T Function(dynamic) fromJson}) async {
    try {
      final response = await dioI.post(endpoint, data: parameters);
      return _handleResponse(response, fromJson);
    } catch (e) {
      if (e is DioException) {
        return _handleError(e);
      } else {
        return ApiResponse<T>(
          status: ApiResult.Error,
          message: "Unknown error: $e",
        );
      }
    }
  }

  ApiResponse<T> _handleResponse<T>(Response response, T Function(dynamic) fromJson) {
    if (response.statusCode == 200 || response.statusCode == 201) {
      return ApiResponse<T>(
        status: ApiResult.Success,
        data: fromJson(response.data), // Successful data parsing
      );
    } else {
      final errorModel = ErrorResponse.fromJson(response.data); // Parse error response
      return ApiResponse<T>(
        status: ApiResult.Error,
        message: "Error: ${response.statusCode}", // You can customize this message
        data: errorModel as T, // Assign the error model to data, cast it to T
      );
    }
  }

  /// Handle Error
  ApiResponse<T> _handleError<T>(DioException error) {
    String errorMessage;
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        errorMessage = "Connection Timeout Exception";
        break;
      case DioExceptionType.sendTimeout:
        errorMessage = "Send Timeout Exception";
        break;
      case DioExceptionType.receiveTimeout:
        errorMessage = "Receive Timeout Exception";
        break;
      case DioExceptionType.connectionError:
        errorMessage = "Connection Error: ${error.response?.statusCode}";
        break;
      case DioExceptionType.cancel:
        errorMessage = "Request to API server was cancelled";
        break;
      case DioExceptionType.unknown:
        errorMessage = "Unexpected error: ${error.message}";
        break;
      case DioExceptionType.badCertificate:
        errorMessage = "Incorrect Certificate error: ${error.message}";
        break;
      case DioExceptionType.badResponse:
        errorMessage = "Incorrect status code: ${error.message}";
        break;
      default:
        errorMessage = "Unknown error occurred";
        break;
    }
    return ApiResponse<T>(
      status: ApiResult.Error,
      message: errorMessage,
    );
  }

  Future<void> sendPushNotification(String heading, String message, String userId) async {
    var dio = Dio();
    const String oneSignalUrl = "https://onesignal.com/api/v1/notifications";
    const String oneSignalAppId = "bfa40d25-2d13-4f6f-b780-67c823604686";
    const String oneSignalApiKey = "OTNiODg1YzgtZTY3ZC00YmVhLThmMjMtNzg3ZDRjNTZlNWEw";

    try {
      final response = await dio.post(
        oneSignalUrl,
        options: Options(headers: {
          "Authorization": "Basic $oneSignalApiKey",
          "Content-Type": "application/json",
        }),
        data: {
          "app_id": oneSignalAppId,
          "include_external_user_ids": [userId],
          "headings": {"en": heading},
          "contents": {"en": message},
          "small_icon": "ic_notification"
        },
      );
      print("Notification Sent: ${response.data}");
    } catch (e) {
      print("Error sending notification: $e");
    }
  }
}
