
import 'package:downcare/Apis/Account/AccountApis.dart';
import 'package:downcare/Modules/AppButton.dart';
import 'package:downcare/utils/AppImages.dart';
import 'package:downcare/utils/Colors.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'PassCode.dart';
class ForgotPass extends StatefulWidget {
  static const String routeName="forgot pass";
  ForgotPass({super.key});

  @override
  State<ForgotPass> createState() => _ForgotPassState();
}

class _ForgotPassState extends State<ForgotPass> {
  var emailcontroller=TextEditingController();

  void showErrorMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: TextStyle(fontSize: 14.sp, color: Colors.white),
        ),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.only(top: 5.h, left: 2.w, right: 2.w),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset("${AppImages.forgotpass}",
          fit: BoxFit.fill,
          width: double.infinity,),
        Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: Colors.transparent,
          body: Padding(
            padding: const EdgeInsets.all(15.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height:MediaQuery.of(context).size.height*0.04 ,
                  ),
                  Text("Forgot Passward ?",style: TextStyle(
                      color: Colours.primaryblue,
                      fontSize: 21.sp,
                      fontWeight: FontWeight.w400
                  ),),
                  SizedBox(
                    height: MediaQuery.of(context).size.height*0.1,
                  ),
                  Text("Email",style: TextStyle(
                      color: Colours.primaryblue,
                      fontSize: 17.sp
                  ),),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(
                        vertical: 0.5.h,
                        horizontal: 2.w
                    ),
                    margin: EdgeInsets.only(
                        top: 15
                    ),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colours.primaryblue
                    ),
                    child: TextField(
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.sp
                      ),
                      controller: emailcontroller,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintStyle: TextStyle(
                              color: Colors.white,
                              fontSize: 15.sp
                          ),
                          hintText: 'enter your email'
                      ),
                    ),
                  ),


                ],
              ),
            ),
          ),
            bottomNavigationBar: BottomAppBar(
              padding: EdgeInsets.zero,
              color: Colors.white,
              elevation: 0,
              child: Center(
                child: Padding(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.viewInsetsOf(context).bottom
                  ),
                  child:AppButton(txt: "Send reset password", onclick: (){
                    AccountApis.forgetpass(
                        onError: (e) {
                         showErrorMessage(e);
                        },
                        emailcontroller.text, onSuccess: (){
                      showDialog(context: context, builder: (context) => AlertDialog(
                        backgroundColor: Colors.white,
                        title: Center(
                          child: Text("A code is sent ! ",style: TextStyle(
                              color: Colors.green,
                              fontSize: 18.sp
                          ),),
                        ),
                        content: Text("Please check your mail",style: TextStyle(
                          fontSize: 17.sp,
                        ),),
                        actions: [
                          ElevatedButton(
                            onPressed: (){
                              Navigator.pushReplacementNamed(context, PassCode.routeName, arguments:emailcontroller.text);
                            },style: ElevatedButton.styleFrom(
                              backgroundColor: Colours.primaryblue
                          ), child: Text("Ok",style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.sp
                          ),),
                          )
                        ],
                      ),);

                    });
                  }, colorbtn: Colours.primaryyellow) ,
                ),
              ),
            ),),
      ],
    );
  }
}

