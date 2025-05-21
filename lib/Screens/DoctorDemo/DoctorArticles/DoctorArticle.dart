
import 'package:downcare/Modules/AppButton.dart';
import 'package:downcare/Screens/DoctorDemo/DoctorArticles/OtherDoctorsArticles.dart';
import 'package:downcare/utils/Colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../../Apis/Article/ArticleApis.dart';
class DoctorArticle extends StatefulWidget {
  static const String routeName ="doc article";
   DoctorArticle({super.key});
  @override
  State<DoctorArticle> createState() => _DoctorArticleState();
}
class _DoctorArticleState extends State<DoctorArticle> {
  var contentController=TextEditingController();

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
             ArticleApis.sendArticle(contentController.text,
                        onSuccess: () {
                    showSuccessMessage("Your Article Published Successfully !");
                    }, onError: (error) {
                     showErrorMessage(error);
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


