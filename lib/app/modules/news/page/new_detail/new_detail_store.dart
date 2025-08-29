import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:pstb/app/models/news_detail_model.dart';
import 'package:mobx/mobx.dart';
import 'package:pstb/app/modules/home/home_store.dart';
import 'package:pstb/services/api_base_helper.dart';
import 'package:pstb/utils/main.dart';
import 'package:pstb/widgets/stateless/stateless_widget.dart';

part 'new_detail_store.g.dart';

class NewsDetailStore = NewsDetailStoreBase with _$NewsDetailStore;

abstract class NewsDetailStoreBase with Store {
  final ApiBaseHelper _apiBaseHelper = ApiBaseHelper();
  final ScrollController scrollController = ScrollController();
  final HomeStore _homeStore = Modular.get<HomeStore>();

  late BuildContext mContext;
  @observable
  bool scrollIsReached = false;
  @observable
  bool isBookmarked = false;
  @observable
  bool loading = true;
  @observable
  bool successNew = false;
  @observable
  NewsDetailModel news = NewsDetailModel();

  @action
  Future<void> getNewsDetail({required dynamic id}) async {
    loading = true;
    successNew = false;
    EasyLoading.show();
    try {
      final response = await _apiBaseHelper.get("${ApiUrl.news}$id");
      news = NewsDetailModel.fromJson(response);
      if (news.id == '17') news.image = ImageEnum.viemRuotThua;
      if (news.id == '18') news.image = ImageEnum.phuChan;
      loading = false;
      successNew = true;
    } catch (e) {
      print(e);
    }
    EasyLoading.dismiss();
  }

  @action
  void scrollListener() {
    if (scrollController.offset >= heightConvert(mContext, 200) &&
        !scrollIsReached) {
      scrollIsReached = true;
    }
    if (scrollController.offset < heightConvert(mContext, 200) &&
        scrollIsReached) {
      scrollIsReached = false;
    }
  }

  @action
  void addListener(BuildContext newContext) {
    createBuildContext(newContext);
    scrollController.addListener(scrollListener);
  }

  @action
  void createBuildContext(BuildContext newContext) {
    mContext = newContext;
  }

  @action
  void scrollToTop() {
    scrollController.animateTo(
      0.0,
      duration: const Duration(milliseconds: 500),
      curve: Curves.ease,
    );
  }

  // @observable
  // Tags.TagsResponsitory tags = Tags.TagsResponsitory();

  // @computed
  // List<Tags.Result>? get tagData {
  //   return tags.results;
  // }

  // @observable
  // bool loadingTags = true;

  // @action
  // Future<void> getTags() async {
  //   loadingTags = true;
  //   EasyLoading.show();
  //   final response = await _apiBaseHelper.get(ApiUrl.tags);
  //   loadingTags = false;
  //   EasyLoading.dismiss();
  //   tags = Tags.TagsResponsitory.fromJson(response);
  // }

  @action
  void initialScreen({
    required dynamic newId,
    required BuildContext screenContext,
  }) {
    _homeStore.getBookmarks();
    // if (_homeStore.listBookmark
    //         .indexWhere((element) => element.newsId == newId) >=
    //     0) {
    //   isBookmarked = true;
    // }
    addListener(screenContext);
    getNewsDetail(id: newId);
    // getTags();
  }

  @action
  Future<void> updateBookmarks(int id) async {
    EasyLoading.show();
    try {
      await _apiBaseHelper.post(
          ApiUrl.bookmarksUser, jsonEncode({'news_id': id}));
      // _homeStore.getBookmarks();
      isBookmarked = true;
    } catch (e) {
      AppSnackBar.show(mContext, AppSnackBarType.Error,
          l10n(mContext)!.update_profile_false!);
    } finally {
      EasyLoading.dismiss();
    }
  }
}
