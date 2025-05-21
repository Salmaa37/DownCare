import 'package:downcare/Apis/Child/ChildApis.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import '../../../../utils/Colors.dart';
import 'LinguisticsResult.dart';

class LinguisticsTest extends StatefulWidget {
  static const String routeName = "linguistics test";

  const LinguisticsTest({super.key});

  @override
  State<LinguisticsTest> createState() => _LinguisticsTestState();
}

class _LinguisticsTestState extends State<LinguisticsTest> {
  int selectedIndex = 0;
  int? selectedAnswerIndex;
  bool? isAnswerCorrect;
  List<dynamic>? testData;
  int score = 0;
  double progressPercent = 0.1;

  bool showCelebration = false;
  double shakeOffset = 0;

  late final String type;
  late final String level;

  void resetSelection() {
    selectedAnswerIndex = null;
    isAnswerCorrect = null;
  }

  void loadData() async {
    var data = await ChildApis.fetchQuestions(level);
    setState(() {
      testData = data;
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args =
    ModalRoute.of(context)!.settings.arguments as Map<String, String?>;
    type = args["type"]!;
    level = args["level"]!;
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    if (testData == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final currentQuestion = testData![selectedIndex];

    return Stack(
      children: [
        Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: const Text("Time to test"),
          ),
          body: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: StepProgressIndicator(
                        totalSteps: 100,
                        currentStep: (progressPercent * 100).toInt(),
                        size: 5.w,
                        padding: 0,
                        selectedColor: Colours.primaryblue,
                        unselectedColor: Colours.primarygrey,
                        roundedEdges: Radius.circular(20),
                      ),
                    ),
                    SizedBox(width: 2.w),
                    Text(
                      "${(progressPercent * 100).toInt()}%",
                      style: TextStyle(
                        fontSize: 20.sp,
                        color: Colours.primaryblue,
                      ),
                    )
                  ],
                ),
                SizedBox(height: 2.h),
                Text(
                  "Please choose the correct answer",
                  style: TextStyle(
                    color: Colours.primaryblue,
                    fontSize: 18.sp,
                  ),
                ),
                SizedBox(height: 2.h),
                Center(
                  child: Image.network(
                    currentQuestion.imagePath ?? "",
                    width: 35.w,
                  ),
                ),
                SizedBox(height: 3.h),
                Expanded(
                  child: GridView.builder(
                    itemCount: currentQuestion.choices.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisSpacing: 3.w,
                      mainAxisSpacing: 3.h,
                      childAspectRatio: 2.5,
                      crossAxisCount: 2,
                    ),
                    itemBuilder: (context, index) {
                      Color bgColor = Colours.primaryyellow;
                      if (selectedAnswerIndex != null &&
                          index == selectedAnswerIndex) {
                        bgColor = isAnswerCorrect! ? Colors.green : Colors.red;
                      }

                      return Transform.translate(
                        offset: Offset(
                          index == selectedAnswerIndex ? shakeOffset : 0,
                          0,
                        ),
                        child: GestureDetector(
                          onTap: () {
                            if (selectedAnswerIndex == null) {
                              final correct =
                                  currentQuestion.choices[index] ==
                                      currentQuestion.correctAnswer;
                              if (correct) {
                                score += 10;
                                setState(() {
                                  selectedAnswerIndex = index;
                                  isAnswerCorrect = true;
                                  showCelebration = true;
                                });
                                Future.delayed(Duration(seconds: 1), () {
                                  setState(() {
                                    showCelebration = false;
                                  });
                                });
                              } else {
                                setState(() {
                                  selectedAnswerIndex = index;
                                  isAnswerCorrect = false;
                                  shakeOffset = 10;
                                });
                                Future.delayed(Duration(milliseconds: 100), () {
                                  setState(() => shakeOffset = -10);
                                });
                                Future.delayed(Duration(milliseconds: 200), () {
                                  setState(() => shakeOffset = 0);
                                });
                              }
                            }
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: bgColor,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Center(
                              child: Text(
                                currentQuestion.choices[index] ?? "",
                                style: TextStyle(fontSize: 18.sp),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          bottomNavigationBar: Padding(
            padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 5.w),
            child: ElevatedButton(
              onPressed: selectedAnswerIndex == null
                  ? null
                  : () async {
                if (selectedIndex < testData!.length - 1) {
                  setState(() {
                    selectedIndex++;
                    resetSelection();
                    progressPercent =
                        (selectedIndex + 1) / testData!.length;
                  });
                } else {

                  final prefs = await SharedPreferences.getInstance();
                  await prefs.setBool('test_done_$level', true);
                  await prefs.setInt('score_$level', score);

                  Navigator.pushReplacementNamed(
                    context,
                    LinguisticsResult.routeName,
                    arguments: {
                      "type": type,
                      "level": level,
                      "score": score.toString(),
                    },
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colours.primaryblue,
                padding:
                EdgeInsets.symmetric(vertical: 1.5.h, horizontal: 10.w),
              ),
              child: Text(
                selectedIndex < testData!.length - 1 ? "Next" : "Finish",
                style: TextStyle(color: Colors.white, fontSize: 16.sp),
              ),
            ),
          ),
        ),

        if (showCelebration)
          Center(
            child: Image.asset(
              "assets/images/celebrate.png",
              width: 20.w,
            ),
          ),
      ],
    );
  }
}
