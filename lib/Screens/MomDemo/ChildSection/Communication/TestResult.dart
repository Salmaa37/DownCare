import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import '../../../../utils/Colors.dart';
import 'package:downcare/Apis/Child/ChildApis.dart';

class TestResult extends StatelessWidget {
  static const String routeName = "test result";

  const TestResult({Key? key}) : super(key: key);

  Future<void> sendResultToApi(int score, String level, String type) async {
    bool result = await ChildApis.updateScore(
      type: type,
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
    final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    final int score = int.tryParse(args["score"]?.toString() ?? "0") ?? 0;
    final String level = args["level"] ?? "communication";
    final String type = args["type"] ?? "communication";

    const int maxScore = 100; // 10 أسئلة * 10 درجات

    final int correctPercent = score.clamp(0, maxScore);
    final int wrongPercent = maxScore - correctPercent;

    Future.microtask(() => sendResultToApi(correctPercent, level, type));

    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Child Score"),
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
                      totalSteps: maxScore,
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
                        color: correctPercent > 50 ? Colors.green : Colors.red,
                        fontSize: 20.sp,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 3.h),
                Text(
                  correctPercent > 50
                      ? "Congratulations to your child, they passed the test successfully."
                      : "Hard luck to your child! Try again.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16.sp,
                    height: 1.5,
                    color: correctPercent > 50 ? Colors.green : Colors.red,
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
                    spacing:1.5.h ,
                    mainAxisSize: MainAxisSize.min,
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
                        totalSteps: maxScore,
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
                            style: const TextStyle(color: Color(0xffC23F33)),
                          ),
                        ],
                      ),
                      StepProgressIndicator(
                        totalSteps: maxScore,
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
