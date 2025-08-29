import 'package:mobx/mobx.dart';

class ResponseNotification {
  final int pageIndex;
  final int pageSize;
  final int total;
  final List<NotificationItemModel> items;

  ResponseNotification(
      {required this.pageIndex,
        required this.pageSize,
        required this.total,
        required this.items});

  factory ResponseNotification.fromJson(Map<String, dynamic> json) =>
      ResponseNotification(
          pageIndex: json["pageIndex"],
          pageSize: json["pageSize"],
          total: json['total'],
          items: (json['items'] as List<dynamic>)
              .map((e) =>
              NotificationItemModel.fromJson(e as Map<String, dynamic>))
              .toList());
}

class NotificationItemModel {
  final int? id;
  final String? typeName;
  final String? typeCode;
  final String? content;
  final String? title;
  final String? created;
  final String? metaData;
  String? urlPdfFile;

  @action
  bool status = false;

  @action
  void mark(){
    status = true;
  }

  NotificationItemModel(
      {required this.id,
        this.typeName,
        this.typeCode,
        this.content,
        this.title,
        this.urlPdfFile,
        this.created,
        this.metaData,
      });

  factory NotificationItemModel.fromJson(Map<String, dynamic> json) =>
      NotificationItemModel(
        id: json['id'],
        typeName: json['typeName'],
        typeCode: json['typeCode'],
        content: json["content"],
        title: json["title"],
        created: json['created'],
        metaData: json['metaData'],);
}
