import 'package:downcare/Models/LoginUserModel.dart';
import 'package:downcare/utils/Colors.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../Apis/Api.dart';
import '../../ReusableComponents/AppButton.dart';
import '../../ReusableComponents/ProfileCard.dart';
import 'EditProfile.dart';

class Profile extends StatefulWidget {
  static const String routeName = "profile";
  Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  LoginUserModel? loginUserModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colours.primaryblue),
        backgroundColor: Colors.white,
        title: Text(
          "Profile",
          style: TextStyle(color: Colours.primaryblue, fontSize: 18.sp),
        ),
      ),
      body: FutureBuilder<LoginUserModel>(
        future: Api.profile(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            print(" Error: ${snapshot.error}");
            return Center(child: Text("Something Went Wrong: ${snapshot.error}"));
          }
          if (!snapshot.hasData || snapshot.data == null) {
            return Center(child: Text("No data available!"));
          }
          loginUserModel ??= snapshot.data;
          return Padding(
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
                        loginUserModel?.userName?.isNotEmpty == true
                            ? loginUserModel!.userName![0].toUpperCase()
                            : "A",
                        style: TextStyle(fontSize: 25.sp, color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Text("Username", style: TextStyle(color: Colours.primaryblue, fontSize: 16.sp)),
                  ProfileCard(label: loginUserModel?.userName ?? "no username"),
                  Text("Email", style: TextStyle(color: Colours.primaryblue, fontSize: 16.sp)),
                  ProfileCard(label: loginUserModel?.email ?? "no email"),
                  Text("Phone", style: TextStyle(color: Colours.primaryblue, fontSize: 16.sp)),
                  ProfileCard(label: loginUserModel?.phone ?? "no phone"),
                  Text("Governorate", style: TextStyle(color: Colours.primaryblue, fontSize: 16.sp)),
                  ProfileCard(label: loginUserModel?.governorate ?? "no governorate"),
                ],
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        padding: EdgeInsets.zero,
        elevation: 0,
        child: Center(
          child: Padding(
            padding: EdgeInsets.only(bottom: 0.5.h),
            child: AppButton(
              txt: "EDIT",
              colorbtn: Colours.primaryyellow,
              onclick: () async {
                if (loginUserModel != null) {
                  var updatedModel = await Navigator.pushNamed(
                    context,
                    EditProfile.routeName,
                    arguments: loginUserModel,
                  );
                  if (updatedModel != null && updatedModel is LoginUserModel) {
                    setState(() {
                      loginUserModel = updatedModel;
                    });
                  }
                } else {
                  print("No user data available!");
                }
              },
            ),

          ),
        ),
      ),
    );
  }
}
