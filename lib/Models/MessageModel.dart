class MessageModel {
  final int messageId;
  final String message;
  final String dateTime;
  final String displayTime;
  final String userName;
  final String userImageURL;
  MessageModel({
    required this.messageId,
    required this.message,
    required this.dateTime,
    required this.displayTime,
    required this.userName,
    required this.userImageURL,
  });
  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      messageId: json["messageId"] is int
          ? json["messageId"]
          : int.tryParse(json["messageId"]?.toString() ?? '0') ?? 0,
      message: json['message']?.toString() ?? '',
      dateTime: json['dateTime']?.toString() ?? DateTime.now().toString(),
      displayTime: json['displayTime']?.toString() ?? '',
      userName: json['userName']?.toString() ?? 'مستخدم',
      userImageURL: json['userImage']?.toString() ?? json['userImageURL']?.toString() ?? '',
    );
  }
  @override
  String toString() {
    return 'MessageModel{messageId: $messageId, message: $message, user: $userName, image: $userImageURL}';
  }
}