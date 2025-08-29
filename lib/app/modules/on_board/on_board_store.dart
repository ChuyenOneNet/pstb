import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pstb/app/models/tutorial_model.dart';
import 'package:pstb/services/api_base_helper.dart';
import 'package:pstb/utils/main.dart';

part 'on_board_store.g.dart';

class OnBoardStore = _OnBoardStoreBase with _$OnBoardStore;

abstract class _OnBoardStoreBase with Store {
  final ApiBaseHelper _apiBaseHelper = Modular.get<ApiBaseHelper>();

  @observable
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  @observable
  int slideNo = 0;

  @computed
  int get slide => slideNo;

  @action
  void changeSlide(indexOfPage) {
    slideNo = indexOfPage;
  }

  Future onNextPress(controllerSlider) async {
    if (slideNo < tutorialList.length - 1) {
      controllerSlider.nextPage();
      return;
    }
    final SharedPreferences prefs = await _prefs;
    await prefs.setInt(Constants.firstTimeLoadApp, 1);
    // Modular.to.popAndPushNamed(AppRoutes.main);
    Modular.to.popAndPushNamed(AppRoutes.selectionHospitalModule);
  }

  @observable
  var tutorialList = ObservableList<TutorialModel>.of([]);

  @computed
  List<String> get tutorials {
    List<String> result = [];
    for (var element in tutorialList) {
      result.add(element.image!);
    }
    return result;
  }

  @action
  Future<void> getTutorial() async {
    EasyLoading.show();
    try {
      final response = await _apiBaseHelper.get(ApiUrl.tutorials);
      if (response != null) {
        response.forEach((v) {
          tutorialList.add(TutorialModel.fromJson(v));
        });
      }
    } catch (e) {
      print(e);
    }
    EasyLoading.dismiss();
  }
}
