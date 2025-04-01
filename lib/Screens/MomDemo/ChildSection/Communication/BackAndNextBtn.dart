import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../../../utils/Colors.dart';
class BackAndNextBtn extends StatelessWidget {
  final VoidCallback back;
  final VoidCallback next;
   BackAndNextBtn({super.key ,required this.back ,required this.next, });
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: Colors.white,
      padding: EdgeInsets.zero,
      elevation: 0,
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(
                        horizontal: 10.w,
                        vertical: 1.5.h
                    ),
                    backgroundColor: Colours.primaryyellow
                ),
                onPressed: back, child: Text("Back",style: TextStyle(
                fontSize: 16.sp,
                color: Colours.primaryblue
            ),)
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(
                        horizontal: 10.w,
                        vertical: 1.5.h
                    ),
                    backgroundColor: Colours.primaryyellow
                ),
                onPressed:next,child: Text("Next",style: TextStyle(
                fontSize: 16.sp,
                color: Colours.primaryblue
            ),)
            ),

          ],
        ),

      ),
    );
  }
}
