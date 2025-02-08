import 'package:downcare/Screens/DoctorDemo/OtherDoctorsArticles.dart';
import 'package:downcare/Screens/Feedbacks.dart';
import 'package:downcare/utils/Colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DoctorArticle extends StatelessWidget {
  static const String routeName ="doc article";
  const DoctorArticle({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Article",style: TextStyle(
          color: Colors.white,
          fontSize: 16
        ),),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 15,
                  backgroundImage: AssetImage("assets/images/person.jpg"),
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: MediaQuery.of(context).size.width*0.2
                  ),
                  margin: EdgeInsets.only(
                      left: 10
                  ),
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
                  child: Text("alaa@gmail.com",

                    style: TextStyle(
                        color: Colours.primaryblue
                    ),),
                )
              ],
            ),
            Container(
              margin: EdgeInsets.symmetric(
                  vertical: 20
              ),
              padding: EdgeInsets.only(
                  left: 20
              ),
              height: MediaQuery.of(context).size.height*0.4,
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 0.2, // مقدار التمويه
                        offset: Offset(0, 1),
                        color: Colours.primaryyellow
                    )
                  ],
                  color: Colours.primarygrey,
                  borderRadius: BorderRadius.circular(10)
              ),
              child: TextField(
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintStyle: TextStyle(
                        fontSize: 13,
                        color: Colours.primaryblue
                    ),
                    hintText: "write your article here"
                ),
              ),
            ),
            Spacer(),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)
                    ),
                    padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width*0.2,
                        vertical: 16
                    ),
                    backgroundColor: Colours.primaryyellow
                ),
                onPressed: (){
                  Navigator.pushNamed(context,OtherDoctorsArticles.routeName);
                }, child:
            Text("Publish your article",style: TextStyle(
                color: Colours.primaryblue
            ),)
            ),
            SizedBox(
              height: 10,
            ),
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(text: "if you want to read other articles", style: TextStyle(color: Colors.black, fontSize:13)),
                  TextSpan(text: 'Click here ', style: TextStyle(color:Colours.primaryblue , fontSize: 16)),
                ],
              ),
            )

          ],
        ),
      ),
    );
  }
}
