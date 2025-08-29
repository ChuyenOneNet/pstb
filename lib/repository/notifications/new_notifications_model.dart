import 'package:intl/intl.dart';
import 'package:pstb/utils/constants.dart';

class NotificationModel {
  NotificationModel({
    this.id,
    this.type,
    this.documentId,
    this.content,
    this.seen,
    this.created,
  });

  int? id;
  String? type;
  String? documentId;
  String? content;
  bool? seen;
  DateTime? created;

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      NotificationModel(
        id: json["id"],
        type: json["type"],
        documentId: json["documentId"],
        content: json["content"],
        seen: json["seen"],
        created: json["created"] == null
            ? null
            : DateFormat(DateTimeFormatPattern.backendTimeFormat)
                .parse(json["created"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        "documentId": documentId,
        "content": content,
        "seen": seen,
        "created": created == null ? null : created!.toIso8601String(),
      };
}
