import 'package:downcare/utils/Colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DocServiceCard extends StatelessWidget {
  String label;
  IconData serviceicon;
  DocServiceCard({super.key,required this.label,required this.serviceicon});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colours.primaryblue,
          borderRadius: BorderRadius.circular(15)
      ),
      width: MediaQuery.of(context).size.width*0.4,
      height: MediaQuery.of(context).size.height*0.23,
      child:Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Icon(serviceicon,size: 50,color: Colors.white,),
          Text(label,style: TextStyle(
              fontSize: 24,
              color: Colors.white
          ),)
        ],

      ) ,

    );
  }
}
