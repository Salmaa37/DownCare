import 'package:downcare/Models/levelModel.dart';
import 'package:downcare/Screens/MomDemo/ChildSection/Communication/LevelCard.dart';
import 'package:downcare/Screens/MomDemo/ChildSection/Communication/LevelDetails.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class SectionLevels extends StatelessWidget {
  List<LevelModel> l = LevelModel.getlevelmodel();
  static const String routeName = "section levels";
  SectionLevels({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Communication Levels"),
      ),
      body:Padding(
        padding: const EdgeInsets.all(30.0),
        child: ListView.separated(
          itemBuilder: (context, index) {
            return Levelcard(txt: l[index].txt, img:l[index].img, width: l[index].width,onclick: (){
              Navigator.pushNamed(context, LevelDetails.routeName);
            },) ;
          },
          separatorBuilder: (context, index) =>  Divider(),
          itemCount: l.length,
        ),
      )


    ) ;
  }
}



