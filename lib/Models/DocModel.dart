class DocModel {
  String id ;
  String name ;
  String email ;
  String phone;
  String Governorate;
  String image;
  String? bio;
  DocModel({
    required this.bio,
    required this.id,
    required this.name,
    required  this.email,
    required  this.phone,
    required  this.Governorate,
    required this.image
    });
  factory DocModel.fromJson(Map<String, dynamic> json) {
    return DocModel(
      bio: json['specialization'],
      image: json["imagePath"],
      id: json["id"],
      email: json["email"],
      name: json["name"],
      phone: json["phone"],
      Governorate: json["governate"],

    );
  }
  }
