
import 'package:downcare/utils/Colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class Articles extends StatelessWidget {
  static const String routeName ="articles";
  const Articles({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Doctors articles",style: TextStyle(
          fontSize: 17,
          color: Colors.white
        ),),

      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ListView.separated(itemBuilder: (context, index) {
          return Column(
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 15,
                    backgroundImage: AssetImage("assets/images/person.jpg"),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text("alaa@gmail.com",style: TextStyle(
                    fontSize: 15,
                    color: Colours.primaryblue
                  ),)
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                padding: EdgeInsets.all(15),
                child: Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis volutpat sit amet massa id pretium.",
                style: TextStyle(
                  height: 1.8,
                  color: Colours.primaryblue
                ),),
                height: MediaQuery.of(context).size.height*0.3,
                width: MediaQuery.of(context).size.width*0.9,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 0.2, // مقدار التمويه
                        offset: Offset(0, 1),
                        color: Colours.primaryyellow
                    )
                  ],
                borderRadius: BorderRadius.circular(15),
                  color: Colours.primarygrey
                ),
              )
            ],
          );
        }, separatorBuilder: (context, index) {
          return Divider(
            color: Colors.transparent,
          );
        }, itemCount: 2),
      ),
    );
  }
}

