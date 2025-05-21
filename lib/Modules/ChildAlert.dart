import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../utils/Colors.dart';
class ChildAlert extends StatelessWidget {
  final VoidCallback cancel;
  final VoidCallback ready;
  const ChildAlert({super.key, required this.ready, required this.cancel});
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(2.w),
      ),
      title: Center(
        child: Image.asset(
          "assets/images/congrate.png",
          width: 35.w,
        ),
      ),
      content: Padding(
        padding: EdgeInsets.symmetric(horizontal: 3.w),
        child: Text(
          "The level has been finished. Are you ready to test?",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16.sp,
          ),
        ),
      ),
      actionsAlignment: MainAxisAlignment.spaceEvenly,
      actions: [
        SizedBox(
          width: 30.w,
          child: ElevatedButton(
            onPressed: cancel,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colours.primaryblue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(2.w),
              ),
            ),
            child: Text(
              "Cancel",
              style: TextStyle(
                color: Colors.white,
                fontSize: 15.sp,
              ),
            ),
          ),
        ),
        SizedBox(
          width: 30.w,
          child: ElevatedButton(
            onPressed: ready,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colours.primaryblue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(2.w),
              ),
            ),
            child: Text(
              "Ready",
              style: TextStyle(
                color: Colors.white,
                fontSize: 15.sp,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
