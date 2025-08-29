import 'dart:convert';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pstb/app/models/category_disease_model.dart';
import 'package:pstb/app/models/question_model.dart';
import 'package:pstb/services/api_base_helper.dart';
import 'package:pstb/utils/main.dart';
import 'package:mobx/mobx.dart';

import '../group_diseases_page/detail_answer_disease/detail_answer_disease_store.dart';

part 'question_store.g.dart';

class QuestionStore = QuestionStoreBase with _$QuestionStore;

enum QuestionState { error, success }

abstract class QuestionStoreBase with Store {
  @observable
  ObservableList<CategoryDiseaseModel> category =
      ObservableList<CategoryDiseaseModel>();
  @observable
  QuestionState state = QuestionState.success;
  @observable
  CategoryDiseaseModel categoryDiseaseModel = CategoryDiseaseModel();
  String contentQuestion = '';

  @observable
  bool isActiveButton = false;

  @action
  Future<void> initState() async {
    bool isShowImage = true;
    try {
      final data = await ApiBaseHelper()
          .get(ApiUrl.apiGetCategoryDisease, {"includeImage": isShowImage});
      state = QuestionState.success;
      for (final disease in data) {
        category.add(CategoryDiseaseModel.fromJson(disease));
      }
    } catch (e) {
      state = QuestionState.error;
    }
  }

  @action
  void onChangedGroup(String? value) {
    final index = category.indexWhere((element) => element.name == value);
    categoryDiseaseModel = category[index];
  }

  @action
  void onChangedQuestion(String value) {
    contentQuestion = value.trim();
  }

  @action
  Future<void> createQuestion() async {
    isActiveButton = contentQuestion.isNotEmpty &&
        categoryDiseaseModel.name != null &&
        categoryDiseaseModel.name!.isNotEmpty;
    if (isActiveButton) {
      try {
        await ApiBaseHelper().post(
            ApiUrl.apiSocialQuestion,
            jsonEncode(QuestionModel(
                    topicId: categoryDiseaseModel.id, question: contentQuestion)
                .toJson()));
        state = QuestionState.success;
      } catch (e) {
        state = QuestionState.error;
      }
    }
  }

  @action
  Future<void> pushDetailAnswer(
      CategoryDiseaseModel categoryDiseasesModel) async {
    await Modular.get<DetailAnswerDiseaseStore>()
        .initState(categoryDiseasesModel);
  }
}
