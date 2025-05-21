import 'package:downcare/Apis/Chat/ChatApis.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../../../utils/Colors.dart';
class GroupMembers extends StatelessWidget {
  static const String routeName="groupMembers";
  const GroupMembers({super.key});
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: FractionallySizedBox(
        widthFactor: 0.75,
        child: Material(
          color: Colors.white,
          elevation: 16,
          child: Column(
            children: [
              AppBar(
                centerTitle: true,
                title: Text("Group Members",style: TextStyle(
                  fontSize: 18.sp
                ),),
                automaticallyImplyLeading: false,
                backgroundColor: Colours.primaryblue,
                foregroundColor: Colors.white,
              ),
              Expanded(
                child:  FutureBuilder(
                  future: ChatApis.fetchGroupMembers(),
                  builder: (context, snapshot) {
                    if(snapshot.connectionState==ConnectionState.waiting){
                      return Center(child: CircularProgressIndicator());
                    }
                    if(snapshot.hasError){
                      return Center(child: Text("Something Went Wrong !",style: TextStyle(
                        fontSize:16.sp
                      ),),);
                    }
                    if(!snapshot.hasData){
                      return Center(child: Text("No Members Exist Until Now !",style: TextStyle(
                          fontSize:16.sp
                      ),),);
                    }
                    var member=snapshot.data;
                    return ListView.builder(
                      itemCount: member?.length??0,
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: CircleAvatar(
                            radius: 20,
                            backgroundColor: Colours.primaryblue,
                            backgroundImage: (member != null &&
                                member[index].userImageURL != null &&
                                member[index].userImageURL!.isNotEmpty)
                                ? NetworkImage(member[index].userImageURL!)
                                : null,
                            child: (member != null &&
                                (member[index].userImageURL == null ||
                                    member[index].userImageURL!.isEmpty))
                                ? Text(
                              (member[index].userName != null && member[index].userName!.isNotEmpty)
                                  ? member[index].userName![0].toUpperCase()
                                  : '',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            )
                                : null,
                          ),
                          title: Text(member != null && member[index].userName != null
                              ? member[index].userName!
                              : '',style: TextStyle(
                            fontSize: 19.sp
                          ),),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
