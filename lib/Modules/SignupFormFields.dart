import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../utils/Colors.dart';
import 'TxtField.dart';

class SignupFormFields extends StatefulWidget {
  final TextEditingController usernameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final TextEditingController phoneController;
  final TextEditingController governorateController;

  const SignupFormFields({
    super.key,
    required this.usernameController,
    required this.emailController,
    required this.passwordController,
    required this.confirmPasswordController,
    required this.phoneController,
    required this.governorateController,
  });

  @override
  State<SignupFormFields> createState() => _SignupFormFieldsState();
}

class _SignupFormFieldsState extends State<SignupFormFields> {
  bool securePassword = true;
  bool secureConfirmPassword = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TxtField(
          hinttxt: "User name",
          controller: widget.usernameController,
          cardcolor: Colours.primaryblue,
          hintcolor: Colors.white,
          stylecolor: Colors.white,
        ),
        SizedBox(height: 1.h),
        TxtField(
          hinttxt: "Email",
          controller: widget.emailController,
          cardcolor: Colours.primaryblue,
          hintcolor: Colors.white,
          stylecolor: Colors.white,
        ),
        SizedBox(height: 1.h),
        _passwordField(
          "Password",
          widget.passwordController,
          securePassword,
              () => setState(() => securePassword = !securePassword),
        ),
        SizedBox(height: 1.h),
        _passwordField(
          "Confirm Password",
          widget.confirmPasswordController,
          secureConfirmPassword,
              () => setState(() => secureConfirmPassword = !secureConfirmPassword),
        ),
        SizedBox(height: 1.h),
        TxtField(
          hinttxt: "Phone",
          controller: widget.phoneController,
          cardcolor: Colours.primaryblue,
          hintcolor: Colors.white,
          stylecolor: Colors.white,
        ),
        SizedBox(height: 1.h),
        TxtField(
          hinttxt: "Governorate",
          controller: widget.governorateController,
          cardcolor: Colours.primaryblue,
          hintcolor: Colors.white,
          stylecolor: Colors.white,
        ),
        SizedBox(height: 2.h),
      ],
    );
  }

  Widget _passwordField(String hint, TextEditingController controller, bool secure, VoidCallback toggleSecure) {
    return Container(
      decoration: BoxDecoration(
        color: Colours.primaryblue,
        borderRadius: BorderRadius.circular(20),
      ),
      padding: EdgeInsets.symmetric(horizontal: 2.w),
      child: TextFormField(
        cursorColor: Colors.white,
        cursorWidth: 1.0,
        cursorHeight: 25.0,
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
