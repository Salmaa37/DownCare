import 'package:downcare/Apis/ApiManager.dart';
import 'package:downcare/Models/Child.dart';
import 'package:downcare/Screens/MomDemo/ChildSection/ChildSection.dart';
import 'package:downcare/utils/Colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import '../../../ReusableComponents/Alert.dart';
class ChildData extends StatefulWidget {
  static const String routeName="child data";
  ChildData ({super.key});

  @override
  State<ChildData> createState() => _ChildDataState();
}

class _ChildDataState extends State<ChildData> {
  String gender ="";
  var namecontroller=TextEditingController();

  var agecontroller=TextEditingController();

  var datecontroller=TextEditingController();

  var gendercontroller=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Your Child Info"),
      ),
      body: Padding(
        padding:  EdgeInsets.all(12.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 1.8.h,
            children: [
              Text("Please fill this form",style: TextStyle(
                color: Colours.primaryblue,
                fontSize: 17.sp
              ),),
              SizedBox(height: 2.h,),
              Text("Child name ",style: TextStyle(
                color: Colours.primaryblue,
                fontSize: 16.sp
              ),),
              Container(
                padding: EdgeInsets.only(
                  left: 2.w
                ),
                decoration: BoxDecoration(
                   color: Colours.primarygrey,
                 borderRadius: BorderRadius.circular(20)
                ),
                child: TextField(
                  controller: namecontroller,
                  decoration: InputDecoration(
                    border: InputBorder.none
                  ),
                ),
              ),
              Text("Age ",style: TextStyle(
                  color: Colours.primaryblue,
                  fontSize: 16.sp
              ),),
              Container(
                padding: EdgeInsets.only(
                    left: 2.w
                ),
                decoration: BoxDecoration(
                    color: Colours.primarygrey,
                    borderRadius: BorderRadius.circular(20)
                ),

                child: TextField(
                  controller: agecontroller,
                  decoration: InputDecoration(
                      border: InputBorder.none
                  ),
                ),
              ),
              Text("Diagnosis date ",style: TextStyle(
                  color: Colours.primaryblue,
                  fontSize: 16.sp
              ),),
              Container(
                padding: EdgeInsets.only(
                    left: 2.w
                ),
                decoration: BoxDecoration(
                    color: Colours.primarygrey,
                    borderRadius: BorderRadius.circular(20)
                ),

                child: TextField(
                  controller: datecontroller,
                  decoration: InputDecoration(
                      border: InputBorder.none
                  ),
                ),
              ),
              Text("Gender ",style: TextStyle(
                  color: Colours.primaryblue,
                  fontSize: 16.sp
              ),),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: () {
                   gender="male";
                   setState(() {

                   });
                    },
                    child: Column(
                      children: [
                        Image.asset("assets/images/male.jpg",width: 20.w,),
                        Text("Male",style: TextStyle(
                          fontSize: 17.sp,
                          color: Colours.primaryblue
                        ),)
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                   gender="female";
                   setState(() {

                   });
                    },
                    child: Column(
                      children: [
                        Image.asset("assets/images/female.jpg",width: 20.w,),
                        Text("Female",style: TextStyle(
                            fontSize: 17.sp,
                            color: Colours.primaryblue
                        ),)
                      ],
                    ),
                  )
                ],
              )
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
                bottom: 0.5.h
            ),
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(
                        vertical: 1.5.h,
                        horizontal: MediaQuery.of(context).size.width*0.4
                    ),
                    backgroundColor: Colours.primaryyellow
                ),
                onPressed: (){
                  ChildModel child =ChildModel(name: namecontroller.text,
                      gender: gender,
                      age: int.parse(agecontroller.text),
                      date: datecontroller.text);
                ApiManager.AddChild(child, onSuccess: ()async{
                  SharedPreferences prefs = await SharedPreferences.getInstance();
                  await prefs.setBool("isChildAdded", true);
                  bool? isChildAdded = prefs.getBool("isChildAdded");
                  print("After saving: isChildAdded = $isChildAdded");
                  if (mounted) {
                    Navigator.pushReplacementNamed(context, ChildSection.routeName);
                  }
                }, onError:(e){
               showDialog(context: context, builder: (context) {
                 return Alert(txt: "$e", title: 'Error', titleColor: Colors.red,);
               },);
             });
                }, child: Text("START",style: TextStyle(
                color: Colours.primaryblue,
                fontSize: 16.sp
            ),)),
          ),
        ),
      ),);
  }
}
