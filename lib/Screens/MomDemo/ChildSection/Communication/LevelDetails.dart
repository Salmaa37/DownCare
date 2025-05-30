import 'package:cached_network_image/cached_network_image.dart';
import 'package:downcare/Apis/Child/ChildApis.dart';
import 'package:downcare/Modules/BackAndNextBtn.dart';
import 'package:downcare/utils/Colors.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:dart_levenshtein/dart_levenshtein.dart';
import '../../../../Models/LinguisticsSectionModel.dart';

class LevelDetails extends StatefulWidget {
  static const String routeName = "level details";
  const LevelDetails({super.key});

  @override
  State<LevelDetails> createState() => _LevelDetailsState();
}

class _LevelDetailsState extends State<LevelDetails> {
  int selectedIndex = 0;
  List<LinguisticsSectionModel> data = [];
  stt.SpeechToText _speech = stt.SpeechToText();
  bool _isListening = false;
  String _spokenText = "";
  bool _isCorrect = false;
  String? type;
  bool _isProcessing = false;

  @override
  void initState() {
    super.initState();
    _initializeSpeech();
  }

  void _initializeSpeech() async {
    bool available = await _speech.initialize(
      onStatus: (status) {
        print("Speech Status: $status");
      },
      onError: (error) {
        print("Speech Error: $error");
      },
    );

    if (!available) {
      print("Speech recognition not available");
    } else {
      print("Speech recognition initialized successfully");
    }
  }

  void _startListening() async {
    if (!_isListening && !_isProcessing) {
      bool isAvailable = await _speech.isAvailable;
      if (isAvailable) {
        setState(() {
          _isListening = true;
          _spokenText = "";
          _isCorrect = false;
        });
        print("Listening started...");

        await _speech.listen(
          onResult: (result) async {
            setState(() {
              _spokenText = result.recognizedWords;
            });

            if (result.finalResult && !_isProcessing) {
              await _evaluateSpokenText();
              setState(() {
                _isListening = false;
              });
            }
          },
        );
      } else {
        print("Speech recognition not available.");
      }
    }
  }

  Future<void> _evaluateSpokenText() async {
    setState(() {
      _isProcessing = true;
    });

    String spokenAnswer = _spokenText.trim();
    String correctAnswer = data[selectedIndex].label?.trim() ?? "";

    if (spokenAnswer.isEmpty) {
      setState(() {
        _isCorrect = false;
        _isProcessing = false;
      });
      return;
    }

    int distance = _calculateDistance(spokenAnswer, correctAnswer);
    int maxAllowedDistance = _getMaxAllowedDistance(correctAnswer);

    setState(() {
      _isCorrect = distance <= maxAllowedDistance;
      _isProcessing = false;
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

  @override
  Widget build(BuildContext context) {
    final args =
    ModalRoute.of(context)!.settings.arguments as Map<String, String?>;
    final String type = args['type']!;
    final String level = args['level']!;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(level?? "Level Details"),
      ),
      body: FutureBuilder(
        future: ChildApis.getLinguisticsDetails(level),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text("Something went wrong! Please try again"));
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text("No Data Exist!"));
          }
          data = snapshot.data ?? [];
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Have your child speak and repeat",
                        style: TextStyle(color: Colours.primaryblue, fontSize: 18.sp)),
                    SizedBox(height: 2.h),
                    Center(
                      child: CachedNetworkImage(
                        imageUrl: data[selectedIndex].imgPath ?? '',
                        width: 50.w,
                        placeholder: (context, url) => Center(child: CircularProgressIndicator()),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Center(
                      child: Text(
                        textAlign: TextAlign.center,
                        data[selectedIndex].label ?? "No Label",
                        style: TextStyle(
                          color: Colours.primaryblue,
                          fontSize: 26.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Tap the mic and speak ",
                            style: TextStyle(
                                color: Colours.primaryblue, fontSize: 20.sp)),
                        GestureDetector(
                          onTap: _startListening,
                          child: AnimatedContainer(
                            duration: Duration(milliseconds: 300),
                            width: _isListening ? 15.w : 12.w,
                            height: _isListening ? 15.w : 12.w,
                            decoration: BoxDecoration(
                              color: _isListening ? Colors.red : Colours.primaryblue,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: (_isListening
                                      ? Colors.red
                                      : Colours.primaryblue)
                                      .withOpacity(0.6),
                                  blurRadius: 10,
                                  spreadRadius: 2,
                                ),
                              ],
                            ),
                            child: Center(
                              child: Icon(
                                _isListening ? Icons.mic_off : Icons.mic,
                                color: Colors.white,
                                size: 10.w,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      _spokenText.isEmpty
                          ? "Waiting for your response..."
                          : "You said: $_spokenText",
                      style: TextStyle(
                          color: Colours.primaryblue,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 2.h),
                    if (_spokenText.isNotEmpty)
                      AnimatedSwitcher(
                        duration: Duration(milliseconds: 300),
                        child: Text(
                          key: ValueKey(_isCorrect),
                          _isCorrect ? "✅ Correct!" : "❌ Try again!",
                          style: TextStyle(
                            fontSize: 18.sp,
                            color: _isCorrect ? Colors.green : Colors.red,
                            fontWeight: FontWeight.bold,
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
      bottomNavigationBar: BackAndNextBtn(
        back: () {
          if (!_isProcessing) {
            setState(() {
              selectedIndex = (selectedIndex > 0) ? selectedIndex - 1 : 0;
              _spokenText = "";
              _isCorrect = false;
            });
          }
        },
        next: () {
          if (!_isProcessing) {
            if (_isCorrect) {
              if (selectedIndex < data.length - 1) {
                setState(() {
                  selectedIndex++;
                  _spokenText = "";
                  _isCorrect = false;
                });
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("🎉 You've completed all items!")),
                );
              }
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("❌ Say the word correctly to proceed.")),
              );
            }
          }
        },
      ),
    );
  }
}