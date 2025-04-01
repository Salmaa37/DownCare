class ArticleModel {
  String email;
  String content;
  DateTime date;

  ArticleModel({required this.email, required this.content,required this.date});

  Map<String, dynamic> toJson() {
    return {
      "dateTime":date,
      "email": email,
      "content": content,

    };
  }

  factory ArticleModel.fromJson(Map<String, dynamic> json) {
    return ArticleModel(
      date: DateTime.parse(json['dateTime']),
      email: json["email"],
      content: json["content"],
    );
  }
}