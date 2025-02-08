
import 'package:downcare/utils/Colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SkillsDevelopment extends StatelessWidget {
  static const String routeName="skills";
   SkillsDevelopment({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Skills Development",style: TextStyle(
          fontSize: 16,
          color: Colors.white
        ),),

      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(
            top:70
          ),
          child: Column(
            mainAxisAlignment:MainAxisAlignment.spaceEvenly,
            children: [
              Stack(
              alignment: Alignment.bottomCenter,
                children: [
                  Container(
                    margin: EdgeInsets.only(

                        right: MediaQuery.of(context).size.width*0.20
                    ),
                    child: Image.asset("assets/images/rotatepuzzle.png",
                        // height:MediaQuery.of(context).size.height*0.2,
                        width:MediaQuery.of(context).size.width*0.5 ,
                    fit: BoxFit.cover,),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width*0.3
                    ),
                    child: Transform.rotate(
                      angle:0.2 ,
                      child: Image.asset("assets/images/puzzle.png",
                        width:MediaQuery.of(context).size.width*0.5 ,),
                    ),
                  )
                ],
              ),
              // SizedBox(
              //   height: 10,
              // ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  Text("IT IS TIME",style: TextStyle(
                    fontSize: 30,
                    color: Colours.primaryblue
                  ),),
                  SizedBox(
                    height: 14,
                  ),
                  Text("TO PLAY",style: TextStyle(
                    fontSize: 30,
                    color: Colours.primaryblue
                  ),)
                ],
              ),
              Text("Click here and start your game ",style: TextStyle(
                fontSize: 17,
                color: Colours.primaryblue
              ),),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)
                  ),
                  padding: EdgeInsets.symmetric(
                    vertical: MediaQuery.of(context).size.width*0.03,
                    horizontal: MediaQuery.of(context).size.width*0.3
                  ),
                  backgroundColor: Colours.primaryyellow
                ),
                  onPressed: (){}, child: Text("START",style:TextStyle(
                fontWeight: FontWeight.w400,
                color: Colors.black,
                fontSize: 20
              ),)
              )

            ],
          ),
        ),
      ),
    );
  }
}
