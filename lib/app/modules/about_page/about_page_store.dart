import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:pstb/app/models/news_detail_model.dart';
import 'package:pstb/app/modules/home/home_store.dart';
import 'package:pstb/utils/helpers/config_helper.dart';
import 'package:mobx/mobx.dart';
import 'package:pstb/services/api_base_helper.dart';

part 'about_page_store.g.dart';

enum StatusWidget {
  webView,
  htmlView,
}

class AboutPageStore = AboutPageStoreBase with _$AboutPageStore;

abstract class AboutPageStoreBase with Store {
  final ApiBaseHelper _apiBaseHelper = Modular.get<ApiBaseHelper>();
  final HomeStore homeStore = Modular.get<HomeStore>();
  @observable
  bool isLoading = true;
  @observable
  NewsDetailModel news = NewsDetailModel();
  @observable
  String url = '';
  @observable
  StatusWidget statusWidget = StatusWidget.htmlView;
  @action
  Future<void> getNewsDetail() async {
    EasyLoading.show();
    isLoading = true;
    final config =
        await ConfigHelper.instance.getConfigByCode(ConfigHelper.about);
    try {
      if ((config?.value ?? '').contains('https://')) {
        url = config?.value ?? '';
        statusWidget = StatusWidget.webView;
      } else {
        final response =
            await _apiBaseHelper.get("api${homeStore.uriAboutPage}");
        statusWidget = StatusWidget.htmlView;
        news = NewsDetailModel.fromJson(response);
      }
      isLoading = false;
    } catch (e) {
      throw Exception(e);
    } finally {
      EasyLoading.dismiss();
    }
  }
}
