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

  @action
  Future<void> getUserBusiness({
    required String maYte,
    required String password,
  }) async {
    try {
      final response = await _apiBaseHelper.postBase(
          ApiUrl.getUserBusiness,
          jsonEncode({
            "UserName":
                //"2500148538",
                maYte,
            "Password":
                //"4OxB7"
                password,
          }));
      userBusiness = UserBusinessModel.fromJson(response);
      print("business: $userBusiness");
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('maYte', maYte);
      await prefs.setString('passwordBusiness', password);
      await loadHistoryRecord();

      Modular.to.pushReplacementNamed(AppRoutes.businessPage);
    } on NetworkException {
      Fluttertoast.showToast(msg: 'Lỗi đăng nhập, vui lòng thử lại');
    } catch (e) {
      Fluttertoast.showToast(msg: 'Lỗi đăng nhập, vui lòng thử lại');
    }
  }

  @action
  Future loadHistoryRecord({DateTime? fromDate, DateTime? toDate}) async {
    //EasyLoading.show();
    loading = true;

    try {
      //TODO load with API

      print("id: ${userBusiness.id}");
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

      // Kiểm tra & ép kiểu
      final List<BusinessModel> _listBusiness = (response as List<dynamic>)
          .map((e) => BusinessModel.fromJson(e as Map<String, dynamic>))
          .toList();

      for (var business in _listBusiness) {
        listBusiness.add(business);
      }
      listBusiness = ObservableList.of(_listBusiness.reversed.toList());
    } catch (e) {
      loading = false;
      Fluttertoast.showToast(
        msg: 'Lỗi khi tải lịch sử khám bệnh',
        backgroundColor: AppColors.error500,
      );
      print(e);
    }
    loading = false;
    //EasyLoading.dismiss();
    // await FireBaseRemoteConfigService.getConfig();
    // initApp();
  }

  @action
  Future<void> loadBusinessDetail(String id) async {
    isLoadingDetail = true;
    //EasyLoading.show();

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
    } catch (e) {
      Fluttertoast.showToast(
        msg: 'Lỗi khi tải chi tiết hồ sơ',
        backgroundColor: AppColors.error500,
      );
      businessDetail = null;
      print("Error in loadBusinessDetail: $e");
    }

    isLoadingDetail = false;
    //EasyLoading.dismiss();
  }

  @action
  Future<String?> fetchVienPhiPdfBase64(String maGiaoDich) async {
    try {
      final response = await _apiBaseHelper.getBase(
        ApiUrl.getVienPhiPdf,
        {'medicalFeeId': maGiaoDich},
      );

      return response as String;
    } catch (e, _) {
      Fluttertoast.showToast(
        msg: 'Lỗi khi xem pdf viện phí',
        backgroundColor: AppColors.error500,
      );
      // debugPrint('Lỗi khi lấy PDF hóa đơn: $e');
    }
    return null;
  }

  @action
  Future<bool> resetPassword({
    required String userName,
  }) async {
    try {
      final response = await _apiBaseHelper.postBase(
        ApiUrl.resetPasswordBusiness, // 👉 sửa lại theo URL thực tế nếu khác
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
    } catch (e) {
      Fluttertoast.showToast(
        msg: 'Lỗi khi đặt lại mật khẩu',
        backgroundColor: AppColors.error500,
      );
      print('Reset password error: $e');
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

      // Xử lý kết quả trả về tùy vào API
      if (response != null) {
        Fluttertoast.showToast(
          msg: response,
          backgroundColor: AppColors.error500,
        );
        return true;
      } else {
        Fluttertoast.showToast(
          msg: response['message'] ?? 'Đổi mật khẩu thất bại',
          backgroundColor: AppColors.error500,
        );
        return false;
      }
    } on NetworkException {
      Fluttertoast.showToast(
        msg: 'Lỗi kết nối mạng',
        backgroundColor: AppColors.error500,
      );
      return false;
    } catch (e) {
      Fluttertoast.showToast(
        msg: 'Đã xảy ra lỗi khi đổi mật khẩu',
        backgroundColor: AppColors.error500,
      );
      print('Error changePassword: $e');
      return false;
    }
  }
}
