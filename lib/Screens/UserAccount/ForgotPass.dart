
import 'package:downcare/Apis/ApiManager.dart';
import 'package:downcare/ReusableComponents/AppButton.dart';

import 'package:downcare/utils/AppImages.dart';
import 'package:downcare/utils/Colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../ReusableComponents/Alert.dart';
import 'PassCode.dart';


class ForgotPass extends StatelessWidget {
  var emailcontroller=TextEditingController();
  static const String routeName="forgot pass";
  ForgotPass({super.key});

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
                    ApiManager.forgetpass(
                        onError: (e) {
                          showDialog(context: context, builder: (context) {
                            return Alert(txt: "$e",title: "Error!",titleColor: Colors.red,);
                          },);
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
                            }, child: Text("Ok",style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.sp
                          ),),style: ElevatedButton.styleFrom(
                              backgroundColor: Colours.primaryblue
                          ),
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

