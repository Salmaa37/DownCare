class GroupMemberModel {
  final String userName;
  final String userImageURL;

  GroupMemberModel({
    required this.userName,
    required this.userImageURL,
  });

  factory GroupMemberModel.fromJson(Map<String, dynamic> json) {
    return GroupMemberModel(
      userName: json['userName'] ?? '',
      userImageURL: json['userImageURL'] ?? '',
    );
  }
}
