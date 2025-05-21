
import 'package:downcare/Screens/MomDemo/ChildSection/ChildSection.dart';
import 'package:downcare/utils/Colors.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'MomDemo/ChildSection/ChildData.dart';
import 'MomDemo/MomSection/MomSection.dart';
class Section extends StatefulWidget {
  String text;
  String img;
   Section({super.key,required this.text,required this.img});

  @override
  State<Section> createState() => _SectionState();
}
class _SectionState extends State<Section> {
  bool isFormFilled = false;
  bool showText = false;
  bool showImage = false;
  @override
  void initState() {
    super.initState();
    _startAnimation();
  }
  void _startAnimation() {
    Future.delayed(Duration(milliseconds: 300), () {
      setState(() => showText = true);
    });
    Future.delayed(Duration(milliseconds: 340), () {
      setState(() => showImage = true);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.symmetric(
              vertical: 2.h,
              horizontal: 1.w
          ),
          child: AnimatedOpacity(
            duration: Duration(seconds: 1),
            opacity: showText ? 1.0 : 0.0,
            child: Text(
              widget.text,
              style: TextStyle(
                  fontSize: 20.sp,
                  color: Colours.primaryblue
              ),
            ),
          ),
        ),
        InkWell(
          onTap: () async {
            if (widget.img == "momsection") {
              Navigator.pushNamed(context, MomSection.routeName);
            } else if (widget.img == "childsection") {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              bool? isChildAdded = prefs.getBool("isChildAdded");

              String? childData = prefs.getString("childData");
              if (mounted) {
                if (isChildAdded == true && childData != null && childData.isNotEmpty) {

                  Navigator.pushNamed(context, ChildSection.routeName);
                } else {
                  Navigator.pushNamed(context, ChildData.routeName);
                }
              }
            }
          },
          child: AnimatedOpacity(
            duration: Duration(seconds: 1),
            opacity: showImage ? 1.0 : 0.0,
            child: Image.asset(
              "assets/images/${widget.img}.png",
              width: double.infinity,
            ),
          ),
        ),
      ],
    );
  }
}

