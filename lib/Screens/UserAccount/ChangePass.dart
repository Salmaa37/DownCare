import 'package:downcare/Apis/ApiManager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../ReusableComponents/Alert.dart';
import '../../utils/Colors.dart';
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
                  showDialog(
                    context: context,
                    builder: (context) => Alert(txt: "All fields are required ", title: "Error!", titleColor: Colors.red),
                  );
                  return;
                }

                if (newPass != confirmPass) {
                  showDialog(
                    context: context,
                    builder: (context) => Alert(txt: "Password and Confirmpassword doesn't match !", title: "Error!", titleColor: Colors.red),
                  );
                  return;
                }

                ApiManager.ChangePass(
                  currentPass, newPass, confirmPass,
                  onError: (e) {
                    showDialog(
                      context: context,
                      builder: (context) => Alert(txt: "$e", title: "Error", titleColor: Colors.red),
                    );
                  },
                  onSuccess: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Center(
                          child: Text(
                            "Your Password Changed Successfully!",
                            style: TextStyle(color: Colors.green, fontSize: 18.sp),
                          ),
                        ),
                        actions: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(backgroundColor: Colours.primaryblue),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text("Ok", style: TextStyle(color: Colors.white)),
                          )
                        ],
                      ),
                    );
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
