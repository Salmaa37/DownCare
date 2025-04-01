class DocModel {
  String id ;
  String name ;
  String email ;
  String phone;
  String Governorate;
  String bio;
  String image;
  DocModel({
    required this.id,
    required this.name,
    required  this.email,
    required  this.phone,
    required  this.Governorate,
    required this.bio,
    required this.image
    });
  factory DocModel.fromJson(Map<String, dynamic> json) {
    return DocModel(
      bio: json["bio"],
      image: json["imagePath"],
      id: json["id"],
      email: json["email"],
      name: json["name"],
      phone: json["phone"],
      Governorate: json["governate"],

    );
  }
  }
