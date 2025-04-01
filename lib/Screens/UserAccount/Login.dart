
import 'package:downcare/Apis/ApiManager.dart';
import 'package:downcare/Screens/HomeScreen.dart';
import 'package:downcare/Screens/UserAccount/LoginBtn.dart';
import 'package:downcare/Screens/UserAccount/SignUp.dart';
import 'package:downcare/utils/AppImages.dart';
import 'package:downcare/utils/Colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../ReusableComponents/Alert.dart';
import '../DoctorDemo/WelcomeDoc.dart';
import 'ForgotPass.dart';
class Login extends StatefulWidget {
  static const String routeName="Login";
  @override
  State<Login> createState() => _LoginState();
}
class _LoginState extends State<Login> {
  final emailcontroller=TextEditingController();
  final passwordcontroller=TextEditingController();
  bool secure = true ;
  @override
  Widget build(BuildContext context) {
    var role = (ModalRoute.of(context)?.settings.arguments as String?) ?? "";
    return Stack(
      children: [
        Image.asset("${AppImages.loginbg}",
          fit: BoxFit.fill,
          width: double.infinity,),
        Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: Colors.transparent,
          body: Padding(
            padding:  EdgeInsets.symmetric(
                vertical: 4.h,
                horizontal: 2.w
            ),
            child: SingleChildScrollView(
              child: Container(
                height: 70.h,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: 1.h,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(text: "LOG IN\n ", style: TextStyle(color: Colours.primaryblue, fontSize:25.sp)),
                          TextSpan(text: 'with DownCare',
                              style: TextStyle(
                                  color:Colors.black ,
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    Text('Email', style: TextStyle(
                      fontSize: 17.sp,
                      color: Colours.primaryblue
                    )),
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 2.w
                      ),
                      decoration: BoxDecoration(
                          color: Colours.primaryblue,
                          borderRadius: BorderRadius.circular(10)
                      ),
                      child: TextField(
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.sp
                        ),
                        controller: emailcontroller,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                            suffixIcon: Icon(Icons.email,color: Colors.white,),
                            border: InputBorder.none,
                            hintStyle: TextStyle(
                                fontSize: 14.sp,
                                color: Colors.white
                            ),
                            hintText: "enter email"
                        ),
                      ),
                    ),
                    Text("Passward",style: TextStyle(
                        fontSize: 17.sp,
                        color: Colours.primaryblue
                    ),),
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 2.w
                      ),
                      decoration: BoxDecoration(
                          color: Colours.primaryblue,
                          borderRadius: BorderRadius.circular(10)
                      ),

                      child: TextField(
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.sp
                        ),
                      controller: passwordcontroller,
                        obscureText: secure,
                        decoration: InputDecoration(
                            suffixIcon: IconButton(onPressed: (){
                              secure? Icons.visibility : Icons.visibility_off;
                              setState(() {
                                secure = !secure;
                              });
                            }, icon: Icon(Icons.remove_red_eye_outlined,color: Colors.white,)),
                            border: InputBorder.none,
                            hintStyle: TextStyle(
                                fontSize: 14.sp,
                                color: Colors.white
                            ),
                            hintText: "enter passward"
                        ),
                      ),

                    ),

                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context,ForgotPass.routeName);
                      },
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: Text("forgot passward ?",
                          style: TextStyle(
                            fontSize: 15.sp,
                           fontWeight:FontWeight.bold,
                          color: Colours.primaryblue
                        ),),
                      ),
                    ),
                    // Spacer(),
                  ],
                ),
              ),
            ),
          ),
        bottomNavigationBar: Padding(
          padding:  EdgeInsets.only(
            bottom: 1.h
          ),
          child: BottomAppBar(
            color: Colors.white,
            padding: EdgeInsets.zero,
            elevation: 0,
            child: Column(
              children: [
                Align(
                  alignment: Alignment.bottomCenter,
                  child:LoginBtn(txt: "LOG IN ", onclick: (){
                    ApiManager.logInUser(
                        onError: (error) {
                          showDialog(context: context, builder: (context) {
                            return Alert(txt:"$error",
                              title: "Error!",
                              titleColor: Colors.red,);
                          },);

                        },
                        emailcontroller.text, passwordcontroller.text,
                        onsuccess: (){
                          print(role);
                          // if(role=="mom"){
                            Navigator.pushNamedAndRemoveUntil(context, HomeScreen.routeName, (route) => false);
                          // }


                        });
                  }),
                ),
               SizedBox(
                 height: 0.2.h,
               ),
                Row(

                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("if you don't have an account ",style: TextStyle(
                        fontSize: 16.sp
                    ),),
                    GestureDetector(
                      onTap: (){
                        Navigator.pushNamed(context, SignUp.routeName);
                      },
                      child: Text("Sign Up ",style: TextStyle(
                          color: Colours.primaryblue,
                          fontSize: 17.sp
                      ),),
                    )
                  ],
                )
              ],
            ),
          ),
        ),),
      ],
    );
  }}




