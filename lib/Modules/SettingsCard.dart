import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../utils/Colors.dart';

class SettingsCard extends StatelessWidget {
  String txt;
  Color textColor;
  Color iconColor;
  IconData icon;
   SettingsCard({super.key,required this.txt,
  required this.icon,
  required this.iconColor,
  required this.textColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      height: 7.h,
      decoration:BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: Offset(0, 5),
          ),
        ],
      ) ,
      child: Row(
        children: [
          Icon(icon,color: iconColor,size: 7.w,),
          Text("$txt",style: TextStyle(
              color: textColor,
              fontSize: 18.sp
          ),)
        ],
      ),);
  }
}
