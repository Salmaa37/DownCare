import 'package:downcare/Models/QuestionModel.dart';
import 'package:downcare/utils/Colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

class AboutDown extends StatefulWidget {
  static const String routeName = "aboutdown";
  const AboutDown({super.key});

  @override
  State<AboutDown> createState() => _AboutDownState();
}

class _AboutDownState extends State<AboutDown> {
  List<QuestionModel> all = [];
  int currentIndex = 0;
  PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();
    loadfile();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("About Down"),
      ),
      body: all.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : Column(
        children: [
          SizedBox(height: 2.h),
          LinearProgressIndicator(
            value: (currentIndex + 1) / all.length,
            backgroundColor: Colours.primarygrey,
            color: Colours.primaryyellow,
          ),
          SizedBox(height: 2.h),
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  currentIndex = index;
                });
              },
              itemCount: all.length,
              itemBuilder: (context, index) {
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOut,
                  padding: const EdgeInsets.all(12.0),
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    elevation: 5,
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            all[index].title,
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 16.sp,
                            ),
                          ),
                          SizedBox(
                              height: MediaQuery.of(context).size.height *
                                  0.03),
                          Expanded(
                            child: SingleChildScrollView(
                              child: Text(
                                all[index].answer.join("\n"),
                                style: TextStyle(
                                  height: 1.5,
                                  fontSize: 16.sp,
                                  color: Colours.primaryblue,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<void> loadfile() async {
    try {
      String file = await rootBundle.loadString("assets/files/questions.txt");
      List<String> questions = file.trim().split("*");
      List<QuestionModel> tempList = [];

      for (String question in questions) {
        List<String> q = question.split("\n");
        if (q.isNotEmpty) {
          String title = q[0];
          q.removeAt(0);
          tempList.add(QuestionModel(title: title, answer: q));
        }
      }
      setState(() {
        all = tempList;
      });
    } catch (e) {
      print("Error loading file: $e");
    }
  }
}
