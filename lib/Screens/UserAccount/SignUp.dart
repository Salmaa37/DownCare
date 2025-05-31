import 'package:downcare/Apis/Account/AccountApis.dart';
import 'package:downcare/Models/UserModel.dart';
import 'package:downcare/Modules/LoginBtn.dart';
import 'package:downcare/Modules/TxtField.dart';
import 'package:downcare/utils/AppImages.dart';
import 'package:downcare/utils/Colors.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'Login.dart';
import '../../Modules/RoleSelector.dart';
import '../../Modules/SignupFormFields.dart';

class SignUp extends StatefulWidget {
  static const String routeName = "signup";
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  String selectedRole = "";
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final phoneController = TextEditingController();
  final governorateController = TextEditingController();

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
    return Stack(
      children: [
        Image.asset(
          AppImages.loginbg,
          fit: BoxFit.fill,
          width: double.infinity,
        ),
        Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: Colors.transparent,
          body: Padding(
            padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 2.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: "SIGN UP\n ",
                        style: TextStyle(
                            color: Colours.primaryblue, fontSize: 25.sp),
                      ),
                      TextSpan(
                        text: 'with DownCare',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 15.sp,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 15.h),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SignupFormFields(
                          usernameController: usernameController,
                          emailController: emailController,
                          passwordController: passwordController,
                          confirmPasswordController: confirmPasswordController,
                          phoneController: phoneController,
                          governorateController: governorateController,
                        ),
                        RoleSelector(
                          selectedRole: selectedRole,
                          onRoleSelected: (role) => setState(() => selectedRole = role),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          bottomNavigationBar: Padding(
            padding: EdgeInsets.only(bottom: 1.h),
            child: BottomAppBar(
              color: Colors.white,
              padding: EdgeInsets.zero,
              elevation: 0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  LoginBtn(
                    txt: "Confirm",
                    onclick: () {
                      String username = usernameController.text.trim();
                      String email = emailController.text.trim();
                      String password = passwordController.text.trim();
                      String confirmPassword = confirmPasswordController.text.trim();
                      String phone = phoneController.text.trim();
                      String governorate = governorateController.text.trim();
                      String role = selectedRole.trim();
                      if(username.isEmpty &&email.isEmpty && password.isEmpty &&confirmPassword.isEmpty &&phone.isEmpty &&role.isEmpty &&governorate.isEmpty ){
                        return showErrorMessage("All Fields are required !");
                      }

                      UserModel usermodel = UserModel(
                        userName: usernameController.text,
                        email: emailController.text,
                        governorate: governorateController.text,
                        role: selectedRole,
                        phone: phoneController.text,
                      );

                      AccountApis.signUpUser(
                        usermodel,
                        password: passwordController.text,
                        Confirmpassword: confirmPasswordController.text,
                        onsuccess: (selectedRole) {
                          showSuccessMessage("Account created successfully! Please check your email.");
                        },
                        onError: (error) {
                          showErrorMessage(error);
                        },
                      );
                    },
                  ),
                  SizedBox(height: 0.3.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("if you have an account ", style: TextStyle(fontSize: 16.sp)),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, Login.routeName, arguments: selectedRole);
                        },
                        child: Text(
                          "LOG IN ",
                          style: TextStyle(color: Colours.primaryblue, fontSize: 17.sp),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
