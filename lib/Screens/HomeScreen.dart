import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';

import 'package:downcare/Screens/Login.dart';
import 'package:downcare/Screens/Profile.dart';
import 'package:downcare/Screens/Tabs/FeedbackTab.dart';
import 'package:downcare/Screens/Tabs/HomeTab.dart';
import 'package:downcare/utils/Colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'Section.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = "home";
   HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedindex=0;
  List<Widget>Tabs=[HomeTab(),FeedbackTab()];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      child: Scaffold(
        appBar: AppBar(
          actions: [
            InkWell(
              onTap: () {
            Navigator.pushNamed(context, Profile.routeName);
              },
              child: CircleAvatar(
               radius: 15,
                backgroundImage: AssetImage("assets/images/person.jpg"),
              ),
            )
          ],
          centerTitle: true,
          title: Center(
            child: Column(
              children: [
                Text("Welcome",style:TextStyle(

                    fontSize: 24,
                    color: Colors.white
                )),
                Text("To DownCare",style: TextStyle(
                  fontSize: 16,
                  color: Colors.white
                ),)
              ],
            ),
          ),
          leading: InkWell(
            onTap: (){
              Navigator.pushNamed(context, Login.routeName);
            },
              child: Icon(Icons.logout,color: Colors.white,size: 25,)),

        ),
        body:Tabs[selectedindex] ,
        bottomNavigationBar:BottomNavigationBar(
          onTap: (value) {
            selectedindex=value;
            setState(() {

            });
          },
          type: BottomNavigationBarType.shifting,
            iconSize: 27,
            unselectedItemColor: Colors.white,
            selectedItemColor: Colors.white,
            elevation: 0,
            selectedLabelStyle: TextStyle(
              fontSize: 11,
            ),
            currentIndex: selectedindex,

            items: [
              BottomNavigationBarItem(icon: Icon(Icons.home,color: Colors.white,),label: 'Home',backgroundColor: Colours.primaryblue),
              BottomNavigationBarItem(icon: Icon(Icons.feedback,color: Colors.white, ),label: 'Feedback',backgroundColor: Colours.primaryblue)

            ]),
      ),
    );
  }
}




