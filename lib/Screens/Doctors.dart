
import 'package:downcare/Screens/DoctorCard.dart';
import 'package:downcare/Screens/DoctorChat.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Doctors extends StatelessWidget {
  static const String routeName ="doctors";
  const Doctors({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Container(
            margin: EdgeInsets.only(
              right: 30
            ),
              child: Icon(Icons.search,color: Colors.white,size: 29,))
        ],
        title: Text("Top Doctors",style: TextStyle(
          fontSize: 17,
          color: Colors.white
        ),),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ListView.separated(itemBuilder: (context, index) {
          return DoctorCard();
        }, separatorBuilder: (context, index) {
          return Divider(
            color: Colors.transparent,
          );
        }, itemCount: 2),
      ),
    );
  }
}
