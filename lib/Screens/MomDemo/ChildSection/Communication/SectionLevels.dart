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
          itemCount: l.length,
          separatorBuilder: (context, index) => const Divider(),
          itemBuilder: (context, index) {
            return TweenAnimationBuilder<double>(
              tween: Tween<double>(begin: 0, end: 1),
              duration: Duration(milliseconds: 700 + index * 100),
              builder: (context, value, child) {
                return Opacity(
                  opacity: value,
                  child: Transform.translate(
                    offset: Offset(0, (1 - value) * 30),
                    child: child,
                  ),
                );
              },
              child: Levelcard(
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
                  final hasTakenTest = prefs.getBool('test_done_${type}_${l[index].level}') ?? false;
                  if (hasTakenTest) {
                    Navigator.pushNamed(
                      context,
                      TestResult.routeName,
                      arguments: {
                        "type": type,
                        "level": l[index].level,
                        "score": prefs.getInt('score_${type}_${l[index].level}')?.toString() ?? "0",
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
              ),
            );
          },
        ),
      ),
    );
  }
}
