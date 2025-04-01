class FeedbackModel {
  String email;
  String content;
  DateTime date;


  FeedbackModel({required this.email, required this.content,
    required this.date
    });

  Map<String, dynamic> toJson() {
    return {
       "dateTime":date,
      "email": email,
      "content": content,
    };
  }
  factory FeedbackModel.fromJson(Map<String, dynamic> json) {
    return FeedbackModel(
      date: DateTime.parse(json['dateTime']),
        email: json["email"],
        content: json["content"],
    );
  }
}