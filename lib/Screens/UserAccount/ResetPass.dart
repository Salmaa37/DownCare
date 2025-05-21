import 'package:downcare/Apis/Account/AccountApis.dart';
import 'package:downcare/Models/PassModel.dart';
import 'package:downcare/Modules/AppButton.dart';
import 'package:downcare/utils/AppImages.dart';
import 'package:downcare/utils/Colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'Login.dart';
class ResetPass extends StatefulWidget {
  static const String routeName="reset pass";
   ResetPass({super.key});
  @override
  State<ResetPass> createState() => _ResetPassState();
}
class _ResetPassState extends State<ResetPass> {
  bool secure = true;
  var passcontroller =TextEditingController();
  var confirmpasscontroller =TextEditingController();
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
  void showSuccessMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: TextStyle(fontSize: 14.sp, color: Colors.white),
        ),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.only(top: 5.h, left: 2.w, right: 2.w),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    var model =(ModalRoute.of(context)?.settings.arguments as PassModel?)??null ;
    return Stack(
      children: [
        Image.asset("${AppImages.forgotpass}",
          fit: BoxFit.fill,
          width: double.infinity,
        ),
        Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: Colors.transparent,
          body: Padding(
            padding:  EdgeInsets.all(15.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height:MediaQuery.of(context).size.height*0.04 ,
                  ),
                  Text("Reset Password",style: TextStyle(
                      color: Colours.primaryblue,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w400
                  ),),
                  SizedBox(
                    height: MediaQuery.of(context).size.height*0.1,
                  ),
                  Text("Password",style: TextStyle(
                      color: Colours.primaryblue,
                      fontSize: 16.sp
                  ),),
                  Container(
                    padding: EdgeInsets.symmetric(
                        vertical: 0.5.h,
                        horizontal: 2.w
                    ),
                    margin: EdgeInsets.only(
                        top: 1.h,
                      bottom: 2.h
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
                      obscureText: secure,
                      controller: passcontroller,
                      decoration: InputDecoration(
                          suffixIcon: IconButton(onPressed: (){
                            secure? Icons.visibility : Icons.visibility_off;
                            setState(() {
                              secure = !secure;
                            });
                          }, icon: Icon(Icons.remove_red_eye_outlined,color: Colors.white,)),
                          border: InputBorder.none,
                          hintStyle: TextStyle(
                              color: Colors.white,
                              fontSize: 15.sp
                          ),
                          hintText: 'enter your password'
                      ),
                    ),
                  ),
                  Text("Confirm password",style: TextStyle(
                      color: Colours.primaryblue,
                      fontSize: 16.sp
                  ),),
                  Container(
                    padding: EdgeInsets.symmetric(
                        vertical: 0.5.w,
                        horizontal: 2.h
                    ),
                    margin: EdgeInsets.only(
                        top: 1.h
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
                      obscureText: true,
                      controller: confirmpasscontroller,
                      decoration: InputDecoration(
                          suffixIcon: IconButton(onPressed: (){
                            secure? Icons.visibility : Icons.visibility_off;
                            setState(() {
                              secure = !secure;
                            });
                          }, icon: Icon(Icons.remove_red_eye_outlined,color: Colors.white,)),
                          border: InputBorder.none,
                          hintStyle: TextStyle(
                              color: Colors.white,
                              fontSize: 15.sp
                          ),
                          hintText: 'confirm your password'
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        bottomNavigationBar: BottomAppBar(
          color: Colors.white,
          padding: EdgeInsets.zero,
          elevation: 0,
          child: Center(
            child: Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.viewInsetsOf(context).bottom
              ),
              child: AppButton(txt: "Reset Password", onclick: (){
                AccountApis.resetpass(
                    onError: (e) {
                      showErrorMessage(e);
                    },
                    model?.email??"", model?.code??"", passcontroller.text, confirmpasscontroller.text, onSuccess: (){
                      showSuccessMessage("You Password Reset Successfully !");
                  Navigator.pushNamed(context,Login.routeName);
                });
              }, colorbtn: Colours.primaryyellow),
            ),
          ),
        ),),
      ],
    );
  }
}