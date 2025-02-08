import 'dart:async';
import 'package:downcare/Screens/Welcome.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class SplahScreen extends StatefulWidget {
  static const String routeName='splah';
   SplahScreen({super.key});
  @override
  State<SplahScreen> createState() => _SplahScreenState();
}

class _SplahScreenState extends State<SplahScreen> {
  void initState() {
    super.initState();

    Timer(Duration(seconds: 4), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => Welcome()),
      );
    });
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/images/logo.png",
            width: MediaQuery.of(context).size.width*0.5,)
          ],
        ),
      ),
    );
  }
}



 