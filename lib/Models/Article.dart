class ArticleModel {
  String userName;
  String imageUrl;
  String content;
  DateTime date;


  ArticleModel({required this.userName,
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
  factory ArticleModel.fromJson(Map<String, dynamic> json) {
    return ArticleModel(
      date: DateTime.parse(json['dateTime']),
      userName: json["name"],
      imageUrl: json['imageUrl'],
      content: json["content"],
    );
  }
}