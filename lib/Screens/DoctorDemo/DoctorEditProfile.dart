import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';

import '../../ReusableComponents/AppButton.dart';
import '../../utils/Colors.dart';
import '../UserAccount/TxtField.dart';

class DoctorEditProfile extends StatefulWidget {
  static const String routeName="editDocProfile";
   DoctorEditProfile({super.key});

  @override
  State<DoctorEditProfile> createState() => _DoctorEditProfileState();
}

class _DoctorEditProfileState extends State<DoctorEditProfile> {
  File? _imageFile;

  final username=TextEditingController();

  final email =TextEditingController();

  final phone=TextEditingController();

  final governorate=TextEditingController();

  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
            color: Colours.primaryblue
        ),

        title: Text("Edit Profile",style: TextStyle(
          fontSize: 18.sp,
          color: Colours.primaryblue,
        ),),
      ),
      body: Padding(
        padding: const EdgeInsets.all(14.0),
        child: SingleChildScrollView(
          child: Column(
            spacing: 1.h,
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
                    backgroundImage: _imageFile != null ? FileImage(_imageFile!) : null, // لا توجد صورة افتراضية
                    child: _imageFile == null
                        ? Icon(Icons.camera_alt,color: Colors.white,size: 13.w,)
                        : null,
                  )
                  ,
                ),
              ),
              Text("Username",style: TextStyle(
                  color: Colours.primaryblue,
                  fontSize: 16.sp
              ),),
              TxtField(hinttxt: "Amal Ali", controller: username,cardcolor: Colours.primarygrey,hintcolor: Colours.primaryblue,stylecolor: Colors.black,),
              Text("Email",style: TextStyle(
                  color: Colours.primaryblue,
                  fontSize: 16.sp
              ),),
              TxtField(hinttxt: "alaa@gmail.com", controller: email,cardcolor: Colours.primarygrey,hintcolor: Colours.primaryblue,stylecolor: Colors.black,),
              Text("Phone",style: TextStyle(
                  color: Colours.primaryblue,
                  fontSize: 16.sp
              ),),
              TxtField(hinttxt: "7893241", controller: phone,cardcolor: Colours.primarygrey,hintcolor: Colours.primaryblue,stylecolor: Colors.black,),
              Text("Governorate",style: TextStyle(
                  color: Colours.primaryblue,
                  fontSize: 16.sp
              ),),
              TxtField(hinttxt: "Giza", controller: governorate,cardcolor: Colours.primarygrey,hintcolor:
              Colours.primaryblue,stylecolor: Colors.black,),
              Text("Specialization",style: TextStyle(
                  color: Colours.primaryblue,
                  fontSize: 16.sp
              ),),
              TxtField(hinttxt: "Heart disease", controller: governorate,cardcolor: Colours.primarygrey,hintcolor:
              Colours.primaryblue,stylecolor: Colors.black,)
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        padding: EdgeInsets.zero,
        elevation: 0,
        color: Colors.white,
        child:  Center(
          child: Padding(
            padding: EdgeInsets.only(
                bottom: 0.5.h
            ),
            child: AppButton(txt: "Confirm", onclick: (){
              Navigator.pop(context);
            }, colorbtn: Colours.primaryyellow),
          ),
        ),
      ), );
  }
  Future<void> pickImage() async {
    try {
      final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);

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
