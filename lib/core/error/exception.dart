class AppException {
  final String? _errorMessage;
  final int? _statusCode;
  AppException([this._errorMessage, this._statusCode]);

  @override
  String toString() {
    return "$_errorMessage";
  }

  int? statusCode() => _statusCode;
}
