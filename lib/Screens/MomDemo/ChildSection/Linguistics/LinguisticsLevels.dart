import 'package:downcare/Screens/MomDemo/ChildSection/Communication/LevelCard.dart';
import 'package:downcare/Screens/MomDemo/ChildSection/Linguistics/LinguisticsDetails.dart';
import 'package:flutter/material.dart';
import '../../../../Models/levelModel.dart';
class LinguisticsLevels extends StatelessWidget {
  static const String routeName="linguistics";
  List<LevelModel> l = LevelModel.getlevelmodel();
   LinguisticsLevels({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Linguistics Levels"),
        ),
        body:Padding(
          padding: const EdgeInsets.all(30.0),
          child: ListView.separated(
            itemBuilder: (context, index) {
              return Levelcard(txt: l[index].txt, img: l[index].img, width: l[index].width,onclick: (){
                Navigator.pushNamed(context, LinguisticsDetails.routeName,arguments: l[index].type);
              },);
            },
            separatorBuilder: (context, index) => const Divider(),
            itemCount: l.length,
          ),
        )
    ) ;
  }
}
