import 'dart:async';
import 'dart:convert';
import 'dart:io' as Io;
import 'package:camera/camera.dart';
import 'package:dio/dio.dart' as Dio;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:pstb/app/models/upload_model.dart';
import 'package:pstb/services/api_response.dart';
import 'package:pstb/utils/main.dart';
import 'package:image/image.dart' as Img;
import 'package:pstb/utils/sessions/session_prefs.dart';
import '../app/models/token_model.dart';
import '../constant/config.dart';
import '../utils/shared_preferences_manager.dart';
import 'api_exception.dart';

Duration defaultTimeout = const Duration(minutes: 2);

class HttpHeaderNames {
  static const String authorizationIntegration = "AuthorizationIntegration";
}

abstract class ApiExceptionHandler {
  onNetworkException(NetworkException e);
}

Map<String, String> headers = {
  "content-type": "application/json",
  "accept": "application/json",
};

Map<String, String> getDefaultHeader() {
  return {
    "content-type": "application/json",
    "accept": "application/json",
  };
}

class ApiBaseHelper {
  ApiExceptionHandler? exceptionHandler;

  ApiBaseHelper({this.enableLogging = false, this.exceptionHandler});

  final bool enableLogging;

  FutureOr<http.Response> onTimeout() {
    return http.Response("{}", 200);
  }

  static setHeader(String? userData) {
    if (userData != null) {
      final token = AuthenticationResult.fromJson(json.decode(userData));
      headers = {
        "authorization": "${token.tokenType} ${token.token}",
        "content-type": "application/json",
      };
      GetIt.instance
          .get<SharedPreferencesManager>()
          .putString(AppConfig.accessTokenKey, token.token ?? "");
    }
  }

  static Future<Map<String, String>> getHeaderWithMedicalUnitId() async {
    var clonedHeader = Map<String, String>.from(headers);
    var medicalUnitId = await SessionPrefs.getMedicalUnitId();
    clonedHeader.addAll({"medical_unit_id": medicalUnitId?.toString() ?? "0"});
    return clonedHeader;
  }

  static removeHeader() {
    headers = {
      "content-type": "application/json",
    };
  }

  Future<dynamic> get(String resource,
      [Map<String, dynamic>? queryParams,
      Duration? timeLimit,
      Map<String, String>? headersParam]) async {
    queryParams?.removeWhere((key, value) => value == null);
    var uri = getUri(resource, queryParams);
    debugPrint('$uri');
    var orgHeader = headersParam ?? headers;
    var clonedHeader = Map<String, String>.from(orgHeader);
    var medicalUnitId = await SessionPrefs.getMedicalUnitId();
    clonedHeader.addAll({'medical_unit_id': medicalUnitId?.toString() ?? "0"});
    print(uri);
    print(clonedHeader);
    print(queryParams);
    try {
      debugPrint('$clonedHeader');
      final response = await http.get(uri, headers: clonedHeader).timeout(
            timeLimit ?? defaultTimeout,
            //onTimeout: () => onTimeout(),
          );
      print(response.body);
      return _returnApiResult(response);
    } on Io.SocketException {
      if (exceptionHandler != null) {
        exceptionHandler!.onNetworkException(NetworkException());
      }
      throw NetworkException();
    }
  }

  Future<dynamic> getBase(String resource,
      [Map<String, dynamic>? queryParams,
      Duration? timeLimit,
      Map<String, String>? headersParam]) async {
    queryParams?.removeWhere((key, value) => value == null);
    var uri = getUriBase(resource, queryParams);
    debugPrint('$uri');
    var orgHeader = headersParam ?? headers;
    var clonedHeader = Map<String, String>.from(orgHeader);
    var medicalUnitId = await SessionPrefs.getMedicalUnitId();
    //clonedHeader.addAll({'medical_unit_id': medicalUnitId?.toString() ?? "0"});
    try {
      debugPrint('$clonedHeader');
      final response = await http.get(uri, headers: clonedHeader).timeout(
            timeLimit ?? defaultTimeout,
            //onTimeout: () => onTimeout(),
          );
      print(response.body);
      return _returnApiResultBase(response);
    } on Io.SocketException {
      if (exceptionHandler != null) {
        exceptionHandler!.onNetworkException(NetworkException());
      }
      throw NetworkException();
    }
  }

  Future<dynamic> postBase(
    String resource,
    Object? body, [
    Map<String, dynamic>? queryParams,
  ]) async {
    var uri = getUriBase(resource, queryParams);
    try {
      var orgHeader = headers;
      var clonedHeader = Map<String, String>.from(orgHeader);
      var medicalUnitId = await SessionPrefs.getMedicalUnitId();
      clonedHeader
          .addAll({'medical_unit_id': medicalUnitId?.toString() ?? "0"});
      print('medicalUnitId ${medicalUnitId?.toString()}');
      print(uri);
      final response =
          await http.post(uri, headers: clonedHeader, body: body).timeout(
                defaultTimeout,
                onTimeout: () => onTimeout(),
              );
      print(response.body);
      return _returnApiResultBase(response);
    } on Io.SocketException catch (e) {
      throw FetchDataException(message: e.message);
    }
  }

  Future<dynamic> getDocs(String resource,
      [Map<String, dynamic>? queryParams,
      Duration? timeLimit,
      Map<String, String>? headersParam]) async {
    queryParams?.removeWhere((key, value) => value == null);
    var uri = getUriDocs(resource, queryParams);
    debugPrint('$uri');
    var orgHeader = headersParam ?? headers;
    var clonedHeader = Map<String, String>.from(orgHeader);
    var medicalUnitId = await SessionPrefs.getMedicalUnitId();
    clonedHeader.addAll({'medical_unit_id': medicalUnitId?.toString() ?? "0"});
    try {
      debugPrint('$clonedHeader');
      final response = await http.get(uri, headers: clonedHeader).timeout(
            timeLimit ?? defaultTimeout,
            //onTimeout: () => onTimeout(),
          );
      print(response.body);
      print("kk $_returnApiResultDocs($response)");
      return _returnApiResultDocs(response);
    } on Io.SocketException {
      if (exceptionHandler != null) {
        exceptionHandler!.onNetworkException(NetworkException());
      }
      throw NetworkException();
    }
  }

  Future<dynamic> post(
    String resource,
    Object? body, [
    Map<String, dynamic>? queryParams,
  ]) async {
    var uri = getUri(resource, queryParams);
    try {
      var orgHeader = headers;
      var clonedHeader = Map<String, String>.from(orgHeader);
      var medicalUnitId = await SessionPrefs.getMedicalUnitId();
      clonedHeader
          .addAll({'medical_unit_id': medicalUnitId?.toString() ?? "0"});
      print(uri);
      print(clonedHeader);
      print(body);
      print('medicalUnitId ${medicalUnitId?.toString()}');
      final response =
          await http.post(uri, headers: clonedHeader, body: body).timeout(
                defaultTimeout,
                onTimeout: () => onTimeout(),
              );
      print(response.body);
      return _returnApiResult(response);
    } on Io.SocketException catch (e) {
      throw FetchDataException(message: e.message);
    }
  }

  Future<dynamic> postDocs(
    String resource,
    Object? body, [
    Map<String, dynamic>? queryParams,
  ]) async {
    var uri = getUriDocs(resource, queryParams);
    try {
      var orgHeader = headers;
      var clonedHeader = Map<String, String>.from(orgHeader);
      var medicalUnitId = await SessionPrefs.getMedicalUnitId();
      clonedHeader
          .addAll({'medical_unit_id': medicalUnitId?.toString() ?? "0"});
      print('medicalUnitId ${medicalUnitId?.toString()}');
      String? requestBody;
      if (body != null) {
        if (body is Map<String, dynamic>) {
          requestBody = json.encode(body);
        } else if (body is List) {
          requestBody = json.encode(body);
        } else {
          // Gọi toJson nếu là object custom
          requestBody = json.encode((body as dynamic).toJson());
        }
      }
      print(requestBody);
      print(uri);
      final response = await http
          .post(uri, headers: clonedHeader, body: requestBody)
          .timeout(
            defaultTimeout,
            onTimeout: () => onTimeout(),
          );
      print(response.body);
      return _returnApiResultDocs(response);
    } on Io.SocketException catch (e) {
      if (exceptionHandler != null) {
        exceptionHandler!.onNetworkException(NetworkException());
      }
      throw NetworkException();
    }
  }

  Future<dynamic> postHeaderAuthorization(String resource, Object? body,
      {Map<String, dynamic>? queryParams, String? token, String? type}) async {
    var uri = getUri(resource, queryParams);
    var orgHeader = headers;
    var clonedHeader = Map<String, String>.from(orgHeader);
    clonedHeader.addAll({"Authorization": "$type $token"});
    var medicalUnitId = await SessionPrefs.getMedicalUnitId();
    clonedHeader.addAll({'medical_unit_id': medicalUnitId?.toString() ?? "0"});

    try {
      final response =
          await http.post(uri, headers: clonedHeader, body: body).timeout(
                defaultTimeout,
                onTimeout: () => onTimeout(),
              );
      return _returnApiResult(response);
    } on Io.SocketException catch (e) {
      throw FetchDataException(message: e.message);
    }
  }

  Future<dynamic> put(String resource, Object? body,
      [Map<String, dynamic>? queryParams,
      Map<String, String>? head,
      bool? nullReturnStatus]) async {
    var uri = getUri(resource, queryParams);
    print(body);
    try {
      var orgHeader = headers;
      var clonedHeader = Map<String, String>.from(orgHeader);
      var medicalUnitId = await SessionPrefs.getMedicalUnitId();
      clonedHeader
          .addAll({'medical_unit_id': medicalUnitId?.toString() ?? "0"});

      final httpResponse = await http
          .put(uri, headers: head ?? clonedHeader, body: body)
          .timeout(
            defaultTimeout,
            onTimeout: () => onTimeout(),
          );
      print(httpResponse.body);
      return _returnApiResult(httpResponse, nullReturnStatus: nullReturnStatus);
    } on Io.SocketException {
      throw NetworkException();
    }
  }

  Future<dynamic> patch(String resource, Object? body,
      [Map<String, dynamic>? queryParams]) async {
    var uri = getUri(resource, queryParams);
    var orgHeader = headers;
    var clonedHeader = Map<String, String>.from(orgHeader);
    var medicalUnitId = await SessionPrefs.getMedicalUnitId();
    clonedHeader.addAll({'medical_unit_id': medicalUnitId?.toString() ?? "0"});
    try {
      final httpResponse =
          await http.patch(uri, headers: clonedHeader, body: body).timeout(
                defaultTimeout,
                onTimeout: () => onTimeout(),
              );
      print('body response ${httpResponse.body}');
      return _returnApiResult(httpResponse);
    } on Io.SocketException {
      // AppSnackBar.show(
      //   _context,
      //   AppSnackBarType.Error,
      //   l10n(_context)!.api_no_internet!,
      // );
      throw FetchDataException();
    }
  }

  Future<dynamic> _returnApiResult(
    Response httpResponse, {
    bool? nullReturnStatus,
  }) async {
    var httpCode = httpResponse.statusCode;
    var apiResponse = await _tryParseBody(httpResponse);
    if (apiResponse != null && apiResponse.status!) {
      if (apiResponse.status == true && nullReturnStatus == true) return true;
      return apiResponse.data;
    }
    var firstError = apiResponse?.errors?.first;
    if (httpCode == 200) {
      if (firstError != null) {
        throw AppException(firstError.code, firstError.message);
      } else {
        throw AppException(null, "Có lỗi xảy ra");
      }
    }
    if (httpCode == 400) {
      if (firstError != null) {
        throw BadRequestException(firstError.code, firstError.message);
      } else {
        throw BadRequestException(null, "Có lỗi xảy ra");
      }
    }
    if (httpCode == 401) {
      if (firstError != null) {
        throw UnauthorisedException(firstError.code, firstError.message);
      } else {
        throw UnauthorisedException(null, "Có lỗi xảy ra");
      }
    }
    if (httpCode == 500) {
      if (firstError != null) {
        throw FetchDataException(
            code: firstError.code, message: firstError.message);
      } else {
        throw FetchDataException();
      }
    }
  }

  Future<dynamic> _returnApiResultDocs(
    Response httpResponse, {
    bool? nullReturnStatus,
  }) async {
    var httpCode = httpResponse.statusCode;
    var apiResponse = _tryParseBodyDocs(httpResponse);
    print("huhu +${apiResponse?.toJson()}");
    if (apiResponse != null) {
      print("huhu +${apiResponse.result}");
      if (apiResponse.success == true) return apiResponse.result;
    }
    var firstError = apiResponse?.error;
    if (httpCode == 200) {
      if (firstError != null) {
        throw AppException(firstError.code, firstError.message);
      } else {
        throw AppException(null, "Có lỗi xảy ra");
      }
    }
    if (httpCode == 400) {
      if (firstError != null) {
        throw BadRequestException(firstError.code, firstError.message);
      } else {
        throw BadRequestException(null, "Có lỗi xảy ra");
      }
    }
    if (httpCode == 401) {
      if (firstError != null) {
        throw UnauthorisedException(firstError.code, firstError.message);
      } else {
        throw UnauthorisedException(null, "Có lỗi xảy ra");
      }
    }
    if (httpCode == 500) {
      if (firstError != null) {
        throw FetchDataException(
            code: firstError.code, message: firstError.message);
      } else {
        throw FetchDataException();
      }
    }
  }

  Future<dynamic> _returnApiResultBase(
    Response httpResponse, {
    bool? nullReturnStatus,
  }) async {
    var httpCode = httpResponse.statusCode;
    var apiResponse = await _tryParseBodyBase(httpResponse);
    if (apiResponse != null || apiResponse?.status != null) {
      if (apiResponse?.status != 200 || nullReturnStatus == true) return true;
      return apiResponse?.data;
    }
    var firstError = apiResponse?.errors;

    throw FetchDataException(code: 500, message: firstError);
  }

  Future<dynamic> delete(String url, Object? body,
      [Map<String, dynamic>? queryParams]) async {
    var uri = getUri(url, queryParams);
    var orgHeader = headers;
    var clonedHeader = Map<String, String>.from(orgHeader);
    var medicalUnitId = await SessionPrefs.getMedicalUnitId();
    clonedHeader.addAll({'medical_unit_id': medicalUnitId?.toString() ?? "0"});
    try {
      debugPrint('$uri');
      final response = await http.delete(uri, headers: clonedHeader).timeout(
            defaultTimeout,
            onTimeout: () => onTimeout(),
          );
      return await _returnApiResult(response);
    } on Io.SocketException {
      // AppSnackBar.show(
      //   _context,
      //   AppSnackBarType.Error,
      //   l10n(_context)!.api_no_internet!,
      // );
      throw FetchDataException();
    }
  }

  Uri getUri(String resource, [Map<String, dynamic>? queryParams]) {
    debugPrint(resource);
    var convertedQueryParam = queryParams;
    if (queryParams != null) {
      convertedQueryParam =
          queryParams.map((key, value) => new MapEntry(key, value.toString()));
    }
    var url = ApiUrl.baseUrl;
    if (url.startsWith("https://")) {
      return Uri.https(ApiUrl.baseUrl.replaceAll("https://", ""), resource,
          convertedQueryParam);
    } else if (url.startsWith("http://")) {
      return Uri.http(ApiUrl.baseUrl.replaceAll("http://", ""), resource,
          convertedQueryParam);
    }
    return Uri.http(ApiUrl.baseUrl.replaceAll("http://", ""), resource,
        convertedQueryParam);
  }

  Uri getUriBase(String resource, [Map<String, dynamic>? queryParams]) {
    debugPrint(resource);
    var convertedQueryParam = queryParams;
    if (queryParams != null) {
      convertedQueryParam =
          queryParams.map((key, value) => new MapEntry(key, value.toString()));
    }
    var url = ApiUrl.baseUrlVDUH;
    if (url.startsWith("https://")) {
      return Uri.https(ApiUrl.baseUrlVDUH.replaceAll("https://", ""), resource,
          convertedQueryParam);
    } else if (url.startsWith("http://")) {
      return Uri.http(ApiUrl.baseUrlVDUH.replaceAll("http://", ""), resource,
          convertedQueryParam);
    }
    return Uri.http(ApiUrl.baseUrlVDUH.replaceAll("http://", ""), resource,
        convertedQueryParam);
  }

  Uri getUriDocs(String resource, [Map<String, dynamic>? queryParams]) {
    debugPrint(resource);
    var convertedQueryParam = queryParams;
    if (queryParams != null) {
      convertedQueryParam =
          queryParams.map((key, value) => new MapEntry(key, value.toString()));
    }
    var url = ApiUrl.baseUrlDocs;
    if (url.startsWith("https://")) {
      return Uri.https(ApiUrl.baseUrlDocs.replaceAll("https://", ""), resource,
          convertedQueryParam);
    } else if (url.startsWith("http://")) {
      return Uri.http(ApiUrl.baseUrlDocs.replaceAll("http://", ""), resource,
          convertedQueryParam);
    }
    return Uri.http(ApiUrl.baseUrlDocs.replaceAll("http://", ""), resource,
        convertedQueryParam);
  }

  static final Dio.Dio _dio = Dio.Dio(
    Dio.BaseOptions(
      baseUrl: ApiUrl.baseUrl,
      connectTimeout: 100000,
      receiveTimeout: 10000,
      headers: {
        ...headers,
        "Content-Type": "multipart/form-data",
      },
    ),
  )..interceptors.add(Dio.InterceptorsWrapper(
      onRequest: (response, handler) {
        return handler.next(response); // continue
      },
      onResponse: (response, handler) {
        print(
            'statusMessage ${response.statusMessage}'); // Do something with response data
        return handler.next(response); // continue
      },
    ));

  Future<dynamic> upload(String url, XFile? photoFile,
      void Function(int, int)? onReceive, Function(String?)? onError,
      [Map<String, dynamic>? queryParams]) async {
    var responseJson;
    var medicalUnitId = await SessionPrefs.getMedicalUnitId();
    _dio.options.headers
        .addAll({'medical_unit_id': medicalUnitId?.toString() ?? "0"});
    try {
      Dio.FormData formData = Dio.FormData.fromMap({
        'file': await Dio.MultipartFile.fromFile(photoFile!.path,
            filename: photoFile.path.split("/").last)
      });
      Dio.Response response = await _dio.post(
        url,
        queryParameters: queryParams,
        onReceiveProgress: onReceive,
        data: formData,
      );
      if (response.statusCode == 201) {
        responseJson = UploadModel.fromJson(response.data);
      }
    } on Io.SocketException {
      // AppSnackBar.show(
      //   _context,
      //   AppSnackBarType.Error,
      //   l10n(_context)!.api_no_internet!,
      // );
      throw FetchDataException();
    } on Dio.DioError catch (e) {
      onError!(e.response!.statusMessage);
    }
    return responseJson;
  }

  Future<dynamic> uploadAvatar(String resource, XFile photoFile,
      void Function(int, int)? onReceive, Function(String?)? onError,
      [Map<String, dynamic>? queryParams]) async {
    var responseJson;
    try {
      var file = Io.File(photoFile.path);
      // Read a jpeg image from file.
      var fileData = await file.readAsBytes();
      Img.Image? image = Img.decodeJpg(fileData);
      // Resize the image to a 120x? thumbnail (maintaining the aspect ratio).
      Img.Image thumbnail = Img.copyResize(image!, width: 120);
      Io.File newFileImage = Io.File(photoFile.path)
        ..writeAsBytesSync(Img.encodeJpg(thumbnail));
      Dio.FormData formData = Dio.FormData.fromMap({
        'file': await Dio.MultipartFile.fromFile(newFileImage.path,
            filename: newFileImage.path.split("/").last)
      });
      var medicalUnitId = await SessionPrefs.getMedicalUnitId();
      _dio.options.headers
          .addAll({'medical_unit_id': medicalUnitId?.toString() ?? "0"});
      print(resource);
      print('${formData.length}');
      print('$queryParams');
      print(_dio.options.baseUrl);
      Dio.Response response = await _dio.patch(
        resource,
        queryParameters: queryParams,
        onReceiveProgress: onReceive,
        data: formData,
      );
      if (response.statusCode == 201) {
        responseJson = UploadModel.fromJson(response.data);
      } else if (response.statusCode == 200) {
        responseJson = true;
      } else {
        responseJson = false;
      }
    } on Io.SocketException {
      throw FetchDataException();
    } on Dio.DioError catch (e) {
      debugPrint(e.toString());
      print('${e.response!.data}');
      onError!(e.response!.statusMessage);
      return;
    }
    return responseJson;
  }

  Future<dynamic> uploadDocumentImage(
      String nameFile,
      String resource,
      XFile photoFile,
      void Function(int, int)? onReceive,
      Function(String?)? onError,
      [Map<String, dynamic>? queryParams]) async {
    var responseJson;
    try {
      var file = Io.File(photoFile.path);
      // Read a jpeg image from file.
      var fileData = await file.readAsBytes();
      Img.Image? image = Img.decodeJpg(fileData);
      // Resize the image to a 120x? thumbnail (maintaining the aspect ratio).
      Img.Image thumbnail = Img.copyResize(image!, width: 120);
      Io.File newFileImage = Io.File(photoFile.path)
        ..writeAsBytesSync(Img.encodeJpg(thumbnail));
      // ..writeAsBytesSync(Img.encodeJpg(image));
      Dio.FormData formData = Dio.FormData.fromMap({
        'document': await Dio.MultipartFile.fromFile(newFileImage.path,
            filename: newFileImage.path.split("/").last)
      });
      var medicalUnitId = await SessionPrefs.getMedicalUnitId();
      _dio.options.headers
          .addAll({'medical_unit_id': medicalUnitId?.toString() ?? "0"});
      print(resource);
      print('${formData.length}');
      print('$queryParams');
      print(_dio.options.baseUrl);
      Dio.Response response = await _dio.patch(
        resource,
        queryParameters: queryParams,
        onReceiveProgress: onReceive,
        data: formData,
      );
      print('response $response');
      if (response.statusCode == 201) {
        responseJson = UploadModel.fromJson(response.data);
      } else if (response.statusCode == 200) {
        responseJson = true;
      } else {
        responseJson = false;
      }
    } on Io.SocketException {
      // AppSnackBar.show(
      //   _context,
      //   AppSnackBarType.Error,
      //   l10n(_context)!.api_no_internet!,
      // );
      throw FetchDataException();
    } on Dio.DioError catch (e) {
      print('${e.response!.data}');
      debugPrint(e.toString());
      onError!(e.response!.statusMessage);
      return;
    }
    return responseJson;
  }

  Future<dynamic> uploadDocument(
      String nameFile,
      String resource,
      PlatformFile documentFile,
      void Function(int, int)? onReceive,
      Function(String?)? onError,
      [Map<String, dynamic>? queryParams]) async {
    var responseJson;
    try {
      var file = Io.File(documentFile.path ?? '');
      Dio.FormData formData = Dio.FormData.fromMap({
        'document': await Dio.MultipartFile.fromFile(file.path,
            filename: file.path.split("/").last)
      });
      var medicalUnitId = await SessionPrefs.getMedicalUnitId();
      _dio.options.headers
          .addAll({'medical_unit_id': medicalUnitId?.toString() ?? "0"});
      Dio.Response response = await _dio.patch(
        resource,
        queryParameters: queryParams,
        onReceiveProgress: onReceive,
        data: formData,
      );
      if (response.statusCode == 201) {
        responseJson = UploadModel.fromJson(response.data);
      }
    } on Io.SocketException {
      // AppSnackBar.show(
      //   _context,
      //   AppSnackBarType.Error,
      //   l10n(_context)!.api_no_internet!,
      // );
      throw FetchDataException();
    } on Dio.DioError catch (e) {
      debugPrint(e.toString());
      print('${e.response!.data}');
      onError!(e.response!.statusMessage);
      return;
    }
    return responseJson;
  }

  Future<ApiResponse?> _tryParseBody(http.Response response) async {
    try {
      if (enableLogging) _httpResponseLogging(response);
      var responseJson = json.decode(response.body);
      return ApiResponse.fromJson(responseJson);
    } catch (e) {
      return null;
    }
  }

  ApiResponseDocs? _tryParseBodyDocs(http.Response response) {
    try {
      if (enableLogging) _httpResponseLogging(response);
      var responseJson = json.decode(response.body);
      print("mm +$responseJson");
      final a = ApiResponseDocs.fromJson(responseJson);
      print("lm +${a.result}");
      print("ll +${a.toJson()}");
      return a;
    } catch (e) {
      print("error $e");
      return null;
    }
  }

  Future<BaseResponseVDUH?> _tryParseBodyBase(http.Response response) async {
    try {
      if (enableLogging) _httpResponseLogging(response);
      var responseJson = json.decode(response.body);
      return BaseResponseVDUH.fromJson(responseJson);
    } catch (e) {
      return null;
    }
  }

  void _httpResponseLogging(http.Response response) {
    debugPrint('\n');
    debugPrint('=======================');
    debugPrint(
        'HTTP RESPONSE: | ${response.request?.method} | Status: ${response.statusCode}');
    debugPrint(response.request?.url.toString());
    debugPrint('=======================');
    debugPrint('Headers:');
    debugPrint(response.headers.toString());
    debugPrint('Body:');
    debugPrint(response.body);
    debugPrint('\n');
  }
}
