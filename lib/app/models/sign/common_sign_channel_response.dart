class CommonSignChannelResponse{
  final bool isSuccess;
  final String? message;

  CommonSignChannelResponse({this.isSuccess = false, this.message});


  factory CommonSignChannelResponse.fromJson(Map<String, dynamic> json) =>
      _$CommonSignChannelResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CommonSignChannelResponseToJson(this);
}

CommonSignChannelResponse _$CommonSignChannelResponseFromJson(
    Map<String, dynamic> json) =>
    CommonSignChannelResponse(
      isSuccess: json['isSuccess'] as bool? ?? false,
      message: json['message'] as String?,
    );

Map<String, dynamic> _$CommonSignChannelResponseToJson(
    CommonSignChannelResponse instance) =>
    <String, dynamic>{
      'isSuccess': instance.isSuccess,
      'message': instance.message,
    };
