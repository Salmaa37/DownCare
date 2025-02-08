
import 'package:downcare/Screens/Login.dart';
import 'package:downcare/utils/Colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Welcome extends StatelessWidget {
  static const String routeName="welcome";
  const Welcome({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset("assets/images/welcomebg.png",fit: BoxFit.fill,),
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
                      TextSpan(text: 'Welcome\n', style: TextStyle(color: Colours.primaryblue, fontSize: 30)),
                      TextSpan(text: '   To DownCare', style: TextStyle(color:Colours.primaryblue , fontSize: 13)),
                    ],
                  ),
                ),
                Text(

                  "Down Syndrome it doesn’t\n mean I’m down it means I\n help people who are\n feeling down ",
                  style: TextStyle(
                    height: 2.7,
                  fontSize: 17
                ),),
                Center(
                  child: ElevatedButton(

                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(
                        vertical: 19,
                        horizontal: MediaQuery.of(context).size.width*0.27
                      ),
                      backgroundColor: Colours.primaryblue
                    ),
                      onPressed: (){
                     Navigator.pushReplacementNamed(context, Login.routeName);
                      }, child: Text("Get Started",style: TextStyle(
                    fontSize: 16,
                     color: Colors.white
                  ),)),
                )
              ],
            ),
          ),

        ),
      ],
    );
  }
}
