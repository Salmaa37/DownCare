import 'package:sizer/sizer.dart';

class LevelModel {
  String txt;
  String img;
  double width;
  String? type;

  LevelModel({required this.txt,required this.img,required this.width,
    this.type });

  static List<LevelModel>getlevelmodel(){
    return [
      LevelModel(txt: "ONE WORD", img: "assets/images/one.png",width: 23.w,type:"OneWord" as String?),
      LevelModel(txt: "TWO WORDS", img: "assets/images/two.png",width: 23.w,type:"TwoWord" as String ?),
      LevelModel(txt: "THREE WORDS", img: "assets/images/three.png",width: 23.w,type:"ThreeWord" as String ?),
      LevelModel(txt: "FOUR WORDS", img: "assets/images/four.png",width: 23.w,type:"FourWord" as String ?),
      LevelModel(txt: "FIVE WORDS", img: "assets/images/five.png",width: 23.w,type:"FiveWord" as String ?)
    ];
  }
}