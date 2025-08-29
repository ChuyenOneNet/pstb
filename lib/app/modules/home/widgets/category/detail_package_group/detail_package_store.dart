import 'package:pstb/app/modules/medical_appointment/pages/medical_package_detail/models/medical_model.dart';
import 'package:pstb/app/models/paging_model.dart';
import 'package:pstb/services/api_base_helper.dart';
import 'package:pstb/utils/main.dart';
import 'package:mobx/mobx.dart';
part 'detail_package_store.g.dart';

class DetailPackageStore = DetailPackageStoreBase with _$DetailPackageStore;

abstract class DetailPackageStoreBase with Store {
  @observable
  Paging<PackageModel> detailPackageGroupModel = Paging<PackageModel>();
  @observable
  bool isLoading = true;
  @observable
  String titleAppbar = '';
  @observable
  List<PackageModel> listPackage = ObservableList<PackageModel>();
  @observable
  List<PackageModel> otherListPackage = ObservableList<PackageModel>();
  final ApiBaseHelper _apiBaseHelper = ApiBaseHelper();

  int _id = 0;
  @action
  Future<void> initDetail(int id, {String name = ''}) async {
    isLoading = true;
    titleAppbar = name;
    _id = id;
    try {
      final response =
          await _apiBaseHelper.get(ApiUrl.packages, {'packageGroupId': '$id'});
      if (response != null) {
        detailPackageGroupModel =
            Paging<PackageModel>.fromJson(response, (item) {
          return PackageModel.fromJson(item);
        });
        for (final item in detailPackageGroupModel.items ?? []) {
          listPackage.add(item);
        }
        isLoading = false;
      }
    } catch (e) {
      isLoading = false;
      throw 'Lỗi';
    }
  }

  @action
  Future<void> loadMorePackage() async {
    final pageIndex = (detailPackageGroupModel.total ?? 0) -
        ((detailPackageGroupModel.pageIndex ?? 0) + 1) *
            (detailPackageGroupModel.pageSize ?? 0);
    try {
      isLoading = true;
      if (pageIndex > 0) {
        final response = await _apiBaseHelper.get(ApiUrl.packages,
            {'packageGroupId': '$_id', 'pageIndex': '$pageIndex'});
        if (response != null) {
          detailPackageGroupModel =
              Paging<PackageModel>.fromJson(response, (item) {
            return PackageModel.fromJson(item);
          });
        }
      }
      isLoading = false;
    } catch (e) {
      isLoading = false;
      throw 'Lỗi';
    }
  }

  @action
  Future<void> onRefreshPackage() async {
    try {
      listPackage = [];
      isLoading = true;
      final response =
          await _apiBaseHelper.get(ApiUrl.packages, {'packageGroupId': '$_id'});
      if (response != null) {
        detailPackageGroupModel =
            Paging<PackageModel>.fromJson(response, (item) {
          return PackageModel.fromJson(item);
        });
        for (final item in detailPackageGroupModel.items ?? []) {
          listPackage.add(item);
        }
        isLoading = false;
      }
    } catch (e) {
      isLoading = false;
      throw 'Lỗi';
    }
  }
}
