enum ApiResult { Initial ,Loading, Success, Error, Canceled }

class ApiResponse<T> {
  final ApiResult status;
  final T? data;
  final String? message;

  ApiResponse({required this.status, this.data, this.message});
}