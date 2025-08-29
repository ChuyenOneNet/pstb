// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'news_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$NewsStore on NewsStoreBase, Store {
  Computed<List<NewsPagingItem>>? _$newsListWillShowComputed;

  @override
  List<NewsPagingItem> get newsListWillShow => (_$newsListWillShowComputed ??=
          Computed<List<NewsPagingItem>>(() => super.newsListWillShow,
              name: 'NewsStoreBase.newsListWillShow'))
      .value;
  Computed<List<Tags.TagItemModel>?>? _$tagDataComputed;

  @override
  List<Tags.TagItemModel>? get tagData => (_$tagDataComputed ??=
          Computed<List<Tags.TagItemModel>?>(() => super.tagData,
              name: 'NewsStoreBase.tagData'))
      .value;

  late final _$isLoadingAtom =
      Atom(name: 'NewsStoreBase.isLoading', context: context);

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  late final _$listCategoryAtom =
      Atom(name: 'NewsStoreBase.listCategory', context: context);

  @override
  List<String> get listCategory {
    _$listCategoryAtom.reportRead();
    return super.listCategory;
  }

  @override
  set listCategory(List<String> value) {
    _$listCategoryAtom.reportWrite(value, super.listCategory, () {
      super.listCategory = value;
    });
  }

  late final _$newsListAtom =
      Atom(name: 'NewsStoreBase.newsList', context: context);

  @override
  List<NewsPagingItem> get newsList {
    _$newsListAtom.reportRead();
    return super.newsList;
  }

  @override
  set newsList(List<NewsPagingItem> value) {
    _$newsListAtom.reportWrite(value, super.newsList, () {
      super.newsList = value;
    });
  }

  late final _$newsListWithTagAtom =
      Atom(name: 'NewsStoreBase.newsListWithTag', context: context);

  @override
  List<NewsPagingItem> get newsListWithTag {
    _$newsListWithTagAtom.reportRead();
    return super.newsListWithTag;
  }

  @override
  set newsListWithTag(List<NewsPagingItem> value) {
    _$newsListWithTagAtom.reportWrite(value, super.newsListWithTag, () {
      super.newsListWithTag = value;
    });
  }

  late final _$newsListWithTagHealthAtom =
      Atom(name: 'NewsStoreBase.newsListWithTagHealth', context: context);

  @override
  List<NewsPagingItem> get newsListWithTagHealth {
    _$newsListWithTagHealthAtom.reportRead();
    return super.newsListWithTagHealth;
  }

  @override
  set newsListWithTagHealth(List<NewsPagingItem> value) {
    _$newsListWithTagHealthAtom.reportWrite(value, super.newsListWithTagHealth,
        () {
      super.newsListWithTagHealth = value;
    });
  }

  late final _$newsListWithTagCovidAtom =
      Atom(name: 'NewsStoreBase.newsListWithTagCovid', context: context);

  @override
  List<NewsPagingItem> get newsListWithTagCovid {
    _$newsListWithTagCovidAtom.reportRead();
    return super.newsListWithTagCovid;
  }

  @override
  set newsListWithTagCovid(List<NewsPagingItem> value) {
    _$newsListWithTagCovidAtom.reportWrite(value, super.newsListWithTagCovid,
        () {
      super.newsListWithTagCovid = value;
    });
  }

  late final _$newsListSearchAtom =
      Atom(name: 'NewsStoreBase.newsListSearch', context: context);

  @override
  List<NewsPagingItem> get newsListSearch {
    _$newsListSearchAtom.reportRead();
    return super.newsListSearch;
  }

  @override
  set newsListSearch(List<NewsPagingItem> value) {
    _$newsListSearchAtom.reportWrite(value, super.newsListSearch, () {
      super.newsListSearch = value;
    });
  }

  late final _$searchTextAtom =
      Atom(name: 'NewsStoreBase.searchText', context: context);

  @override
  String get searchText {
    _$searchTextAtom.reportRead();
    return super.searchText;
  }

  @override
  set searchText(String value) {
    _$searchTextAtom.reportWrite(value, super.searchText, () {
      super.searchText = value;
    });
  }

  late final _$idNewAtom = Atom(name: 'NewsStoreBase.idNew', context: context);

  @override
  String get idNew {
    _$idNewAtom.reportRead();
    return super.idNew;
  }

  @override
  set idNew(String value) {
    _$idNewAtom.reportWrite(value, super.idNew, () {
      super.idNew = value;
    });
  }

  late final _$keywordSearchAtom =
      Atom(name: 'NewsStoreBase.keywordSearch', context: context);

  @override
  List<String> get keywordSearch {
    _$keywordSearchAtom.reportRead();
    return super.keywordSearch;
  }

  @override
  set keywordSearch(List<String> value) {
    _$keywordSearchAtom.reportWrite(value, super.keywordSearch, () {
      super.keywordSearch = value;
    });
  }

  late final _$keywordAtom =
      Atom(name: 'NewsStoreBase.keyword', context: context);

  @override
  String get keyword {
    _$keywordAtom.reportRead();
    return super.keyword;
  }

  @override
  set keyword(String value) {
    _$keywordAtom.reportWrite(value, super.keyword, () {
      super.keyword = value;
    });
  }

  late final _$loadingNewAtom =
      Atom(name: 'NewsStoreBase.loadingNew', context: context);

  @override
  bool get loadingNew {
    _$loadingNewAtom.reportRead();
    return super.loadingNew;
  }

  @override
  set loadingNew(bool value) {
    _$loadingNewAtom.reportWrite(value, super.loadingNew, () {
      super.loadingNew = value;
    });
  }

  late final _$loadingMoreAtom =
      Atom(name: 'NewsStoreBase.loadingMore', context: context);

  @override
  bool get loadingMore {
    _$loadingMoreAtom.reportRead();
    return super.loadingMore;
  }

  @override
  set loadingMore(bool value) {
    _$loadingMoreAtom.reportWrite(value, super.loadingMore, () {
      super.loadingMore = value;
    });
  }

  late final _$currentPageAtom =
      Atom(name: 'NewsStoreBase.currentPage', context: context);

  @override
  int get currentPage {
    _$currentPageAtom.reportRead();
    return super.currentPage;
  }

  @override
  set currentPage(int value) {
    _$currentPageAtom.reportWrite(value, super.currentPage, () {
      super.currentPage = value;
    });
  }

  late final _$importantNewAtom =
      Atom(name: 'NewsStoreBase.importantNew', context: context);

  @override
  NewsPagingItem get importantNew {
    _$importantNewAtom.reportRead();
    return super.importantNew;
  }

  @override
  set importantNew(NewsPagingItem value) {
    _$importantNewAtom.reportWrite(value, super.importantNew, () {
      super.importantNew = value;
    });
  }

  late final _$newestListAtom =
      Atom(name: 'NewsStoreBase.newestList', context: context);

  @override
  ObservableList<NewsPagingItem> get newestList {
    _$newestListAtom.reportRead();
    return super.newestList;
  }

  @override
  set newestList(ObservableList<NewsPagingItem> value) {
    _$newestListAtom.reportWrite(value, super.newestList, () {
      super.newestList = value;
    });
  }

  late final _$tagsAtom = Atom(name: 'NewsStoreBase.tags', context: context);

  @override
  Paging<Tags.TagItemModel> get tags {
    _$tagsAtom.reportRead();
    return super.tags;
  }

  @override
  set tags(Paging<Tags.TagItemModel> value) {
    _$tagsAtom.reportWrite(value, super.tags, () {
      super.tags = value;
    });
  }

  late final _$loadingTagsAtom =
      Atom(name: 'NewsStoreBase.loadingTags', context: context);

  @override
  bool get loadingTags {
    _$loadingTagsAtom.reportRead();
    return super.loadingTags;
  }

  @override
  set loadingTags(bool value) {
    _$loadingTagsAtom.reportWrite(value, super.loadingTags, () {
      super.loadingTags = value;
    });
  }

  late final _$selectedTagsAtom =
      Atom(name: 'NewsStoreBase.selectedTags', context: context);

  @override
  String get selectedTags {
    _$selectedTagsAtom.reportRead();
    return super.selectedTags;
  }

  @override
  set selectedTags(String value) {
    _$selectedTagsAtom.reportWrite(value, super.selectedTags, () {
      super.selectedTags = value;
    });
  }

  late final _$getSearchNewAsyncAction =
      AsyncAction('NewsStoreBase.getSearchNew', context: context);

  @override
  Future<void> getSearchNew(String value) {
    return _$getSearchNewAsyncAction.run(() => super.getSearchNew(value));
  }

  late final _$loadMoreItemAsyncAction =
      AsyncAction('NewsStoreBase.loadMoreItem', context: context);

  @override
  Future<void> loadMoreItem() {
    return _$loadMoreItemAsyncAction.run(() => super.loadMoreItem());
  }

  late final _$getNewsAsyncAction =
      AsyncAction('NewsStoreBase.getNews', context: context);

  @override
  Future<void> getNews({required int page}) {
    return _$getNewsAsyncAction.run(() => super.getNews(page: page));
  }

  late final _$onRefreshAsyncAction =
      AsyncAction('NewsStoreBase.onRefresh', context: context);

  @override
  Future<void> onRefresh() {
    return _$onRefreshAsyncAction.run(() => super.onRefresh());
  }

  late final _$onScrollAsyncAction =
      AsyncAction('NewsStoreBase.onScroll', context: context);

  @override
  Future<void> onScroll(ScrollController scrollController) {
    return _$onScrollAsyncAction.run(() => super.onScroll(scrollController));
  }

  late final _$getTagsAsyncAction =
      AsyncAction('NewsStoreBase.getTags', context: context);

  @override
  Future<void> getTags() {
    return _$getTagsAsyncAction.run(() => super.getTags());
  }

  late final _$getNewsWithTagAsyncAction =
      AsyncAction('NewsStoreBase.getNewsWithTag', context: context);

  @override
  Future<void> getNewsWithTag(String tags) {
    return _$getNewsWithTagAsyncAction.run(() => super.getNewsWithTag(tags));
  }

  late final _$getNewsWithTagHealthAsyncAction =
      AsyncAction('NewsStoreBase.getNewsWithTagHealth', context: context);

  @override
  Future<void> getNewsWithTagHealth(String tags) {
    return _$getNewsWithTagHealthAsyncAction
        .run(() => super.getNewsWithTagHealth(tags));
  }

  late final _$getNewsWithTagCovidAsyncAction =
      AsyncAction('NewsStoreBase.getNewsWithTagCovid', context: context);

  @override
  Future<void> getNewsWithTagCovid(String tags) {
    return _$getNewsWithTagCovidAsyncAction
        .run(() => super.getNewsWithTagCovid(tags));
  }

  late final _$NewsStoreBaseActionController =
      ActionController(name: 'NewsStoreBase', context: context);

  @override
  dynamic onChangeSearchText(String value) {
    final _$actionInfo = _$NewsStoreBaseActionController.startAction(
        name: 'NewsStoreBase.onChangeSearchText');
    try {
      return super.onChangeSearchText(value);
    } finally {
      _$NewsStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic createNewestNew(List<NewsPagingItem> newsResponse) {
    final _$actionInfo = _$NewsStoreBaseActionController.startAction(
        name: 'NewsStoreBase.createNewestNew');
    try {
      return super.createNewestNew(newsResponse);
    } finally {
      _$NewsStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic clearList() {
    final _$actionInfo = _$NewsStoreBaseActionController.startAction(
        name: 'NewsStoreBase.clearList');
    try {
      return super.clearList();
    } finally {
      _$NewsStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic showLoading() {
    final _$actionInfo = _$NewsStoreBaseActionController.startAction(
        name: 'NewsStoreBase.showLoading');
    try {
      return super.showLoading();
    } finally {
      _$NewsStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic hiddenLoading() {
    final _$actionInfo = _$NewsStoreBaseActionController.startAction(
        name: 'NewsStoreBase.hiddenLoading');
    try {
      return super.hiddenLoading();
    } finally {
      _$NewsStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setSelectedTags({required String tagName}) {
    final _$actionInfo = _$NewsStoreBaseActionController.startAction(
        name: 'NewsStoreBase.setSelectedTags');
    try {
      return super.setSelectedTags(tagName: tagName);
    } finally {
      _$NewsStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isLoading: ${isLoading},
listCategory: ${listCategory},
newsList: ${newsList},
newsListWithTag: ${newsListWithTag},
newsListWithTagHealth: ${newsListWithTagHealth},
newsListWithTagCovid: ${newsListWithTagCovid},
newsListSearch: ${newsListSearch},
searchText: ${searchText},
idNew: ${idNew},
keywordSearch: ${keywordSearch},
keyword: ${keyword},
loadingNew: ${loadingNew},
loadingMore: ${loadingMore},
currentPage: ${currentPage},
importantNew: ${importantNew},
newestList: ${newestList},
tags: ${tags},
loadingTags: ${loadingTags},
selectedTags: ${selectedTags},
newsListWillShow: ${newsListWillShow},
tagData: ${tagData}
    ''';
  }
}
