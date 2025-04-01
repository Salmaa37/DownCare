import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../utils/Colors.dart';


class FeedbackSuccessDialog extends StatelessWidget {
  String txt;
   FeedbackSuccessDialog({super.key,required this.txt});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      title: Column(
        spacing: 0.5.h,
        children: [
          Icon(Icons.sentiment_satisfied_alt_rounded,color: Colors.pinkAccent,size: 15.w,),
          Center(
            child: Text("$txt",style: TextStyle(
              color: Colors.green,
                fontSize: 18.sp
            ),),
          ),
        ],
      ),
      content: Text("thanks for you ",style: TextStyle(
        color: Colors.grey,
        fontSize: 17.sp,
      ),),
      actions: [
        ElevatedButton(
          onPressed: (){
            Navigator.pop(context);
          }, child: Text("Okay",style: TextStyle(
            color: Colors.white,
            fontSize: 16.sp
        ),),style: ElevatedButton.styleFrom(
            backgroundColor: Colours.primaryblue
        ),
        )
      ],
    );
  }
}
