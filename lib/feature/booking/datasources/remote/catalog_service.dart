import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:pstb/feature/booking/data/models/base_list_response.dart';
import 'package:retrofit/retrofit.dart';

import '../../data/models/auth_response.dart';
import '../../domain/entities/lead_service.dart';
import '../../domain/entities/time_slot.dart'; // dùng lớp sẵn có của bạn

part 'catalog_service.g.dart';

@RestApi()
abstract class CatalogService {
  factory CatalogService(Dio dio, {String baseUrl}) = _CatalogService;

  @GET("/api/MediCRM/auth")
  Future<AuthResponse> auth(
    @Query("username") String username,
    @Query("access_key_md5") String accessKeyMd5,
  );

  @GET("/api/MediCRM/list")
  Future<BaseListResponse<LeadService>> getServices(
    @Header("Access-Token") String token,
    @Query("module") String module,
    @Query("sort_column") String sortColumn,
    @Query("sort_order") String sortOrder,
    @Query("offset") int offset,
    @Query("max_rows") int maxRows,
  );
}
