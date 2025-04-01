
import 'package:downcare/ReusableComponents/AppButton.dart';
import 'package:downcare/Screens/DoctorDemo/OtherDoctorsArticles.dart';
import 'package:downcare/Screens/Tabs/FeedbackSuccessDialog.dart';
import 'package:downcare/utils/Colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../Apis/ApiManager.dart';
import '../../ReusableComponents/Alert.dart';
class DoctorArticle extends StatelessWidget {
  var contentController=TextEditingController();
  static const String routeName ="doc article";
   DoctorArticle({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Article"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "We value your article!",
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: Colours.primaryblue,
                    ),
                  ),
                  Icon(Icons.sentiment_satisfied_alt_rounded,
                    color: Colors.green,
                    size: 7.w,
                  )
                ],
              ),
             
              Container(
                height: 80.h,
                margin: EdgeInsets.symmetric(vertical: 2.h),
                padding: EdgeInsets.only(left: 2.w),
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          blurRadius: 0.2,
                          offset: Offset(0, 1),
                          color: Colours.primaryyellow)
                    ],
                    color: Colours.primarygrey,
                    borderRadius: BorderRadius.circular(10)),
                child: TextField(
                  controller: contentController,
                  minLines: 1,
                  maxLines: null,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintStyle: TextStyle(fontSize: 16.sp, color: Colours.primaryblue),
                      hintText: "Write your article here"),
                ),
              ),
            ],
          ),
        ),
      ),
   bottomNavigationBar: Padding(
     padding: EdgeInsets.only(
       bottom: MediaQuery.viewInsetsOf(context).bottom
     ),
     child: BottomAppBar(
       padding: EdgeInsets.zero,
       elevation: 0,
       color: Colors.white,
       child: Column(
         children: [
           AppButton(txt: "Publish your article", onclick: (){
             ApiManager.sendArticle(contentController.text,
                        onSuccess: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return FeedbackSuccessDialog(
                              txt: "Your article published successfully!");
                        },
                      );
                    }, onError: (error) {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return Alert(
                            txt: "$error",
                            title: "Error!",
                            titleColor: Colors.red,
                          );
                        },
                      );
                    });
                  }, colorbtn: Colours.primaryyellow),
           SizedBox(height: 0.3.h),
           Row(
             mainAxisAlignment: MainAxisAlignment.center,
             children: [
               Text("if you want to read articles ",style: TextStyle(
                   fontSize: 15.sp
               ),),
               GestureDetector(
                 onTap: (){
                   Navigator.pushNamed(context, OtherDoctorsArticles.routeName);
                 },
                 child: Text(" Click here",style: TextStyle(
                     color: Colours.primaryblue,
                     fontSize: 16.sp
                 ),),
               )
             ],
           ),
         ],
       ),
     ),
   ), );
  }
}


