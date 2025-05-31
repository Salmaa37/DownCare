import 'package:downcare/Apis/Chat/ChatApis.dart';
import 'package:downcare/Screens/MomDemo/MomSection/ChatRoomWithDoctors/PrivateChatWithDoc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../../../utils/Colors.dart';

class MomHistory extends StatelessWidget {
  static const String routeName = "momHistory";

  const MomHistory({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Your History"),
        elevation: 1,
      ),
      backgroundColor: Colors.white,
      body: FutureBuilder(
        future: ChatApis.fetchChatRooms(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text("Something went wrong !"));
          }
          if (!snapshot.hasData || snapshot.data!.length <= 1) {
            return Center(child: Text("No chatrooms exist until now !"));
          }

          var chatroom = snapshot.data;

          return ListView.separated(
            padding: EdgeInsets.all(3.w),
            separatorBuilder: (context, index) => SizedBox(height: 2.h),
            itemCount: chatroom!.length ,
            itemBuilder: (context, index) {
              final room = chatroom[index];

              return GestureDetector(
                onTap: () {
                  if (chatroom![index]!= null) {
                    Navigator.pushNamed(
                      context,
                      PrivateChatWithDoc.routeName,
                      arguments: chatroom![index],
                    );
                  }

                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.15),
                        blurRadius: 8,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  padding: EdgeInsets.all(3.w),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: room.imageUrl != null && room.imageUrl.isNotEmpty
                            ? Image.network(
                          room.imageUrl,
                          width: 16.w,
                          height: 16.w,
                          fit: BoxFit.cover,
                        )
                            : Container(
                          width: 16.w,
                          height: 16.w,
                          color: Colours.primaryblue,
                          alignment: Alignment.center,
                          child: Text(
                            room.name.isNotEmpty ? room.name[0].toUpperCase() : '',
                            style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 4.w),
                      Expanded(
                        child: Text(
                          "${room.name}",
                          style: TextStyle(
                            color: Colours.primaryblue,
                            fontSize: 17.sp,
                          ),
                        ),
                      ),
                      Icon(Icons.arrow_forward_ios, size: 18, color: Colours.primaryblue),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
