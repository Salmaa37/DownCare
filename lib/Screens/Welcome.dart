import 'package:downcare/Screens/DoctorDemo/WelcomeDoc.dart';
import 'package:downcare/utils/AppImages.dart';
import 'package:downcare/utils/Colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'HomeScreen.dart';
import 'UserAccount/Login.dart';
class Welcome extends StatelessWidget {
  static const String routeName = "welcome";
  Welcome({super.key});
  Future<void> _checkLoginStatus(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    final bool isLoggedIn = prefs.getBool('is_logged_in') ?? false;
    final String role = prefs.getString('role') ?? '';
    if (isLoggedIn) {
      if (role == 'mom') {
        Navigator.pushReplacementNamed(context, HomeScreen.routeName);
      } else if (role == 'doctor') {
        Navigator.pushReplacementNamed(context, WelcomeDoc.routeName);
      } else {

        _showErrorDialog(context, "Your role is not correctly selected.");
      }
    } else {

      Navigator.pushReplacementNamed(context, Login.routeName);
    }
  }

  void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Error", style: TextStyle(color: Colors.red)),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("OK"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset("${AppImages.welcomebg}",
            fit: BoxFit.fill, width: double.infinity),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: Padding(
            padding: const EdgeInsets.all(11.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(text: 'Welcome\n', style: TextStyle(color: Colours.primaryblue, fontSize: 24.sp)),
                      TextSpan(text: '   To DownCare', style: TextStyle(color: Colours.primaryblue, fontSize: 16.sp)),
                    ],
                  ),
                ),
                Text(
                  "Down Syndrome it doesn’t\n mean I’m down it means I\n help people who are\n feeling down ",
                  style: TextStyle(
                    height: 0.4.h,
                    fontSize: 17.sp,
                  ),
                ),
                Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(
                        vertical: 2.h,
                        horizontal: MediaQuery.of(context).size.width * 0.27,
                      ),
                      backgroundColor: Colours.primaryblue,
                    ),
                    onPressed: () => _checkLoginStatus(context),
                    child: Text("Get Started", style: TextStyle(
                      fontSize: 16.sp,
                      color: Colors.white,
                    )),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
