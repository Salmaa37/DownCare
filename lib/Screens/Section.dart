
import 'package:downcare/utils/Colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'ChildSection.dart';
import 'MomSection.dart';
class Section extends StatefulWidget {
  String text;
  String img;
   Section({super.key,required this.text,required this.img});

  @override
  State<Section> createState() => _SectionState();
}

class _SectionState extends State<Section> {
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
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.symmetric(
              vertical: 12.0
          ),
          child: AnimatedOpacity(
            duration: Duration(seconds: 1),
            opacity: showText ? 1.0 : 0.0,
            child: Text(widget.text,style: TextStyle(
                // fontWeight: FontWeight.w400,
                fontSize: 23,
                color: Colours.primaryblue
            ),),
          ),
        ),
        InkWell(
          onTap: () {
            if (widget.img=="momsection"){
              Navigator.pushNamed(context, MomSection.routeName);
            }
            else
              {
                Navigator.pushNamed(context, ChildSection.routeName);
              }
          },
            child: AnimatedOpacity(
                duration: Duration(seconds: 1),
                opacity: showImage ? 1.0 : 0.0,
                child: Image.asset("assets/images/${widget.img}.png"))),
      ],
    );
  }
}
