import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../../../utils/Colors.dart';
import '../../../../Modules/SettingsCard.dart';
import '../ChatRoomWithDoctors/MomHistory.dart';
import '../MomAccount/ChangePass.dart';
import '../../../UserAccount/Login.dart';
import '../MomAccount/Profile.dart';
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
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MomHistory()),
              );
            },
            child: SettingsCard(txt: "Chats",
                icon: Icons.chat_bubble,
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
