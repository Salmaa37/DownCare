import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../../../utils/Colors.dart';
import 'LinguisticsResult.dart';
class LinguisticsTest extends StatelessWidget {
  List <String>choices=["تفاحة","برتقالة","موزة","فراولة"];
  static const String routeName="linguistics test";
   LinguisticsTest({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Test on One Word"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Center(
          child: Column(
            spacing: 3.h,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("Please choose the correct answer  ",style: TextStyle(
                color: Colours.primaryblue,
                fontSize: 18.sp
              ),),
              Image.asset("assets/images/orange.png",width: 60.w,),
             SizedBox(
               height: 1.h,
             ),
              Expanded(
                child: GridView.builder(
                  itemCount: choices.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisSpacing: 3.w,
                      mainAxisSpacing: 3.h,
                      childAspectRatio: 2.5,
                      crossAxisCount: 2),
                  itemBuilder: (context, index) {
                  return Container(
                    decoration: BoxDecoration(
                      color: Colours.primaryyellow,
                      borderRadius: BorderRadius.circular(0)
                    ),
                    child: Center(
                      child: Text("${choices[index]}",style: TextStyle(
                        fontSize: 22.sp
                      ),),
                    ),
                  );
                },),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        padding: EdgeInsets.zero,
        elevation: 0,
        child: Center(
          child: Padding(
            padding: EdgeInsets.only(
                bottom: 0.5.h
            ),
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(
                        vertical: 1.5.h,
                        horizontal: MediaQuery.of(context).size.width*0.4
                    ),
                    backgroundColor: Colours.primaryblue
                ),
                onPressed: (){
              Navigator.pushNamed(context,LinguisticsResult.routeName);
                }, child: Text("Next",style: TextStyle(
              color: Colors.white,
              fontSize: 17.sp,
            ),)),
          ),
        ),
      ),
    );
  }
}
