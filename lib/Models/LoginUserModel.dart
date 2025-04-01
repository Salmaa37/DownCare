class LoginUserModel {
  String userName;
  String? bio;
  String? imagePath;
  String email;
  String phone;
  String governorate;
  LoginUserModel({required this.userName,
    this.bio,
    this.imagePath,
    required this.email, required this.phone, required this.governorate});
  factory LoginUserModel.fromJson(Map<String, dynamic> json) {
    return LoginUserModel(
      imagePath: json["imagePath"] as String?,
      bio: json["bio"] as String?,
      userName: json["name"] ,
      email: json["email"] ,
      phone: json["phone"] ,
      governorate: json["governate"] ,
    );
  }
}
