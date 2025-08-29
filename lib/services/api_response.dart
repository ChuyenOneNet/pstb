class ApiResponse {
  bool? status;
  dynamic data;
  List<ApiError>? errors;

  ApiResponse({this.status, this.data, this.errors});

  ApiResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'];
    if (json['errors'] != null) {
      errors = <ApiError>[];
      json['errors'].forEach((v) {
        errors!.add(ApiError.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (this.data != null) {
      data['data'] = this.data?.toJson();
    }
    if (errors != null) {
      data['errors'] = errors!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ApiResponseDocs {
  bool? success;
  dynamic result;
  ApiError? error;
  ApiResponseDocs({
    this.success,
    this.result,
    this.error,
  });

  ApiResponseDocs.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    result = json['result'];
    error = json['error'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    if (this.result != null) {
      data['result'] = result;
    }
    if (error != null) {
      data['error'] = error?.toJson();
    }
    return data;
  }
}

class ApiError {
  int? code;
  String? message;

  ApiError({this.code, this.message});

  ApiError.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    data['message'] = message;
    return data;
  }
}

class BaseResponseVDUH {
  int? status;
  dynamic data;
  String? errors;

  BaseResponseVDUH({this.status, this.data, this.errors});

  BaseResponseVDUH.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'];
    errors = json['errors'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (this.data != null) {
      data['data'] = this.data?.toJson();
    }
    data['errors'] = errors;

    return data;
  }
}
