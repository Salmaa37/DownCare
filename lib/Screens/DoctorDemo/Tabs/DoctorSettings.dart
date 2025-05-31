import 'package:downcare/Screens/DoctorDemo/DoctorAccount/ChangeDoctorPass.dart';
import 'package:downcare/Screens/DoctorDemo/DoctorAccount/DoctorProfile.dart';
import 'package:downcare/Screens/UserAccount/Login.dart';
import 'package:downcare/utils/Colors.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import '../../../Modules/SettingsCard.dart';
class DoctorSettings extends StatelessWidget {
  const DoctorSettings({super.key});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        spacing: 3.h,
        children: [
          SizedBox(
            height: 3.h,
          ),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, DoctorProfile.routeName);
            },
            child: SettingsCard(txt: "Profile",
                icon: Icons.person,
                iconColor: Colours.primaryblue,
                textColor: Colours.primaryblue),
          ),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, ChangeDoctorPass.routeName);
            },
            child: SettingsCard(txt: "Change Password",
                icon: Icons.edit,
                iconColor: Colours.primaryblue,
                textColor: Colours.primaryblue),
          ),
          GestureDetector(
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text("Confirm Logout",style: TextStyle(
                      color: Colors.red,

                    ),),
                    content: Text("Are you sure you want to log out?"),
                    actions: [
                      TextButton(
                        child: Text("Cancel",style: TextStyle(
                          color: Colours.primaryblue
                        ),),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      TextButton(
                        child: Text("Log Out", style: TextStyle(color: Colors.red)),
                   onPressed: () async {
                          final prefs = await SharedPreferences.getInstance();
                          await prefs.remove('is_logged_in');
                          Navigator.of(context).pop();
                          Navigator.pushNamedAndRemoveUntil(
                            context,
                            Login.routeName,
                                (route) => false,
                          );
                        },
                      ),
                    ],
                  );
                },
              );
            },
            child: SettingsCard(
              txt: "Log Out",
              icon: Icons.logout,
              iconColor: Colors.red,
              textColor: Colors.red,
            ),
          )

        ],
      ),
    );
  }
}

