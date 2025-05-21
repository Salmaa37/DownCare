import 'package:sizer/sizer.dart';

class LevelModel {
  final String txt;
  final String img;
  final double width;
  final String? level;

  LevelModel({
    required this.txt,
    required this.img,
    required this.width,
    this.level,
  });

  static List<LevelModel> getLevelModel() => [
    LevelModel(txt: "ONE WORD",   img: "assets/images/one.png",   width: 23.w, level: "OneWord"),
    LevelModel(txt: "TWO WORDS",  img: "assets/images/two.png",   width: 23.w, level: "TwoWord"),
    LevelModel(txt: "THREE WORDS",img: "assets/images/three.png", width: 23.w, level: "ThreeWord"),
    LevelModel(txt: "FOUR WORDS", img: "assets/images/four.png",  width: 23.w, level: "FourWord"),
    LevelModel(txt: "FIVE WORDS", img: "assets/images/five.png",  width: 23.w, level: "FiveWord"),
  ];
}
