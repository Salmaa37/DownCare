
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import '../../Apis/Account/AccountApis.dart';
import '../../utils/AppImages.dart';
import '../../utils/Colors.dart';
import '../DoctorDemo/WelcomeDoc.dart';
import '../HomeScreen.dart';
import 'ForgotPass.dart';
import 'SignUp.dart';
import '../../Modules/LoginBtn.dart';

class Login extends StatefulWidget {
  static const String routeName = "Login";

  @override
  State<Login> createState() => _LoginState();
}
class _LoginState extends State<Login> {
  final emailcontroller = TextEditingController();
  final passwordcontroller = TextEditingController();
  bool secure = true;

  void showErrorMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: TextStyle(fontSize: 14.sp, color: Colors.white),
        ),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.only(top: 5.h, left: 2.w, right: 2.w),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          AppImages.loginbg,
          fit: BoxFit.fill,
          width: double.infinity,
        ),
        Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: Colors.transparent,
          body: Padding(
            padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 2.w),
            child: SingleChildScrollView(
              child: Container(
                height: 70.h,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                              text: "LOG IN\n ",
                              style: TextStyle(
                                  color: Colours.primaryblue, fontSize: 25.sp)),
                          TextSpan(
                              text: 'with DownCare',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                    SizedBox(height: 15.h),
                    Text('Email',
                        style: TextStyle(
                            fontSize: 17.sp, color: Colours.primaryblue)),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 2.w),
                      decoration: BoxDecoration(
                          color: Colours.primaryblue,
                          borderRadius: BorderRadius.circular(10)),
                      child: TextField(
                        cursorColor: Colors.white,
                        cursorWidth: 1.0,
                        cursorHeight: 25.0,
                        style: TextStyle(color: Colors.white, fontSize: 16.sp),
                        controller: emailcontroller,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                            suffixIcon: Icon(Icons.email, color: Colors.white),
                            border: InputBorder.none,
                            hintStyle:
                            TextStyle(fontSize: 14.sp, color: Colors.white),
                            hintText: "enter email"),
                      ),
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    Text("Password",
                        style: TextStyle(
                            fontSize: 17.sp, color: Colours.primaryblue)),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 2.w),
                      decoration: BoxDecoration(
                          color: Colours.primaryblue,
                          borderRadius: BorderRadius.circular(10)),
                      child: TextField(
                        cursorColor: Colors.white,
                        cursorWidth: 1.0,
                        cursorHeight: 25.0,
                        style: TextStyle(color: Colors.white, fontSize: 16.sp),
                        controller: passwordcontroller,
                        obscureText: secure,
                        decoration: InputDecoration(
                            suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    secure = !secure;
                                  });
                                },
                                icon: Icon(
                                  secure
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  color: Colors.white,
                                )),
                            border: InputBorder.none,
                            hintStyle:
                            TextStyle(fontSize: 14.sp, color: Colors.white),
                            hintText: "enter password"),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, ForgotPass.routeName);
                      },
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: Text(
                          "forgot password ?",
                          style: TextStyle(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.bold,
                              color: Colours.primaryblue),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          bottomNavigationBar: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  LoginBtn(
                    txt: "LOG IN ",
                    onclick: () async {
                      AccountApis.logInUser(
                        emailcontroller.text,
                        passwordcontroller.text,
                        onsuccess: () async {
                          final prefs = await SharedPreferences.getInstance();
                          await prefs.setBool('is_logged_in', true);
                          String? role = prefs.getString('role');

                          if (role == null || role.isEmpty) {
                            showErrorMessage(
                                "No role selected. Please try logging in again.");
                            return;
                          }

                          if (role == "mom") {
                            Navigator.pushNamedAndRemoveUntil(
                              context,
                              HomeScreen.routeName,
                                  (route) => false,
                            );
                          } else if (role == "doctor") {
                            Navigator.pushNamedAndRemoveUntil(
                              context,
                              WelcomeDoc.routeName,
                                  (route) => false,
                            );
                          } else {
                            showErrorMessage("Your role is not selected correctly.");
                          }
                        },
                        onError: (error) {
                          showErrorMessage(error);
                        },
                      );
                    },
                  ),
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("if you don't have an account ",
                          style: TextStyle(fontSize: 16.sp)),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, SignUp.routeName);
                        },
                        child: Text(
                          "Sign Up ",
                          style: TextStyle(
                              color: Colours.primaryblue, fontSize: 17.sp),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),

        ),
      ],
    );
  }
}

