class UserModel {
  String email;
  String userName;
  String governorate;
  String role;
  String phone;


  UserModel({required this.userName,
    required this.email,
    required this.governorate,required this.role,required this.phone}
      );


  Map<String, dynamic> toJson() {
    return {
      "userName": userName,
      "email": email,
      "governate": governorate,
      "role":role,
      "phone":phone
    };
  }


  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
       userName: json["userName"],
       email: json["email"],
       governorate: json["governate"],
        role: json["role"],
        phone: json["phone"]

    );
  }
}
