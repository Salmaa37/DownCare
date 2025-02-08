import 'package:downcare/Screens/ProfileCard.dart';
import 'package:downcare/utils/Colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EditProfile extends StatelessWidget {
  static const String routeName="edit profile";
  const EditProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(
            color: Colours.primaryblue
        ),
        backgroundColor: Colors.white,
        title: Text("Edit Profile",style: TextStyle(
            color: Colours.primaryblue,
            fontSize: 18
        ),),
      ),
      body: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CircleAvatar(
                radius: 100,
                backgroundImage: AssetImage("assets/images/person.jpg"),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text("Username",style: TextStyle(
                color: Colours.primaryblue,
                fontSize: 16
            ),),
            ProfileCard(label: "Amal Ali",),
            SizedBox(
              height: 20,
            ),
            Text("Email",style: TextStyle(
                color: Colours.primaryblue,
                fontSize: 16
            ),),
            ProfileCard(label:"amal@gmail.com"),
            SizedBox(
              height: 20,
            ),
            Text("Phone",style: TextStyle(
                color: Colours.primaryblue,
                fontSize: 16
            ),),
            ProfileCard(label: "895634"),
            SizedBox(
              height: 20,
            ),
            Text("Governorate",style: TextStyle(
                color: Colours.primaryblue,
                fontSize: 16
            ),),
            ProfileCard(label: "Giza"),
            Spacer(),

            Center(
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(
                          vertical: 13,
                          horizontal: MediaQuery.of(context).size.width*0.3
                      ),
                      backgroundColor: Colours.primaryyellow
                  ),
                  onPressed: (){
                    Navigator.pop(context);
                  }, child: Text("Confirm",style: TextStyle(
                  color: Colours.primaryblue,
                  fontSize: 15
              ),)),
            )
          ],
        ),
      ),
    );;
  }
}
