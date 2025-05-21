class FeedbackModel {
  String userName;
  String imageUrl;
  String content;
  DateTime date;


  FeedbackModel({required this.userName,
    required this.imageUrl,
    required this.content,
    required this.date
    });

  Map<String, dynamic> toJson() {
    return {
       "dateTime":date,
      "name": userName,
      "content": content,
      "imageUrl":imageUrl
    };
  }
  factory FeedbackModel.fromJson(Map<String, dynamic> json) {
    return FeedbackModel(
      date: DateTime.parse(json['dateTime']),
        userName: json["name"],
        imageUrl: json['imageUrl'],
        content: json["content"],
    );
  }
}