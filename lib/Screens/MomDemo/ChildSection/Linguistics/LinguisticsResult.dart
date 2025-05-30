import 'dart:ui';
import 'package:downcare/Apis/Child/ChildApis.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

import '../../../../utils/Colors.dart';

class LinguisticsResult extends StatelessWidget {
  static const String routeName = "result";

  LinguisticsResult({Key? key}) : super(key: key);

  Future<void> sendResultToApi(int score, String level) async {
    bool result = await ChildApis.updateScore(
      type: "linguistics",
      level: level,
      score: score,
    );

    if (result) {

      print("Score sent successfully");
    } else {

      print("Failed to send score");
    }
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments as Map<String, String?>;

    final int score = int.tryParse(args["score"] ?? "0") ?? 0;
    final String level = args["level"] ?? "linguistics";

    Future.microtask(() {
      sendResultToApi(score, level);
    });

    int correctPercent = score;
    int wrongPercent = 100 - score;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Your child Score"),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(14.0),
            child: Column(
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    CircularStepProgressIndicator(
                      totalSteps: 100,
                      currentStep: correctPercent,
                      stepSize: 10,
                      selectedColor: Colors.green,
                      unselectedColor: Colors.grey[200],
                      padding: 0,
                      width: 150,
                      height: 150,
                      selectedStepSize: 15,
                      roundedCap: (_, __) => true,
                    ),
                    Text(
                      "$correctPercent%",
                      style: TextStyle(
                        color: score > 50 ? Colors.green : Colors.red,
                        fontSize: 20.sp,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 3.h),
                Text(
                  score > 50
                      ? "Congratulations to your child, they passed the test successfully."
                      : "Hard luck to your child! Try again.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16.sp,
                    height: 1.5,
                    color: score > 50 ? Colors.green : Colors.red,
                  ),
                ),
                SizedBox(height: 3.h),
                Text(
                  "Your Child Score",
                  style: TextStyle(
                    color: Colours.primaryblue,
                    fontSize: 16.sp,
                  ),
                ),
                SizedBox(height: 1.5.h),
                Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.grey),
                  ),
                  child: Column(
                    spacing: 1.h,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Correct Answer "),
                          Text(
                            "$correctPercent%",
                            style: const TextStyle(color: Colors.green),
                          ),
                        ],
                      ),
                      StepProgressIndicator(
                        totalSteps: 100,
                        currentStep: correctPercent,
                        size: 6.w,
                        padding: 0,
                        selectedColor: Colours.primaryblue,
                        unselectedColor: Colours.primarygrey,
                        roundedEdges: const Radius.circular(20),
                      ),
                      SizedBox(height: 1.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Wrong Answer "),
                          Text(
                            "$wrongPercent%",
                            style: TextStyle(color: Color(0xffC23F33)),
                          ),
                        ],
                      ),
                      StepProgressIndicator(
                        totalSteps: 100,
                        currentStep: wrongPercent,
                        size: 6.w,
                        padding: 0,
                        selectedColor: Colours.primaryblue,
                        unselectedColor: Colours.primarygrey,
                        roundedEdges: const Radius.circular(20),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}