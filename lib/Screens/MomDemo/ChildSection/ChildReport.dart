import 'package:downcare/Apis/Child/ChildApis.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../../Modules/ScoreSection.dart';
class ChildReport extends StatelessWidget {
  static const String routeName = "childreport";
  const ChildReport({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Child Report"),
      ),
      body: FutureBuilder(
        future: ChildApis.getChildReport(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(
                "Something went wrong!",
                style: TextStyle(fontSize: 16.sp),
              ),
            );
          }
          if (!snapshot.hasData) {
            return Center(
              child: Text(
                "Report data doesn't exist!",
                style: TextStyle(fontSize: 16.sp),
              ),
            );
          }
          var report = snapshot.data;
          return Padding(
            padding: const EdgeInsets.all(12.0),
            child: SingleChildScrollView(
              child: Column(
                spacing: 2.6.h,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Child Name: ${report?.childName ?? " "}", style: TextStyle(fontSize: 17.sp)),
                  Text("Age: ${report?.age ?? " "} years old", style: TextStyle(fontSize: 17.sp)),
                  Text("Gender: ${report?.gender ?? " "}", style: TextStyle(fontSize: 17.sp)),
                  Text("Date of diagnosis: ${report?.diagnosisDate ?? " "}", style: TextStyle(fontSize: 17.sp)),
                  SizedBox(height: 2.h),
                  ScoreSection(title: "Your Child Communication Score", scores: report!.communicationScore),
                  SizedBox(height: 2.h),
                  ScoreSection(title: "Your Child Linguistics Score", scores: report.linguisticsScore),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
