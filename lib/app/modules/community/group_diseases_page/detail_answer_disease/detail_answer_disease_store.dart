import 'dart:convert';

import 'package:pstb/app/models/category_disease_model.dart';
import 'package:pstb/app/models/topic_disease_model.dart';
import 'package:pstb/services/api_base_helper.dart';
import 'package:pstb/utils/main.dart';
import 'package:mobx/mobx.dart';

import '../../../../../utils/helpers/firebase_config.dart';
import '../../../../models/question_model.dart';

part 'detail_answer_disease_store.g.dart';

class DetailAnswerDiseaseStore = DetailAnswerDiseaseBase
    with _$DetailAnswerDiseaseStore;

enum DetailState { error, success, loading }

enum LoadMoreState { error, success, loading }

enum DetailQuestionState { error, success }

abstract class DetailAnswerDiseaseBase with Store {
  @observable
  CategoryDiseaseModel categoryDiseaseModel = CategoryDiseaseModel();
  @observable
  TopicDiseaseModel topicDiseaseModel = TopicDiseaseModel();
  @observable
  ObservableList<Items> items = ObservableList<Items>();
  @observable
  DetailState state = DetailState.loading;
  @observable
  DetailQuestionState questionState = DetailQuestionState.success;
  @observable
  LoadMoreState loadMoreState = LoadMoreState.loading;
  @observable
  int lengthLoadMore = 0;
  @observable
  int page = 0;
  String contentQuestion = '';
  @observable
  bool isActiveButton = false;

  @action
  void onChangedQuestion(String value) {
    contentQuestion = value.trim();
  }

  @action
  Future<void> createQuestion() async {
    isActiveButton = contentQuestion.isNotEmpty;
    if (isActiveButton) {
      try {
        await ApiBaseHelper().post(
            ApiUrl.apiSocialQuestion,
            jsonEncode(QuestionModel(
                    topicId: categoryDiseaseModel.id, question: contentQuestion)
                .toJson()));
        questionState = DetailQuestionState.success;
      } catch (e) {
        questionState = DetailQuestionState.error;
      }
    }
    onRefresh();
  }

  @action
  Future<void> initState(CategoryDiseaseModel categoryDiseaseModel) async {
    this.categoryDiseaseModel = categoryDiseaseModel;
    state = DetailState.loading;
    final data = await ApiBaseHelper().get(ApiUrl.apiSocialQuestion,
        {'topicId': categoryDiseaseModel.id, "pageIndex": 0});
    topicDiseaseModel = TopicDiseaseModel.fromJson(data);
    lengthLoadMore = (topicDiseaseModel.items ?? []).length;
    if (lengthLoadMore == 0) {
      items = ObservableList<Items>();
    } else {
      for (int index = 0;
          index < (topicDiseaseModel.items ?? []).length;
          index++) {
        items.add((topicDiseaseModel.items ?? [])[index]);
      }
    }
    state = DetailState.success;
  }

  @action
  Future<void> onRefresh() async {
    items.clear();
    page = 0;
    state = DetailState.loading;
    final data = await ApiBaseHelper().get(ApiUrl.apiSocialQuestion,
        {'topicId': categoryDiseaseModel.id, "pageIndex": 0});
    topicDiseaseModel = TopicDiseaseModel.fromJson(data);
    lengthLoadMore = (topicDiseaseModel.items ?? []).length;
    if (lengthLoadMore == 0) {
      items = ObservableList<Items>();
    } else {
      for (int index = 0;
          index < (topicDiseaseModel.items ?? []).length;
          index++) {
        items.add((topicDiseaseModel.items ?? [])[index]);
      }
    }
    state = DetailState.success;
  }

  @action
  Future<void> loadMore() async {
    try {
      page++;
      loadMoreState = LoadMoreState.loading;
      final data = await ApiBaseHelper().get(ApiUrl.apiSocialQuestion,
          {'topicId': categoryDiseaseModel.id, "pageIndex": page});
      loadMoreState = LoadMoreState.success;
      topicDiseaseModel = TopicDiseaseModel.fromJson(data);
      lengthLoadMore += ((topicDiseaseModel.items ?? []).length);
      if (lengthLoadMore == 0) {
        items = ObservableList<Items>();
      } else {
        for (int index = 0;
            index < (topicDiseaseModel.items ?? []).length;
            index++) {
          items.add((topicDiseaseModel.items ?? [])[index]);
        }
      }
    } catch (e) {
      loadMoreState = LoadMoreState.error;
    }
    loadMoreState = LoadMoreState.success;
  }

  @action
  void dispose() {
    page = 0;
    categoryDiseaseModel = CategoryDiseaseModel();
    topicDiseaseModel = TopicDiseaseModel();
    items = ObservableList<Items>();
    lengthLoadMore = 0;
  }
}
