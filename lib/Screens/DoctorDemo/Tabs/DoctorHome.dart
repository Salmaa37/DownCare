import 'package:downcare/Screens/DoctorDemo/DoctorChats/ChatRooms.dart';
import 'package:downcare/Screens/DoctorDemo/DoctorArticles/DoctorArticle.dart';
import 'package:downcare/Screens/DoctorDemo/DoctorSection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class DoctorHome extends StatefulWidget {
  const DoctorHome({super.key});

  @override
  State<DoctorHome> createState() => _DoctorHomeState();
}

class _DoctorHomeState extends State<DoctorHome> {
  List<bool> isVisible = [false, false];

  @override
  void initState() {
    super.initState();
    _showCardsSequentially();
  }

  void _showCardsSequentially() async {
    for (int i = 0; i < isVisible.length; i++) {
      await Future.delayed(const Duration(milliseconds: 500));
      setState(() {
        isVisible[i] = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            AnimatedOpacity(
              duration: const Duration(seconds: 1),
              opacity: isVisible[0] ? 1.0 : 0.0,
              child: DoctorSection(
                txt: "To view the messages, click here and discover",
                onclick: () {
                  Navigator.pushNamed(context, ChatRooms.routeName);
                },
                img: "assets/images/chatroom.png",
                imgWidth: 20.w,
              ),
            ),
            SizedBox(height: 4.h),
            AnimatedOpacity(
              duration: const Duration(seconds: 1),
              opacity: isVisible[1] ? 1.0 : 0.0,
              child: DoctorSection(
                txt: "To be able to publish articles, click here  ",
                onclick: () {
                  Navigator.pushNamed(context, DoctorArticle.routeName);
                },
                img: "assets/images/articles.png",
                imgWidth: 15.w,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
