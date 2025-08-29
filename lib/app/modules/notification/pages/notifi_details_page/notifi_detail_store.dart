import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';
import 'package:mobx/mobx.dart';
import '../../../../models/notification_model.dart';

part 'notifi_detail_store.g.dart';

class NotificationDetailsStore = NotificationDetailsStoreBase
    with _$NotificationDetailsStore;

abstract class NotificationDetailsStoreBase with Store {

  @observable
  String date = "";

  @observable
  String title = "";

  @observable
  String phone = "";

  @observable
  String url = "";

  @observable
  bool isLoadingData = true;

  @computed
  String get getDate => date;

  @computed
  String get getTitle => title;

  @computed
  String get getPhone => phone;

  @computed
  String get getUrl => url;

  @computed
  bool get getLoadingState => isLoadingData;

  ResultMetaData getUrlFromMetaData(String source) {
    ResultMetaData dataMeta = ResultMetaData("", "");
    String str = source
        .replaceAll("{", "")
        .replaceAll("}", "")
        .replaceAll("\n", "")
        .replaceAll("\t", "")
        .replaceAll("\\", "")
        .replaceAll("\"", "")
        .replaceAll('nt', "");
    print(str);
    List<String> data = str.split(',');
    print(data);
    dataMeta.type = data[0].split(":")[1];
    dataMeta.link = data[1].split("link:")[1];

    return dataMeta;
  }

  @action
  Future<void> loadDetails(
      RemoteMessage? message, NotificationItemModel? noti) async {
    EasyLoading.show();
    if (message != null) {
      print(message.data);
      var data = message.data['MetaData'] as String;

      title = message.notification!.body ?? "";
      date = DateFormat('dd-MM-yyyy – kk:mm').format(message.sentTime!);
      url = data
          .replaceAll("{", "")
          .replaceAll("}", "")
          .replaceAll("\"", "")
          .split("link:")[1];
    } else {
      title = noti!.content ?? noti.title ?? "";
      date = noti.created ??
          DateFormat('dd-MM-yyyy – kk:mm').format(DateTime.now());
      url = noti.urlPdfFile ?? "";
    }
    isLoadingData = false;
    EasyLoading.dismiss();
  }
}

class ResultMetaData {
  String type;
  String link;

  ResultMetaData(this.type, this.link);
}
