import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../utils/Colors.dart';
class DoctorSection extends StatelessWidget {
  String txt;
  String img;
  final VoidCallback onclick;
  double imgWidth;
   DoctorSection({super.key,required this.txt, required this.img,required this.onclick,required this.imgWidth});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      height: 38.h,
      width: double.infinity,
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 4,
              offset: Offset(0, 5),
            ),
          ],
          color: Colours.primarygrey,
          borderRadius: BorderRadius.circular(15)
      ),
      child: Column(
        spacing: 1.5.h,
        children: [
          Image.asset("$img",width: imgWidth,),
          Text("$txt",style:TextStyle(
              color: Colours.primaryblue,
              fontSize: 18.sp,
              height: .3.h
          ) ,),
          Align(
            alignment: Alignment.bottomRight,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                padding: EdgeInsets.symmetric(
                  vertical: 1.5.h,
                  horizontal: 7.w,
                ),
                backgroundColor: Colours.primaryyellow,
              ),
              onPressed:onclick,
              child: Text(
                "Discover",
                style: TextStyle(
                  color: Colours.primaryblue,
                  fontSize: 17.sp,
                ),
              ),
            ),
          )
        ],
      ),);
  }
}
