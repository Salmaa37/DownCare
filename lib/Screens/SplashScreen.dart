import 'dart:async';
import 'package:downcare/Screens/Welcome.dart';
import 'package:downcare/utils/Colors.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
class SplahScreen extends StatefulWidget {
  static const String routeName='splah';
   SplahScreen({super.key});
  @override
  State<SplahScreen> createState() => _SplahScreenState();
}
class _SplahScreenState extends State<SplahScreen> {
  void initState() {
    super.initState();
    Timer(Duration(seconds: 4), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => Welcome()),
      );
    });
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Container(
                    margin: EdgeInsets.only(
                        right: 11.w
                    ),

                    child: Image.asset("assets/images/bluehand.png",width: 30.w,)),
                Container(
                  margin: EdgeInsets.only(
                    left: 11.w,
                    bottom: 3.h
                  ),
                    child: Image.asset("assets/images/yellowhand.png",width: 20.w,)),

              ],
            ),
            Text("DownCare",style: TextStyle(
              fontSize: 23.sp,
              color: Colours.primaryblue
            ),)
          ],
        ),
      ),
    );
  }
}



 