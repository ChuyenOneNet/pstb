import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:pstb/app/modules/first_aid_guide/models/first_aid_model.dart';
import 'package:pstb/app/models/emergency_model.dart';
import 'package:pstb/services/api_base_helper.dart';
import 'package:pstb/utils/main.dart';
import 'package:pstb/widgets/stateless/app_snack_bar.dart';

part 'first_aid_store.g.dart';

class FirstAidStore = FirstAidStoreBase with _$FirstAidStore;

abstract class FirstAidStoreBase with Store {
  final ApiBaseHelper _apiBaseHelper = Modular.get<ApiBaseHelper>();

  //@observable
  // List<FirstAids> listTutorial = [
  //   FirstAids(id: 1, img: ImageEnum.batTinh, title: "Bất tỉnh"),
  //   FirstAids(id: 2, img: ImageEnum.chayMau, title: "Chảy máu"),
  //   FirstAids(id: 3, img: ImageEnum.bong, title: "Bỏng"),
  //   FirstAids(id: 4, img: ImageEnum.gayXuong, title: "Gãy xương"),
  //   FirstAids(id: 5, img: ImageEnum.dotQuy, title: "Đột quỵ"),
  //   FirstAids(id: 6, img: ImageEnum.nhoiMau, title: "Nhồi máu cơ tim"),
  //   FirstAids(id: 7, img: ImageEnum.batTinh1, title: "Bất tỉnh"),
  //   FirstAids(id: 8, img: ImageEnum.batTinh2, title: "Bất tỉnh"),
  // ];

  @action
  void navigateTo(String route) {
    Modular.to.pushNamed(route);
  }

  late BuildContext mContext;

  @observable
  bool loading = true;

  @observable
  var firstAids = ObservableList<EmergencyModel>.of([]);

  @computed
  List<FirstAidsViewModel> get listTutorial {
    List<FirstAidsViewModel> _listTutorial = [];
    for (var element in firstAids) {
      final FirstAidsViewModel _firstAid = FirstAidsViewModel(
        id: element.id!,
        img: element.image,
        title: element.title,
      );
      _listTutorial.add(_firstAid);
    }
    return _listTutorial;
  }

  EmergencyModel getFirstAid(int index) {
    return firstAids[index];
  }

  @action
  Future<void> getEmergency({required BuildContext newContext}) async {
    loading = true;
    mContext = newContext;
    try {
      final response = await _apiBaseHelper.get(
        ApiUrl.firstAid,
      );
      if (response != null) {
        response.forEach((e) {
          var model = EmergencyModel.fromJson(e);
          if (model.id != 1 &&
              model.id != 2 &&
              model.id != 3 &&
              model.id != 4 &&
              model.id != 5 &&
              model.id != 6) firstAids.add(model);
        });
      }
    } catch (e) {
      AppSnackBar.show(
          mContext, AppSnackBarType.Error, l10n(newContext)!.wrong_when_try);
    }
    loading = false;
  }
}
