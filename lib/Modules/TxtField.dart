import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
class TxtField extends StatelessWidget {
  Color stylecolor;
  Color hintcolor;
  Color cardcolor;
  TextEditingController controller;
  String hinttxt;
   TxtField({super.key,required this.hinttxt,
     required this.controller,
     required this.cardcolor,
     required this.hintcolor,required this.stylecolor});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
          top: 0.4.h
      ),
      padding: EdgeInsets.only(
          left: 2.w
      ),
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: cardcolor
      ),
      child: TextField(
        cursorColor: Colors.white,
        cursorWidth: 1.0,
        cursorHeight: 25.0,
        style: TextStyle(
          color: stylecolor
        ),
      controller: controller,
        decoration: InputDecoration(
            border: InputBorder.none,
            hintStyle: TextStyle(
                color: hintcolor,
                fontSize: 16.sp
            ),
            hintText: '$hinttxt'
        ),
      ),
    );
  }
}
