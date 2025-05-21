import 'dart:convert';

class ChildModel {
  String name;
  String gender;
  int age;
  String date;

  ChildModel({
    required this.name,
    required this.gender,
    required this.age,
    required this.date,
  });


  Map<String, dynamic> toJson() {
    return {
      "childName": name,
      "age": age,
      "gneder": gender,
      "diagnosisDate": date
    };
  }

  String toJsonString() {
    return jsonEncode(toJson());
  }


  factory ChildModel.fromJson(Map<String, dynamic> json) {
    return ChildModel(
      name: json["childName"],
      gender: json["gender"],
      age: json["age"],
      date: json["diagnosisDate"],
    );
  }

  factory ChildModel.fromJsonString(String jsonString) {
    return ChildModel.fromJson(jsonDecode(jsonString));
  }
}
