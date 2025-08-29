import 'dart:convert';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:pstb/app/models/medical_unit/hospital_unit_model.dart';
import 'package:mobx/mobx.dart';

import '../../../../services/api_base_helper.dart';
import '../../../../utils/api_url.dart';
import '../../../../utils/helpers/firebase_config.dart';
import '../../../../utils/sessions/session_prefs.dart';
import '../../../models/detail_medical_model.dart';
import '../../../models/lading_unit_model.dart';
import '../../../models/medical_unit/user_review_model.dart';
import '../../../models/paging_model.dart';
import '../../../models/slide_unit_model.dart';
import 'package:http/http.dart' as http;
import 'package:pstb/extensions/list_dynamic_extension.dart';

part 'detail_hospital_store.g.dart';

class DetailHospitalStore = _DetailHospitalStoreBase with _$DetailHospitalStore;

abstract class _DetailHospitalStoreBase with Store {
  final ApiBaseHelper apiBaseHelper = ApiBaseHelper();

  @observable
  bool isLoading = true;
  @observable
  bool isUpdate = false;
  @observable
  int rate = 5;
  @observable
  String review = '';
  @observable
  DetailHospitalModel detailHospital = DetailHospitalModel();
  @observable
  UserReviewModel userReviewModel = UserReviewModel();
  @observable
  List<Data> listSlide = ObservableList<Data>.of([]);
  @observable
  List<UserReviewModel> listReviewHospital =
      ObservableList<UserReviewModel>.of([]);
  @observable
  bool isChecked = false;
  @observable
  int page = 0;

  @action
  Future<void> checkLogin() async {
    final isSignedIn = await SessionPrefs.isSignedIn();
    if (isSignedIn) {
      isChecked = true;
    } else {
      isChecked = false;
    }
  }

  @action
  Future<void> getDetailMedical(int id) async {
    isLoading = true;
    EasyLoading.show();
    try {
      final response = await apiBaseHelper.get(
        '${ApiUrl.detailMedicalUnit}$id',
      );
      detailHospital = DetailHospitalModel.fromJson(response);
    } catch (e) {
      print(e);
    }
    isLoading = false;
    EasyLoading.dismiss();
  }

  @action
  Future<void> getSlideMedical(int id) async {
    isLoading = true;
    listSlide.clear();
    EasyLoading.show();
    try {
      List<dynamic> apiResponse = await apiBaseHelper.get(
        '${ApiUrl.detailMedicalUnit}$id/slide',
      );
      var response = apiResponse.mapList<Data>((x) => Data.fromJson(x));
      listSlide.addAll(response);
    } catch (e) {
      print(e);
    }
    isLoading = false;
    EasyLoading.dismiss();
  }

  @action
  Future<void> getUserReviewUnit(int id) async {
    isLoading = true;
    EasyLoading.show();
    try {
      final response = await apiBaseHelper.get(
        '${ApiUrl.detailMedicalUnit}$id/user-review',
      );
      if (response == null) {
        userReviewModel = UserReviewModel();
      }
      userReviewModel = UserReviewModel.fromJson(response);
    } catch (e) {
      print(e);
    }
    isLoading = false;
    EasyLoading.dismiss();
  }

  @action
  Future<void> sendReviewUnit(int id, String content, int rate) async {
    isLoading = true;
    EasyLoading.show();
    try {
      await ApiBaseHelper().post(
        '${ApiUrl.detailMedicalUnit}$id/user-review',
        jsonEncode(
          PostModel(rate: rate, review: content).toJson(),
        ),
      );
    } catch (e) {
      EasyLoading.dismiss();
      print(e);
    }
    isLoading = false;
    EasyLoading.dismiss();
  }

  @action
  Future<void> updateReviewUnit(int id, String content, int rate) async {
    isLoading = true;
    EasyLoading.show();
    try {
      await ApiBaseHelper().put(
        '${ApiUrl.detailMedicalUnit}$id/user-review',
        jsonEncode(
          UpdateModel(rate: rate, review: content).toJson(),
        ),
      );
    } catch (e) {
      print(e);
    }
    isLoading = false;
    EasyLoading.dismiss();
  }

  @action
  Future<void> deleteReviewUnit(
    int id,
  ) async {
    isLoading = true;
    EasyLoading.show();
    try {
      await ApiBaseHelper()
          .delete('${ApiUrl.detailMedicalUnit}$id/user-review', null);
    } catch (e) {
      print(e);
    }
    isLoading = false;
    EasyLoading.dismiss();
  }

  @action
  Future<void> getReviewHospital(int id) async {
    isLoading = true;
    EasyLoading.show();
    listReviewHospital.clear();
    try {
      // servertest

      final response = await apiBaseHelper.get(
        '${ApiUrl.detailMedicalUnit}$id/review',
        {
          "pageIndex": 0,
          "pageSize": 10,
        },
      );
      final reviewUnitPaging =
          Paging<UserReviewModel>.fromJson(response, (item) {
        return UserReviewModel.fromJson(item);
      });
      listReviewHospital.addAll(reviewUnitPaging.items!);
    } catch (e) {
      print(e);
    }
    isLoading = false;
    EasyLoading.dismiss();
  }

  @action
  Future<void> loadMoreItem(int id) async {
    isLoading = false;
    page++;
    isLoading = true;
    try {
      final response = await apiBaseHelper.get(
        '${ApiUrl.detailMedicalUnit}$id/review',
        {
          "pageIndex": page,
          "pageSize": 10,
        },
      );
      final reviewUnitPaging =
          Paging<UserReviewModel>.fromJson(response, (item) {
        return UserReviewModel.fromJson(item);
      });
      listReviewHospital.addAll(reviewUnitPaging.items!);
    } catch (e) {
      isLoading = false;
    }
    isLoading = false;
  }
}
