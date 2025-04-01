import 'package:downcare/utils/Colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../Apis/ApiManager.dart';
class OtherDoctorsArticles extends StatelessWidget {
  static const String routeName ="articles";
  OtherDoctorsArticles({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Articles of other doctors",),
      ),
      body: FutureBuilder(
        future: ApiManager.getArticles(),
        builder: (context, snapshot) {
          if(snapshot.connectionState==ConnectionState.waiting){
            return Center(child: CircularProgressIndicator());
          }
          else if(snapshot.hasError){
            return Center(child: Text("SomeThing Went Wrong ! Try Again ",style: TextStyle(
              color: Colors.red,
              fontSize: 18.sp
            ),));
          }
          return Padding(
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
                        width: 2.w,
                      ),
                      Text (snapshot.data?[index].email??"",style: TextStyle(
                          fontSize: 16.sp,
                          color: Colours.primaryblue
                      ),)
                    ],
                  ),
                  SizedBox(
                    height: 1.h,
                  ),
                  Container(
                    padding: EdgeInsets.all(15),


                    width: MediaQuery.of(context).size.width*0.9,
                    decoration: BoxDecoration(

                        borderRadius: BorderRadius.circular(15),
                        color: Colours.primarygrey
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("${snapshot.data?[index].content??""}",
                          style: TextStyle(
                              fontSize: 15.sp,
                              height: 0.3.h,
                              color: Colours.primaryblue
                          ),),
                        Align(
                            alignment: Alignment.bottomRight,
                            child: Text("${snapshot.data?[index].date.day??""}-"
                                "${snapshot.data?[index].date.month??""}-"
                                "${snapshot.data?[index].date.year??""}",style: TextStyle(
                                color: Colours.primaryblue
                            ),)
                        )

                      ],
                    ),)
                ],
              );
            }, separatorBuilder: (context, index) {
              return Divider(
                height: 3.h,
              );
            }, itemCount: snapshot.data?.length??0),
          );
        },
      ),
    );
  }
}