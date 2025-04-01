import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../utils/Colors.dart';

class Alert extends StatelessWidget {
  String txt;
  String title;
  Color titleColor;

   Alert({super.key,required this.txt,required this.title,required this.titleColor});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      title: Center(child: Text("$title",style: TextStyle(
        color: titleColor,
      ),)),
      content: Text("$txt",style: TextStyle(

          fontSize:18.sp
      ),),
      actions: [
        ElevatedButton(
            onPressed: (){
              Navigator.pop(context);
            },

            style: ElevatedButton.styleFrom(
                backgroundColor:Colours.primaryblue
            ),
          child:Text("OK",style: TextStyle(
              color: Colors.white,
              fontSize: 18.sp
          ),),
        )
      ],
    );
  }
}
