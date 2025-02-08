
import 'package:downcare/Screens/AboutDown.dart';
import 'package:downcare/Screens/Articles.dart';
import 'package:downcare/Screens/Doctors.dart';

import 'package:downcare/Screens/MomChat.dart';
import 'package:downcare/utils/Colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class MomSection extends StatefulWidget {
  static const String routeName = "momsection";

   MomSection({super.key});

  @override
  State<MomSection> createState() => _MomSectionState();
}

class _MomSectionState extends State<MomSection> {
  List<String> texts =["Read more info about down  ",
  "chat room with all down moms ", "Doctors from all governorates ","articles from diffrent doctors"];

  List<String>images=["assets/images/aboutdown.png","assets/images/chatroom.png","assets/images/doctors.png","assets/images/articles.png"];

  List<bool> isVisible = [false, false, false, false]; // حالة ظهور الكروت

  @override
  void initState() {
    super.initState();
    _showCardsSequentially();
  }

  void _showCardsSequentially() async {
    for (int i = 0; i < isVisible.length; i++) {
      await Future.delayed(Duration(milliseconds: 500)); // انتظار 5 ثواني
      setState(() {
        isVisible[i] = true; // إظهار الكارد الحالي
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:  AppBar(
        title:Text("Mom Section ",style: TextStyle(
          fontSize: 18,
          color: Colors.white
        )) ,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView.separated(
          separatorBuilder: (context, index) {
            return Divider(
              color: Colors.transparent,
            );
          },
          itemCount: texts.length,
          itemBuilder: (context, index) {
          return AnimatedOpacity(
            duration: Duration(seconds: 1), // مدة التلاشي
            opacity: isVisible[index] ? 1.0 : 0.0,
            child: Container(
              padding: EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(child: Image.asset(images[index],
                    height:MediaQuery.of(context).size.height*0.05 ,

                  )
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height*0.02,
                  ),
                  Text(texts[index],style: TextStyle(
                      height: 2.2,
                      fontSize: 16,
                      color: Colours.primaryblue
                  ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height*0.03,
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shape:RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)
                            ) ,
                            padding: EdgeInsets.symmetric(
                                vertical: 12,
                                horizontal: 28
                            ),
                            backgroundColor: Colours.primaryyellow
                        ),
                        onPressed: (){
                          if(index==0){
                        Navigator.pushNamed(context, AboutDown.routeName);
                          }
                          else if(index==1){
                        Navigator.pushNamed(context, Momchat.routeName);
                          }
                          else if (index==2){
                        Navigator.pushNamed(context, Doctors.routeName);
                          }
                          else {
                        Navigator.pushNamed(context, Articles.routeName);
                          }
                        }, child: Text("Discover",style: TextStyle(
                        color: Colours.primaryblue,
                        fontSize: 17
                    ),)),
                  )
                ],
              ),
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.1), // لون الظل
                        blurRadius: 4, // مقدار التمويه
                        offset: Offset(0, 5)
                    )
                  ],
                  color:Colours.primarygrey,
                  borderRadius: BorderRadius.circular(15)
              ),
              width: double.infinity,
              height: MediaQuery.of(context).size.height*0.25,
            ),
          );
        },),
      ),
    );
  }
}
