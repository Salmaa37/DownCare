import 'package:downcare/Apis/Child/ChildApis.dart';
import 'package:downcare/Screens/MomDemo/ChildSection/Communication/TestResult.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'dart:async';
import '../../../../utils/Colors.dart';

class LevelTest extends StatefulWidget {
  static const String routeName = "level test";
  const LevelTest({super.key});

  @override
  State<LevelTest> createState() => _LevelTestState();
}

class _LevelTestState extends State<LevelTest> {
  int selectedIndex = 0;
  int score = 0;
  List<dynamic>? testData;
  String _spokenText = "";
  bool _isListening = false;
  bool _hasStartedListening = false;
  String _feedbackMessage = '';
  late stt.SpeechToText _speech;
  Timer? _silenceTimer;
  late final String type;
  late final String level;
  double progressPercent = 0.1;

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
    _initializeSpeech();
  }

  void _initializeSpeech() async {
    bool available = await _speech.initialize();
    if (!available) print("Speech recognition not available");
  }

  void _startListening() async {
    if (!_hasStartedListening && await _speech.isAvailable) {
      setState(() {
        _isListening = true;
        _hasStartedListening = true;
        _feedbackMessage = 'Listening...';
      });
      await _speech.listen(onResult: (result) {
        setState(() => _spokenText = result.recognizedWords);
        _resetSilenceTimer();
      });
    }
  }

  void _stopListening() async {
    if (_isListening) {
      await _speech.stop();
      setState(() => _isListening = false);
      _checkAnswer();
    }
  }

  void _resetSilenceTimer() {
    _silenceTimer?.cancel();
    _silenceTimer = Timer(Duration(seconds: 1), () {
      if (_isListening) {
        _stopListening();
      }
    });
  }

  int _calculateDistance(String a, String b) {
    if (a.isEmpty) return b.length;
    if (b.isEmpty) return a.length;

    List<List<int>> matrix = List.generate(
      a.length + 1,
          (i) => List.filled(b.length + 1, 0),
    );

    for (int i = 0; i <= a.length; i++) matrix[i][0] = i;
    for (int j = 0; j <= b.length; j++) matrix[0][j] = j;

    for (int i = 1; i <= a.length; i++) {
      for (int j = 1; j <= b.length; j++) {
        int cost = a[i - 1] == b[j - 1] ? 0 : 1;
        matrix[i][j] = [
          matrix[i - 1][j] + 1,
          matrix[i][j - 1] + 1,
          matrix[i - 1][j - 1] + cost
        ].reduce((min, value) => min < value ? min : value);
      }
    }

    return matrix[a.length][b.length];
  }

  int _getMaxAllowedDistance(String word) {
    int length = word.length;
    if (length <= 3) return 1;
    if (length <= 5) return 2;
    return 3;
  }

  String _clean(String text) {
    final cleaned = text
        .replaceAll(RegExp(r'[^\u0621-\u064A ]'), '')
        .replaceAll(RegExp(r'\s+'), ' ')
        .trim();
    return cleaned;
  }

  void _checkAnswer() {
    final correctAnswer = testData![selectedIndex].correctAnswer.toString();
    final spokenAnswer = _spokenText;

    final cleanCorrect = _clean(correctAnswer);
    final cleanSpoken = _clean(spokenAnswer);

    int distance = _calculateDistance(cleanSpoken, cleanCorrect);
    int maxAllowedDistance = _getMaxAllowedDistance(cleanCorrect);

    if (distance <= maxAllowedDistance) {
      setState(() {
        score += 10;
        _feedbackMessage = '✅ Correct';
      });
    } else {
      setState(() {
        _feedbackMessage = '❌ Incorrect';
      });
    }
  }

  void loadData() async {
    var data = await ChildApis.fetchQuestions(level);
    setState(() {
      testData = data;
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)!.settings.arguments as Map<String, String?>;
    type = args["type"]!;
    level = args["level"]!;
    loadData();
  }

  void _resetState({bool keepIndex = true}) {
    setState(() {
      _spokenText = "";
      _feedbackMessage = "";
      _isListening = false;
      _hasStartedListening = false;
      if (!keepIndex) selectedIndex = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (testData == null) {
      return Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    final current = testData![selectedIndex];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: Text("Time to test")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
          SizedBox(height: 2.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: StepProgressIndicator(
                  totalSteps: 100,
                  currentStep: (progressPercent * 100).toInt(),
                  size: 5.w,
                  padding: 0,
                  selectedColor: Colours.primaryblue,
                  unselectedColor: Colours.primarygrey,
                  roundedEdges: Radius.circular(20),
                ),
              ),
              SizedBox(width: 2.w),
              Text(
                "${(progressPercent * 100).toInt()}%",
                style: TextStyle(
                  fontSize: 20.sp,
                  color: Colours.primaryblue,
                ),
              )
            ],
          ),
          SizedBox(height: 2.h),
          Center(child: Image.network(current.imagePath ?? "",
              width: 45.w)),
          SizedBox(height: 3.h),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,

              children: [
            Text(
              "Make your child say (${current.correctAnswer})",
              style: TextStyle(color: Colours.primaryblue, fontSize: 17.sp),
            ),
            GestureDetector(
              onTap: () {
                if (!_hasStartedListening) {
                  _startListening();
                }
              },
              child: Align(
                alignment: Alignment.bottomRight,
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  width: _isListening ? 9.w : 8.w,
                  height: _isListening ? 9.w : 8.w,
                  decoration: BoxDecoration(
                    color: _isListening ? Colors.red : Colours.primaryblue,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: (_isListening ? Colors.red : Colours.primaryblue).withOpacity(0.6),
                        blurRadius: 10,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: Center(
                    child: Icon(
                      _isListening ? Icons.mic_off : Icons.mic,
                      color: Colors.white,
                      size: 6.w,
                    ),
                  ),
                ),
              ),
            ),
          ]),
          SizedBox(height: 2.h),
          Text(
            _spokenText.isEmpty
                ? "Waiting for your answer..."
                : "You said: $_spokenText",
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
              color: Colours.primaryblue,
            ),
          ),
          SizedBox(height: 2.h),
          if (_feedbackMessage.isNotEmpty)
            Text(
              _feedbackMessage,
              style: TextStyle(
                fontSize: 18.sp,
                color: _feedbackMessage.startsWith('✅')
                    ? Colors.green
                    : Colors.red,
              ),
            ),
        ]),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 5.w),
        child: Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: () async {
                  _resetState();
                  if (selectedIndex < testData!.length - 1) {
                    setState(() {
                      selectedIndex++;
                      progressPercent = (selectedIndex + 1) / testData!.length;
                    });
                  } else {
                    // حفظ حالة الامتحان والسكور
                    final prefs = await SharedPreferences.getInstance();
                    await prefs.setBool('test_done_$level', true);
                    await prefs.setInt('score_$level', score);

                    Navigator.pushReplacementNamed(
                      context,
                      TestResult.routeName,
                      arguments: {
                        "type": type,
                        "level": level,
                        "score": score.toString(),
                      },
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colours.primaryyellow),
                child: Text(
                  selectedIndex < testData!.length - 1 ? "Next" : "Finish",
                  style: TextStyle(
                    color: Colours.primaryblue,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
