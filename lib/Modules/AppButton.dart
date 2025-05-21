import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../Screens/MomDemo/ChildSection/Communication/TestResult.dart';
import '../utils/Colors.dart';
class AppButton extends StatelessWidget {
  Color colorbtn;
  String txt;
  final VoidCallback onclick;
   AppButton({super.key,required this.txt ,required this.onclick,required this.colorbtn});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 95.w,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(
                  vertical: 1.5.h,
              ),
              backgroundColor: colorbtn
          ),
          onPressed: onclick, child: Text("$txt",style: TextStyle(
        color: Colours.primaryblue,
        fontSize: 17.sp,

      ),)),
    );
  }
}
