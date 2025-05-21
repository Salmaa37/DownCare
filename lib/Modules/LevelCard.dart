import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../utils/Colors.dart';
import '../Screens/MomDemo/ChildSection/Communication/LevelDetails.dart';
class Levelcard extends StatelessWidget {
  final VoidCallback onclick;
  final VoidCallback testOnclick;
  double width;
  String txt;
  String img;
  Levelcard({super.key,required this.txt ,required this.img, required this.width,required this.onclick,
    required this.testOnclick});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(right: 4.w),
      height: 25.h,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: Offset(0, 5),
          ),
        ],
        color: Colours.primarygrey,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: SizedBox(
                  width: width,
                  child: Image.asset(img),
                ),
              ),
              SizedBox(width: 2.w),
              Expanded(
                child: Text(
                  "$txt",
                  style: TextStyle(fontSize: 17.sp),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Align(
                alignment: Alignment.bottomRight,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50)
                    ),
                    backgroundColor: Colours.primaryblue,
                  ),
                  onPressed: testOnclick,
                  child: Text(
                    "Test",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.sp,
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 3.w,
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50)
                    ),
                    backgroundColor: Colours.primaryblue,
                  ),
                  onPressed: onclick,
                  child: Text(
                    "Start",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.sp,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}