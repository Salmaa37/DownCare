import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

import '../utils/Colors.dart';

class ScoreItem extends StatelessWidget {
  final String title;
  final int score;

  const ScoreItem({super.key, required this.title, required this.score});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 1.h,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title),
            Text(
              score.toString(),
              style: const TextStyle(color: Colors.green),
            ),
          ],
        ),
        StepProgressIndicator(
          totalSteps: 100,
          currentStep: score,
          size: 6.w,
          padding: 0,
          selectedColor: Colours.primaryblue,
          unselectedColor: Colours.primarygrey,
          roundedEdges: const Radius.circular(20),
        ),
      ],
    );
  }
}
