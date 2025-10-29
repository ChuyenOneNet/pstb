import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import 'package:pstb/core/base/base_response.dart';

import '../../domain/entities/lead_service.dart';
import '../../domain/entities/time_slot.dart'; // dùng lớp sẵn có của bạn

part 'catalog_service.g.dart';

@RestApi()
abstract class CatalogService {
  factory CatalogService(Dio dio, {String baseUrl}) = _CatalogService;

  // Tuỳ backend là GET/POST; ở đây minh hoạ POST với body: {date:'YYYY-MM-DD', branch_id:'...'}
  @POST("")
  Future<BaseListResponse<TimeSlot>> fetchTimeSlots(
      @Body() Map<String, dynamic> body);

  @POST("")
  Future<BaseListResponse<LeadService>> fetchLeadServices(
      @Body() Map<String, dynamic> body);
}
