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

  @GET("/api/app/country-catalog")
  Future<BaseListResponse<Nationality>> getNationalities(
    @Query("keyword") String keyword,
  );

  @GET("/api/app/job-catalog")
  Future<BaseListResponse<Job>> getJobs(
    @Query("keyword") String keyword,
  );

  @GET("/api/app/nation-catalog")
  Future<BaseListResponse<Ethnic>> getEthnics(
    @Query("keyword") String keyword,
  );

  @GET("/api/app/province-catalog")
  Future<BaseListResponse<Address>> fetchAddresses(
    @Query("keyword") String keyword,
    @Query("type") int type,
  );

  @GET("/api/app/province-catalog")
  Future<BaseListResponse<Address>> fetchCity(
    @Query("keyword") String keyword,
    @Query("type") int type,
  );
}
