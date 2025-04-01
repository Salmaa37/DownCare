import 'package:audioplayers/audioplayers.dart';
import 'package:downcare/Models/LinguisticsSectionModel.dart';
import 'package:downcare/Screens/MomDemo/ChildSection/Communication/BackAndNextBtn.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../../../Apis/Api.dart';
import '../../../../utils/Colors.dart';


class LinguisticsDetails extends StatefulWidget {
  static const String routeName="details";
   LinguisticsDetails({super.key});

  @override
  State<LinguisticsDetails> createState() => _LinguisticsDetailsState();
}

class _LinguisticsDetailsState extends State<LinguisticsDetails> {
  int selectedIndex=0;
  List<LinguisticsSectionModel>data=[];
  final AudioPlayer _audioPlayer = AudioPlayer();

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var type=ModalRoute.of(context)?.settings.arguments as String? ;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Two Word"),

      ),
      body: FutureBuilder(
        future: Api.getLinguisticsDetails(type),
        builder: (context, snapshot) {
          if(snapshot.hasError){
            return Center(child: Text("SomeThing Went Wrong ! . Please try again"));
          }
          if (!snapshot.hasData){
            return Center(child: Text("No Data Exist !"));
          }
           data =snapshot.data??[];
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Center(
                child: Column(

                  spacing: 2.h,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Have your child listen and repeat",style: TextStyle(
                      color: Colours.primaryblue,
                      fontSize: 18.sp,

                    ),),
                    Center(child: Image.network(data[selectedIndex].imgPath??"No img",width: 50.w,)),
                    Center(
                      child: Text(data[selectedIndex].label??"No Label",style: TextStyle(
                        color: Colours.primaryblue,
                        fontSize: 26.sp,
                        fontWeight: FontWeight.bold

                      ),),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("if you want to listen Click here ",style: TextStyle(
                            color: Colours.primaryblue,
                            fontSize: 17.sp
                        ),),
                        IconButton(onPressed: (){
                          _audioPlayer.play(UrlSource(data[selectedIndex].soundPath));
                        }, icon: Icon(Icons.volume_up,color: Colours.primaryblue,size: 10.w,))
                      ],
                    )


                  ],
                ),
              ),
            ),
          ) ;
        },
      ),
      bottomNavigationBar: BackAndNextBtn(back: (){
        if (selectedIndex > 0){

          setState(() {
            selectedIndex--;
            _audioPlayer.stop();
          });
        }
        else {
          null;
        }
      }, next: (){
        if(selectedIndex<data.length-1){
          setState(() {
            selectedIndex++;
            _audioPlayer.stop();
          });
        }
        else{
          null;
        }

        },),);



  }
}
