
import 'package:downcare/Screens/AboutDown.dart';
import 'package:downcare/Screens/Articles.dart';
import 'package:downcare/Screens/ChildSection.dart';
import 'package:downcare/Screens/DoctorChat.dart';
import 'package:downcare/Screens/DoctorDemo/ChatRooms.dart';
import 'package:downcare/Screens/DoctorDemo/DoctorArticle.dart';
import 'package:downcare/Screens/DoctorDemo/OtherDoctorsArticles.dart';
import 'package:downcare/Screens/DoctorDemo/WelcomeDoc.dart';
import 'package:downcare/Screens/Doctors.dart';
import 'package:downcare/Screens/EditProfile.dart';
import 'package:downcare/Screens/Feedbacks.dart';
import 'package:downcare/Screens/ForgotPass.dart';
import 'package:downcare/Screens/Login.dart';
import 'package:downcare/Screens/MomChat.dart';
import 'package:downcare/Screens/Profile.dart';
import 'package:downcare/Screens/ResetPass.dart';
import 'package:downcare/Screens/SkillsDevelopment.dart';
import 'package:downcare/Screens/SplashScreen.dart';
import 'package:downcare/Screens/Welcome.dart';
import 'package:downcare/utils/Colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'MomSection.dart';
import 'HomeScreen.dart';
void main (){
  runApp(MyApp());
}
class MyApp extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        appBarTheme: AppBarTheme(
           iconTheme: IconThemeData(
             color: Colors.white
           ),
          toolbarHeight: 80,
          titleSpacing: 0,
          color: Colours.primaryblue
        ),
        fontFamily: "Inknut Antiqua"
      ),
      initialRoute: Welcome.routeName,
      debugShowCheckedModeBanner: false,
      routes: {
        HomeScreen.routeName:(context) => HomeScreen(),
        MomSection.routeName:(context) => MomSection(),
        ChildSection.routeName:(context) => ChildSection(),
        Momchat.routeName:(context) => Momchat(),
        Doctors.routeName:(context) => Doctors(),
        Doctorchat.routeName:(context) => Doctorchat(),
        Articles.routeName:(context) => Articles(),
        SkillsDevelopment.routeName:(context) => SkillsDevelopment(),
        Welcome.routeName:(context)=>Welcome(),
        Login.routeName:(context)=>Login(),
        Feedbacks.routeName:(context)=>Feedbacks(),
        AboutDown.routeName:(context)=>AboutDown(),
        ForgotPass.routeName:(context)=>ForgotPass(),
        ResetPass.routeName:(context)=>ResetPass(),
        Profile.routeName:(context)=>Profile(),
        EditProfile.routeName:(context)=>EditProfile(),
        WelcomeDoc.routeName:(context)=>WelcomeDoc(),
        SplahScreen.routeName:(context)=>SplahScreen(),
        DoctorArticle.routeName:(context)=>DoctorArticle(),
         OtherDoctorsArticles.routeName:(context)=>OtherDoctorsArticles(),
        ChatRooms.routeName:(context)=>ChatRooms()
      },
    );
  }
}





















