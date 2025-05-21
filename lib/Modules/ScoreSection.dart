import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'ScoreItem.dart';
import '../utils/Colors.dart';

class ScoreSection extends StatelessWidget {
  final String title;
  final Map<String, dynamic> scores;

  const ScoreSection({super.key, required this.title, required this.scores});

  @override
  Widget build(BuildContext context) {
    final wordLevels = ['oneWord', 'twoWord', 'threeWord', 'fourWord', 'fiveWord'];

    return Column(
      children: [
        Center(
          child: Text(
            title,
            style: TextStyle(color: Colours.primaryblue, fontSize: 17.sp),
          ),
        ),
        SizedBox(
          height: 1.5.h,
        ),
        Container(
          padding: const EdgeInsets.all(20),
          height: 50.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.grey),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: wordLevels
                .map((level) => ScoreItem(
              title: level.replaceAll("Word", " Word"),
              score: scores[level] ?? 0,
            ))
                .toList(),
          ),
        ),
      ],
    );
  }
}
