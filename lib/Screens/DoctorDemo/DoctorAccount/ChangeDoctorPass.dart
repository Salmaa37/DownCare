import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../../Apis/Account/AccountApis.dart';
import '../../../Apis/User/UserApis.dart';
import '../../../utils/Colors.dart';
import '../../../Modules/PasswordFieldWidget.dart';
import '../../MomDemo/MomSection/MomAccount/ChangePass.dart';

class ChangeDoctorPass extends StatefulWidget {
  static const String routeName = "change pass";
  const ChangeDoctorPass({super.key});

  @override
  State<ChangeDoctorPass> createState() => _ChangePassState();
}

class _ChangePassState extends State<ChangeDoctorPass> {
  bool secure1 = true;
  bool secure2 = true;
  bool secure3 = true;

  final currentPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmNewPasswordController = TextEditingController();
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
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: Text("Change Your Password")),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 1.2.h),
              PasswordFieldWidget(
                label: "Current Password",
                controller: currentPasswordController,
                isSecure: secure1,
                toggleSecure: () => setState(() => secure1 = !secure1),
              ),
              PasswordFieldWidget(
                label: "New Password",
                controller: newPasswordController,
                isSecure: secure2,
                toggleSecure: () => setState(() => secure2 = !secure2),
              ),
              PasswordFieldWidget(
                label: "Confirm New Password",
                controller: confirmNewPasswordController,
                isSecure: secure3,
                toggleSecure: () => setState(() => secure3 = !secure3),
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
                 showErrorMessage("All fields are required");
                  return;
                }

                if (newPass != confirmPass) {
                 showErrorMessage("Password and Confirm Password don't match!");
                  return;
                }

               AccountApis.ChangePass(
                  currentPass,
                  newPass,
                  confirmPass,
                  onError: (e) {
                   showErrorMessage(e);
                  },
                  onSuccess: () {
                   showSuccessMessage("Your Password Changed Successfully ! ");
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
}
