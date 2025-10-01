import 'package:dio/dio.dart';
import 'package:pstb/core/base/base_response.dart';
import 'package:retrofit/retrofit.dart';

import '../../models/address_model.dart';
import '../../models/ethnic_model.dart';
import '../../models/job_model.dart';
import '../../models/nationality_model.dart';

part 'dropdown_service.g.dart';

@RestApi()
abstract class DropdownService {
  factory DropdownService(Dio dio, {String baseUrl}) = _DropdownService;

  @POST("/api/Location/country")
  Future<BaseListResponse<Nationality>> getNationalities(
    @Body() Map<String, dynamic> body,
  );

  @GET("/api/job-catalog")
  Future<BaseListResponse<Job>> getJobs(
    @Query("keyword") String keyword,
  );

  @GET("/api/nation-catalog")
  Future<BaseListResponse<Ethnic>> getEthnics(
    @Query("keyword") String keyword,
  );

  @POST("/api/Location/commune-ward")
  Future<BaseListResponse<Address>> fetchAddresses(
    @Body() Map<String, dynamic> body,
  );

  @POST("/api/Location/province")
  Future<BaseListResponse<Address>> fetchCity(
    @Body() Map<String, dynamic> body,
  );
}
