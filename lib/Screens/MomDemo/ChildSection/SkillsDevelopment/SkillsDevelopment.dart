import 'package:downcare/utils/AppImages.dart';
import 'package:downcare/utils/Colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../../../ReusableComponents/AppButton.dart';
class SkillsDevelopment extends StatelessWidget {
  static const String routeName="skills";
  SkillsDevelopment({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Skills Development"),

      ),
      body: Center(
        child: Padding(
          padding:  EdgeInsets.only(
              top:10.h,
              bottom: 3.h
          ),
          child: Column(
            mainAxisAlignment:MainAxisAlignment.spaceEvenly,
            children: [
              Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Container(
                    margin: EdgeInsets.only(

                        right: MediaQuery.of(context).size.width*0.20
                    ),
                    child: Image.asset("${AppImages.rotatepuzzle}",
                      width:MediaQuery.of(context).size.width*0.5 ,
                      fit: BoxFit.cover,),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width*0.3
                    ),
                    child: Transform.rotate(
                      angle:0.2 ,
                      child: Image.asset("${AppImages.puzzle}",
                        width:MediaQuery.of(context).size.width*0.5 ,),
                    ),
                  )
                ],
              ),
              // SizedBox(
              //   height: 10,
              // ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  Text("IT IS TIME",style: TextStyle(
                      fontSize: 22.sp,
                      color: Colours.primaryblue
                  ),),
                  SizedBox(
                    height: 1.h,
                  ),
                  Text("TO PLAY",style: TextStyle(
                      fontSize: 22.sp,
                      color: Colours.primaryblue
                  ),)
                ],
              ),
              Spacer(),
              Text("Click here and start your game ",style: TextStyle(
                  fontSize: 17.sp,
                  color: Colours.primaryblue
              ),),
              SizedBox(
                height: 3.h,
              ),
              AppButton(txt: "START",onclick: (){},colorbtn: Colours.primaryyellow,)

            ],
          ),
        ),
      ),
    );
  }
}