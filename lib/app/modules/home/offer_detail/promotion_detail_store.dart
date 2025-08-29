import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:mobx/mobx.dart';
import 'package:pstb/app/models/promotion_news_model.dart';
import 'package:pstb/services/api_base_helper.dart';
import 'package:pstb/utils/main.dart';
part 'promotion_detail_store.g.dart';

class PromotionDetailStore = PromotionDetailStoreBase
    with _$PromotionDetailStore;

abstract class PromotionDetailStoreBase with Store {
  final ApiBaseHelper _apiBaseHelper = ApiBaseHelper();
  @observable
  bool loading = true;

  @observable
  PromotionNewsModel promoteNews = PromotionNewsModel();

  @action
  Future<void> getOfferDetail({required dynamic id}) async {
    loading = true;
    EasyLoading.show();
    try {
      final response = await _apiBaseHelper.get("${ApiUrl.promotion}$id");
      promoteNews = PromotionNewsModel.fromJson(response);
    } catch (e) {
      print(e);
    } finally {
      loading = false;
      EasyLoading.dismiss();
    }
  }

  @action
  void initialScreen({
    required dynamic offerId,
  }) {
    getOfferDetail(id: offerId);
    // getTags();
  }
}
