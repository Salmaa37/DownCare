import 'package:downcare/Apis/Account/AccountApis.dart';
import 'package:downcare/Apis/User/UserApis.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../../../utils/Colors.dart';
class ChangePass extends StatefulWidget {
  static const String routeName = "change password";
  ChangePass({super.key});
  @override
  State<ChangePass> createState() => _ChangePassState();
}
class _ChangePassState extends State<ChangePass> {
  bool secure1 = true;
  bool secure2 = true;
  bool secure3 = true;
  var currentPasswordController = TextEditingController();
  var newPasswordController = TextEditingController();
  var confirmNewPasswordController = TextEditingController();
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
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Change Your Password"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            spacing: 2.h,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 1.2.h),
              buildPasswordField("Current Password", currentPasswordController, secure1, () {
                setState(() {
                  secure1 = !secure1;
                });
              }),
              buildPasswordField("New Password", newPasswordController, secure2, () {
                setState(() {
                  secure2 = !secure2;
                });
              }),
              buildPasswordField("Confirm New Password", confirmNewPasswordController, secure3, () {
                setState(() {
                  secure3 = !secure3;
                });
              }),
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
            padding: EdgeInsets.only(bottom: 0.5.h),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(
                  vertical: 1.5.h,
                  horizontal: MediaQuery.of(context).size.width * 0.4,
                ),
                backgroundColor: Colours.primaryyellow,
              ),
              onPressed: () {
                String currentPass = currentPasswordController.text.trim();
                String newPass = newPasswordController.text.trim();
                String confirmPass = confirmNewPasswordController.text.trim();

                if (currentPass.isEmpty || newPass.isEmpty || confirmPass.isEmpty) {
                showErrorMessage("All fields are required ");
                  return;
                }

                if (newPass != confirmPass) {
                 showErrorMessage("Password and Confirmpassword doesn't match !");
                  return;
                }

                AccountApis.ChangePass(
                  currentPass, newPass, confirmPass,
                  onError: (e) {
                   showErrorMessage(e);
                  },
                  onSuccess: () {
                   showSuccessMessage("Your Password Changed Successfully !");
                  },
                );
              },
              child: Text("Confirm", style: TextStyle(color: Colours.primaryblue, fontSize: 16.sp)),
            ),
          ),
        ),
      ),
    );
  }
  Widget buildPasswordField(String label, TextEditingController controller, bool isSecure, VoidCallback toggleSecure) {
    return Column(
      spacing: 2.h,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(color: Colours.primaryblue, fontSize: 16.sp)),
        Container(
          padding: EdgeInsets.only(left: 2.w),
          decoration: BoxDecoration(color: Colours.primarygrey, borderRadius: BorderRadius.circular(20)),
          child: TextField(
            controller: controller,
            obscureText: isSecure,
            decoration: InputDecoration(
              suffixIcon: IconButton(onPressed: toggleSecure, icon: Icon(isSecure ? Icons.visibility : Icons.visibility_off, color: Colours.primaryblue)),
              border: InputBorder.none,
            ),
          ),
        ),
      ],
    );
  }
}
