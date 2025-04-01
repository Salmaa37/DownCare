class ChildModel {
  String name;
  String gender;
  int age;
 String date;

  ChildModel({required this.name,
    required this.gender,
    required this.age,
    required this.date});

  // تحويل الكائن إلى JSON لإرساله في الطلب
  Map<String, dynamic> toJson() {
    return {
      "childName": name,
      "age": age,
      "gneder":gender,
      "diagnosisDate":date
    };
  }

  factory ChildModel.fromJson(Map<String, dynamic> json) {
    return ChildModel(
      name: json["childName"],
      gender: json["gender"],
      age: json["age"],
      date: json["diagnosisDate"],
    );
  }
}