import 'package:downcare/Screens/DoctorDemo/DoctorChats/ChatRooms.dart';
import 'package:downcare/Screens/DoctorDemo/DoctorArticles/DoctorArticle.dart';
import 'package:downcare/Screens/DoctorDemo/DoctorSection.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
class DoctorHome extends StatelessWidget {
  const DoctorHome({super.key});
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          spacing: 4.h,
          children: [
            DoctorSection(txt: "To view the messages, click here and discover",onclick: (){
              Navigator.pushNamed(context, ChatRooms.routeName);
            },img: "assets/images/chatroom.png",imgWidth: 20.w,),
            DoctorSection(txt: "To be able to publish articles, click here  ",onclick: (){
              Navigator.pushNamed(context, DoctorArticle.routeName);
            },img: "assets/images/articles.png",imgWidth: 15.w,)

          ],
        ),
      ),
    );
  }
}
