import 'package:downcare/Apis/Account/AccountApis.dart';
import 'package:downcare/Models/PassModel.dart';
import 'package:downcare/Modules/AppButton.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../utils/AppImages.dart';
import '../../utils/Colors.dart';
import 'ResetPass.dart';
class PassCode extends StatefulWidget {
  static const String routeName="code";
   PassCode({super.key});

  @override
  State<PassCode> createState() => _PassCodeState();
}

class _PassCodeState extends State<PassCode> {
  var codecontroller =TextEditingController();
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
    var email = (ModalRoute.of(context)?.settings.arguments as String?) ?? "";
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
                  Text("Enter Your Code",style: TextStyle(
                      color: Colours.primaryblue,
                      fontSize: 21.sp,
                      fontWeight: FontWeight.w400
                  ),),
                  SizedBox(
                    height: MediaQuery.of(context).size.height*0.1,
                  ),

                  Text("Code",style: TextStyle(
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
                      cursorColor: Colors.white,
                      cursorWidth: 1.0,
                      cursorHeight: 25.0,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.sp
                      ),
                    controller:codecontroller ,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintStyle: TextStyle(
                              color: Colors.white,
                              fontSize: 15.sp
                          ),
                          hintText: 'enter your code'
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
                child: AppButton(txt: "Confirm", onclick: (){
                  AccountApis.code(
                      onError: (e) {
                        showErrorMessage(e);
                      },
                      email, codecontroller.text, onSuccess: (){
                    PassModel passmodel =PassModel(email, codecontroller.text);
                    Navigator.pushReplacementNamed(context,ResetPass.routeName,arguments: passmodel);
                  });
                }, colorbtn: Colours.primaryyellow),
              ),
            ),
          ),),
      ],
    );
  }
}
