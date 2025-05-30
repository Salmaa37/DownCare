import 'package:downcare/Screens/MomDemo/ChildSection/ChildReport.dart';
import 'package:downcare/Screens/MomDemo/ChildSection/Communication/SectionLevels.dart';
import 'package:downcare/utils/AppImages.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../../utils/Colors.dart';
import 'Linguistics/LinguisticsLevels.dart';
import 'SkillsDevelopment/SkillsDevelopment.dart';

class ChildSection extends StatefulWidget {
  static const String routeName = "child section";

  const ChildSection({super.key});

  @override
  State<ChildSection> createState() => _ChildSectionState();
}

class _ChildSectionState extends State<ChildSection> {
  final List<String> texts = [
    "Communication Skills",
    "Linguistics Skills",
    "Skills Development"
  ];

  final List<String> images = [
    AppImages.communication,
    AppImages.chatroom,
    AppImages.skillsdeveloment,
  ];

  List<bool> isVisible = [false, false, false];

  @override
  void initState() {
    super.initState();
    _showCardsSequentially();
  }

  void _showCardsSequentially() async {
    for (int i = 0; i < isVisible.length; i++) {
      await Future.delayed(const Duration(milliseconds: 500));
      setState(() {
        isVisible[i] = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, ChildReport.routeName);
            },
            icon: Icon(Icons.text_snippet_sharp, color: Colors.white, size: 7.w),
          )
        ],
        title: const Text("Child Section"),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 3.h),
        child: ListView.builder(
          itemCount: texts.length,
          itemBuilder: (context, index) {
            return AnimatedOpacity(
              duration: const Duration(seconds: 1),
              opacity: isVisible[index] ? 1.0 : 0.0,
              child: Container(
                padding: EdgeInsets.all(4.w),
                margin: EdgeInsets.only(bottom: 2.h),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 4,
                      offset: const Offset(0, 5),
                    ),
                  ],
                  color: Colours.primarygrey,
                  borderRadius: BorderRadius.circular(3.w),
                ),
                width: double.infinity,
                height: 25.h,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      images[index],
                      height: 9.h,
                    ),
                    Text(
                      texts[index],
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: Colours.primaryblue,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4.w),
                          ),
                          padding: EdgeInsets.symmetric(
                            vertical: 1.5.h,
                            horizontal: 7.w,
                          ),
                          backgroundColor: Colours.primaryyellow,
                        ),
                        onPressed: () {
                          switch (index) {
                            case 0:
                              Navigator.pushNamed(
                                context,
                                SectionLevels.routeName,
                                arguments: {'type': 'Communication'},
                              );
                              break;
                            case 1:
                              Navigator.pushNamed(
                                context,
                                LinguisticsLevels.routeName,
                                arguments: {'type': 'Linguistics'},
                              );
                              break;
                            default:
                              Navigator.pushNamed(context, SkillsDevelopment.routeName);
                          }
                        },
                        child: Text(
                          "Discover",
                          style: TextStyle(
                            color: Colours.primaryblue,
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}