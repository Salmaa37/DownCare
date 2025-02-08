
import 'package:downcare/Screens/DoctorChat.dart';
import 'package:downcare/utils/Colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DoctorCard extends StatelessWidget {
   DoctorCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(19),
      child: Row(

        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage("assets/images/person.jpg"),
              ),

              SizedBox(
                height: 15,
              ),
              Text("Dr.Alaa Ali ",style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 15,
                  color: Colours.primaryblue
              ),)
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  Icon(Icons.location_pin,color: Colours.primaryblue,),
                  Text("Giza,Egypt",style: TextStyle(
                      color: Colours.primaryblue
                  ),)
                ],
              ),
              SizedBox(
                height: 8,
              ),
              Row(
                children: [
                  Icon(Icons.phone,color: Colours.primaryblue,),
                  Text("0984678",style: TextStyle(
                      color: Colours.primaryblue
                  ),)
                ],
              ),
              SizedBox(
                height: 8,
              ),
              Row(
                children: [
                  Icon(Icons.email,color: Colours.primaryblue,),
                  Text("mo@gmail",style: TextStyle(
                      color: Colours.primaryblue
                  ))
                ],
              ),
              SizedBox(
                height: 15,
              ),
              ElevatedButton(

                  style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(
                          horizontal: 34
                      ),
                      backgroundColor: Colours.primaryyellow
                  ),
                  onPressed: (){
                    Navigator.pushNamed(context, Doctorchat.routeName);
                  }, child: Text("Connect",style: TextStyle(
                  color: Colours.primaryblue
              ),)
              )
            ],
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
          borderRadius: BorderRadius.circular(15),
          color: Colours.primarygrey
      ),
      width: double.infinity,
      height: MediaQuery.of(context).size.height*0.25,
    );
  }
}

