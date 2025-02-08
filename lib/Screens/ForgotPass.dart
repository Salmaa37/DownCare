
import 'package:downcare/Screens/ResetPass.dart';
import 'package:downcare/utils/Colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ForgotPass extends StatelessWidget {
  static const String routeName="forgot pass";
  ForgotPass({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset("assets/images/forgotpass.png",fit: BoxFit.fill,),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height:MediaQuery.of(context).size.height*0.04 ,
                ),
                Text("Forgot Passward ?",style: TextStyle(
                    color: Colours.primaryblue,
                    fontSize: 25,
                    fontWeight: FontWeight.w400
                ),),
                SizedBox(
                  height: MediaQuery.of(context).size.height*0.1,
                ),
                Text("Email",style: TextStyle(
                    color: Colours.primaryblue,
                    fontSize: 16
                ),),
                Container(
                  padding: EdgeInsets.symmetric(
                      vertical: 5,
                      horizontal: 20
                  ),
                  margin: EdgeInsets.only(
                      top: 15
                  ),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colours.primaryblue
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 14
                        ),
                        hintText: 'enter your email'
                    ),
                  ),
                ),
                Spacer(),
                Center(
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                              vertical: 15,
                              horizontal: MediaQuery.of(context).size.width*0.22
                          ),
                          backgroundColor: Colours.primaryyellow
                      ),
                      onPressed: (){
                        Navigator.pushReplacementNamed(context,ResetPass.routeName);
                      }, child: Text("Send reset passward",style: TextStyle(
                      color: Colours.primaryblue,
                      fontSize: 16
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

