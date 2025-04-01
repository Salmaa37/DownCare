
import 'package:downcare/Screens/MomDemo/ChildSection/Communication/BackAndNextBtn.dart';
import 'package:downcare/Screens/MomDemo/ChildSection/Communication/ChildAlert.dart';
import 'package:downcare/Screens/MomDemo/ChildSection/Communication/LevelTest.dart';
import 'package:downcare/utils/Colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
class LevelDetails extends StatelessWidget {
  static const String routeName="level details";
  const LevelDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("One Word"),
        
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Center(
            child: Column(
              spacing: 1.h,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("Have your child listen and repeat",style: TextStyle(
                  color: Colours.primaryblue,
                  fontSize: 18.sp,

                ),),
                Image.asset("assets/images/orange.png",width: 60.w,),
                Text("بُرتقالة",style: TextStyle(
                  color: Colours.primaryblue,
                  fontSize: 35.sp,

                ),),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Click here to enable your child to repeat ",style: TextStyle(
                      color: Colours.primaryblue,
                      fontSize: 16.sp
                    ),),
                    SizedBox(
                      height: 0.1.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("the statement",style: TextStyle(
                        color: Colours.primaryblue,
                        fontSize: 16.sp
                    ),),
                       IconButton(onPressed: (){}, icon:
                       Icon(Icons.mic,color: Colours.primaryblue,size: 10.w,))
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
        bottomNavigationBar:BackAndNextBtn(back: (){}, next: (){
          showDialog(context: context, builder: (context) => ChildAlert(ready: (){
            Navigator.pushNamed(context,LevelTest.routeName);
          }, cancel: (){
            Navigator.pop(context);
          }),);
        }) ,
    );
  }
}
