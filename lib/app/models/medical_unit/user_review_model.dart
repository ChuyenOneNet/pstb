import 'package:intl/intl.dart';

import '../../../utils/constants.dart';

class UserReviewModel {
  String? userName;
  int? rate;
  String? review;
  String? fullName;
  DateTime? reviewedTime;

  UserReviewModel({this.userName, this.rate, this.review, this.fullName, this.reviewedTime});

  UserReviewModel.fromJson(Map<String, dynamic> json) {
    userName = json['userName'];
    rate = json['rate'];
    review = json['review'];
    fullName = json['fullName'];
    reviewedTime = json['reviewedTime'] != null
        ? DateFormat(DateTimeFormatPattern.backendTimeFormat)
        .parse(json['reviewedTime'])
        : null;
  }

}

class PostModel {
  String? review;
  int? rate;

  PostModel({this.review, this.rate});

  PostModel.fromJson(Map<String, dynamic> json) {
    review = json['review'];
    rate = json['rate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['review'] = review;
    data['rate'] = rate;
    return data;
  }
}

class UpdateModel {
  int? rate;
  String? review;

  UpdateModel({this.rate, this.review});

  UpdateModel.fromJson(Map<String, dynamic> json) {
    rate = json['rate'];
    review = json['review'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['rate'] = rate;
    data['review'] = review;
    return data;
  }
}