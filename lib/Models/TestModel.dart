class TestModel {
  final String imagePath;
  final List<String> choices;
  final String correctAnswer;

 TestModel({
    required this.imagePath,
    required this.choices,
    required this.correctAnswer,
  });

  factory TestModel.fromJson(Map<String, dynamic> json) {
    return TestModel(
      imagePath: json['imagePath'],
      choices: List<String>.from(json['choices']),
      correctAnswer: json['correctAnswer'],
    );
  }
}
