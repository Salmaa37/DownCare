import 'package:downcare/Screens/DoctorDemo/ChatRooms.dart';
import 'package:downcare/Screens/DoctorDemo/DocServiceCard.dart';
import 'package:downcare/Screens/DoctorDemo/DoctorArticle.dart';
import 'package:downcare/utils/Colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class WelcomeDoc extends StatelessWidget {
  static const String routeName="welcome doc";
   WelcomeDoc({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        actions: [
          Icon(Icons.person,size: 25,color: Colours.primaryblue,)
        ],
        leading: Icon(Icons.logout,color: Colours.primaryblue,size: 25,),
        centerTitle: true,
        backgroundColor: Colors.white,
        title:Text.rich(
          TextSpan(
            children: [
              TextSpan(text: 'Welcome\n', style: TextStyle(color: Colours.primaryblue, fontSize: 35,fontWeight: FontWeight.bold)),
              TextSpan(text: '   To DownCare', style: TextStyle(color:Colours.primaryblue , fontSize: 16)),
            ],
          ),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(
                height:MediaQuery.of(context).size.height*0.05 ,
              ),
              CircleAvatar(
                radius: 150,
                backgroundImage: AssetImage("assets/images/childsection.png"),
              ),
              SizedBox(
                height:MediaQuery.of(context).size.height*0.05 ,
              ),
              Text("Welcome, Dr. Ali, to our application! .",style: TextStyle(
                color: Colours.primaryblue,
                fontSize: 18
              ),),
              SizedBox(
                height:MediaQuery.of(context).size.height*0.05 ,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, ChatRooms.routeName);
                    },
                      child: DocServiceCard(label: "Messages",serviceicon:Icons.chat_bubble_outlined )),
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, DoctorArticle.routeName);
                    },
                      child: DocServiceCard(label: "Articles",serviceicon: Icons.article_rounded,))
                ],
              )
            ],
          ),
        ),
      ),

    );
  }
}

