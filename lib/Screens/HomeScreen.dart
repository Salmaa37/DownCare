import 'package:downcare/Screens/Tabs/FeedbackTab.dart';
import 'package:downcare/Screens/Tabs/HomeTab.dart';
import 'package:downcare/Screens/Tabs/MomSettings.dart';
import 'package:downcare/utils/Colors.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
class HomeScreen extends StatefulWidget {
  static const String routeName = "home";

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;

  final List<Widget> tabs = [HomeTab(), FeedbackTab(), MomSetting()];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(

        resizeToAvoidBottomInset: true,
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
        body: tabs[selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          onTap: (value) {
            setState(() {
              selectedIndex = value;
            });
          },
          iconSize: 7.w,
          currentIndex: selectedIndex,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white70,
          backgroundColor: Colours.primaryblue,
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.home), label: 'Home',backgroundColor: Colours.primaryblue),
            BottomNavigationBarItem(
                icon: Icon(Icons.feedback), label: 'Feedback',backgroundColor: Colours.primaryblue),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings), label: 'Settings',backgroundColor: Colours.primaryblue),
          ],
        ),
      ),
    );
  }
}
