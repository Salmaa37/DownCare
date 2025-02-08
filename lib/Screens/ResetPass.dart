import 'package:downcare/utils/Colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ResetPass extends StatelessWidget {
  static const String routeName="reset pass";
  const ResetPass({super.key});

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
                Text("Reset Password",style: TextStyle(
                    color: Colours.primaryblue,
                    fontSize: 25,
                    fontWeight: FontWeight.w400
                ),),
                SizedBox(
                  height: MediaQuery.of(context).size.height*0.1,
                ),
                Text("Password",style: TextStyle(
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
                        hintText: 'enter your password'
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Text("Confirm password",style: TextStyle(
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
                        hintText: 'confirm your password'
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
                        Navigator.pop(context);
                      }, child: Text("Reset password",style: TextStyle(
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