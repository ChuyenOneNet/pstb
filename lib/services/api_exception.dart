class ErrorInfo {
  String? message;
  int? code;

  ErrorInfo({this.code, this.message});

  factory ErrorInfo.fromJson(Map<String, dynamic> json) {
    return ErrorInfo(
      code: json['code'],
      message: json['message'],
    );
  }

  @override
  String toString() {
    // TODO: implement toString
    return "$code$message";
  }
}

class AppException implements Exception {
  ErrorInfo? apiError;

  AppException(int? code, String? message) {
    apiError = ErrorInfo(code: code, message: message);
  }

  @override
  String toString() {
    // TODO: implement toString
    return getMessage();
  }

  String getMessage() {
    return apiError?.message ?? '';
  }
}

class FetchDataException extends AppException {
  FetchDataException({int? code, String? message}) : super(code, message);
}

class NetworkException extends FetchDataException {

}

class BadRequestException extends AppException {
  BadRequestException(int? code, String? message) : super(code, message);
}

class UnauthorisedException extends AppException {
  UnauthorisedException(int? code, String? message) : super(code, message);
}

class InvalidInputException extends AppException {
  InvalidInputException(int? code, String? message) : super(code, message);
}
