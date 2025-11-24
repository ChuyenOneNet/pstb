import 'dart:async';
import 'dart:convert';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:pstb/app/models/business_detail_model.dart';
import 'package:pstb/app/modules/home/home_store.dart';
import 'package:pstb/utils/main.dart';
import 'package:mobx/mobx.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../services/api_base_helper.dart';
import '../../../services/api_exception.dart';
import '../../models/business_model.dart';
import '../../models/user_business_model.dart';

part 'business_store.g.dart';

const String authorizationIntegration = 'sys.admin:1';
const String roleCode = 'BAC_SI';
const String? userName = 'sys.admin';

class BusinessStore = BusinessStoreBase with _$BusinessStore;

abstract class BusinessStoreBase with Store {
  final _apiBaseHelper = Modular.get<ApiBaseHelper>();
  final HomeStore homeStore = Modular.get<HomeStore>();

  @observable
  bool loading = true;
  @observable
  UserBusinessModel userBusiness = UserBusinessModel();
  // Hồ sơ bệnh nhân
  @observable
  List<BusinessModel> listBusiness = ObservableList<BusinessModel>.of([]);

  @observable
  BusinessDetailModel? businessDetail;

  @observable
  bool isLoadingDetail = false;

  Future<bool> getUserBusiness({
    required String maYte,
    required String password,
  }) async {
    try {
      final response = await _apiBaseHelper.postBase(
        ApiUrl.getUserBusiness,
        jsonEncode({
          "UserName": maYte,
          "Password": password,
        }),
      );
      print("response111 $response");

      final status = response;
      if (status is bool && status != true) {
        return false;
      }

      userBusiness = UserBusinessModel.fromJson(response);

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('maYte', maYte);
      await prefs.setString('passwordBusiness', password);
      await loadHistoryRecord();

      return true;
    } on NetworkException catch (e, stack) {
      print("❌ NetworkException in getUserBusiness: $e");
      return false;
    } catch (e, stack) {
      print("❌ Error in getUserBusiness: $e");
      return false;
    }
  }

  @action
  Future loadHistoryRecord({DateTime? fromDate, DateTime? toDate}) async {
    loading = true;
    try {
      print("🔎 id: ${userBusiness.id}");
      final response = await _apiBaseHelper.postBase(
        ApiUrl.getBusinessHistory,
        (fromDate != null && toDate != null)
            ? jsonEncode({
                "Key": userBusiness.id,
                "TuNgay": DateFormat('yyyy-MM-dd').format(fromDate),
                "DenNgay": DateFormat('yyyy-MM-dd').format(toDate),
              })
            : jsonEncode({
                "Key": userBusiness.id,
              }),
      );

      final List<BusinessModel> _listBusiness = (response as List<dynamic>)
          .map((e) => BusinessModel.fromJson(e as Map<String, dynamic>))
          .toList();

      listBusiness = ObservableList.of(_listBusiness.reversed.toList());
    } catch (e, stack) {
      Fluttertoast.showToast(
        msg: 'Lỗi khi tải lịch sử khám bệnh',
        backgroundColor: AppColors.error500,
      );
      print("❌ Error in loadHistoryRecord: $e");
      print("📌 StackTrace: $stack");
    }
    loading = false;
  }

  @action
  Future<void> loadBusinessDetail(String id) async {
    isLoadingDetail = true;
    try {
      final response = await _apiBaseHelper.getBase(
        ApiUrl.getBusinessDetail,
        {'id': id},
      );

      if (response != null) {
        businessDetail =
            BusinessDetailModel.fromJson(response as Map<String, dynamic>);
      } else {
        businessDetail = null;
      }
    } catch (e, stack) {
      Fluttertoast.showToast(
        msg: 'Lỗi khi tải chi tiết hồ sơ',
        backgroundColor: AppColors.error500,
      );
      businessDetail = null;
      print("❌ Error in loadBusinessDetail: $e");
      print("📌 StackTrace: $stack");
    }
    isLoadingDetail = false;
  }

  @action
  Future<String?> fetchVienPhiPdfBase64(String maGiaoDich) async {
    try {
      final response = await _apiBaseHelper.getBase(
        ApiUrl.getVienPhiPdf,
        {'medicalFeeId': maGiaoDich},
      );
      return response as String;
    } catch (e, stack) {
      Fluttertoast.showToast(
        msg: 'Lỗi khi xem pdf viện phí',
        backgroundColor: AppColors.error500,
      );
      print("❌ Error in fetchVienPhiPdfBase64: $e");
      print("📌 StackTrace: $stack");
      return null;
    }
  }

  @action
  Future<bool> resetPassword({
    required String userName,
  }) async {
    try {
      final response = await _apiBaseHelper.postBase(
        ApiUrl.resetPasswordBusiness,
        jsonEncode({
          "UserName": userName,
        }),
      );

      if (response != null) {
        Fluttertoast.showToast(msg: 'Đặt lại mật khẩu thành công');
        return true;
      } else {
        Fluttertoast.showToast(msg: 'Đặt lại mật khẩu thất bại');
        return false;
      }
    } catch (e, stack) {
      Fluttertoast.showToast(
        msg: 'Lỗi khi đặt lại mật khẩu',
        backgroundColor: AppColors.error500,
      );
      print("❌ Error in resetPassword: $e");
      print("📌 StackTrace: $stack");
      return false;
    }
  }

  @action
  Future<bool> changePassword({
    required String userName,
    required String oldPassword,
    required String newPassword,
  }) async {
    try {
      final response = await _apiBaseHelper.postBase(
        ApiUrl.changePasswordBusiness,
        jsonEncode({
          "UserName": userName,
          "Password": oldPassword,
          "NewPassword": newPassword,
        }),
      );

      if (response != null) {
        Fluttertoast.showToast(
          msg: response,
          backgroundColor: AppColors.error500,
        );
        return true;
      } else {
        Fluttertoast.showToast(
          msg: 'Đổi mật khẩu thất bại',
          backgroundColor: AppColors.error500,
        );
        return false;
      }
    } on NetworkException catch (e, stack) {
      Fluttertoast.showToast(
        msg: 'Lỗi kết nối mạng',
        backgroundColor: AppColors.error500,
      );
      print("❌ NetworkException in changePassword: $e");
      print("📌 StackTrace: $stack");
      return false;
    } catch (e, stack) {
      Fluttertoast.showToast(
        msg: 'Đã xảy ra lỗi khi đổi mật khẩu',
        backgroundColor: AppColors.error500,
      );
      print("❌ Error in changePassword: $e");
      print("📌 StackTrace: $stack");
      return false;
    }
  }
}
