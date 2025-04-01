import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../utils/Colors.dart';
import '../DoctorDemo/SettingsCard.dart';
import '../UserAccount/ChangePass.dart';
import '../UserAccount/Login.dart';
import '../UserAccount/Profile.dart';
class MomSetting extends StatelessWidget {
  const MomSetting({super.key});
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
              Navigator.pushNamed(context, Profile.routeName);
            },
            child: SettingsCard(txt: "Profile",
                icon: Icons.person,
                iconColor: Colours.primaryblue,
                textColor: Colours.primaryblue),
          ),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, ChangePass.routeName);
            },
            child: SettingsCard(txt: "Change Password",
                icon: Icons.edit,
                iconColor: Colours.primaryblue,
                textColor: Colours.primaryblue),
          ),
          GestureDetector(
            onTap: (){
              Navigator.pushNamed(context, Login.routeName);
            },
            child: SettingsCard(txt: "Log Out",
                icon: Icons.logout,
                iconColor: Colors.red,
                textColor: Colors.red),
          )
        ],
      ),
    );
  }
}
