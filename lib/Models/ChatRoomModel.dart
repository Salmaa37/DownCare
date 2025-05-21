class ChatRoomModel {
  final int id;
  final String name;
  final String imageUrl;
  final String recipientUserId;

  ChatRoomModel({required this.id,
    required this.name,
    required this.imageUrl,
    required this.recipientUserId});

  factory ChatRoomModel.fromJson(Map<String, dynamic> json) {
    return ChatRoomModel(
      recipientUserId: json['recipientUserId'],
      id: json['id'],
      name: json['name'],
      imageUrl: json['imageUrl'],
    );
  }
}