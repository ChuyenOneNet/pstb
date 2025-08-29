import 'package:pstb/app/models/paging_model.dart';
import 'package:pstb/app/models/registration_model.dart';
import 'package:pstb/services/api_base_helper.dart';
import 'package:pstb/utils/main.dart';

class RegistrationService {
  final ApiBaseHelper apiBaseHelper;

  RegistrationService({required this.apiBaseHelper});

  // Future<List<List<RegistrationModel>>> getAllRegistration(
  //     {required String registrationId,
  //     required String status,
  //     String? pageIndex,
  //     String? pageSize}) async {
  //   List<List<RegistrationModel>> data = List.generate(
  //       Constants.listStatusSpecific.length,
  //       (index) {
  //         final data =
  //         return List.generate(length, (j) => null)
  //       });
  //   return [];
  // }

  Future<Paging<RegistrationModel>> getListRegistration(
      {required String registrationId,
      required int? status,
      int? pageIndex,
      int? pageSize}) async {
    final rawData = await apiBaseHelper.get(ApiUrl.registration, {
      'RegistrationId': registrationId,
      'status': status,
      'PageIndex': pageIndex,
      'PageSize': pageSize
    });

    return Paging<RegistrationModel>.fromJson(
        rawData, (e) => RegistrationModel.fromJson(e));
  }
}
