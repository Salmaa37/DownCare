import 'package:downcare/Screens/DoctorDemo/DoctorEditProfile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../ReusableComponents/AppButton.dart';
import '../../ReusableComponents/ProfileCard.dart';
import '../../utils/Colors.dart';
import '../UserAccount/EditProfile.dart';

class DoctorProfile extends StatelessWidget {
  static const String routeName="docProfile";
  const DoctorProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(
            color: Colours.primaryblue
        ),
        backgroundColor: Colors.white,
        title: Text("Profile",style: TextStyle(
            color: Colours.primaryblue,
            fontSize: 18.sp
        ),),
      ),
      body: Padding(
        padding: const EdgeInsets.all(14.0),
        child: SingleChildScrollView(
          child: Column(
            spacing: 1.h,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: CircleAvatar(
                  radius: 80,
                  backgroundColor: Colours.primaryblue,
                  child: Text(
                    "A",
                    style: TextStyle(fontSize: 25.sp, color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),

              Text("Username",style: TextStyle(
                  color: Colours.primaryblue,
                  fontSize: 16.sp
              ),),
              ProfileCard(label: "Amal Ali",),

              Text("Email",style: TextStyle(
                  color: Colours.primaryblue,
                  fontSize: 16.sp
              ),),
              ProfileCard(label:"amal@gmail.com"),

              Text("Phone",style: TextStyle(
                  color: Colours.primaryblue,
                  fontSize: 16.sp
              ),),
              ProfileCard(label: "895634"),

              Text("Governorate",style: TextStyle(
                  color: Colours.primaryblue,
                  fontSize: 16.sp
              ),),
              ProfileCard(label: "Giza"),
              Text("Specialization",style: TextStyle(
                  color: Colours.primaryblue,
                  fontSize: 16.sp
              ),),
              ProfileCard(label: "---"),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        padding: EdgeInsets.zero,
        elevation: 0,
        child: Center(
          child: Padding(
            padding: EdgeInsets.only(
                bottom: 0.5.h
            ),
            child: AppButton(txt: "EDIT",colorbtn: Colours.primaryyellow,onclick: (){
              Navigator.pushNamed(context, DoctorEditProfile.routeName);
            },),
          ),
        ),
      ),);
  }
}
