// import 'dart:async';
// import 'dart:convert';
// import 'dart:io' as Io;
// import 'package:camera/camera.dart';
// import 'package:dio/dio.dart' as Dio;
// import 'package:file_picker/file_picker.dart';
// import 'package:flutter/material.dart';
// import 'package:get_it/get_it.dart';
// import 'package:http/http.dart' as http;
// import 'package:http/http.dart';
// import 'package:pstb/app/models/upload_model.dart';
// import 'package:pstb/services/api_response.dart';
// import 'package:pstb/utils/main.dart';
// import 'package:image/image.dart' as Img;
// import 'package:pstb/utils/sessions/session_prefs.dart';
// import '../app/models/token_model.dart';
// import '../constant/config.dart';
// import '../utils/shared_preferences_manager.dart';
// import 'api_exception.dart';
//
// Duration defaultTimeout = const Duration(minutes: 2);
//
// class HttpHeaderNames {
//   static const String authorizationIntegration = "AuthorizationIntegration";
// }
//
// abstract class ApiExceptionHandler {
//   onNetworkException(NetworkException e);
// }
//
// Map<String, String> headers = {
//   "content-type": "application/json",
//   "accept": "application/json",
// };
//
// Map<String, String> getDefaultHeader() {
//   return {
//     "content-type": "application/json",
//     "accept": "application/json",
//   };
// }
//
// class ApiBaseHelper {
//   ApiExceptionHandler? exceptionHandler;
//
//   ApiBaseHelper({this.enableLogging = false, this.exceptionHandler});
//
//   final bool enableLogging;
//
//   FutureOr<http.Response> onTimeout() {
//     return http.Response("{}", 200);
//   }
//
//   static setHeader(String? userData) {
//     if (userData != null) {
//       final token = AuthenticationResult.fromJson(json.decode(userData));
//       headers = {
//         "authorization": "${token.tokenType} ${token.token}",
//         "content-type": "application/json",
//       };
//       GetIt.instance
//           .get<SharedPreferencesManager>()
//           .putString(AppConfig.accessTokenKey, token.token ?? "");
//     }
//   }
//
//   static Future<Map<String, String>> getHeaderWithMedicalUnitId() async {
//     var clonedHeader = Map<String, String>.from(headers);
//     var medicalUnitId = await SessionPrefs.getMedicalUnitId();
//     clonedHeader.addAll({"medical_unit_id": medicalUnitId?.toString() ?? "0"});
//     return clonedHeader;
//   }
//
//   static removeHeader() {
//     headers = {
//       "content-type": "application/json",
//     };
//   }
//
//   Future<dynamic> get(String resource,
//       [Map<String, dynamic>? queryParams,
//       Duration? timeLimit,
//       Map<String, String>? headersParam]) async {
//     queryParams?.removeWhere((key, value) => value == null);
//     var uri = getUri(resource, queryParams);
//     debugPrint('$uri');
//     var orgHeader = headersParam ?? headers;
//     var clonedHeader = Map<String, String>.from(orgHeader);
//     var medicalUnitId = await SessionPrefs.getMedicalUnitId();
//     clonedHeader.addAll({'medical_unit_id': medicalUnitId?.toString() ?? "0"});
//     print(uri);
//     print(clonedHeader);
//     print(queryParams);
//     try {
//       debugPrint('$clonedHeader');
//       final response = await http.get(uri, headers: clonedHeader).timeout(
//             timeLimit ?? defaultTimeout,
//             //onTimeout: () => onTimeout(),
//           );
//       print(response.body);
//       return _returnApiResult(response);
//     } on Io.SocketException {
//       if (exceptionHandler != null) {
//         exceptionHandler!.onNetworkException(NetworkException());
//       }
//       throw NetworkException();
//     }
//   }
//
//   Future<dynamic> getBase(String resource,
//       [Map<String, dynamic>? queryParams,
//       Duration? timeLimit,
//       Map<String, String>? headersParam]) async {
//     queryParams?.removeWhere((key, value) => value == null);
//     var uri = getUriBase(resource, queryParams);
//     debugPrint('$uri');
//     var orgHeader = headersParam ?? headers;
//     var clonedHeader = Map<String, String>.from(orgHeader);
//     var medicalUnitId = await SessionPrefs.getMedicalUnitId();
//     //clonedHeader.addAll({'medical_unit_id': medicalUnitId?.toString() ?? "0"});
//     try {
//       debugPrint('$clonedHeader');
//       final response = await http.get(uri, headers: clonedHeader).timeout(
//             timeLimit ?? defaultTimeout,
//             //onTimeout: () => onTimeout(),
//           );
//       print(response.body);
//       return _returnApiResultBase(response);
//     } on Io.SocketException {
//       if (exceptionHandler != null) {
//         exceptionHandler!.onNetworkException(NetworkException());
//       }
//       throw NetworkException();
//     }
//   }
//
//   Future<dynamic> postBase(
//     String resource,
//     Object? body, [
//     Map<String, dynamic>? queryParams,
//   ]) async {
//     var uri = getUriBase(resource, queryParams);
//     try {
//       var orgHeader = headers;
//       var clonedHeader = Map<String, String>.from(orgHeader);
//       var medicalUnitId = await SessionPrefs.getMedicalUnitId();
//       clonedHeader
//           .addAll({'medical_unit_id': medicalUnitId?.toString() ?? "0"});
//       print('medicalUnitId ${medicalUnitId?.toString()}');
//       print(uri);
//       final response =
//           await http.post(uri, headers: clonedHeader, body: body).timeout(
//                 defaultTimeout,
//                 onTimeout: () => onTimeout(),
//               );
//       print(response.body);
//       return _returnApiResultBase(response);
//     } on Io.SocketException catch (e) {
//       throw FetchDataException(message: e.message);
//     }
//   }
//
//   Future<dynamic> getDocs(String resource,
//       [Map<String, dynamic>? queryParams,
//       Duration? timeLimit,
//       Map<String, String>? headersParam]) async {
//     queryParams?.removeWhere((key, value) => value == null);
//     var uri = getUriDocs(resource, queryParams);
//     debugPrint('$uri');
//     var orgHeader = headersParam ?? headers;
//     var clonedHeader = Map<String, String>.from(orgHeader);
//     var medicalUnitId = await SessionPrefs.getMedicalUnitId();
//     clonedHeader.addAll({'medical_unit_id': medicalUnitId?.toString() ?? "0"});
//     try {
//       debugPrint('$clonedHeader');
//       final response = await http.get(uri, headers: clonedHeader).timeout(
//             timeLimit ?? defaultTimeout,
//             //onTimeout: () => onTimeout(),
//           );
//       print(response.body);
//       print("kk $_returnApiResultDocs($response)");
//       return _returnApiResultDocs(response);
//     } on Io.SocketException {
//       if (exceptionHandler != null) {
//         exceptionHandler!.onNetworkException(NetworkException());
//       }
//       throw NetworkException();
//     }
//   }
//
//   Future<dynamic> post(
//     String resource,
//     Object? body, [
//     Map<String, dynamic>? queryParams,
//   ]) async {
//     var uri = getUri(resource, queryParams);
//     try {
//       var orgHeader = headers;
//       var clonedHeader = Map<String, String>.from(orgHeader);
//       var medicalUnitId = await SessionPrefs.getMedicalUnitId();
//       clonedHeader
//           .addAll({'medical_unit_id': medicalUnitId?.toString() ?? "0"});
//       print(uri);
//       print(clonedHeader);
//       print(body);
//       print('medicalUnitId ${medicalUnitId?.toString()}');
//       final response =
//           await http.post(uri, headers: clonedHeader, body: body).timeout(
//                 defaultTimeout,
//                 onTimeout: () => onTimeout(),
//               );
//       print(response.body);
//       return _returnApiResult(response);
//     } on Io.SocketException catch (e) {
//       throw FetchDataException(message: e.message);
//     }
//   }
//
//   Future<dynamic> postDocs(
//     String resource,
//     Object? body, [
//     Map<String, dynamic>? queryParams,
//   ]) async {
//     var uri = getUriDocs(resource, queryParams);
//     try {
//       var orgHeader = headers;
//       var clonedHeader = Map<String, String>.from(orgHeader);
//       var medicalUnitId = await SessionPrefs.getMedicalUnitId();
//       clonedHeader
//           .addAll({'medical_unit_id': medicalUnitId?.toString() ?? "0"});
//       print('medicalUnitId ${medicalUnitId?.toString()}');
//       String? requestBody;
//       if (body != null) {
//         if (body is Map<String, dynamic>) {
//           requestBody = json.encode(body);
//         } else if (body is List) {
//           requestBody = json.encode(body);
//         } else {
//           // Gọi toJson nếu là object custom
//           requestBody = json.encode((body as dynamic).toJson());
//         }
//       }
//       print(requestBody);
//       print(uri);
//       final response = await http
//           .post(uri, headers: clonedHeader, body: requestBody)
//           .timeout(
//             defaultTimeout,
//             onTimeout: () => onTimeout(),
//           );
//       print(response.body);
//       return _returnApiResultDocs(response);
//     } on Io.SocketException catch (e) {
//       if (exceptionHandler != null) {
//         exceptionHandler!.onNetworkException(NetworkException());
//       }
//       throw NetworkException();
//     }
//   }
//
//   Future<dynamic> postHeaderAuthorization(String resource, Object? body,
//       {Map<String, dynamic>? queryParams, String? token, String? type}) async {
//     var uri = getUri(resource, queryParams);
//     var orgHeader = headers;
//     var clonedHeader = Map<String, String>.from(orgHeader);
//     clonedHeader.addAll({"Authorization": "$type $token"});
//     var medicalUnitId = await SessionPrefs.getMedicalUnitId();
//     clonedHeader.addAll({'medical_unit_id': medicalUnitId?.toString() ?? "0"});
//
//     try {
//       final response =
//           await http.post(uri, headers: clonedHeader, body: body).timeout(
//                 defaultTimeout,
//                 onTimeout: () => onTimeout(),
//               );
//       return _returnApiResult(response);
//     } on Io.SocketException catch (e) {
//       throw FetchDataException(message: e.message);
//     }
//   }
//
//   Future<dynamic> put(String resource, Object? body,
//       [Map<String, dynamic>? queryParams,
//       Map<String, String>? head,
//       bool? nullReturnStatus]) async {
//     var uri = getUri(resource, queryParams);
//     print(body);
//     try {
//       var orgHeader = headers;
//       var clonedHeader = Map<String, String>.from(orgHeader);
//       var medicalUnitId = await SessionPrefs.getMedicalUnitId();
//       clonedHeader
//           .addAll({'medical_unit_id': medicalUnitId?.toString() ?? "0"});
//
//       final httpResponse = await http
//           .put(uri, headers: head ?? clonedHeader, body: body)
//           .timeout(
//             defaultTimeout,
//             onTimeout: () => onTimeout(),
//           );
//       print(httpResponse.body);
//       return _returnApiResult(httpResponse, nullReturnStatus: nullReturnStatus);
//     } on Io.SocketException {
//       throw NetworkException();
//     }
//   }
//
//   Future<dynamic> patch(String resource, Object? body,
//       [Map<String, dynamic>? queryParams]) async {
//     var uri = getUri(resource, queryParams);
//     var orgHeader = headers;
//     var clonedHeader = Map<String, String>.from(orgHeader);
//     var medicalUnitId = await SessionPrefs.getMedicalUnitId();
//     clonedHeader.addAll({'medical_unit_id': medicalUnitId?.toString() ?? "0"});
//     try {
//       final httpResponse =
//           await http.patch(uri, headers: clonedHeader, body: body).timeout(
//                 defaultTimeout,
//                 onTimeout: () => onTimeout(),
//               );
//       print('body response ${httpResponse.body}');
//       return _returnApiResult(httpResponse);
//     } on Io.SocketException {
//       // AppSnackBar.show(
//       //   _context,
//       //   AppSnackBarType.Error,
//       //   l10n(_context)!.api_no_internet!,
//       // );
//       throw FetchDataException();
//     }
//   }
//
//   Future<dynamic> _returnApiResult(
//     Response httpResponse, {
//     bool? nullReturnStatus,
//   }) async {
//     var httpCode = httpResponse.statusCode;
//     var apiResponse = await _tryParseBody(httpResponse);
//     if (apiResponse != null && apiResponse.status!) {
//       if (apiResponse.status == true && nullReturnStatus == true) return true;
//       return apiResponse.data;
//     }
//     var firstError = apiResponse?.errors?.first;
//     if (httpCode == 200) {
//       if (firstError != null) {
//         throw AppException(firstError.code, firstError.message);
//       } else {
//         throw AppException(null, "Có lỗi xảy ra");
//       }
//     }
//     if (httpCode == 400) {
//       if (firstError != null) {
//         throw BadRequestException(firstError.code, firstError.message);
//       } else {
//         throw BadRequestException(null, "Có lỗi xảy ra");
//       }
//     }
//     if (httpCode == 401) {
//       if (firstError != null) {
//         throw UnauthorisedException(firstError.code, firstError.message);
//       } else {
//         throw UnauthorisedException(null, "Có lỗi xảy ra");
//       }
//     }
//     if (httpCode == 500) {
//       if (firstError != null) {
//         throw FetchDataException(
//             code: firstError.code, message: firstError.message);
//       } else {
//         throw FetchDataException();
//       }
//     }
//   }
//
//   Future<dynamic> _returnApiResultDocs(
//     Response httpResponse, {
//     bool? nullReturnStatus,
//   }) async {
//     var httpCode = httpResponse.statusCode;
//     var apiResponse = _tryParseBodyDocs(httpResponse);
//     print("huhu +${apiResponse?.toJson()}");
//     if (apiResponse != null) {
//       print("huhu +${apiResponse.result}");
//       if (apiResponse.success == true) return apiResponse.result;
//     }
//     var firstError = apiResponse?.error;
//     if (httpCode == 200) {
//       if (firstError != null) {
//         throw AppException(firstError.code, firstError.message);
//       } else {
//         throw AppException(null, "Có lỗi xảy ra");
//       }
//     }
//     if (httpCode == 400) {
//       if (firstError != null) {
//         throw BadRequestException(firstError.code, firstError.message);
//       } else {
//         throw BadRequestException(null, "Có lỗi xảy ra");
//       }
//     }
//     if (httpCode == 401) {
//       if (firstError != null) {
//         throw UnauthorisedException(firstError.code, firstError.message);
//       } else {
//         throw UnauthorisedException(null, "Có lỗi xảy ra");
//       }
//     }
//     if (httpCode == 500) {
//       if (firstError != null) {
//         throw FetchDataException(
//             code: firstError.code, message: firstError.message);
//       } else {
//         throw FetchDataException();
//       }
//     }
//   }
//
//   Future<dynamic> _returnApiResultBase(
//     Response httpResponse, {
//     bool? nullReturnStatus,
//   }) async {
//     var httpCode = httpResponse.statusCode;
//     var apiResponse = await _tryParseBodyBase(httpResponse);
//     if (apiResponse != null || apiResponse?.status != null) {
//       if (apiResponse?.status != 200 || nullReturnStatus == true) return true;
//       return apiResponse?.data;
//     }
//     var firstError = apiResponse?.errors;
//
//     throw FetchDataException(code: 500, message: firstError);
//   }
//
//   Future<dynamic> delete(String url, Object? body,
//       [Map<String, dynamic>? queryParams]) async {
//     var uri = getUri(url, queryParams);
//     var orgHeader = headers;
//     var clonedHeader = Map<String, String>.from(orgHeader);
//     var medicalUnitId = await SessionPrefs.getMedicalUnitId();
//     clonedHeader.addAll({'medical_unit_id': medicalUnitId?.toString() ?? "0"});
//     try {
//       debugPrint('$uri');
//       final response = await http.delete(uri, headers: clonedHeader).timeout(
//             defaultTimeout,
//             onTimeout: () => onTimeout(),
//           );
//       return await _returnApiResult(response);
//     } on Io.SocketException {
//       // AppSnackBar.show(
//       //   _context,
//       //   AppSnackBarType.Error,
//       //   l10n(_context)!.api_no_internet!,
//       // );
//       throw FetchDataException();
//     }
//   }
//
//   Uri getUri(String resource, [Map<String, dynamic>? queryParams]) {
//     debugPrint(resource);
//     var convertedQueryParam = queryParams;
//     if (queryParams != null) {
//       convertedQueryParam =
//           queryParams.map((key, value) => new MapEntry(key, value.toString()));
//     }
//     var url = ApiUrl.baseUrl;
//     if (url.startsWith("https://")) {
//       return Uri.https(ApiUrl.baseUrl.replaceAll("https://", ""), resource,
//           convertedQueryParam);
//     } else if (url.startsWith("http://")) {
//       return Uri.http(ApiUrl.baseUrl.replaceAll("http://", ""), resource,
//           convertedQueryParam);
//     }
//     return Uri.http(ApiUrl.baseUrl.replaceAll("http://", ""), resource,
//         convertedQueryParam);
//   }
//
//   Uri getUriBase(String resource, [Map<String, dynamic>? queryParams]) {
//     debugPrint(resource);
//     var convertedQueryParam = queryParams;
//     if (queryParams != null) {
//       convertedQueryParam =
//           queryParams.map((key, value) => new MapEntry(key, value.toString()));
//     }
//     var url = ApiUrl.baseUrlVDUH;
//     if (url.startsWith("https://")) {
//       return Uri.https(ApiUrl.baseUrlVDUH.replaceAll("https://", ""), resource,
//           convertedQueryParam);
//     } else if (url.startsWith("http://")) {
//       return Uri.http(ApiUrl.baseUrlVDUH.replaceAll("http://", ""), resource,
//           convertedQueryParam);
//     }
//     return Uri.http(ApiUrl.baseUrlVDUH.replaceAll("http://", ""), resource,
//         convertedQueryParam);
//   }
//
//   Uri getUriDocs(String resource, [Map<String, dynamic>? queryParams]) {
//     debugPrint(resource);
//     var convertedQueryParam = queryParams;
//     if (queryParams != null) {
//       convertedQueryParam =
//           queryParams.map((key, value) => new MapEntry(key, value.toString()));
//     }
//     var url = ApiUrl.baseUrlDocs;
//     if (url.startsWith("https://")) {
//       return Uri.https(ApiUrl.baseUrlDocs.replaceAll("https://", ""), resource,
//           convertedQueryParam);
//     } else if (url.startsWith("http://")) {
//       return Uri.http(ApiUrl.baseUrlDocs.replaceAll("http://", ""), resource,
//           convertedQueryParam);
//     }
//     return Uri.http(ApiUrl.baseUrlDocs.replaceAll("http://", ""), resource,
//         convertedQueryParam);
//   }
//
//   static final Dio.Dio _dio = Dio.Dio(
//     Dio.BaseOptions(
//       baseUrl: ApiUrl.baseUrl,
//       connectTimeout: 100000,
//       receiveTimeout: 10000,
//       headers: {
//         ...headers,
//         "Content-Type": "multipart/form-data",
//       },
//     ),
//   )..interceptors.add(Dio.InterceptorsWrapper(
//       onRequest: (response, handler) {
//         return handler.next(response); // continue
//       },
//       onResponse: (response, handler) {
//         print(
//             'statusMessage ${response.statusMessage}'); // Do something with response data
//         return handler.next(response); // continue
//       },
//     ));
//
//   Future<dynamic> upload(String url, XFile? photoFile,
//       void Function(int, int)? onReceive, Function(String?)? onError,
//       [Map<String, dynamic>? queryParams]) async {
//     var responseJson;
//     var medicalUnitId = await SessionPrefs.getMedicalUnitId();
//     _dio.options.headers
//         .addAll({'medical_unit_id': medicalUnitId?.toString() ?? "0"});
//     try {
//       Dio.FormData formData = Dio.FormData.fromMap({
//         'file': await Dio.MultipartFile.fromFile(photoFile!.path,
//             filename: photoFile.path.split("/").last)
//       });
//       Dio.Response response = await _dio.post(
//         url,
//         queryParameters: queryParams,
//         onReceiveProgress: onReceive,
//         data: formData,
//       );
//       if (response.statusCode == 201) {
//         responseJson = UploadModel.fromJson(response.data);
//       }
//     } on Io.SocketException {
//       // AppSnackBar.show(
//       //   _context,
//       //   AppSnackBarType.Error,
//       //   l10n(_context)!.api_no_internet!,
//       // );
//       throw FetchDataException();
//     } on Dio.DioError catch (e) {
//       onError!(e.response!.statusMessage);
//     }
//     return responseJson;
//   }
//
//   Future<dynamic> uploadAvatar(String resource, XFile photoFile,
//       void Function(int, int)? onReceive, Function(String?)? onError,
//       [Map<String, dynamic>? queryParams]) async {
//     var responseJson;
//     try {
//       var file = Io.File(photoFile.path);
//       // Read a jpeg image from file.
//       var fileData = await file.readAsBytes();
//       Img.Image? image = Img.decodeJpg(fileData);
//       // Resize the image to a 120x? thumbnail (maintaining the aspect ratio).
//       Img.Image thumbnail = Img.copyResize(image!, width: 120);
//       Io.File newFileImage = Io.File(photoFile.path)
//         ..writeAsBytesSync(Img.encodeJpg(thumbnail));
//       Dio.FormData formData = Dio.FormData.fromMap({
//         'file': await Dio.MultipartFile.fromFile(newFileImage.path,
//             filename: newFileImage.path.split("/").last)
//       });
//       var medicalUnitId = await SessionPrefs.getMedicalUnitId();
//       _dio.options.headers
//           .addAll({'medical_unit_id': medicalUnitId?.toString() ?? "0"});
//       print(resource);
//       print('${formData.length}');
//       print('$queryParams');
//       print(_dio.options.baseUrl);
//       Dio.Response response = await _dio.patch(
//         resource,
//         queryParameters: queryParams,
//         onReceiveProgress: onReceive,
//         data: formData,
//       );
//       if (response.statusCode == 201) {
//         responseJson = UploadModel.fromJson(response.data);
//       } else if (response.statusCode == 200) {
//         responseJson = true;
//       } else {
//         responseJson = false;
//       }
//     } on Io.SocketException {
//       throw FetchDataException();
//     } on Dio.DioError catch (e) {
//       debugPrint(e.toString());
//       print('${e.response!.data}');
//       onError!(e.response!.statusMessage);
//       return;
//     }
//     return responseJson;
//   }
//
//   Future<dynamic> uploadDocumentImage(
//       String nameFile,
//       String resource,
//       XFile photoFile,
//       void Function(int, int)? onReceive,
//       Function(String?)? onError,
//       [Map<String, dynamic>? queryParams]) async {
//     var responseJson;
//     try {
//       var file = Io.File(photoFile.path);
//       // Read a jpeg image from file.
//       var fileData = await file.readAsBytes();
//       Img.Image? image = Img.decodeJpg(fileData);
//       // Resize the image to a 120x? thumbnail (maintaining the aspect ratio).
//       Img.Image thumbnail = Img.copyResize(image!, width: 120);
//       Io.File newFileImage = Io.File(photoFile.path)
//         ..writeAsBytesSync(Img.encodeJpg(thumbnail));
//       // ..writeAsBytesSync(Img.encodeJpg(image));
//       Dio.FormData formData = Dio.FormData.fromMap({
//         'document': await Dio.MultipartFile.fromFile(newFileImage.path,
//             filename: newFileImage.path.split("/").last)
//       });
//       var medicalUnitId = await SessionPrefs.getMedicalUnitId();
//       _dio.options.headers
//           .addAll({'medical_unit_id': medicalUnitId?.toString() ?? "0"});
//       print(resource);
//       print('${formData.length}');
//       print('$queryParams');
//       print(_dio.options.baseUrl);
//       Dio.Response response = await _dio.patch(
//         resource,
//         queryParameters: queryParams,
//         onReceiveProgress: onReceive,
//         data: formData,
//       );
//       print('response $response');
//       if (response.statusCode == 201) {
//         responseJson = UploadModel.fromJson(response.data);
//       } else if (response.statusCode == 200) {
//         responseJson = true;
//       } else {
//         responseJson = false;
//       }
//     } on Io.SocketException {
//       // AppSnackBar.show(
//       //   _context,
//       //   AppSnackBarType.Error,
//       //   l10n(_context)!.api_no_internet!,
//       // );
//       throw FetchDataException();
//     } on Dio.DioError catch (e) {
//       print('${e.response!.data}');
//       debugPrint(e.toString());
//       onError!(e.response!.statusMessage);
//       return;
//     }
//     return responseJson;
//   }
//
//   Future<dynamic> uploadDocument(
//       String nameFile,
//       String resource,
//       PlatformFile documentFile,
//       void Function(int, int)? onReceive,
//       Function(String?)? onError,
//       [Map<String, dynamic>? queryParams]) async {
//     var responseJson;
//     try {
//       var file = Io.File(documentFile.path ?? '');
//       Dio.FormData formData = Dio.FormData.fromMap({
//         'document': await Dio.MultipartFile.fromFile(file.path,
//             filename: file.path.split("/").last)
//       });
//       var medicalUnitId = await SessionPrefs.getMedicalUnitId();
//       _dio.options.headers
//           .addAll({'medical_unit_id': medicalUnitId?.toString() ?? "0"});
//       Dio.Response response = await _dio.patch(
//         resource,
//         queryParameters: queryParams,
//         onReceiveProgress: onReceive,
//         data: formData,
//       );
//       if (response.statusCode == 201) {
//         responseJson = UploadModel.fromJson(response.data);
//       }
//     } on Io.SocketException {
//       // AppSnackBar.show(
//       //   _context,
//       //   AppSnackBarType.Error,
//       //   l10n(_context)!.api_no_internet!,
//       // );
//       throw FetchDataException();
//     } on Dio.DioError catch (e) {
//       debugPrint(e.toString());
//       print('${e.response!.data}');
//       onError!(e.response!.statusMessage);
//       return;
//     }
//     return responseJson;
//   }
//
//   Future<ApiResponse?> _tryParseBody(http.Response response) async {
//     try {
//       if (enableLogging) _httpResponseLogging(response);
//       var responseJson = json.decode(response.body);
//       return ApiResponse.fromJson(responseJson);
//     } catch (e) {
//       return null;
//     }
//   }
//
//   ApiResponseDocs? _tryParseBodyDocs(http.Response response) {
//     try {
//       if (enableLogging) _httpResponseLogging(response);
//       var responseJson = json.decode(response.body);
//       print("mm +$responseJson");
//       final a = ApiResponseDocs.fromJson(responseJson);
//       print("lm +${a.result}");
//       print("ll +${a.toJson()}");
//       return a;
//     } catch (e) {
//       print("error $e");
//       return null;
//     }
//   }
//
//   Future<BaseResponseVDUH?> _tryParseBodyBase(http.Response response) async {
//     try {
//       if (enableLogging) _httpResponseLogging(response);
//       var responseJson = json.decode(response.body);
//       return BaseResponseVDUH.fromJson(responseJson);
//     } catch (e) {
//       return null;
//     }
//   }
//
//   void _httpResponseLogging(http.Response response) {
//     debugPrint('\n');
//     debugPrint('=======================');
//     debugPrint(
//         'HTTP RESPONSE: | ${response.request?.method} | Status: ${response.statusCode}');
//     debugPrint(response.request?.url.toString());
//     debugPrint('=======================');
//     debugPrint('Headers:');
//     debugPrint(response.headers.toString());
//     debugPrint('Body:');
//     debugPrint(response.body);
//     debugPrint('\n');
//   }
// }
import 'dart:async';
import 'dart:convert';
import 'dart:io' as Io;
import 'package:camera/camera.dart';
import 'package:dio/dio.dart' as Dio;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:pstb/app/models/upload_model.dart';
import 'package:pstb/services/api_response.dart';
import 'package:pstb/utils/main.dart';
import 'package:image/image.dart' as Img;
import 'package:pstb/utils/sessions/session_prefs.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
    _log('⏰ TIMEOUT: Request timeout after ${defaultTimeout.inSeconds}s');
    return http.Response("{}", 200);
  }

  static setHeader(String? userData) {
    _log(
        '🔑 Setting header - userData: ${userData != null ? "provided" : "null"}');
    if (userData != null) {
      final token = AuthenticationResult.fromJson(json.decode(userData));
      headers = {
        "authorization": "${token.tokenType} ${token.token}",
        "content-type": "application/json",
      };
      GetIt.instance
          .get<SharedPreferencesManager>()
          .putString(AppConfig.accessTokenKey, token.token ?? "");
      _log(
          '🔑 Token set: ${token.tokenType} ${token.token?.substring(0, 20)}...');
    } else {
      _log('⚠️ No userData provided - skipping token setup');
    }
  }

  static Future<Map<String, String>> getHeaderWithMedicalUnitId() async {
    _log('🏥 Getting header with medical unit ID');
    var clonedHeader = Map<String, String>.from(headers);
    var medicalUnitId = await SessionPrefs.getMedicalUnitId();
    clonedHeader.addAll({"medical_unit_id": medicalUnitId?.toString() ?? "0"});
    _log('🏥 MedicalUnitId added: ${medicalUnitId?.toString() ?? "0"}');
    return clonedHeader;
  }

  static removeHeader() {
    _log('🗑️ Removing authorization header');
    headers = {
      "content-type": "application/json",
    };
    _log('🗑️ Headers cleared - only content-type remains');
  }

  Future<dynamic> get(String resource,
      [Map<String, dynamic>? queryParams,
      Duration? timeLimit,
      Map<String, String>? headersParam]) async {
    _log('🚀 === GET REQUEST ===');
    _log('📍 Resource: $resource');

    queryParams?.removeWhere((key, value) => value == null);
    var uri = getUri(resource, queryParams);
    _log('🔗 Final URI: $uri');

    debugPrint('$uri');
    var orgHeader = headersParam ?? headers;
    var clonedHeader = Map<String, String>.from(orgHeader);
    var medicalUnitId = await SessionPrefs.getMedicalUnitId();
    clonedHeader.addAll({'medical_unit_id': medicalUnitId?.toString() ?? "0"});
    _log('🏥 MedicalUnitId: ${medicalUnitId?.toString() ?? "0"}');

    print(uri);
    print(clonedHeader);
    print(queryParams);

    try {
      _log('📝 GET Headers: ${clonedHeader}');
      debugPrint('$clonedHeader');

      final stopwatch = Stopwatch()..start();
      final response = await http.get(uri, headers: clonedHeader).timeout(
            timeLimit ?? defaultTimeout,
            //onTimeout: () => onTimeout(),
          );
      stopwatch.stop();

      _log(
          '📥 GET Response - Status: ${response.statusCode}, Duration: ${stopwatch.elapsedMilliseconds}ms');
      print(response.body);

      _log('🔍 Processing GET response...');
      return _returnApiResult(response);
    } on Io.SocketException {
      _log('🌐 GET NETWORK ERROR: SocketException occurred');
      if (exceptionHandler != null) {
        exceptionHandler!.onNetworkException(NetworkException());
      }
      throw NetworkException();
    } catch (e) {
      _log('❌ GET UNEXPECTED ERROR: $e');
      rethrow;
    }
  }

  Future<dynamic> getBase(String resource,
      [Map<String, dynamic>? queryParams,
      Duration? timeLimit,
      Map<String, String>? headersParam]) async {
    _log('🚀 === GET_BASE REQUEST ===');
    _log('📍 Base Resource: $resource');

    queryParams?.removeWhere((key, value) => value == null);
    var uri = await getUriBase(resource, queryParams);
    _log('🔗 Base URI: $uri');

    debugPrint('$uri');
    var orgHeader = headersParam ?? headers;
    var clonedHeader = Map<String, String>.from(orgHeader);
    var medicalUnitId = await SessionPrefs.getMedicalUnitId();
    //clonedHeader.addAll({'medical_unit_id': medicalUnitId?.toString() ?? "0"});
    _log(
        '🏥 MedicalUnitId: ${medicalUnitId?.toString() ?? "0"} (not added to header)');

    try {
      _log('📝 GET_BASE Headers: ${clonedHeader}');
      debugPrint('$clonedHeader');

      final stopwatch = Stopwatch()..start();
      final response = await http.get(uri, headers: clonedHeader).timeout(
            timeLimit ?? defaultTimeout,
            //onTimeout: () => onTimeout(),
          );
      stopwatch.stop();

      _log(
          '📥 GET_BASE Response - Status: ${response.statusCode}, Duration: ${stopwatch.elapsedMilliseconds}ms');
      print(response.body);

      _log('🔍 Processing GET_BASE response...');
      return _returnApiResultBase(response);
    } on Io.SocketException {
      _log('🌐 GET_BASE NETWORK ERROR: SocketException occurred');
      if (exceptionHandler != null) {
        exceptionHandler!.onNetworkException(NetworkException());
      }
      throw NetworkException();
    } catch (e) {
      _log('❌ GET_BASE UNEXPECTED ERROR: $e');
      rethrow;
    }
  }

  Future<dynamic> postBase(
    String resource,
    Object? body, [
    Map<String, dynamic>? queryParams,
  ]) async {
    _log('🚀 === POST_BASE REQUEST ===');
    _log('📍 Base Resource: $resource');

    var uri = await getUriBase(resource, queryParams);
    _log('🔗 Base URI: $uri');

    try {
      var orgHeader = headers;
      var clonedHeader = Map<String, String>.from(orgHeader);
      var medicalUnitId = await SessionPrefs.getMedicalUnitId();
      clonedHeader
          .addAll({'medical_unit_id': medicalUnitId?.toString() ?? "0"});
      _log('🏥 MedicalUnitId: ${medicalUnitId?.toString()}');
      _log('📝 POST_BASE Headers: ${clonedHeader}');
      _log('📦 POST_BASE Body: $body');

      print('medicalUnitId ${medicalUnitId?.toString()}');
      print(uri);

      final stopwatch = Stopwatch()..start();
      final response =
          await http.post(uri, headers: clonedHeader, body: body).timeout(
                defaultTimeout,
                onTimeout: () => onTimeout(),
              );
      stopwatch.stop();

      _log(
          '📥 POST_BASE Response - Status: ${response.statusCode}, Duration: ${stopwatch.elapsedMilliseconds}ms');
      print(response.body);

      _log('🔍 Processing POST_BASE response...');
      return _returnApiResultBase(response);
    } on Io.SocketException catch (e) {
      _log('🌐 POST_BASE NETWORK ERROR: ${e.message}');
      throw FetchDataException(message: e.message);
    } catch (e) {
      _log('❌ POST_BASE UNEXPECTED ERROR: $e');
      rethrow;
    }
  }

  Future<dynamic> getDocs(String resource,
      [Map<String, dynamic>? queryParams,
      Duration? timeLimit,
      Map<String, String>? headersParam]) async {
    _log('🚀 === GET_DOCS REQUEST ===');
    _log('📍 Docs Resource: $resource');

    queryParams?.removeWhere((key, value) => value == null);
    var uri = getUriDocs(resource, queryParams);
    _log('🔗 Docs URI: $uri');

    debugPrint('$uri');
    var orgHeader = headersParam ?? headers;
    var clonedHeader = Map<String, String>.from(orgHeader);
    var medicalUnitId = await SessionPrefs.getMedicalUnitId();
    clonedHeader.addAll({'medical_unit_id': medicalUnitId?.toString() ?? "0"});
    _log('🏥 MedicalUnitId: ${medicalUnitId?.toString() ?? "0"}');

    try {
      _log('📝 GET_DOCS Headers: ${clonedHeader}');
      debugPrint('$clonedHeader');

      final stopwatch = Stopwatch()..start();
      final response = await http.get(uri, headers: clonedHeader).timeout(
            timeLimit ?? defaultTimeout,
            //onTimeout: () => onTimeout(),
          );
      stopwatch.stop();

      _log(
          '📥 GET_DOCS Response - Status: ${response.statusCode}, Duration: ${stopwatch.elapsedMilliseconds}ms');
      print(response.body);
      print("kk $_returnApiResultDocs($response)");
      _log('📄 GET_DOCS Raw result logged');

      _log('🔍 Processing GET_DOCS response...');
      return _returnApiResultDocs(response);
    } on Io.SocketException {
      _log('🌐 GET_DOCS NETWORK ERROR: SocketException occurred');
      if (exceptionHandler != null) {
        exceptionHandler!.onNetworkException(NetworkException());
      }
      throw NetworkException();
    } catch (e) {
      _log('❌ GET_DOCS UNEXPECTED ERROR: $e');
      rethrow;
    }
  }

  Future<dynamic> post(
    String resource,
    Object? body, [
    Map<String, dynamic>? queryParams,
  ]) async {
    _log('🚀 === POST REQUEST ===');
    _log('📍 Resource: $resource');

    var uri = getUri(resource, queryParams);
    _log('🔗 URI: $uri');

    try {
      var orgHeader = headers;
      var clonedHeader = Map<String, String>.from(orgHeader);
      var medicalUnitId = await SessionPrefs.getMedicalUnitId();
      clonedHeader
          .addAll({'medical_unit_id': medicalUnitId?.toString() ?? "0"});
      _log('🏥 MedicalUnitId: ${medicalUnitId?.toString()}');
      _log('📝 POST Headers: ${clonedHeader}');
      _log('📦 POST Body: $body');

      print(uri);
      print(clonedHeader);
      print(body);
      print('medicalUnitId ${medicalUnitId?.toString()}');

      final stopwatch = Stopwatch()..start();
      final response =
          await http.post(uri, headers: clonedHeader, body: body).timeout(
                defaultTimeout,
                onTimeout: () => onTimeout(),
              );
      stopwatch.stop();

      _log(
          '📥 POST Response - Status: ${response.statusCode}, Duration: ${stopwatch.elapsedMilliseconds}ms');
      print(response.body);

      _log('🔍 Processing POST response...');
      return _returnApiResult(response);
    } on Io.SocketException catch (e) {
      _log('🌐 POST NETWORK ERROR: ${e.message}');
      throw FetchDataException(message: e.message);
    } catch (e) {
      _log('❌ POST UNEXPECTED ERROR: $e');
      rethrow;
    }
  }

  Future<dynamic> postDocs(
    String resource,
    Object? body, [
    Map<String, dynamic>? queryParams,
  ]) async {
    _log('🚀 === POST_DOCS REQUEST ===');
    _log('📍 Docs Resource: $resource');

    var uri = getUriDocs(resource, queryParams);
    _log('🔗 Docs URI: $uri');

    try {
      var orgHeader = headers;
      var clonedHeader = Map<String, String>.from(orgHeader);
      var medicalUnitId = await SessionPrefs.getMedicalUnitId();
      clonedHeader
          .addAll({'medical_unit_id': medicalUnitId?.toString() ?? "0"});
      _log('🏥 MedicalUnitId: ${medicalUnitId?.toString()}');
      _log('📝 POST_DOCS Headers: ${clonedHeader}');

      print('medicalUnitId ${medicalUnitId?.toString()}');
      String? requestBody;
      if (body != null) {
        if (body is Map<String, dynamic>) {
          requestBody = json.encode(body);
          _log('📦 POST_DOCS Body is Map - encoded to JSON');
        } else if (body is List) {
          requestBody = json.encode(body);
          _log('📦 POST_DOCS Body is List - encoded to JSON');
        } else {
          // Gọi toJson nếu là object custom
          try {
            requestBody = json.encode((body as dynamic).toJson());
            _log(
                '📦 POST_DOCS Body is Custom Object - toJson() called successfully');
          } catch (e) {
            _log('❌ POST_DOCS toJson() failed: $e - will use direct encode');
            requestBody = json.encode(body);
          }
        }
      } else {
        _log('⚠️ POST_DOCS Body is null');
      }

      _log('📦 POST_DOCS Request Body: $requestBody');
      print(requestBody);
      print(uri);

      final stopwatch = Stopwatch()..start();
      final response = await http
          .post(uri, headers: clonedHeader, body: requestBody)
          .timeout(
            defaultTimeout,
            onTimeout: () => onTimeout(),
          );
      stopwatch.stop();

      _log(
          '📥 POST_DOCS Response - Status: ${response.statusCode}, Duration: ${stopwatch.elapsedMilliseconds}ms');
      print(response.body);

      _log('🔍 Processing POST_DOCS response...');
      return _returnApiResultDocs(response);
    } on Io.SocketException catch (e) {
      _log('🌐 POST_DOCS NETWORK ERROR: ${e.message}');
      if (exceptionHandler != null) {
        exceptionHandler!.onNetworkException(NetworkException());
      }
      throw NetworkException();
    } catch (e) {
      _log('❌ POST_DOCS UNEXPECTED ERROR: $e');
      rethrow;
    }
  }

  Future<dynamic> postHeaderAuthorization(String resource, Object? body,
      {Map<String, dynamic>? queryParams, String? token, String? type}) async {
    _log('🚀 === POST_HEADER_AUTH REQUEST ===');
    _log('📍 Auth Resource: $resource');

    var uri = getUri(resource, queryParams);
    _log('🔗 Auth URI: $uri');

    var orgHeader = headers;
    var clonedHeader = Map<String, String>.from(orgHeader);
    clonedHeader.addAll({"Authorization": "$type $token"});
    var medicalUnitId = await SessionPrefs.getMedicalUnitId();
    clonedHeader.addAll({'medical_unit_id': medicalUnitId?.toString() ?? "0"});

    _log('🔐 Custom Authorization: $type ${token?.substring(0, 20)}...');
    _log('🏥 MedicalUnitId: ${medicalUnitId?.toString() ?? "0"}');
    _log('📝 POST_AUTH Headers: ${clonedHeader}');
    _log('📦 POST_AUTH Body: $body');

    try {
      final stopwatch = Stopwatch()..start();
      final response =
          await http.post(uri, headers: clonedHeader, body: body).timeout(
                defaultTimeout,
                onTimeout: () => onTimeout(),
              );
      stopwatch.stop();

      _log(
          '📥 POST_AUTH Response - Status: ${response.statusCode}, Duration: ${stopwatch.elapsedMilliseconds}ms');

      _log('🔍 Processing POST_AUTH response...');
      return _returnApiResult(response);
    } on Io.SocketException catch (e) {
      _log('🌐 POST_AUTH NETWORK ERROR: ${e.message}');
      throw FetchDataException(message: e.message);
    } catch (e) {
      _log('❌ POST_AUTH UNEXPECTED ERROR: $e');
      rethrow;
    }
  }

  Future<dynamic> put(String resource, Object? body,
      [Map<String, dynamic>? queryParams,
      Map<String, String>? head,
      bool? nullReturnStatus]) async {
    _log('🚀 === PUT REQUEST ===');
    _log('📍 Resource: $resource');

    var uri = getUri(resource, queryParams);
    _log('🔗 PUT URI: $uri');

    print(body);
    _log('📦 PUT Body: $body');

    try {
      var orgHeader = headers;
      var clonedHeader = Map<String, String>.from(orgHeader);
      var medicalUnitId = await SessionPrefs.getMedicalUnitId();
      clonedHeader
          .addAll({'medical_unit_id': medicalUnitId?.toString() ?? "0"});
      _log('🏥 MedicalUnitId: ${medicalUnitId?.toString() ?? "0"}');
      _log('📝 PUT Headers: ${head ?? clonedHeader}');

      final stopwatch = Stopwatch()..start();
      final httpResponse = await http
          .put(uri, headers: head ?? clonedHeader, body: body)
          .timeout(
            defaultTimeout,
            onTimeout: () => onTimeout(),
          );
      stopwatch.stop();

      _log(
          '📥 PUT Response - Status: ${httpResponse.statusCode}, Duration: ${stopwatch.elapsedMilliseconds}ms');
      print(httpResponse.body);

      _log('🔍 Processing PUT response...');
      return _returnApiResult(httpResponse, nullReturnStatus: nullReturnStatus);
    } on Io.SocketException {
      _log('🌐 PUT NETWORK ERROR: SocketException occurred');
      throw NetworkException();
    } catch (e) {
      _log('❌ PUT UNEXPECTED ERROR: $e');
      rethrow;
    }
  }

  Future<dynamic> patch(String resource, Object? body,
      [Map<String, dynamic>? queryParams]) async {
    _log('🚀 === PATCH REQUEST ===');
    _log('📍 Resource: $resource');

    var uri = getUri(resource, queryParams);
    _log('🔗 PATCH URI: $uri');

    var orgHeader = headers;
    var clonedHeader = Map<String, String>.from(orgHeader);
    var medicalUnitId = await SessionPrefs.getMedicalUnitId();
    clonedHeader.addAll({'medical_unit_id': medicalUnitId?.toString() ?? "0"});
    _log('🏥 MedicalUnitId: ${medicalUnitId?.toString() ?? "0"}');
    _log('📝 PATCH Headers: ${clonedHeader}');
    _log('📦 PATCH Body: $body');

    try {
      final stopwatch = Stopwatch()..start();
      final httpResponse =
          await http.patch(uri, headers: clonedHeader, body: body).timeout(
                defaultTimeout,
                onTimeout: () => onTimeout(),
              );
      stopwatch.stop();

      _log(
          '📥 PATCH Response - Status: ${httpResponse.statusCode}, Duration: ${stopwatch.elapsedMilliseconds}ms');
      print('body response ${httpResponse.body}');

      _log('🔍 Processing PATCH response...');
      return _returnApiResult(httpResponse);
    } on Io.SocketException {
      _log('🌐 PATCH NETWORK ERROR: SocketException occurred');
      // AppSnackBar.show(
      //   _context,
      //   AppSnackBarType.Error,
      //   l10n(_context)!.api_no_internet!,
      // );
      throw FetchDataException();
    } catch (e) {
      _log('❌ PATCH UNEXPECTED ERROR: $e');
      rethrow;
    }
  }

  Future<dynamic> _returnApiResult(
    Response httpResponse, {
    bool? nullReturnStatus,
  }) async {
    var httpCode = httpResponse.statusCode;
    _log('🔍 === PROCESSING API RESULT ===');
    _log('📊 HTTP Status Code: $httpCode');

    var apiResponse = await _tryParseBody(httpResponse);
    _log('🔍 API Response parsed - Status: ${apiResponse?.status}');

    if (apiResponse != null && apiResponse.status!) {
      _log('✅ API Success - Status: true');
      if (apiResponse.status == true && nullReturnStatus == true) return true;
      _log('✅ API Data returned: ${apiResponse.data?.runtimeType}');
      return apiResponse.data;
    }

    var firstError = apiResponse?.errors?.first;
    _log('⚠️ API Response has errors: ${firstError?.message}');

    if (httpCode == 200) {
      if (firstError != null) {
        _log('❌ API Error (200): ${firstError.code} - ${firstError.message}');
        throw AppException(firstError.code, firstError.message);
      } else {
        _log('❌ API Error (200): Unknown error occurred');
        throw AppException(null, "Có lỗi xảy ra");
      }
    }
    if (httpCode == 400) {
      if (firstError != null) {
        _log('❌ Bad Request (400): ${firstError.code} - ${firstError.message}');
        throw BadRequestException(firstError.code, firstError.message);
      } else {
        _log('❌ Bad Request (400): Unknown error occurred');
        throw BadRequestException(null, "Có lỗi xảy ra");
      }
    }
    if (httpCode == 401) {
      _log('🔐 UNAUTHORIZED (401) - Token may be expired');
      if (firstError != null) {
        _log('❌ Unauthorized: ${firstError.code} - ${firstError.message}');
        throw UnauthorisedException(firstError.code, firstError.message);
      } else {
        _log('❌ Unauthorized: Unknown error occurred');
        throw UnauthorisedException(null, "Có lỗi xảy ra");
      }
    }
    if (httpCode == 500) {
      if (firstError != null) {
        _log(
            '❌ Server Error (500): ${firstError.code} - ${firstError.message}');
        throw FetchDataException(
            code: firstError.code, message: firstError.message);
      } else {
        _log('❌ Server Error (500): Unknown server error');
        throw FetchDataException();
      }
    }

    _log('❌ Unknown HTTP Status Code: $httpCode');
  }

  Future<dynamic> _returnApiResultDocs(
    Response httpResponse, {
    bool? nullReturnStatus,
  }) async {
    var httpCode = httpResponse.statusCode;
    _log('📄 === PROCESSING DOCS RESULT ===');
    _log('📊 Docs HTTP Status Code: $httpCode');

    var apiResponse = _tryParseBodyDocs(httpResponse);
    _log('📄 Docs Response parsed - Success: ${apiResponse?.success}');
    print("huhu +${apiResponse?.toJson()}");

    if (apiResponse != null) {
      print("huhu +${apiResponse.result}");
      _log('📄 Docs Result: ${apiResponse.result?.runtimeType}');
      if (apiResponse.success == true) {
        _log('✅ Docs Success - Returning result');
        return apiResponse.result;
      }
    }

    var firstError = apiResponse?.error;
    _log('⚠️ Docs Response has error: ${firstError?.message}');

    if (httpCode == 200) {
      if (firstError != null) {
        _log('❌ Docs Error (200): ${firstError.code} - ${firstError.message}');
        throw AppException(firstError.code, firstError.message);
      } else {
        _log('❌ Docs Error (200): Unknown error occurred');
        throw AppException(null, "Có lỗi xảy ra");
      }
    }
    if (httpCode == 400) {
      if (firstError != null) {
        _log(
            '❌ Docs Bad Request (400): ${firstError.code} - ${firstError.message}');
        throw BadRequestException(firstError.code, firstError.message);
      } else {
        _log('❌ Docs Bad Request (400): Unknown error occurred');
        throw BadRequestException(null, "Có lỗi xảy ra");
      }
    }
    if (httpCode == 401) {
      _log('🔐 Docs UNAUTHORIZED (401)');
      if (firstError != null) {
        _log('❌ Docs Unauthorized: ${firstError.code} - ${firstError.message}');
        throw UnauthorisedException(firstError.code, firstError.message);
      } else {
        _log('❌ Docs Unauthorized: Unknown error occurred');
        throw UnauthorisedException(null, "Có lỗi xảy ra");
      }
    }
    if (httpCode == 500) {
      if (firstError != null) {
        _log(
            '❌ Docs Server Error (500): ${firstError.code} - ${firstError.message}');
        throw FetchDataException(
            code: firstError.code, message: firstError.message);
      } else {
        _log('❌ Docs Server Error (500): Unknown server error');
        throw FetchDataException();
      }
    }

    _log('❌ Docs Unknown HTTP Status Code: $httpCode');
  }

  Future<dynamic> _returnApiResultBase(
    Response httpResponse, {
    bool? nullReturnStatus,
  }) async {
    var httpCode = httpResponse.statusCode;
    _log('🏗️ === PROCESSING BASE RESULT ===');
    _log('📊 Base HTTP Status Code: $httpCode');

    var apiResponse = await _tryParseBodyBase(httpResponse);
    _log('🏗️ Base Response parsed - Status: ${apiResponse?.status}');

    if (apiResponse != null || apiResponse?.status != null) {
      _log('🏗️ Base Response valid - Status: ${apiResponse?.status}');
      if (apiResponse?.status != 200 || nullReturnStatus == true) return true;
      _log('🏗️ Base Data returned: ${apiResponse?.data?.runtimeType}');
      return apiResponse?.data;
    }

    var firstError = apiResponse?.errors;
    _log('⚠️ Base Response has errors: $firstError');

    _log('❌ Base throwing FetchDataException');
    throw FetchDataException(code: 500, message: firstError);
  }

  Future<dynamic> delete(String url, Object? body,
      [Map<String, dynamic>? queryParams]) async {
    _log('🚀 === DELETE REQUEST ===');
    _log('📍 Delete URL: $url');

    var uri = getUri(url, queryParams);
    _log('🔗 Delete URI: $uri');

    var orgHeader = headers;
    var clonedHeader = Map<String, String>.from(orgHeader);
    var medicalUnitId = await SessionPrefs.getMedicalUnitId();
    clonedHeader.addAll({'medical_unit_id': medicalUnitId?.toString() ?? "0"});
    _log('🏥 MedicalUnitId: ${medicalUnitId?.toString() ?? "0"}');
    _log('📝 DELETE Headers: ${clonedHeader}');

    try {
      debugPrint('$uri');
      final stopwatch = Stopwatch()..start();
      final response = await http.delete(uri, headers: clonedHeader).timeout(
            defaultTimeout,
            onTimeout: () => onTimeout(),
          );
      stopwatch.stop();

      _log(
          '📥 DELETE Response - Status: ${response.statusCode}, Duration: ${stopwatch.elapsedMilliseconds}ms');

      _log('🔍 Processing DELETE response...');
      return await _returnApiResult(response);
    } on Io.SocketException {
      _log('🌐 DELETE NETWORK ERROR: SocketException occurred');
      // AppSnackBar.show(
      //   _context,
      //   AppSnackBarType.Error,
      //   l10n(_context)!.api_no_internet!,
      // );
      throw FetchDataException();
    } catch (e) {
      _log('❌ DELETE UNEXPECTED ERROR: $e');
      rethrow;
    }
  }

  Uri getUri(String resource, [Map<String, dynamic>? queryParams]) {
    _log('🔗 === BUILDING URI ===');
    _log('📍 Resource: $resource');

    debugPrint(resource);
    var convertedQueryParam = queryParams;
    if (queryParams != null) {
      convertedQueryParam =
          queryParams.map((key, value) => new MapEntry(key, value.toString()));
      _log('🔍 Query params converted: $convertedQueryParam');
    }
    var url = ApiUrl.baseUrl;
    _log('🌐 Base URL: $url');

    if (url.startsWith("https://")) {
      var result = Uri.https(ApiUrl.baseUrl.replaceAll("https://", ""),
          resource, convertedQueryParam);
      _log('🔗 HTTPS URI built: $result');
      return result;
    } else if (url.startsWith("http://")) {
      var result = Uri.http(ApiUrl.baseUrl.replaceAll("http://", ""), resource,
          convertedQueryParam);
      _log('🔗 HTTP URI built: $result');
      return result;
    }
    var result = Uri.http(ApiUrl.baseUrl.replaceAll("http://", ""), resource,
        convertedQueryParam);
    _log('🔗 Default URI built: $result');
    return result;
  }

  Future<Uri> getUriBase(String resource,
      [Map<String, dynamic>? queryParams]) async {
    _log('🏗️ === BUILDING BASE URI ===');
    _log('📍 Base Resource: $resource');

    debugPrint(resource);
    var convertedQueryParam = queryParams;
    if (queryParams != null) {
      convertedQueryParam =
          queryParams.map((key, value) => new MapEntry(key, value.toString()));
      _log('🔍 Base Query params converted: $convertedQueryParam');
    }
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final vduhUrl =
        await prefs.getString("vduhUrl") ?? "https://192.168.1.25:6443";
    var url = vduhUrl;
    _log('🌐 Base VDUH URL: $url');

    if (url.startsWith("https://")) {
      var result = Uri.https(
          url.replaceAll("https://", ""), resource, convertedQueryParam);
      _log('🏗️ Base HTTPS URI built: $result');
      return result;
    } else if (url.startsWith("http://")) {
      var result = Uri.http(
          url.replaceAll("http://", ""), resource, convertedQueryParam);
      _log('🏗️ Base HTTP URI built: $result');
      return result;
    }
    var result =
        Uri.http(url.replaceAll("http://", ""), resource, convertedQueryParam);
    _log('🏗️ Base Default URI built: $result');
    return result;
  }

  Uri getUriDocs(String resource, [Map<String, dynamic>? queryParams]) {
    _log('📄 === BUILDING DOCS URI ===');
    _log('📍 Docs Resource: $resource');

    debugPrint(resource);
    var convertedQueryParam = queryParams;
    if (queryParams != null) {
      convertedQueryParam =
          queryParams.map((key, value) => new MapEntry(key, value.toString()));
      _log('🔍 Docs Query params converted: $convertedQueryParam');
    }
    var url = ApiUrl.baseUrlDocs;
    _log('🌐 Docs Base URL: $url');

    if (url.startsWith("https://")) {
      var result = Uri.https(ApiUrl.baseUrlDocs.replaceAll("https://", ""),
          resource, convertedQueryParam);
      _log('📄 Docs HTTPS URI built: $result');
      return result;
    } else if (url.startsWith("http://")) {
      var result = Uri.http(ApiUrl.baseUrlDocs.replaceAll("http://", ""),
          resource, convertedQueryParam);
      _log('📄 Docs HTTP URI built: $result');
      return result;
    }
    var result = Uri.http(ApiUrl.baseUrlDocs.replaceAll("http://", ""),
        resource, convertedQueryParam);
    _log('📄 Docs Default URI built: $result');
    return result;
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
        _log('📤 === DIO REQUEST ===');
        _log('📍 Dio URL: ${response.uri}');
        _log('📝 Dio Method: ${response.method}');
        _log('📦 Dio Data: ${response.data}');
        _log('📝 Dio Headers: ${response.headers}');
        return handler.next(response); // continue
      },
      onResponse: (response, handler) {
        _log('📥 === DIO RESPONSE ===');
        _log('📊 Dio Status: ${response.statusCode} ${response.statusMessage}');
        _log('📍 Dio URL: ${response.requestOptions.uri}');
        _log('📦 Dio Response Data: ${response.data}');
        print(
            'statusMessage ${response.statusMessage}'); // Do something with response data
        return handler.next(response); // continue
      },
      onError: (error, handler) {
        _log('❌ === DIO ERROR ===');
        _log('📊 Dio Error: ${error.message}');
        if (error.response != null) {
          _log('📦 Dio Error Response: ${error.response!.data}');
        }
        return handler.next(error);
      },
    ));

  Future<dynamic> upload(String url, XFile? photoFile,
      void Function(int, int)? onReceive, Function(String?)? onError,
      [Map<String, dynamic>? queryParams]) async {
    _log('📤 === UPLOAD REQUEST ===');
    _log('📍 Upload URL: $url');
    _log('📄 Upload File: ${photoFile?.path}');

    var responseJson;
    var medicalUnitId = await SessionPrefs.getMedicalUnitId();
    _dio.options.headers
        .addAll({'medical_unit_id': medicalUnitId?.toString() ?? "0"});
    _log('🏥 Upload MedicalUnitId: ${medicalUnitId?.toString() ?? "0"}');

    try {
      _log('📦 Creating FormData for upload');
      Dio.FormData formData = Dio.FormData.fromMap({
        'file': await Dio.MultipartFile.fromFile(photoFile!.path,
            filename: photoFile.path.split("/").last)
      });
      _log('📦 FormData created - Filename: ${photoFile.path.split("/").last}');

      final stopwatch = Stopwatch()..start();
      Dio.Response response = await _dio.post(
        url,
        queryParameters: queryParams,
        onReceiveProgress: (received, total) {
          double progress = total > 0 ? (received / total * 100) : 0;
          _log(
              '📊 Upload Progress: ${progress.toStringAsFixed(1)}% ($received/$total bytes)');
          onReceive?.call(received, total);
        },
        data: formData,
      );
      stopwatch.stop();

      _log('✅ Upload completed - Duration: ${stopwatch.elapsedMilliseconds}ms');

      if (response.statusCode == 201) {
        responseJson = UploadModel.fromJson(response.data);
        _log('✅ Upload Success (201) - Model created');
      } else {
        _log('⚠️ Upload Response Code: ${response.statusCode}');
        _log('📦 Upload Response Data: ${response.data}');
      }
    } on Io.SocketException {
      _log('🌐 UPLOAD NETWORK ERROR: SocketException occurred');
      // AppSnackBar.show(
      //   _context,
      //   AppSnackBarType.Error,
      //   l10n(_context)!.api_no_internet!,
      // );
      throw FetchDataException();
    } on Dio.DioError catch (e) {
      _log('❌ Upload DioError: ${e.message}');
      onError!(e.response!.statusMessage);
      _log('📦 Upload Error Response: ${e.response!.data}');
    } catch (e) {
      _log('❌ Upload UNEXPECTED ERROR: $e');
      rethrow;
    }
    return responseJson;
  }

  Future<dynamic> uploadAvatar(String resource, XFile photoFile,
      void Function(int, int)? onReceive, Function(String?)? onError,
      [Map<String, dynamic>? queryParams]) async {
    _log('👤 === AVATAR UPLOAD ===');
    _log('📍 Avatar Resource: $resource');
    _log('📄 Avatar File: ${photoFile.path}');

    var responseJson;
    try {
      var file = Io.File(photoFile.path);
      _log('📄 Avatar file opened: ${file.path}');

      // Read a jpeg image from file.
      var fileData = await file.readAsBytes();
      _log('🖼️ Avatar file read: ${fileData.length} bytes');

      Img.Image? image = Img.decodeJpg(fileData);
      _log('🖼️ Avatar image decoded: ${image != null ? "Success" : "Failed"}');

      // Resize the image to a 120x? thumbnail (maintaining the aspect ratio).
      Img.Image thumbnail = Img.copyResize(image!, width: 120);
      _log(
          '🖼️ Avatar thumbnail created: ${thumbnail.width}x${thumbnail.height}');

      Io.File newFileImage = Io.File(photoFile.path)
        ..writeAsBytesSync(Img.encodeJpg(thumbnail));
      _log('🖼️ Avatar thumbnail saved to: ${newFileImage.path}');

      Dio.FormData formData = Dio.FormData.fromMap({
        'file': await Dio.MultipartFile.fromFile(newFileImage.path,
            filename: newFileImage.path.split("/").last)
      });
      _log('📦 Avatar FormData created');

      var medicalUnitId = await SessionPrefs.getMedicalUnitId();
      _dio.options.headers
          .addAll({'medical_unit_id': medicalUnitId?.toString() ?? "0"});
      _log('🏥 Avatar MedicalUnitId: ${medicalUnitId?.toString() ?? "0"}');

      print(resource);
      print('${formData.length}');
      print('$queryParams');
      print(_dio.options.baseUrl);
      _log(
          '📝 Avatar upload details - Resource: $resource, FormData: ${await formData.length} bytes, Query: $queryParams');

      final stopwatch = Stopwatch()..start();
      Dio.Response response = await _dio.patch(
        resource,
        queryParameters: queryParams,
        onReceiveProgress: (received, total) {
          double progress = total > 0 ? (received / total * 100) : 0;
          _log(
              '📊 Avatar Upload Progress: ${progress.toStringAsFixed(1)}% ($received/$total bytes)');
          onReceive?.call(received, total);
        },
        data: formData,
      );
      stopwatch.stop();

      _log(
          '✅ Avatar upload completed - Duration: ${stopwatch.elapsedMilliseconds}ms');

      if (response.statusCode == 201) {
        responseJson = UploadModel.fromJson(response.data);
        _log('✅ Avatar Upload Success (201) - Model created');
      } else if (response.statusCode == 200) {
        responseJson = true;
        _log('✅ Avatar Upload Success (200 OK)');
      } else {
        responseJson = false;
        _log('⚠️ Avatar Upload Response Code: ${response.statusCode}');
        _log('📦 Avatar Upload Response: ${response.data}');
      }
    } on Io.SocketException {
      _log('🌐 Avatar Upload NETWORK ERROR: SocketException occurred');
      throw FetchDataException();
    } on Dio.DioError catch (e) {
      debugPrint(e.toString());
      print('${e.response!.data}');
      _log('❌ Avatar Upload DioError: ${e.message}');
      _log('📦 Avatar Upload Error Response: ${e.response!.data}');
      onError!(e.response!.statusMessage);
      return;
    } catch (e) {
      _log('❌ Avatar Upload UNEXPECTED ERROR: $e');
      rethrow;
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
    _log('📄 === DOCUMENT IMAGE UPLOAD ===');
    _log('📍 Doc Image Resource: $resource');
    _log('📄 Doc Image File: ${photoFile.path}');
    _log('📝 Document Name: $nameFile');

    var responseJson;
    try {
      var file = Io.File(photoFile.path);
      _log('📄 Document image file opened: ${file.path}');

      // Read a jpeg image from file.
      var fileData = await file.readAsBytes();
      _log('🖼️ Document image file read: ${fileData.length} bytes');

      Img.Image? image = Img.decodeJpg(fileData);
      _log(
          '🖼️ Document image decoded: ${image != null ? "Success" : "Failed"}');

      // Resize the image to a 120x? thumbnail (maintaining the aspect ratio).
      Img.Image thumbnail = Img.copyResize(image!, width: 120);
      _log(
          '🖼️ Document thumbnail created: ${thumbnail.width}x${thumbnail.height}');

      Io.File newFileImage = Io.File(photoFile.path)
        ..writeAsBytesSync(Img.encodeJpg(thumbnail));
      // ..writeAsBytesSync(Img.encodeJpg(image));
      _log('🖼️ Document thumbnail saved to: ${newFileImage.path}');

      Dio.FormData formData = Dio.FormData.fromMap({
        'document': await Dio.MultipartFile.fromFile(newFileImage.path,
            filename: newFileImage.path.split("/").last)
      });
      _log('📦 Document image FormData created');

      var medicalUnitId = await SessionPrefs.getMedicalUnitId();
      _dio.options.headers
          .addAll({'medical_unit_id': medicalUnitId?.toString() ?? "0"});
      _log(
          '🏥 Document image MedicalUnitId: ${medicalUnitId?.toString() ?? "0"}');

      print(resource);
      print('${formData.length}');
      print('$queryParams');
      print(_dio.options.baseUrl);
      _log(
          '📝 Document image upload details - Resource: $resource, FormData: ${await formData.length} bytes, Query: $queryParams');

      final stopwatch = Stopwatch()..start();
      Dio.Response response = await _dio.patch(
        resource,
        queryParameters: queryParams,
        onReceiveProgress: (received, total) {
          double progress = total > 0 ? (received / total * 100) : 0;
          _log(
              '📊 Document Image Upload Progress: ${progress.toStringAsFixed(1)}% ($received/$total bytes)');
          onReceive?.call(received, total);
        },
        data: formData,
      );
      stopwatch.stop();

      print('response $response');
      _log(
          '✅ Document image upload completed - Duration: ${stopwatch.elapsedMilliseconds}ms');
      _log('📥 Document Image Response - Status: ${response.statusCode}');

      if (response.statusCode == 201) {
        responseJson = UploadModel.fromJson(response.data);
        _log('✅ Document Image Upload Success (201) - Model created');
      } else if (response.statusCode == 200) {
        responseJson = true;
        _log('✅ Document Image Upload Success (200 OK)');
      } else {
        responseJson = false;
        _log('⚠️ Document Image Upload Response Code: ${response.statusCode}');
        _log('📦 Document Image Upload Response: ${response.data}');
      }
    } on Io.SocketException {
      _log('🌐 Document Image Upload NETWORK ERROR: SocketException occurred');
      // AppSnackBar.show(
      //   _context,
      //   AppSnackBarType.Error,
      //   l10n(_context)!.api_no_internet!,
      // );
      throw FetchDataException();
    } on Dio.DioError catch (e) {
      print('${e.response!.data}');
      debugPrint(e.toString());
      _log('❌ Document Image Upload DioError: ${e.message}');
      _log('📦 Document Image Upload Error Response: ${e.response!.data}');
      onError!(e.response!.statusMessage);
      return;
    } catch (e) {
      _log('❌ Document Image Upload UNEXPECTED ERROR: $e');
      rethrow;
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
    _log('📄 === DOCUMENT UPLOAD ===');
    _log('📍 Document Resource: $resource');
    _log('📝 Document Name: $nameFile');
    _log('📄 Document File: ${documentFile.path}');

    var responseJson;
    try {
      var file = Io.File(documentFile.path ?? '');
      _log('📄 Document file opened: ${file.path}');

      Dio.FormData formData = Dio.FormData.fromMap({
        'document': await Dio.MultipartFile.fromFile(file.path,
            filename: file.path.split("/").last)
      });
      _log(
          '📦 Document FormData created - Filename: ${file.path.split("/").last}');

      var medicalUnitId = await SessionPrefs.getMedicalUnitId();
      _dio.options.headers
          .addAll({'medical_unit_id': medicalUnitId?.toString() ?? "0"});
      _log('🏥 Document MedicalUnitId: ${medicalUnitId?.toString() ?? "0"}');

      final stopwatch = Stopwatch()..start();
      Dio.Response response = await _dio.patch(
        resource,
        queryParameters: queryParams,
        onReceiveProgress: (received, total) {
          double progress = total > 0 ? (received / total * 100) : 0;
          _log(
              '📊 Document Upload Progress: ${progress.toStringAsFixed(1)}% ($received/$total bytes)');
          onReceive?.call(received, total);
        },
        data: formData,
      );
      stopwatch.stop();

      _log(
          '✅ Document upload completed - Duration: ${stopwatch.elapsedMilliseconds}ms');

      if (response.statusCode == 201) {
        responseJson = UploadModel.fromJson(response.data);
        _log('✅ Document Upload Success (201) - Model created');
      } else {
        _log('⚠️ Document Upload Response Code: ${response.statusCode}');
        _log('📦 Document Upload Response: ${response.data}');
      }
    } on Io.SocketException {
      _log('🌐 Document Upload NETWORK ERROR: SocketException occurred');
      // AppSnackBar.show(
      //   _context,
      //   AppSnackBarType.Error,
      //   l10n(_context)!.api_no_internet!,
      // );
      throw FetchDataException();
    } on Dio.DioError catch (e) {
      debugPrint(e.toString());
      print('${e.response!.data}');
      _log('❌ Document Upload DioError: ${e.message}');
      _log('📦 Document Upload Error Response: ${e.response!.data}');
      onError!(e.response!.statusMessage);
      return;
    } catch (e) {
      _log('❌ Document Upload UNEXPECTED ERROR: $e');
      rethrow;
    }
    return responseJson;
  }

  Future<ApiResponse?> _tryParseBody(http.Response response) async {
    _log('🔍 === PARSING API BODY ===');
    _log('📄 Response body length: ${response.body.length} chars');

    try {
      if (enableLogging) _httpResponseLogging(response);

      _log('🔄 JSON decoding started...');
      var responseJson = json.decode(response.body);
      _log('✅ JSON decoded successfully');

      _log('🔄 Creating ApiResponse model...');
      var apiResponse = ApiResponse.fromJson(responseJson);
      _log('✅ ApiResponse model created - Status: ${apiResponse.status}');

      return apiResponse;
    } catch (e) {
      _log('❌ JSON Parse Error: $e');
      _log(
          '📄 Raw response body: ${response.body.substring(0, response.body.length > 200 ? 200 : response.body.length)}...');
      return null;
    }
  }

  ApiResponseDocs? _tryParseBodyDocs(http.Response response) {
    _log('📄 === PARSING DOCS BODY ===');
    _log('📄 Docs response body length: ${response.body.length} chars');

    try {
      if (enableLogging) _httpResponseLogging(response);

      _log('🔄 Docs JSON decoding started...');
      var responseJson = json.decode(response.body);
      print("mm +$responseJson");
      _log('📄 Docs JSON decoded: ${responseJson.runtimeType}');

      _log('🔄 Creating ApiResponseDocs model...');
      final a = ApiResponseDocs.fromJson(responseJson);
      print("lm +${a.result}");
      _log(
          '📄 ApiResponseDocs model created - Result: ${a.result?.runtimeType}');
      print("ll +${a.toJson()}");
      _log('📄 Docs model toJson: ${a.toJson()}');

      return a;
    } catch (e) {
      print("error $e");
      _log('❌ Docs JSON Parse Error: $e');
      _log(
          '📄 Docs Raw response body: ${response.body.substring(0, response.body.length > 200 ? 200 : response.body.length)}...');
      return null;
    }
  }

  Future<BaseResponseVDUH?> _tryParseBodyBase(http.Response response) async {
    _log('🏗️ === PARSING BASE BODY ===');
    _log('🏗️ Base response body length: ${response.body.length} chars');

    try {
      if (enableLogging) _httpResponseLogging(response);

      _log('🔄 Base JSON decoding started...');
      var responseJson = json.decode(response.body);
      _log('✅ Base JSON decoded successfully');

      _log('🔄 Creating BaseResponseVDUH model...');
      var baseResponse = BaseResponseVDUH.fromJson(responseJson);
      _log('✅ BaseResponseVDUH model created - Status: ${baseResponse.status}');

      return baseResponse;
    } catch (e) {
      _log('❌ Base JSON Parse Error: $e');
      _log(
          '📄 Base Raw response body: ${response.body.substring(0, response.body.length > 200 ? 200 : response.body.length)}...');
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
    debugPrint('Body (${response.body.length} chars):');
    debugPrint(response.body);
    debugPrint('\n');
    _log('📋 Detailed HTTP response logged via debugPrint');
  }

  // ===== LOGGING HELPER =====
  static void _log(String message) {
    if (kDebugMode) {
      final timestamp = DateTime.now().toIso8601String().substring(11, 19);
      debugPrint('[$timestamp] $message');
    }
  }
}
