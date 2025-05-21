class LinguisticsSectionModel {
  String label;
  String imgPath;
  String soundPath;
  String type;



  LinguisticsSectionModel({required this.label,
    required this.type,
    required this.imgPath,required this.soundPath,});

  factory LinguisticsSectionModel.fromJson(Map<String, dynamic> json) {
    return LinguisticsSectionModel(
     type: json['type'],
      imgPath: json["imagePath"] ,
      label: json["label"] ,
      soundPath: json["soundPath"] ,

    );
  }
}