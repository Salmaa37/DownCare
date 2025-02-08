
import 'package:downcare/Screens/ForgotPass.dart';
import 'package:downcare/Screens/HomeScreen.dart';
import 'package:downcare/utils/Colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class Login extends StatelessWidget {
  static const String routeName="Login";
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset("assets/images/loginbg.png",fit: BoxFit.fill,),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: Padding(
            padding: const EdgeInsets.symmetric(
                vertical: 50,
                horizontal: 17
            ),
            child: Column(

              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(text: "LOG IN\n ", style: TextStyle(color: Colours.primaryblue, fontSize:30)),
                      TextSpan(text: 'with DownCare',
                          style: TextStyle(
                              color:Colors.black ,
                              fontSize: 16,
                              fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    bottom: 14,
                    top: MediaQuery.of(context).size.height*0.22,

                  ),
                  child: Text("Email",style: TextStyle(
                      fontSize: 17,
                      color: Colours.primaryblue
                  ),),
                ),

                Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: 9
                  ),
                  decoration: BoxDecoration(
                      color: Colours.primaryblue,
                      borderRadius: BorderRadius.circular(10)
                  ),

                  child: TextField(
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                        suffixIcon: Icon(Icons.email,color: Colors.white,),
                        border: InputBorder.none,
                        hintStyle: TextStyle(
                            fontSize: 13,
                            color: Colors.white
                        ),
                        hintText: "enter email"
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(
                      vertical: 14
                  ),
                  child: Text("Passward",style: TextStyle(
                      fontSize: 17,
                      color: Colours.primaryblue
                  ),),
                ),

                Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: 9
                  ),
                  decoration: BoxDecoration(
                      color: Colours.primaryblue,
                      borderRadius: BorderRadius.circular(10)
                  ),

                  child: TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                        suffixIcon: Icon(Icons.password,color: Colors.white,),
                        border: InputBorder.none,
                        hintStyle: TextStyle(
                            fontSize: 13,
                            color: Colors.white
                        ),
                        hintText: "enter passward"
                    ),
                  ),

                ),
                SizedBox(
                  height: 7,
                ),
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context,ForgotPass.routeName);
                  },
                  child: Text("forgot passward ?",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                     fontWeight:FontWeight.bold,
                    color: Colours.primaryblue
                  ),),
                ),
                Spacer(),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                              vertical: 14,
                              horizontal: MediaQuery.of(context).size.width*0.3
                          ),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)
                          ),
                          backgroundColor: Colours.primaryyellow
                      ),
                      onPressed: (){
                       Navigator.pushNamedAndRemoveUntil(context, HomeScreen.routeName, (route) => false);
                      }, child: Text("LOG IN",style: TextStyle(
                      color: Colours.primaryblue,
                      fontSize: 16
                  ),)),
                ),
                SizedBox(
                  height: 10,
                ),
                Center(
                  child: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(text: "if you don't have an accout", style: TextStyle(color: Colors.black, fontSize:13)),
                        TextSpan(text: ' Sign Up', style: TextStyle(color:Colours.primaryblue , fontSize: 16)),
                      ],
                    ),
                  ),
                )

              ],
            ),
          ),
        ),
      ],
    );
  }
}