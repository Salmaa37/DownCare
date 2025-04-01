import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import '../../../../utils/Colors.dart';
import 'SectionLevels.dart';
  class TestResult extends StatelessWidget {
  static const String routeName="test result";
  const TestResult({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Child Score"),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(14.0),
            child: Column(
              spacing: 5.h,
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    CircularStepProgressIndicator(
                      totalSteps: 100,
                      currentStep: 30,
                      stepSize: 10,
                      selectedColor: Color(0xffC23F33),
                      unselectedColor: Colors.grey[200],
                      padding: 0,
                      width: 150,
                      height: 150,
                      selectedStepSize: 15,
                      roundedCap: (_, __) => true,
                    ),
                    Text("30%",style: TextStyle(
                      color: Color(0xffC23F33),
                      fontSize: 20.sp
                    ),),
                  ],
                ),
                Text("Hard Luck to your child, he can’t pass \n the test . Click here and repeat the same\n level",style: TextStyle(
                  height: 0.25.h,
                  fontSize: 16.sp
                ),),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(
                            vertical: 2.h,
                            horizontal: 30.w

                        ),
                        backgroundColor: Colours.primaryyellow
                    ),
                    onPressed: (){
                Navigator.pushNamed(context, SectionLevels.routeName);
                    }, child: Text("Get Started",style: TextStyle(
                  color: Colours.primaryblue,
                  fontSize: 16.sp,

                ),)),
                Text("Your Child Score",style: TextStyle(
                  color: Colours.primaryblue,
                  fontSize: 16.sp

                ),),
                Container(
                  padding: EdgeInsets.all(20),
                  height: 25.h,
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
                        Text("Correct Answer "),
                        Text("30%",style: TextStyle(
                          color: Colors.green
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
                        Text("Wrong Answer "),
                        Text("70%",style: TextStyle(
                            color: Color(0xffC23F33)
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
                  ],
                ),
                )

              ],
            ),
          ),
        ),
      ),
    );
  }
}
