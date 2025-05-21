import 'package:downcare/Modules/LevelCard.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../Models/levelModel.dart';
import 'LevelDetails.dart';
import 'LevelTest.dart';
import 'TestResult.dart';
class SectionLevels extends StatelessWidget {
  static const String routeName = "section levels";
  final List<LevelModel> l = LevelModel.getLevelModel();
  SectionLevels({super.key});
  @override
  Widget build(BuildContext context) {
    final Map<String, String?> args = ModalRoute.of(context)!.settings.arguments as Map<String, String?>;
    final String type = args['type']!;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Communication Levels"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: ListView.separated(
          itemBuilder: (context, index) {
            return Levelcard(
              txt: l[index].txt,
              img: l[index].img,
              width: l[index].width,
              onclick: () {
                Navigator.pushNamed(
                  context,
                  LevelDetails.routeName,
                  arguments: {
                    "type": type,
                    "level": l[index].level,
                  },
                );
              },
              testOnclick: () async {
                final prefs = await SharedPreferences.getInstance();
                final hasTakenTest = prefs.getBool('test_done_${l[index].level}') ?? false;
                if (hasTakenTest) {
                  Navigator.pushReplacementNamed(
                    context,
                    TestResult.routeName,
                    arguments: {
                      "type": type,
                      "level": l[index].level,
                      "score": prefs
                          .getInt('score_${l[index].level}')
                          ?.toString() ?? "0",
                    },
                  );
                } else {
                  Navigator.pushNamed(
                    context,
                    LevelTest.routeName,
                    arguments: {
                      "type": type,
                      "level": l[index].level,
                    },
                  );
                }
              },
            );
          },
          separatorBuilder: (context, index) => const Divider(),
          itemCount: l.length,
        ),
      ),
    );
  }
}
