import 'package:audioplayers/audioplayers.dart';
import 'package:downcare/Apis/Child/ChildApis.dart';
import 'package:downcare/Models/LinguisticsSectionModel.dart';
import 'package:downcare/Modules/BackAndNextBtn.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../../../utils/Colors.dart';
import 'dart:async';

class LinguisticsDetails extends StatefulWidget {
  static const String routeName = "details";
  const LinguisticsDetails({super.key});

  @override
  State<LinguisticsDetails> createState() => _LinguisticsDetailsState();
}

class _LinguisticsDetailsState extends State<LinguisticsDetails> {
  int selectedIndex = 0;
  List<LinguisticsSectionModel> data = [];
  final AudioPlayer _audioPlayer = AudioPlayer();
  PlayerState _playerState = PlayerState.stopped;
  StreamSubscription? _playerStateSubscription;

  @override
  void initState() {
    super.initState();
    _playerStateSubscription =
        _audioPlayer.onPlayerStateChanged.listen((state) {
          if (mounted) setState(() => _playerState = state);
        });
  }

  @override
  void dispose() {
    _playerStateSubscription?.cancel();
    _audioPlayer.dispose();
    super.dispose();
  }

  Future<void> _playAudio(String url) async {
    try {
      await _audioPlayer.play(UrlSource(url));
    } catch (e) {
      print("Error playing audio: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    final args =
    ModalRoute.of(context)!.settings.arguments as Map<String, String?>;
    final String type = args['type']!;
    final String level = args['level']!;

    return FutureBuilder<List<LinguisticsSectionModel>>(
      future: ChildApis.getLinguisticsDetails(level),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Scaffold(
            body: Center(child: Text("Something went wrong")),
          );
        }
        if (!snapshot.hasData) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        data = snapshot.data!;

        return Scaffold(
          appBar: AppBar(title: Text('$type - ${data[selectedIndex].type}')),
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Have your child listen and repeat",
                    style: TextStyle(
                        color: Colours.primaryblue, fontSize: 18.sp),
                  ),
                  Center(
                    child: Image.network(
                      data[selectedIndex].imgPath ?? '',
                      width: 50.w,
                    ),
                  ),
                  Center(
                    child: Text(
                      data[selectedIndex].label ?? '',
                      textAlign: TextAlign.center,
                      textDirection: TextDirection.rtl,
                      style: TextStyle(
                          color: Colours.primaryblue,
                          fontSize: 26.sp,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "If you want to listen Click here",
                        style: TextStyle(
                            color: Colours.primaryblue, fontSize: 17.sp),
                      ),
                      IconButton(
                        onPressed: () {
                          final sound = data[selectedIndex].soundPath;
                          if (sound != null && sound.isNotEmpty) {
                            _playAudio(sound);
                          }
                        },
                        icon: Icon(Icons.volume_up,
                            color: Colours.primaryblue, size: 10.w),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          bottomNavigationBar: BackAndNextBtn(
            back: () {
              if (selectedIndex > 0) {
                setState(() {
                  selectedIndex--;
                  _audioPlayer.stop();
                });
              }
            },
            next: () {
              if (selectedIndex < data.length - 1) {
                setState(() {
                  selectedIndex++;
                  _audioPlayer.stop();
                });
              } else {
                showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    title: Column(
                      spacing: 1.h,
                      children: [
                        Icon(Icons.sentiment_satisfied_alt_rounded,color: Colors.pinkAccent,size: 15.w,),
                        Text(
                          "Congratulations!",
                          style: TextStyle(
                              fontSize: 17.sp,
                              color: Colors.green,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    content: Text(
                      "You've completed this part. Let's move on to the test.",
                      style: TextStyle(fontSize: 16.sp),
                    ),
                  ),
                );
              }
            },
          ),
        );
      },
    );
  }
}
