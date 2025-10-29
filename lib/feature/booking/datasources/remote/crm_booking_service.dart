import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../data/models/booking_request.dart';
import '../../data/models/crm_booking_response.dart';

part 'crm_booking_service.g.dart';

@RestApi()
abstract class CrmBookingService {
  factory CrmBookingService(Dio dio, {String baseUrl}) = _CrmBookingService;

  @POST(
      "/entrypoint.php?name=BookingCapture") // /entrypoint.php?name=BookingCapture
  Future<CrmBookingResponse> createBooking(@Body() BookingRequest body);
}
