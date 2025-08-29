import 'package:diacritic/diacritic.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:pstb/app/models/tag_item_model.dart';
import 'package:mobx/mobx.dart';
import 'package:pstb/app/models/new_model.dart';
import 'package:pstb/app/models/news_paging_model.dart';
import 'package:pstb/app/models/tag_item_model.dart' as Tags;
import 'package:pstb/services/api_base_helper.dart';
import 'package:pstb/utils/main.dart';
import '../../../../models/paging_model.dart';

part 'news_store.g.dart';

class NewsStore = NewsStoreBase with _$NewsStore;

abstract class NewsStoreBase with Store {
  final ApiBaseHelper _apiBaseHelper = Modular.get<ApiBaseHelper>();
  int limit = Constants.pageSize;

  @observable
  bool isLoading = false;

  @observable
  List<String> listCategory = [];

  @observable
  List<NewsPagingItem> newsList = ObservableList<NewsPagingItem>.of([]);

  @observable
  List<NewsPagingItem> newsListWithTag = ObservableList<NewsPagingItem>.of([]);

  @observable
  List<NewsPagingItem> newsListWithTagHealth =
      ObservableList<NewsPagingItem>.of([]);

  @observable
  List<NewsPagingItem> newsListWithTagCovid =
      ObservableList<NewsPagingItem>.of([]);

  @observable
  List<NewsPagingItem> newsListSearch = ObservableList<NewsPagingItem>.of([]);

  @observable
  String searchText = '';

  @observable
  String idNew = '';

  @observable
  List<String> keywordSearch = [];

  @observable
  String keyword = "";

  @action
  onChangeSearchText(String value) {
    searchText = value;
  }

  @action
  Future<void> getSearchNew(String value) async {
    value = value.trim();
    isLoading = true;
    EasyLoading.show();
    newsListSearch.clear();
    keywordSearch.add(value);
    keywordSearch = keywordSearch.toSet().toList();
    try {
      final response =
          await _apiBaseHelper.get(ApiUrl.news, {"Keywords": value});
      final newsPaging = Paging<NewsPagingItem>.fromJson(
          response, (x) => NewsPagingItem.fromJson(x)).items;
      newsListSearch.addAll(newsPaging!);
    } catch (e) {
      isLoading = false;
      EasyLoading.dismiss();
    }
    isLoading = false;
    EasyLoading.dismiss();
  }

  @computed
  List<NewsPagingItem> get newsListWillShow {
    if (isNotEmptyNullString(searchText)) {
      List<NewsPagingItem> resultSearch = [];
      String valueDiacritics = removeDiacritics(searchText).toUpperCase();
      for (var element in newsList) {
        if (removeDiacritics(element.title ?? '')
            .toUpperCase()
            .contains(valueDiacritics)) {
          resultSearch.add(element);
        }
      }
      return resultSearch;
    } else {
      return newsList;
    }
  }

  @observable
  bool loadingNew = true;

  @observable
  bool loadingMore = false;

  @observable
  int currentPage = 0;

  bool canLoadMore = true;

  @observable
  NewsPagingItem importantNew = NewsPagingItem();

  @observable
  var newestList = ObservableList<NewsPagingItem>.of([]);

  @action
  createNewestNew(List<NewsPagingItem> newsResponse) {
    newestList = ObservableList<NewsPagingItem>.of([]);
    for (var i = 0; i < newsResponse.length; i++) {
      final newItem = newsResponse[i];
      if (i == 0) {
        importantNew = newItem;
      }
      if (i > 0 && i < 4) {
        newestList.add(newItem);
      }
    }
  }

  @action
  Future<void> loadMoreItem() async {
    final newPage = currentPage + 1;
    loadingMore = true;
    await getNews(page: newPage);
    loadingMore = false;
  }

  @action
  Future<void> getNews({required int page}) async {
    currentPage = page;
    final response = await _apiBaseHelper.get(
      ApiUrl.news,
      NewModel(
        pageSize: limit,
        pageIndex: currentPage,
        tags: selectedTags.toString(),
      ).toJson(),
    );
    final newsPaging = Paging<NewsPagingItem>.fromJson(
        response, (x) => NewsPagingItem.fromJson(x));
    if (page == 0) {
      loadingMore = false;
      newsList = ObservableList<NewsPagingItem>.of([]);
      createNewestNew(newsPaging.items!);
    }
    if (newsPaging.isEnded()) {
      canLoadMore = false;
    }
    newsPaging.items?.forEach((element) {
      //if (element.id != '4' && element.id != '7' && element.id != '15')
      newsList.add(element);
    });
  }

  @action
  Future<void> onRefresh() async {
    loadingNew = true;
    newsList = ObservableList<NewsPagingItem>.of([]);
    currentPage = 0;
    canLoadMore = true;
    loadingMore = false;
    await getNews(page: currentPage);
    await getTags();
    await getNewsWithTagHealth('1');
    await getNewsWithTagCovid('2');
    loadingNew = false;
  }

  @action
  Future<void> onScroll(ScrollController scrollController) async {
    if (!scrollController.hasClients || loadingMore || !canLoadMore) return;

    if (scrollController.position.extentAfter < double.parse("100")) {
      await loadMoreItem();
    }
  }

  @observable
  Paging<TagItemModel> tags = Paging<TagItemModel>();

  @computed
  List<Tags.TagItemModel>? get tagData {
    return tags.items;
  }

  @observable
  bool loadingTags = true;

  @action
  Future<void> getTags() async {
    loadingTags = true;
    try {
      final response = await _apiBaseHelper.get(ApiUrl.tags);
      tags = Paging<TagItemModel>.fromJson(
          response, (e) => TagItemModel.fromJson(e));
      loadingTags = false;
    } catch (e) {
      loadingTags = false;
    }
  }

  @action
  clearList() {
    newsListWithTag.clear();
  }

  @action
  showLoading() {
    loadingTags = true;
    EasyLoading.show();
  }

  @action
  hiddenLoading() {
    loadingTags = false;
    EasyLoading.dismiss();
  }

  @action
  Future<void> getNewsWithTag(String tags) async {
    EasyLoading.show();
    loadingTags = true;
    newsListWithTag.clear();
    try {
      final response = await _apiBaseHelper.get(ApiUrl.news, {"Tags": tags});
      final newsPaging = Paging<NewsPagingItem>.fromJson(
          response, (x) => NewsPagingItem.fromJson(x)).items;
      newsListWithTag.addAll(newsPaging!);
      loadingTags = false;
    } catch (e) {
      EasyLoading.dismiss();
      loadingTags = false;
    }
    EasyLoading.dismiss();
    loadingTags = false;
  }

  @action
  Future<void> getNewsWithTagHealth(String tags) async {
    EasyLoading.show();
    loadingTags = true;
    newsListWithTagHealth.clear();
    try {
      final response = await _apiBaseHelper.get(ApiUrl.news, {"Tags": tags});
      final newsPaging = Paging<NewsPagingItem>.fromJson(
          response, (x) => NewsPagingItem.fromJson(x)).items;
      newsListWithTagHealth.addAll(newsPaging!);
      loadingTags = false;
    } catch (e) {
      EasyLoading.dismiss();
      loadingTags = false;
    }
    EasyLoading.dismiss();
    loadingTags = false;
  }

  @action
  Future<void> getNewsWithTagCovid(String tags) async {
    EasyLoading.show();
    loadingTags = true;
    newsListWithTagCovid.clear();
    try {
      final response = await _apiBaseHelper.get(ApiUrl.news, {"Tags": tags});
      final newsPaging = Paging<NewsPagingItem>.fromJson(
          response, (x) => NewsPagingItem.fromJson(x)).items;
      newsListWithTagCovid.addAll(newsPaging!);
      loadingTags = false;
    } catch (e) {
      EasyLoading.dismiss();
      loadingTags = false;
    }
    EasyLoading.dismiss();
    loadingTags = false;
  }

  @observable
  String selectedTags = "";

  @action
  void setSelectedTags({required String tagName}) {
    selectedTags = tagName;
    onRefresh();
  }
}
