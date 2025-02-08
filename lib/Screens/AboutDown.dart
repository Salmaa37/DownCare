import 'package:downcare/Models/QuestionModel.dart';
import 'package:downcare/utils/Colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
    loadfile(); // Load questions once
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "About Down",
          style: TextStyle(fontSize: 14, color: Colors.white),
        ),
      ),
      body: all.isEmpty
          ? const Center(child: CircularProgressIndicator()) // Show loading indicator while loading data
          : Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  all[currentIndex].title,
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                 SizedBox(height: MediaQuery.of(context).size.height*0.03),
                Text(
                  all[currentIndex].answer.join("\n"), // Convert list to string
                  style:  TextStyle(
                     height: 2,
                    fontSize: 16,
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
                    vertical: 10,
                    horizontal: MediaQuery.of(context).size.width*0.1
                  ),
                  backgroundColor: Colours.primaryyellow
                ),
                onPressed: currentIndex > 0
                    ? () {
                  setState(() {
                    currentIndex--; // Go back to the previous question
                  });
                }
                    : null, // Disable if at the first question
                child:  Text("Back",style: TextStyle(
                  fontSize: 16,
                  color: Colours.primaryblue
                ),),
              ),
              ElevatedButton(
                     style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(
                              vertical: 10,
                              horizontal:
                                  MediaQuery.of(context).size.width * 0.1),
                          backgroundColor: Colours.primaryyellow),
                      onPressed: currentIndex < all.length - 1
                    ? () {
                  setState(() {
                    currentIndex++; // Show next question
                  });
                }
                    : null, // Disable if at the last question
                child:  Text("Next",style: TextStyle(
                  fontSize: 16,
                  color: Colours.primaryblue
                ),),
              ),
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height*0.03,
          )
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
        all = tempList; // Update state once after processing all items
      });
    } catch (e) {
      print("Error loading file: $e");
    }
  }
}