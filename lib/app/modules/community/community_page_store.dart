import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:pstb/utils/sessions/session_prefs.dart';
import 'package:mobx/mobx.dart';

import '../../../services/api_base_helper.dart';
import '../../../utils/api_url.dart';
import '../../../utils/helpers/firebase_config.dart';
import '../../models/category_disease_model.dart';
import '../../models/paging_model.dart';
import '../../models/topic_disease_model.dart';
import '../medical_appointment/pages/medical_package_detail/models/medical_model.dart';

part 'community_page_store.g.dart';

class CommunityPageStore = CommunityPageStoreBase with _$CommunityPageStore;

abstract class CommunityPageStoreBase with Store {
  @observable
  bool isLogin = false;
  @observable
  bool isLoading = true;
  @observable
  ObservableList<Items> listMyQuestion = ObservableList<Items>.of([]);
  @observable
  ObservableList<Items> listSearchQuestion = ObservableList<Items>.of([]);
  @observable
  TopicDiseaseModel topicDiseaseModel = TopicDiseaseModel();
  @observable
  int page = 0;
  @observable
  int pageSearch= 0;
  @observable
  List<String> keywordSearch = [];
  @observable
  String keyword = "";

  @action
  Future<void> checkLogin() async {
    final isSignedIn = await SessionPrefs.isSignedIn();
    if (isSignedIn) {
      isLogin = true;
    } else {
      isLogin = false;
    }
  }

  @action
  Future<void> getListQuestion() async {
    isLoading = true;
    EasyLoading.show();
    listMyQuestion.clear();
    try {
      final data = await ApiBaseHelper().get(
        ApiUrl.apiMyQuestion,
        {
          "pageIndex": 0,
          "pageSize": 10,
        },
      );
      topicDiseaseModel = TopicDiseaseModel.fromJson(data);
      listMyQuestion.addAll(topicDiseaseModel.items!);
    } catch (e) {
      isLoading = false;
      EasyLoading.dismiss();
    }
    isLoading = false;
    EasyLoading.dismiss();
  }

  @action
  Future<void> loadMoreQuestion() async {
    page++;
    isLoading = true;
    try {
      final data = await ApiBaseHelper().get(
        ApiUrl.apiMyQuestion,
        {
          "pageIndex": page,
          "pageSize": 10,
        },
      );
      topicDiseaseModel = TopicDiseaseModel.fromJson(data);
      listMyQuestion.addAll(topicDiseaseModel.items!);
    } catch (e) {
      isLoading = false;
      // EasyLoading.dismiss();
    }
    isLoading = false;
    // EasyLoading.dismiss();
  }

  @action
  Future<void> getSearchQuestion(String value) async {
    value = value.trim();
    isLoading = true;
    EasyLoading.show();
    listSearchQuestion.clear();
    keywordSearch.add(value);
    keywordSearch = keywordSearch.toSet().toList();
    try {
      final data = await ApiBaseHelper().get(
        ApiUrl.apiMyQuestion,
        {
          "pageIndex": 0,
          "pageSize": 10,
          "keyword": value
        },
      );
      topicDiseaseModel = TopicDiseaseModel.fromJson(data);
      listSearchQuestion.addAll(topicDiseaseModel.items!);
      print('${listSearchQuestion.length}');
    } catch (e) {
      isLoading = false;
      EasyLoading.dismiss();
    }
    isLoading = false;
    EasyLoading.dismiss();
  }

  @action
  Future<void> loadMoreSearchQuestion(String value) async {
    pageSearch++;
    isLoading = true;
    try {
      final data = await ApiBaseHelper().get(
        ApiUrl.apiMyQuestion,
        {
          "pageIndex": pageSearch,
          "pageSize": 10,
          "keyword": value
        },
      );
      topicDiseaseModel = TopicDiseaseModel.fromJson(data);
      listSearchQuestion.addAll(topicDiseaseModel.items!);
    } catch (e) {
      isLoading = false;
      // EasyLoading.dismiss();
    }
    isLoading = false;
    // EasyLoading.dismiss();
  }

}
