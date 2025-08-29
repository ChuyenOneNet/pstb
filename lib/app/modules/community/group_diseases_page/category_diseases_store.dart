import 'package:flutter_modular/flutter_modular.dart';
import 'package:pstb/app/models/category_disease_model.dart';
import 'package:pstb/services/api_base_helper.dart';
import 'package:pstb/utils/api_url.dart';
import 'package:mobx/mobx.dart';

import '../../../../utils/helpers/firebase_config.dart';
import 'detail_answer_disease/detail_answer_disease_store.dart';
part 'category_diseases_store.g.dart';

class CategoryDiseasesStore = CategoryDiseasesStoreBase
    with _$CategoryDiseasesStore;

enum CategoryDiseasesState { error }

abstract class CategoryDiseasesStoreBase with Store {
  @observable
  ObservableList<CategoryDiseaseModel> category =
      ObservableList<CategoryDiseaseModel>();
  @observable
  CategoryDiseasesState state = CategoryDiseasesState.error;
  @action
  Future<void> initState() async {
    bool isShowImage = true;
    try {
      final data = await Modular.get<ApiBaseHelper>()
          .get(ApiUrl.apiGetCategoryDisease, {"includeImage": isShowImage});
      for (final disease in data) {
        category.add(CategoryDiseaseModel.fromJson(disease));
      }
    } catch (e) {
      state = CategoryDiseasesState.error;
    }
  }

  @action
  Future<void> pushDetailAnswer(
      CategoryDiseaseModel categoryDiseasesModel) async {
    await Modular.get<DetailAnswerDiseaseStore>()
        .initState(categoryDiseasesModel);
  }
}
