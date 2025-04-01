import 'package:downcare/Apis/ApiManager.dart';
import 'package:downcare/ReusableComponents/AppButton.dart';
import 'package:downcare/Screens/Tabs/FeedbackSuccessDialog.dart';
import 'package:downcare/utils/Colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../ReusableComponents/Alert.dart';
import '../MomDemo/MomSection/Feedbacks.dart';
class FeedbackTab extends StatelessWidget {
  final feedbackController=TextEditingController();
  FeedbackTab({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "We value your feedback!",
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
            SizedBox(height: 3.h),
           Expanded(
             child: Container(
               padding: EdgeInsets.only(
                 left: 2.w
               ),
               decoration: BoxDecoration(
                 color: Colours.primarygrey,
                 borderRadius: BorderRadius.circular(10),
               ),
               child: TextField(
                 controller: feedbackController,
                 maxLines: null,
                 minLines: 1,
                 decoration: InputDecoration(
                   border: InputBorder.none,
                   hintStyle: TextStyle(
                     fontSize: 16.sp,
                     color: Colours.primaryblue
                   ),
                   hintText: "Write your feedback here "
                 ),
               ),
             ),
           ),
            SizedBox(
              height:15.h ,
            ),
            Column(
              children: [
                AppButton(txt: "Publish your feedback",colorbtn: Colours.primaryyellow, onclick: (){
                  ApiManager.SendFeedback(
                      feedbackController.text, onSuccess: (){
                    showDialog(context: context, builder: (context) =>FeedbackSuccessDialog( txt: "Your feedback published successfully!",) );

                  },onError: (error){
                    showDialog(context: context, builder: (context) {
                      return Alert(txt: "$error",title: "Error!",titleColor: Colors.red,);
                    },);
                  });
                }),
                SizedBox(height: 1.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("if you want to read feedbacks ",style: TextStyle(
                        fontSize: 15.sp
                    ),),
                    GestureDetector(
                      onTap: (){
                        Navigator.pushNamed(context, Feedbacks.routeName);
                      },
                      child: Text("Click here",style: TextStyle(
                          color: Colours.primaryblue,
                          fontSize: 16.sp
                      ),),
                    )
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}