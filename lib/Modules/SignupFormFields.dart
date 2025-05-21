import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../utils/Colors.dart';
import 'TxtField.dart';

class SignupFormFields extends StatelessWidget {
  final TextEditingController usernameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final TextEditingController phoneController;
  final TextEditingController governorateController;
  final bool secure;
  final VoidCallback toggleSecure;

  const SignupFormFields({
    super.key,
    required this.usernameController,
    required this.emailController,
    required this.passwordController,
    required this.confirmPasswordController,
    required this.phoneController,
    required this.governorateController,
    required this.secure,
    required this.toggleSecure,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TxtField(
          hinttxt: "User name",
          controller: usernameController,
          cardcolor: Colours.primaryblue,
          hintcolor: Colors.white,
          stylecolor: Colors.white,
        ),
        SizedBox(height: 1.h),
        TxtField(
          hinttxt: "Email",
          controller: emailController,
          cardcolor: Colours.primaryblue,
          hintcolor: Colors.white,
          stylecolor: Colors.white,
        ),
        SizedBox(height: 1.h),
        _passwordField("Password", passwordController),
        SizedBox(height: 1.h),
        _passwordField("Confirm Password", confirmPasswordController),
        SizedBox(height: 1.h),
        TxtField(
          hinttxt: "Phone",
          controller: phoneController,
          cardcolor: Colours.primaryblue,
          hintcolor: Colors.white,
          stylecolor: Colors.white,
        ),
        SizedBox(height: 1.h),
        TxtField(
          hinttxt: "Governorate",
          controller: governorateController,
          cardcolor: Colours.primaryblue,
          hintcolor: Colors.white,
          stylecolor: Colors.white,
        ),
        SizedBox(height: 2.h),
      ],
    );
  }

  Widget _passwordField(String hint, TextEditingController controller) {
    return Container(
      decoration: BoxDecoration(
        color: Colours.primaryblue,
        borderRadius: BorderRadius.circular(20),
      ),
      padding: EdgeInsets.symmetric(horizontal: 2.w),
      child: TextFormField(
        obscureText: secure,
        style: TextStyle(fontSize: 16.sp, color: Colors.white),
        controller: controller,
        decoration: InputDecoration(
          suffixIcon: IconButton(
            onPressed: toggleSecure,
            icon: Icon(
              secure ? Icons.visibility : Icons.visibility_off,
              color: Colors.white,
            ),
          ),
          border: InputBorder.none,
          hintStyle: TextStyle(fontSize: 16.sp, color: Colors.white),
          hintText: hint,
        ),
      ),
    );
  }
}
