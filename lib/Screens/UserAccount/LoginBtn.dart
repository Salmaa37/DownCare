import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../utils/Colors.dart';
class LoginBtn extends StatelessWidget {
  String txt;
  final VoidCallback onclick;
   LoginBtn({super.key,required this.txt ,required this.onclick});
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(
                vertical: 1.5.h,
                horizontal: MediaQuery.of(context).size.width*0.3
            ),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10)
            ),
            backgroundColor: Colours.primaryyellow
        ),
        onPressed: onclick, child: Text("$txt",style: TextStyle(
        color: Colours.primaryblue,
        fontSize: 16.sp
    ),));
  }
}



