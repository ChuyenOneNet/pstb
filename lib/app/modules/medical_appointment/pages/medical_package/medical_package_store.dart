import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:pstb/app/models/category_model.dart';
import 'package:pstb/app/modules/medical_appointment/medical_appointment_store.dart';
import 'package:pstb/app/modules/medical_appointment/pages/medical_package_detail/models/medical_model.dart';
import 'package:pstb/app/models/paging_model.dart';
import 'package:mobx/mobx.dart';
import 'package:pstb/app/models/search_model.dart';
import 'package:pstb/app/models/packages_model.dart';
import 'package:pstb/services/api_base_helper.dart';
import 'package:pstb/utils/main.dart';
import 'package:pstb/widgets/stateful/stateful_widget.dart';

import '../../../../../utils/sessions/session_prefs.dart';

part 'medical_package_store.g.dart';

class MedicalPackageStore = MedicalPackageStoreBase with _$MedicalPackageStore;

abstract class MedicalPackageStoreBase with Store {
  final MedicalAppointmentStore _appointmentStore =
      Modular.get<MedicalAppointmentStore>();
  final _apiBaseHelper = Modular.get<ApiBaseHelper>();
  late BuildContext mContext;
  @observable
  List<PackagePagingItem> physicalExam = [];
  @observable
  List<PackagePagingItem> analysisPackage = [];
  @observable
  List<PackagePagingItem> medicalPackage = [];
  @observable
  List<PackageModel> listPackageSearch = [];
  @observable
  List<PackagePagingItem> consultationSpecialist = [];
  @observable
  List<PackagePagingItem> psychologicalHealth = [];
  @observable
  List<String> keywordSearch = [];
  @observable
  int pageIndex = 0;
  @observable
  int pageIndexSearch = 0;
  @observable
  int pageOtherIndex = 0;
  @observable
  bool clear = false;
  @observable
  bool finish = false;
  @observable
  int medicalUnitId = 0;
  @observable
  String keyword = "";
  @observable
  bool otherPackage = true;
  @observable
  bool packageGroup = false;

  MedicalAppointmentStore medicalAppointmentStore =
      Modular.get<MedicalAppointmentStore>();

  @action
  void createBuildContext(BuildContext newContext) {
    mContext = newContext;
  }

  /// xem view có cần dùng đến dịch vụ khác không
  @action
  void setOtherPackage(bool isOtherPackage) => otherPackage = isOtherPackage;

  /// xem view dịch vụ khác từ đặt lịch hay từ gói khám nổi bật
  @action
  void setPackageGroup(bool isPackageGroup) => packageGroup = isPackageGroup;

  @action
  void navigateTo(String route) {
    Modular.to.pushNamed(route);
  }

  @observable
  ObservableList<PackageModel> packagesList =
      ObservableList<PackageModel>.of([]);

  @observable
  ObservableList<PackageModel> otherPackagesList =
      ObservableList<PackageModel>.of([]);

  @observable
  bool loadingPackage = true;

  @observable
  bool errloadPackage = false;

  @action
  Future<void> setOtherPackageList() async {}
  // List<PackageModel> _generateFakePackages({int count = 10}) {
  //   final List<String> names = [
  //     'Gói khám tổng quát',
  //     'Gói khám tiêu hóa',
  //     'Gói tầm soát ung thư',
  //     'Gói khám tai mũi họng',
  //     'Gói khám tim mạch',
  //     'Gói kiểm tra huyết áp',
  //     'Gói xét nghiệm máu',
  //     'Gói kiểm tra tiểu đường',
  //     'Gói khám sức khỏe định kỳ',
  //     'Gói kiểm tra chức năng gan'
  //   ];
  //
  //   return List.generate(count, (index) {
  //     return PackageModel(
  //       id: index,
  //       name: names[index % names.length],
  //       description:
  //           'Mô tả chi tiết cho ${names[index % names.length]}. Bao gồm nhiều hạng mục kiểm tra chuyên sâu.',
  //       price: 300000 + index * 100000,
  //       originalPrice: 500000 + index * 120000,
  //       image: 'https://via.placeholder.com/150', // ảnh fake mẫu
  //       icon: 'https://via.placeholder.com/50', // icon fake mẫu
  //       categoryId: 'cat$index',
  //       categoryName: 'Chuyên khoa ${index + 1}',
  //       insurance: index % 2 == 0,
  //       gender: index % 3 == 0 ? 'Nam' : 'Nữ',
  //       categoryGroupCode: 'group${index % 4}',
  //       disCount: 15,
  //       isGetSample: index % 2 == 0,
  //       isSeeDoctor: index % 3 == 1,
  //       isChoiceDoctor: index % 4 == 0,
  //       testAtHome: false,
  //       examAtHome: false,
  //     );
  //   });
  // }

  @action
  Future<void> getPackages() async {
    loadingPackage = true;
    packagesList.clear();
    otherPackagesList.clear();
    EasyLoading.show();
    await Future.delayed(const Duration(seconds: 1)); // Simulate delay

    if (medicalAppointmentStore.dataForAtHome) {
      searchObj.atHomeOption = "2";
    } else {
      searchObj.parentId = '0';
      searchObj.categoryGroupId =
          medicalAppointmentStore.selectedCategoryGroupId;
    }
    Map<String, dynamic> params = {};
    // params.addAll(searchObj.toJson());
    medicalUnitId = await SessionPrefs.getMedicalUnitId() ?? 0;
    params.addAll({
      'pageSize': '10',
      'pageIndex': 0,
      'MedicalUnitId': medicalUnitId,
    });
    if (loadingPackage != false) {
      loadingPackage = true;
    }
    try {
      // ApiUrl.baseUrl = "http://192.168.1.123:5244"; -- server test
      final response = await _apiBaseHelper.get(ApiUrl.packages, params);
      final packagePaging = Paging<PackageModel>.fromJson(response, (item) {
        return PackageModel.fromJson(item);
      });
      final packages = packagePaging.items;
      if (packages == null || packages.isEmpty) {
        finish = true;
        EasyLoading.dismiss();
        loadingPackage = false;
        return;
      }
      // pageIndex += 1;
      for (var item in packages) {
        packagesList.add(item);
        otherPackagesList.add(item);
      }
      // if (packages == null || packages.isEmpty) {
      //   // ➜ fallback to fake data
      //   final fakeItems = _generateFakePackages();
      //   packagesList.addAll(fakeItems);
      //   otherPackagesList.addAll(fakeItems);
      // } else {
      //   packagesList.addAll(packages);
      //   otherPackagesList.addAll(packages);
      // }
      EasyLoading.dismiss();
    } catch (e) {
      // final fakeItems = _generateFakePackages();
      // packagesList.addAll(fakeItems);
      // otherPackagesList.addAll(fakeItems);
      EasyLoading.dismiss();
      errloadPackage = true;
    }
    EasyLoading.dismiss();
    loadingPackage = false;
  }

  @action
  Future<void> loadMorePackage() async {
    loadingPackage = true;
    pageIndex++;
    if (medicalAppointmentStore.dataForAtHome) {
      searchObj.atHomeOption = "2";
    } else {
      searchObj.parentId = '0';
      searchObj.categoryGroupId =
          medicalAppointmentStore.selectedCategoryGroupId;
    }
    Map<String, dynamic> params = {};
    // params.addAll(searchObj.toJson());
    medicalUnitId = await SessionPrefs.getMedicalUnitId() ?? 0;
    params.addAll({
      'pageSize': '10',
      'pageIndex': pageIndex,
      'MedicalUnitId': medicalUnitId,
    });
    try {
      final response = await _apiBaseHelper.get(ApiUrl.packages, params);
      final packagePaging = Paging<PackageModel>.fromJson(response, (item) {
        return PackageModel.fromJson(item);
      });
      final packages = packagePaging.items;
      if (packages == null || packages.isEmpty) {
        loadingPackage = false;
        return;
      }
      for (var item in packages) {
        packagesList.add(item);
      }
    } catch (e) {
      errloadPackage = true;
    }
    loadingPackage = false;
  }

  @action
  Future<void> getSearchPackages(String value, {bool useFake = false}) async {
    value = value.trim();
    loadingPackage = true;
    EasyLoading.show();
    keywordSearch.add(value);
    keywordSearch = keywordSearch.toSet().toList();
    listPackageSearch.clear();

    await Future.delayed(const Duration(seconds: 1)); // Simulate delay

    Map<String, dynamic> params = {};
    medicalUnitId = await SessionPrefs.getMedicalUnitId() ?? 0;
    params.addAll({
      'slug': value,
      'pageSize': '10',
      'pageIndex': 0,
      'MedicalUnitId': medicalUnitId,
    });
    try {
      final response = await _apiBaseHelper.get(ApiUrl.packages, params);
      final packagePaging = Paging<PackageModel>.fromJson(response, (item) {
        return PackageModel.fromJson(item);
      });
      final packages = packagePaging.items;
      // if (packages == null || packages.isEmpty) {
      //   // ➜ fallback to fake data
      //   final fakeItems = _generateFakePackages();
      //   listPackageSearch.addAll(fakeItems);
      // } else {
      //   listPackageSearch.addAll(packages);
      // }
      if (packages == null || packages.isEmpty) {
        loadingPackage = false;
        EasyLoading.dismiss();
        return;
      }
      for (var item in packages) {
        listPackageSearch.add(item);
      }
    } catch (e) {
      // final fakeItems = _generateFakePackages();
      // listPackageSearch.addAll(fakeItems);
      EasyLoading.dismiss();
      errloadPackage = true;
    }
    loadingPackage = false;
    EasyLoading.dismiss();
  }

  @action
  Future<void> loadMoreSearchPackages(String value) async {
    loadingPackage = true;
    pageIndexSearch++;
    Map<String, dynamic> params = {};
    medicalUnitId = await SessionPrefs.getMedicalUnitId() ?? 0;
    params.addAll({
      'slug': value,
      'pageSize': '10',
      'pageIndex': pageIndexSearch,
      'MedicalUnitId': medicalUnitId,
    });
    try {
      final response = await _apiBaseHelper.get(ApiUrl.packages, params);
      final packagePaging = Paging<PackageModel>.fromJson(response, (item) {
        return PackageModel.fromJson(item);
      });
      final packages = packagePaging.items;
      if (packages == null || packages.isEmpty) {
        loadingPackage = false;
        return;
      }
      for (var item in packages) {
        listPackageSearch.add(item);
      }
    } catch (e) {
      errloadPackage = true;
    }
    loadingPackage = false;
  }

  @action
  Future<void> loadMoreOtherPackage() async {
    loadingPackage = true;
    pageOtherIndex++;
    if (medicalAppointmentStore.dataForAtHome) {
      searchObj.atHomeOption = "2";
    } else {
      searchObj.parentId = '0';
      searchObj.categoryGroupId =
          medicalAppointmentStore.selectedCategoryGroupId;
    }
    Map<String, dynamic> params = {};
    params.addAll(searchObj.toJson());
    params.addAll({'pageSize': '10', 'pageIndex': pageOtherIndex});
    try {
      final response = await _apiBaseHelper.get(ApiUrl.packages, params);
      final packagePaging = Paging<PackageModel>.fromJson(response, (item) {
        return PackageModel.fromJson(item);
      });
      final packages = packagePaging.items;
      if (packages == null || packages.isEmpty) {
        loadingPackage = false;
        return;
      }
      for (var item in packages) {
        otherPackagesList.add(item);
      }
    } catch (e) {
      errloadPackage = true;
    }
    loadingPackage = false;
  }

  @action
  Future<void> getAdvisory() async {
    // try {
    //   final response = await _apiBaseHelper.get(ApiUrl.advisory);
    //   final responsitory = PackageResponsitory.fromJson(response);
    //   final activePackage = responsitory.results!
    //       .where((element) => element.status == Constants.activate);
    //   _packageResponsitory = activePackage.groupListsBy((element) {
    //     if (element.category != null && element.category!.isNotEmpty) {
    //       return element.category![0].name;
    //     }
    //     return l10n(context)!.other;
    //   });
    // } catch (e) {
    // } finally {
    //   loadingPackage = false;
    // }
  }

  // Search

  @observable
  SearchModel searchObj = SearchModel(
    slug: '',
    categorySlug: '',
    priceHigher: '',
    priceLower: '',
    ordering: '',
    parentId: '',
  );

  @observable
  ObservableList<FilterObject> categories = ObservableList<FilterObject>.of([]);

  @observable
  bool hadSearchButNoResult = false;

  @action
  void onChangeSearchFilter(
      {String? categorySlug,
      String? priceGte,
      String? priceLte,
      String? ordering}) {
    searchObj.categorySlug = categorySlug;
    searchObj.priceHigher = priceGte;
    searchObj.priceLower = priceLte;
    searchObj.ordering = ordering;
  }

  @action
  void onChangeSearchText(String value) {
    searchObj.slug = value;
  }

  @action
  Future<void> refreshList() async {
    packagesList.clear();
    otherPackagesList.clear();
    pageIndex = 0;
    pageOtherIndex = 0;
    await getPackages();
  }

  @action
  Future<void> searchPackages() async {
    loadingPackage = true;
    try {
      searchObj.categoryGroupId =
          medicalAppointmentStore.selectedCategoryGroupId;
      final response =
          await _apiBaseHelper.get(ApiUrl.packages, searchObj.toJson());
      final packagePaging = Paging<PackageModel>.fromJson(
          response, (item) => PackageModel.fromJson(item));
      final packages = packagePaging.items;
      hadSearchButNoResult = packages == null || packages.isEmpty;
      loadingPackage = false;
      // if (packages != null) {
      //   _packages = packages.groupListsBy((element) {
      //     return element.categoryName ?? l10n(mContext)!.other;
      //   });
      // }
    } catch (e) {}
  }

  @action
  Future<void> getListCategory() async {
    try {
      medicalUnitId = await SessionPrefs.getMedicalUnitId() ?? 0;
      final response = await _apiBaseHelper.get(
        ApiUrl.category,
        {"MedicalUnitId": medicalUnitId},
      );
      final categoryPaging =
          Paging.fromJson(response, (item) => CategoryModel.fromJson(item));
      var items = categoryPaging.items;
      if (items != null && items.isNotEmpty) {
        for (var element in items) {
          categories.add(FilterObject(
              id: element.doctorId, name: element._name, value: element.slug));
        }
      } else {
        categories = ObservableList<FilterObject>.of([
          const FilterObject(id: 0, name: '', value: ''),
        ]);
      }
    } catch (e) {
      print('somethingWrong:${e.toString()}');
    }
  }

  void nextPage() {
    if (_appointmentStore.selectedPackage.isChoiceDoctor ?? false) {
      Modular.to.pushNamed(AppRoutes.selectDoctor);
    } else {
      if (_appointmentStore.selectedPackage.isSeeDoctor ?? false) {
        Modular.to.pushNamed(AppRoutes.medicalTimeVisitDoctor,
            arguments: {"doctorId": null, "booking": null});
      } else if (_appointmentStore.selectedPackage.isGetSample ?? false) {
        Modular.to.pushNamed(AppRoutes.medicalTimeGetResultTest);
      }
    }
  }

  void nextPageWithPostInfo() {
    if (_appointmentStore.testAtHome) {
      Modular.to.pushNamed(AppRoutes.postInfoTestPage);
      return;
    } else {
      Modular.to.pushNamed(AppRoutes.postInfoExamPage);
      return;
    }
  }
}
