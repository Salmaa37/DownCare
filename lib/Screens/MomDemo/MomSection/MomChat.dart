
import 'package:downcare/utils/Colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
class Momchat extends StatelessWidget {
  static const String routeName="momchat";
  const Momchat({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        actions: [
          Icon(Icons.more_vert_rounded,color: Colors.white,)
        ],
        title: Text("Moms Group",),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.only(
          bottom: MediaQuery.viewInsetsOf(context).bottom,
          left: 2.w,
          right: 2.w
        ),
        margin: EdgeInsets.symmetric(
          vertical: 2.h,
          horizontal: 3.w
        ),
        color: Colours.primarygrey,
        child: TextField(
          decoration: InputDecoration(
            suffixIcon: Icon(Icons.send,color: Colours.primaryblue,),
            hintStyle: TextStyle(
              color: Colours.primaryblue
            ),
            border: InputBorder.none,
            hintText: "Type your message"
          ),
        ),
      ) ,
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Row(
              children: [
                CircleAvatar(
                 radius: 17,
                  backgroundImage: AssetImage("assets/images/person.jpg"),
                  ),

                SizedBox(
                  width: 2.w,
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colours.primarygrey,
                      borderRadius: BorderRadius.circular(20)
                    ),
                    padding: EdgeInsets.all(10),

                    child: Text("Hello,I am Amal ",style: TextStyle(
                      fontSize: 16.sp,
                      color: Colours.primaryblue
                    ),),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
