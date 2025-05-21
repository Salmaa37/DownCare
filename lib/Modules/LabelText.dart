import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../utils/Colors.dart';


class LabelText extends StatelessWidget {
  final String text;

  const LabelText(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 1.h, bottom: 0.5.h),
      child: Text(
        text,
        style: TextStyle(color: Colours.primaryblue, fontSize: 16.sp),
      ),
    );
  }
}
