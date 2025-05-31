import 'package:downcare/utils/AppImages.dart';
import 'package:downcare/utils/Colors.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../../Apis/SignalRService.dart';
import 'AboutDown/AboutDown.dart';
import 'DoctorsArticles/Article.dart';
import 'ChatRoomWithMoms/MomChat.dart';
import 'ChatRoomWithDoctors/Search.dart';

class MomSection extends StatefulWidget {
  static const String routeName = "momsection";
  MomSection({super.key});

  @override
  State<MomSection> createState() => _MomSectionState();
}

class _MomSectionState extends State<MomSection> {
  final SignalRService _signalRService = SignalRService();

  List<String> texts = [
    "Read more info about down",
    "Chat room with all down moms",
    "Doctors from all governorates",
    "Articles from different doctors"
  ];

  List<String> images = [
    AppImages.aboutdown,
    AppImages.chatroom,
    AppImages.doctors,
    AppImages.articles
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Mom Section"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView.separated(
          separatorBuilder: (context, index) => Divider(),
          itemCount: texts.length,
          itemBuilder: (context, index) {
            return TweenAnimationBuilder<double>(
              tween: Tween<double>(begin: 0, end: 1),
              duration: Duration(milliseconds: 700 + index * 150),
              builder: (context, value, child) {
                return Opacity(
                  opacity: value,
                  child: Transform.translate(
                    offset: Offset(0, (1 - value) * 30),
                    child: child,
                  ),
                );
              },
              child: Container(
                padding: EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: Colours.primarygrey,
                  borderRadius: BorderRadius.circular(15),
                ),
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.25,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Center(
                      child: Image.asset(
                        images[index],
                        height: MediaQuery.of(context).size.height * 0.07,
                      ),
                    ),
                    Text(
                      texts[index],
                      style: TextStyle(
                        fontSize: 17.sp,
                        color: Colours.primaryblue,
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                          padding: EdgeInsets.symmetric(
                            vertical: 1.5.h,
                            horizontal: 7.w,
                          ),
                          backgroundColor: Colours.primaryyellow,
                        ),
                        onPressed: () async {
                          if (index == 0) {
                            Navigator.pushNamed(context, AboutDown.routeName);
                          } else if (index == 1) {
                            if (!_signalRService.isConnected) {
                              await _signalRService.connect();
                            }
                            if (_signalRService.isConnected) {
                              _signalRService.joinGroup();
                              Navigator.pushNamed(context, Momchat.routeName);
                            } else {
                              print("الاتصال فشل");
                            }
                          } else if (index == 2) {
                            Navigator.pushNamed(context, DoctorSearchScreen.routeName);
                          } else if (index == 3) {
                            Navigator.pushNamed(context, Article.routeName);
                          }
                        },
                        child: Text(
                          "Discover",
                          style: TextStyle(
                            color: Colours.primaryblue,
                            fontSize: 16.sp,
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
