
import 'package:downcare/Screens/DoctorDemo/Tabs/DoctorHome.dart';
import 'package:downcare/Screens/DoctorDemo/Tabs/DoctorSettings.dart';
import 'package:downcare/utils/Colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
class WelcomeDoc extends StatefulWidget {
  static const String routeName="welcome doc";
   WelcomeDoc({super.key});

  @override
  State<WelcomeDoc> createState() => _WelcomeDocState();
}

class _WelcomeDocState extends State<WelcomeDoc> {
  int selectedIndex=0;
  List<Widget>docTabs=[DoctorHome(),DoctorSettings()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: docTabs[selectedIndex],
        resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          title: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Welcome",
                style: TextStyle(
                  height: 1.5,
                  color: Colors.white,
                  fontSize: 22.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                "To DownCare",
                style: TextStyle(
                  height: 1.2,
                  fontSize: 14.sp,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar:BottomNavigationBar(
            onTap: (value) {
              selectedIndex=value;
              setState(() {
              });
            },
            iconSize: 7.w,
            currentIndex: selectedIndex,
            items: [
              BottomNavigationBarItem(icon: Icon(Icons.home,color: Colors.white,),label: 'Home',backgroundColor: Colours.primaryblue),
              BottomNavigationBarItem(icon: Icon(Icons.settings,color: Colors.white, ),label: 'Settings',backgroundColor: Colours.primaryblue)
            ])



    );
  }
}
































