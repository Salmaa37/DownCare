
import 'package:downcare/ReusableComponents/AppButton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../utils/Colors.dart';

import 'TestResult.dart';


class LevelTest extends StatelessWidget {
  static const String routeName ="level test";
  const LevelTest({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Test on One Word"),

      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Center(
            child: Column(
              spacing: 1.h,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
              SizedBox(
                height:2.h ,
              ),
                Image.asset("assets/images/orange.png",width: 60.w,),
                Text("------",style: TextStyle(
                  color: Colours.primaryblue,
                  fontSize: 35.sp,

                ),),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Tap the mic and have your child ",style: TextStyle(
                        color: Colours.primaryblue,
                        fontSize: 18.sp
                    ),),
                    SizedBox(
                      height: 0.1.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("say what does he see",style: TextStyle(
                            color: Colours.primaryblue,
                            fontSize: 18.sp
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
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        padding: EdgeInsets.zero,
        elevation: 0,
        child: Center(
          child: Padding(
            padding: EdgeInsets.only(
                bottom: 0.5.h
            ),
            child: AppButton(txt: "Next",
                colorbtn: Colours.primaryyellow,
                onclick: (){
              Navigator.pushNamed(context,TestResult.routeName);
            }),
          ),
        ),
      ),

    );
  }
}
