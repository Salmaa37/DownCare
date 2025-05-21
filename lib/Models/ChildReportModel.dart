class ChildReportModel {
  final String childName;
  final int age;
  final String diagnosisDate;
  final String gender;
  final Map<String, int> linguisticsScore;
  final Map<String, int> communicationScore;

  ChildReportModel({
    required this.childName,
    required this.age,
    required this.diagnosisDate,
    required this.gender,
    required this.linguisticsScore,
    required this.communicationScore,
  });


  factory ChildReportModel.fromJson(Map<String, dynamic> json) {
    return ChildReportModel(
      childName: json['childName'] ?? '',
      age: json['age'] ?? 0,
      diagnosisDate: json['diagnosisDate'] ?? '',
      gender: json['gneder'] ?? '',
      linguisticsScore: Map<String, int>.from(json['linguisticsScore'] ?? {}),
      communicationScore: Map<String, int>.from(json['communicationScore'] ?? {}),
    );
  }
}
