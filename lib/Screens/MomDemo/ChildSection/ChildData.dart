import 'package:downcare/Apis/Child/ChildApis.dart';
import 'package:downcare/Models/Child.dart';
import 'package:downcare/Screens/MomDemo/ChildSection/ChildSection.dart';
import 'package:downcare/utils/Colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import '../../../Modules/GenderOption.dart';
import '../../../Modules/InputField.dart';
import '../../../Modules/LabelText.dart';
class ChildData extends StatefulWidget {
  static const String routeName = "child form";
  const ChildData({super.key});
  @override
  State<ChildData> createState() => _ChildDataState();
}
class _ChildDataState extends State<ChildData> {
  String gender = "";
  var namecontroller = TextEditingController();
  var agecontroller = TextEditingController();
  var datecontroller = TextEditingController();
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

  Future<void> _selectDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      String formattedDate = DateFormat('yyyy-MM-dd').format(picked);
      setState(() {
        datecontroller.text = formattedDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: Text("Your Child Info")),
      body: Padding(
        padding: EdgeInsets.all(12.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Please fill this form", style: TextStyle(color: Colours.primaryblue, fontSize: 17.sp)),
              SizedBox(height: 2.h),
              LabelText("Child name"),
              InputField(controller: namecontroller),
              LabelText("Age"),
              InputField(controller: agecontroller),
              LabelText("Diagnosis date"),
              Container(
                padding: EdgeInsets.only(left: 2.w),
                decoration: BoxDecoration(
                  color: Colours.primarygrey,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: TextField(
                  controller: datecontroller,
                  readOnly: true,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "YYYY-MM-DD",
                    suffixIcon: IconButton(
                      icon: Icon(Icons.calendar_today, color: Colours.primaryblue),
                      onPressed: _selectDate,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 2.h),
              LabelText("Gender"),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GenderOption(
                    value: "male",
                    imagePath: "assets/images/male.jpg",
                    label: "Male",
                    selectedGender: gender,
                    onSelect: (val) => setState(() => gender = val),
                  ),
                  GenderOption(
                    value: "female",
                    imagePath: "assets/images/female.jpg",
                    label: "Female",
                    selectedGender: gender,
                    onSelect: (val) => setState(() => gender = val),
                  ),
                ],
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
                String childName = namecontroller.text.trim();
                String date = datecontroller.text.trim();
                String childGender = gender.trim();

                if (childName.isEmpty) {
                  return showErrorMessage("Child name is required !");
                }
                if (agecontroller.text.isEmpty) {
                  return showErrorMessage("Child age is required !");
                }
                if (date.isEmpty) {
                  return showErrorMessage("Diagnosis date is required !");
                }
                if (childGender.isEmpty) {
                  return showErrorMessage("Gender is required !");
                }

                int age = int.tryParse(agecontroller.text) ?? 0;
                if (age == 0) {
                  return showErrorMessage("Enter a valid age!");
                }

                ChildModel child = ChildModel(
                  name: childName,
                  gender: childGender,
                  age: age,
                  date: date,
                );

                ChildApis.AddChild(
                  child,
                  onSuccess: () async {
                    SharedPreferences prefs = await SharedPreferences.getInstance();
                    await prefs.setBool("isChildAdded", true);
                    if (mounted) {
                      showSuccessMessage("Your Child Added Successfully !");
                      Navigator.pushReplacementNamed(context, ChildSection.routeName);
                    }
                  },
                  onError: (e) {
                    showErrorMessage(e);
                  },
                );
              },
              child: Text("START", style: TextStyle(color: Colours.primaryblue, fontSize: 16.sp)),
            ),
          ),
        ),
      ),
    );
  }
}
