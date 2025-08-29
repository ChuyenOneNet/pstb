class QuestionModel{
  String? question;
  int? topicId;

  QuestionModel({this.question,this.topicId});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['question'] = question;
    data['topicId'] = topicId;
    print(data.toString());
    return data;
  }
}