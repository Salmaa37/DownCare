import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

import '../../../utils/Colors.dart';

class ChildReport extends StatelessWidget {
  static const String routeName="childreport";
  const ChildReport({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Child Report"),
      ),
      body:Padding(
        padding: const EdgeInsets.all(12.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 4.h,
            children: [
              Text("Child name : Hamza",style: TextStyle(
                fontSize: 17.sp
              ),),
              Text("Age: 10 years old",style: TextStyle(
                  fontSize: 17.sp
              ),),
              Text("Gender : male",style: TextStyle(
                  fontSize: 17.sp
              ),),
              Text("Date of diagnosis : 2020-02-02",style: TextStyle(
                  fontSize: 17.sp
              ),),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Communication Skills Level"),
                  Text("70%",style: TextStyle(
                      color: Colors.orange
                  ),)
                ],
              ),
              StepProgressIndicator(
                totalSteps: 100,
                currentStep: 70,
                size: 6.w,
                padding: 0,
                selectedColor: Colours.primaryblue,
                unselectedColor: Colours.primarygrey,
                roundedEdges: Radius.circular(20),

              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Linguistics Skills Level"),
                  Text("70%",style: TextStyle(
                      color: Colors.orange
                  ),)
                ],
              ),
              StepProgressIndicator(
                totalSteps: 100,
                currentStep: 70,
                size: 6.w,
                padding: 0,
                selectedColor: Colours.primaryblue,
                unselectedColor: Colours.primarygrey,
                roundedEdges: Radius.circular(20),

              ),
              SizedBox(
                height: 1.h,
              ),
              Center(
                child: Text("Your Child Communication Score",style: TextStyle(
                  fontSize: 17.sp
                ),),
              ),
              Container(
                padding: EdgeInsets.all(20),
                height: 50.h,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                        color: Colors.grey
                    )
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("One Word "),
                        Text("70%",style: TextStyle(
                            color: Colors.green
                        ),)
                      ],
                    ),
                    StepProgressIndicator(
                      totalSteps: 100,
                      currentStep: 70,
                      size: 6.w,
                      padding: 0,
                      selectedColor: Colours.primaryblue,
                      unselectedColor: Colours.primarygrey,
                      roundedEdges: Radius.circular(20),

                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Two Word "),
                        Text("30%",style: TextStyle(
                            color: Color(0xffC23F33)
                        ),)
                      ],
                    ),
                    StepProgressIndicator(
                      totalSteps: 100,
                      currentStep: 30,
                      size: 6.w,
                      padding: 0,
                      selectedColor: Colours.primaryblue,
                      unselectedColor: Colours.primarygrey,
                      roundedEdges: Radius.circular(20),

                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Three Word "),
                        Text("30%",style: TextStyle(
                            color: Color(0xffC23F33)
                        ),)
                      ],
                    ),
                    StepProgressIndicator(
                      totalSteps: 100,
                      currentStep: 30,
                      size: 6.w,
                      padding: 0,
                      selectedColor: Colours.primaryblue,
                      unselectedColor: Colours.primarygrey,
                      roundedEdges: Radius.circular(20),

                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Four Word "),
                        Text("30%",style: TextStyle(
                            color: Color(0xffC23F33)
                        ),)
                      ],
                    ),
                    StepProgressIndicator(
                      totalSteps: 100,
                      currentStep: 30,
                      size: 6.w,
                      padding: 0,
                      selectedColor: Colours.primaryblue,
                      unselectedColor: Colours.primarygrey,
                      roundedEdges: Radius.circular(20),

                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Five Word "),
                        Text("30%",style: TextStyle(
                            color: Color(0xffC23F33)
                        ),)
                      ],
                    ),
                    StepProgressIndicator(
                      totalSteps: 100,
                      currentStep: 30,
                      size: 6.w,
                      padding: 0,
                      selectedColor: Colours.primaryblue,
                      unselectedColor: Colours.primarygrey,
                      roundedEdges: Radius.circular(20),

                    )
                  ],
                ),
              )
            ],

          ),
        ),
      ) ,
    );
  }
}
