import 'package:downcare/Screens/SkillsDevelopment.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utils/Colors.dart';

class ChildSection extends StatefulWidget {
  static const String routeName="child";
   ChildSection({super.key});

  @override
  State<ChildSection> createState() => _ChildSectionState();
}

class _ChildSectionState extends State<ChildSection> {
  List<String> texts =["Communication Skills" ,
    "Linguistics Skills ", "Skills Development "];

  List<String>images=["assets/images/communicationskills.png","assets/images/chatroom.png","assets/images/skillsdevelopment.png",];

  List<bool> isVisible = [false, false, false]; // حالة ظهور الكروت

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


        title:Text("Child Section ",style: TextStyle(
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
                      height:MediaQuery.of(context).size.height*0.07 ,

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
                      height: MediaQuery.of(context).size.height*0.019,
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

                            }
                            else if(index==1){

                            }
                           else{
                          Navigator.pushNamed(context, SkillsDevelopment.routeName);
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
