// signed_models.dart
class SignedDocData {
  final String? message;
  final List<String> ids;
  SignedDocData({this.message, List<String>? ids}) : ids = ids ?? const [];

  factory SignedDocData.fromJson(Map<String, dynamic> json) => SignedDocData(
        message: json['message'] as String?,
        ids: (json['ids'] as List?)?.map((e) => e.toString()).toList() ??
            const [],
      );

  Map<String, dynamic> toJson() => {
        'message': message,
        'ids': ids,
      };
}

// Giữ tên cũ để không phải đổi nhiều nơi
class SignedDoucmentModel {
  final bool ok; // lấy từ `status`
  final String? message; // lấy từ `data.message` (nếu có)
  final List<String> ids; // lấy từ `data.ids` (nếu có)

  SignedDoucmentModel({
    required this.ok,
    this.message,
    List<String>? ids,
  }) : ids = ids ?? const [];
}
