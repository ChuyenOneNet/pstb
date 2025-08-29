import 'package:pstb/app/models/covid_declaration_model.dart';
import 'package:mobx/mobx.dart';
import 'package:pstb/app/modules/medical_appointment/pages/select_doctor/models/doctor_model.dart';
import '../../models/paging_model.dart';
import '../../../services/api_base_helper.dart';
import '../../../utils/main.dart';
import '../../models/search_model.dart';
import 'pages/medical_package_detail/models/medical_model.dart';

part 'medical_appointment_store.g.dart';

class MedicalAppointmentStore = MedicalAppointmentStoreBase
    with _$MedicalAppointmentStore;

abstract class MedicalAppointmentStoreBase with Store {
  CovidDeclaration? _covidDeclaration;
  @observable
  bool consultation = true;

  final ApiBaseHelper _apiBaseHelper = ApiBaseHelper();
  int pageIndex = 0;

  @observable
  bool testAtHome = false;

  @observable
  bool visible = true;

  @observable
  bool checkTimeVisitDoctor = true;

  @observable
  bool examAtHome = false;

  @observable
  bool dataForAtHome = false;

  @action
  void changeSearchDataAtHome(bool val) => dataForAtHome = val;

  @action
  void setTestAtHome(bool val) => testAtHome = val;

  @action
  void setExamAtHome(bool val) => examAtHome = val;

  @action
  void setVisible(bool val) => visible = val;

  @action
  void setcheckTimeVisitDoctor(bool val) => checkTimeVisitDoctor = val;

  @observable
  String selectedCategoryGroupId = '';

  @observable
  bool isMedicalFacil = false;

  @observable
  ObservableList<PackageModel> packagesList =
      ObservableList<PackageModel>.of([]);

  // @observable
  // List<String> selectedCategoryGroupIds = [];

  @observable
  ObservableList<PackageModel> listPackageShowed =
      ObservableList<PackageModel>.of([]);

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
  bool loadingPackage = true;

  @observable
  bool errloadPackage = false;

  @action
  void setCategoryGroupId(String categoryGroup) {
    selectedCategoryGroupId = categoryGroup;
    _resetCachedData();
  }

  // @action
  // void setCategoryGroupIds(List<String> categoryGroups) {
  //   selectedCategoryGroupIds = categoryGroups;
  //   _resetCachedData();
  // }

  @action
  void addPackageToShowed(PackageModel data) {
    listPackageShowed.clear();
    listPackageShowed.add(data);
  }

  @action
  void removePackageToShow(PackageModel data) {
    listPackageShowed.removeLast();
  }

  @action
  void setMedicaFacil(bool isMedicalFacility) =>
      isMedicalFacil = isMedicalFacility;

  @action
  void setConsultation(bool isConsultation) => consultation = isConsultation;

  @observable
  PackageModel selectedPackage = PackageModel();

  @computed
  bool get isGetSampleInPackage => selectedPackage.isGetSample ?? false;

  @observable
  DoctorPagingItem? doctorDetail;

  @action
  void setPackageDetail(PackageModel data) {
    selectedPackage = data;
  }

  @action
  void chooseDoctor(DoctorPagingItem data) => doctorDetail = data;

  void setCovidDeclaration(CovidDeclaration covidDeclaration) {
    _covidDeclaration = covidDeclaration;
  }

  @action
  Future<void> getPackages() async {
    searchObj.parentId = '0';
    searchObj.categoryGroupId = selectedCategoryGroupId;
    Map<String, dynamic> params = {};
    params.addAll(searchObj.toJson());
    params.addAll({'pageSize': '10', 'pageIndex': pageIndex});
    loadingPackage = true;
    try {
      final response = await _apiBaseHelper.get(ApiUrl.packages, params);
      final packagePaging = Paging<PackageModel>.fromJson(response, (item) {
        return PackageModel.fromJson(item);
      });
      final packages = packagePaging.items;
      if (packages == null || packages.isEmpty) return;
      pageIndex += 1;
      for (var item in packages) {
        packagesList.add(item);
      }
    } catch (e) {
      errloadPackage = true;
    }
    loadingPackage = false;
  }

  CovidDeclaration? getCovidDeclaration() => _covidDeclaration;

  void _resetCachedData() {
    _covidDeclaration = null;
  }

  void setPackageList(List<PackageModel> list) {
    for (var item in list) {
      packagesList.add(item);
    }
  }
}
