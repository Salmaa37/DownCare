import 'package:downcare/utils/Colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatRooms extends StatelessWidget {
  static const String routeName="chat rooms";
  const ChatRooms({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chat Rooms",style: TextStyle(
          color: Colors.white,
          fontSize: 15
        ),),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ListView.separated(itemBuilder: (context, index) {
          return Container(
            child: Padding(
              padding: const EdgeInsets.all(9.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 20,
                        backgroundImage: AssetImage("assets/images/person.jpg"),
                      ),
                      SizedBox(
                        width: 6,
                      ),
                      Text("Amal Ali",style: TextStyle(
                        color: Colors.black,
                        fontSize: 18
                      ),)
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),

                  Text("Click open and discover this chat "
                    ,style: TextStyle(
                    color: Colours.primaryblue,
                    fontSize: 15
                  ),),
                  Spacer(),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colours.primaryyellow
                      ),
                        onPressed: (){},
                        child: Text("Open Chat" ,style: TextStyle(
                          color: Colors.black,
                          fontSize: 16
                        ),)
                    ),
                  )
                ],
              ),
            ),
            height: MediaQuery.of(context).size.height*0.18,
            decoration: BoxDecoration(
              color: Colours.primarygrey,
              borderRadius: BorderRadius.circular(10)
            ),
            width: double.infinity,
          );
        }, separatorBuilder: (context, index) {
          return Divider(color: Colors.transparent,);
        }, itemCount: 2),
      ),
    );
  }
}
