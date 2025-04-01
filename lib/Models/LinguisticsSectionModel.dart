class LinguisticsSectionModel {
  String label;
  String imgPath;
  String soundPath;

  LinguisticsSectionModel({required this.label,
    required this.imgPath,required this.soundPath});

  factory LinguisticsSectionModel.fromJson(Map<String, dynamic> json) {
    return LinguisticsSectionModel(
      imgPath: json["imagePath"] ,
      label: json["label"] ,
      soundPath: json["soundPath"] ,

    );
  }
}