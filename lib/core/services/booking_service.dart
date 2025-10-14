import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../../app/modules/booking_v2/model/create_request_model.dart';
import '../../app/modules/booking_v2/model/create_request_response.dart';
import '../base/base_response.dart';

part 'booking_service.g.dart';

@RestApi()
abstract class BookingService {
  factory BookingService(Dio dio, {String baseUrl}) = _BookingService;

  @POST("/api/Register/register-medical")
  Future<CreateRequestModel?> createRequest(
    @Body() CreateRequestModel model,
  );
}
