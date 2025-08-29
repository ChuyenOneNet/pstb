import 'package:intl/intl.dart';

import '../../utils/constants.dart';

class TopicDiseaseModel {
  int? pageIndex;
  int? pageSize;
  int? total;
  List<Items>? items;

  TopicDiseaseModel({this.pageIndex, this.pageSize, this.total, this.items});

  factory TopicDiseaseModel.fromJson(Map<String, dynamic> json) {
    return TopicDiseaseModel(
      pageIndex: json['pageIndex'],
      pageSize: json['pageSize'],
      total: json['total'],
      items: List<Items>.from(json['items'].map((e) => Items.fromJson(e))),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['pageIndex'] = pageIndex;
    data['pageSize'] = pageSize;
    data['total'] = total;
    if (items != null) {
      data['items'] = items!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Items {
  String? requesterName;
  String? requesterImage;
  String? question;
  String? replierName;
  String? replierImage;
  String? answer;
  String? topicName;
  DateTime? createdTime;
  String? questionTitle;

  Items({
    this.requesterName,
    this.requesterImage,
    this.question,
    this.replierName,
    this.replierImage,
    this.answer,
    this.topicName,
    this.createdTime,
    this.questionTitle,
  });

  factory Items.fromJson(Map<String, dynamic> json) {
    return Items(
      requesterName: json['requesterName'],
      requesterImage: json['requesterImage'],
      question: json['question'],
      replierName: json['replierName'],
      replierImage: json['replierImage'],
      answer: json['answer'],
      topicName: json['topicName'],
      createdTime: json['createdTime'] != null
          ? DateFormat(DateTimeFormatPattern.backendTimeFormat)
              .parse(json['createdTime'])
          : null,
      questionTitle: json['questionTitle'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['requesterName'] = requesterName;
    data['requesterImage'] = requesterImage;
    data['question'] = question;
    data['replierName'] = replierName;
    data['replierImage'] = replierImage;
    data['answer'] = answer;
    return data;
  }
}
