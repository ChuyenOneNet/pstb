import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../models/relative_model.dart';

part 'relative_remote_ds.g.dart';

@RestApi()
abstract class RelativeRemoteDataSource {
  factory RelativeRemoteDataSource(Dio dio, {String baseUrl}) =
      _RelativeRemoteDataSource;

  // 4.1: danh sách người thân
  @GET('/citizens/{mainCccd}/relatives')
  Future<List<RelativeModel>> getRelatives(
    @Path('mainCccd') String mainCccd,
  );

  // 4.2: chi tiết
  @GET('/citizens/{mainCccd}/relatives/{relativeId}')
  Future<RelativeModel> getRelativeDetail(
    @Path('mainCccd') String mainCccd,
    @Path('relativeId') int relativeId,
  );

  // 4.3: thêm
  @POST('/citizens/{mainCccd}/relatives')
  Future<RelativeModel> addRelative(
    @Path('mainCccd') String mainCccd,
    @Body() RelativeModel body,
  );

  // 4.4: sửa
  @PUT('/citizens/{mainCccd}/relatives/{relativeId}')
  Future<RelativeModel> updateRelative(
    @Path('mainCccd') String mainCccd,
    @Path('relativeId') int relativeId,
    @Body() RelativeModel body,
  );

  // 4.5: xoá
  @DELETE('/citizens/{mainCccd}/relatives/{relativeId}')
  Future<void> deleteRelative(
    @Path('mainCccd') String mainCccd,
    @Path('relativeId') int relativeId,
  );
}
