import 'dart:io';
import 'package:downcare/Apis/User/UserApis.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';
import '../../../Models/LoginUserModel.dart';
import '../../../Modules/AppButton.dart';
import '../../../utils/Colors.dart';
import '../../../Modules/TxtField.dart';
class DoctorEditProfile extends StatefulWidget {
  static const String routeName = "edit doctor profile";
  DoctorEditProfile({super.key});
  @override
  State<DoctorEditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<DoctorEditProfile> {
  File? _imageFile;
  final ImagePicker _picker = ImagePicker();

  final username = TextEditingController();
  final email = TextEditingController();
  final phone = TextEditingController();
  final governorate = TextEditingController();
  final bio = TextEditingController();

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
    var model = ModalRoute.of(context)!.settings.arguments as LoginUserModel?;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colours.primaryblue),
        backgroundColor: Colors.white,
        title: Text(
          "Edit Profile",
          style: TextStyle(
            fontSize: 18.sp,
            color: Colours.primaryblue,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(14.0),
        child: SingleChildScrollView(
          child: Column(

            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: GestureDetector(
                  onTap: () {
                    pickImage();
                  },
                  child: CircleAvatar(
                    radius: 80,
                    backgroundColor: Colours.primaryblue,
                    backgroundImage: _imageFile != null
                        ? FileImage(_imageFile!)
                        : (model?.imagePath != null && model!.imagePath!.isNotEmpty
                        ? NetworkImage(model.imagePath!)
                        : null) as ImageProvider<Object>?,
                    child: (_imageFile == null &&
                        (model?.imagePath == null || model!.imagePath!.isEmpty))
                        ? Icon(
                      Icons.camera_alt,
                      color: Colors.white,
                      size: 13.w,
                    )
                        : null,
                  ),
                ),
              ),
              SizedBox(height: 1.h),

              Text(
                "Username",
                style: TextStyle(color: Colours.primaryblue, fontSize: 16.sp),
              ),
              TxtField(
                hinttxt: model?.userName ?? "",
                controller: username,
                cardcolor: Colours.primarygrey,
                hintcolor: Colours.primaryblue,
                stylecolor: Colors.black,
              ),
              SizedBox(height: 1.h),

              Text(
                "Email",
                style: TextStyle(color: Colours.primaryblue, fontSize: 16.sp),
              ),
              TxtField(
                hinttxt: model?.email ?? "",
                controller: email,
                cardcolor: Colours.primarygrey,
                hintcolor: Colours.primaryblue,
                stylecolor: Colors.black,
              ),
              SizedBox(height: 1.h),

              Text(
                "Phone",
                style: TextStyle(color: Colours.primaryblue, fontSize: 16.sp),
              ),
              TxtField(
                hinttxt: model?.phone ?? "",
                controller: phone,
                cardcolor: Colours.primarygrey,
                hintcolor: Colours.primaryblue,
                stylecolor: Colors.black,
              ),
              SizedBox(height: 1.h),

              Text(
                "Governorate",
                style: TextStyle(color: Colours.primaryblue, fontSize: 16.sp),
              ),
              TxtField(
                hinttxt: model?.governorate ?? "",
                controller: governorate,
                cardcolor: Colours.primarygrey,
                hintcolor: Colours.primaryblue,
                stylecolor: Colors.black,
              ),
              SizedBox(height: 1.h),

              Text(
                "Specialization",
                style: TextStyle(color: Colours.primaryblue, fontSize: 16.sp),
              ),
              TxtField(
                hinttxt: model?.bio ?? "",
                controller: bio,
                cardcolor: Colours.primarygrey,
                hintcolor: Colours.primaryblue,
                stylecolor: Colors.black,
              ),
              SizedBox(height: 2.h),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        padding: EdgeInsets.zero,
        elevation: 0,
        color: Colors.white,
        child: Center(
          child: Padding(
            padding: EdgeInsets.only(bottom: 0.5.h),
            child: AppButton(
              txt: "Confirm",
              onclick: () {
                LoginUserModel userModel = LoginUserModel(
                  userName: username.text.isNotEmpty
                      ? username.text
                      : model?.userName ?? "",
                  email:
                  email.text.isNotEmpty ? email.text : model?.email ?? "",
                  phone:
                  phone.text.isNotEmpty ? phone.text : model?.phone ?? "",
                  governorate: governorate.text.isNotEmpty
                      ? governorate.text
                      : model?.governorate ?? "",
                  bio: bio.text.isNotEmpty ? bio.text : model?.bio ?? "not specialized",
                );

                UserApis.updateProfile(
                  userModel,
                  imageFile: _imageFile,
                  onSuccess: () {
                    setState(() {
                      model?.bio = userModel.bio;
                      model?.userName = userModel.userName;
                      model?.email = userModel.email;
                      model?.phone = userModel.phone;
                      model?.governorate = userModel.governorate;
                    });
                    showSuccessMessage("Your profile updated successfully !");
                    Navigator.pop(context, model);
                  },
                  onError: (e) {
                    showErrorMessage(e);
                  },
                );
              },
              colorbtn: Colours.primaryyellow,
            ),
          ),
        ),
      ),
    );
  }

  Future<void> pickImage() async {
    try {
      final XFile? pickedFile =
      await _picker.pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        setState(() {
          _imageFile = File(pickedFile.path);
        });
      }
    } catch (e) {
      print("Error picking image: $e");
    }
  }
}
