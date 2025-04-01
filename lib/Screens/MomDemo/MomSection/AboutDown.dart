import 'package:downcare/Models/QuestionModel.dart';
import 'package:downcare/utils/Colors.dart';
import 'package:flutter/cupertino.dart';
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
  int currentIndex = 0; // Track the current question index
  @override
  void initState() {
    super.initState();
    loadfile();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text(
          "About Down",
        ),
      ),
      body: all.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    all[currentIndex].title,
                    style:  TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 16.sp,
                    ),
                  ),
                   SizedBox(height: MediaQuery.of(context).size.height*0.03),
                  Text(
                    all[currentIndex].answer.join("\n"), // Convert list to string
                    style:  TextStyle(
                       height: 0.25.h,
                      fontSize: 16.sp,
                      color: Colours.primaryblue
                    ),
                  ),
                ],
              ),
            ),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(
                      vertical: 1.h,
                      horizontal: MediaQuery.of(context).size.width*0.1
                    ),
                    backgroundColor: Colours.primaryyellow
                  ),
                  onPressed: currentIndex > 0
                      ? () {
                    setState(() {
                      currentIndex--;
                    });
                  }
                      : null,
                  child:  Text("Back",style: TextStyle(
                    fontSize: 17.sp,
                    color: Colours.primaryblue
                  ),),
                ),
                ElevatedButton(
                       style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(
                                vertical: 1.h,
                                horizontal: MediaQuery.of(context).size.width * 0.1),
                                backgroundColor: Colours.primaryyellow
                       ),
                        onPressed: currentIndex < all.length - 1
                      ? () {
                    setState(() {
                      currentIndex++; // Show next question
                    });
                  }
                      : null,
                  child:  Text("Next",style: TextStyle(
                    fontSize: 17.sp,
                    color: Colours.primaryblue
                  ),),
                ),
              ],
            ),

                    ],
                  ),
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