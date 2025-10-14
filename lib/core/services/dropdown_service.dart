import 'package:dio/dio.dart';
import 'package:pstb/core/base/base_response.dart';
import 'package:pstb/models/treatment_catalog_model.dart';
import 'package:retrofit/retrofit.dart';

import '../../models/address_model.dart';
import '../../models/ethnic_model.dart';
import '../../models/job_model.dart';
import '../../models/nationality_model.dart';
import '../../models/treatment_catalog_department_model.dart';

part 'dropdown_service.g.dart';

@RestApi()
abstract class DropdownService {
  factory DropdownService(Dio dio, {String baseUrl}) = _DropdownService;

  @POST("/api/Location/country")
  Future<BaseListResponse<Nationality>> getNationalities(
    @Body() Map<String, dynamic> body,
  );

  @GET("/api/Register/GetAllCareer")
  Future<List<Job>> getJobs();

  @GET("/api/Register/GetAllEthnic")
  Future<List<Ethnic>> getEthnics();

  @POST("/api/Location/commune-ward")
  Future<BaseListResponse<Address>> fetchAddresses(
    @Body() Map<String, dynamic> body,
  );

  @POST("/api/Location/province")
  Future<BaseListResponse<Address>> fetchCity(
    @Body() Map<String, dynamic> body,
  );

  @GET("/api/Register/GetAllTreatmentCatalog")
  Future<List<TreatmentCatalogModel>> fetchTreatmentCatalogs();

  @GET("/api/Register/GetTreatmentCatalogDepartmentByTreatmentCatalogId/{id}")
  Future<List<TreatmentCatalogDepartmentModel>>
      fetchfetchTreatmentCatalogDepartments(@Path("id") String id);
}
