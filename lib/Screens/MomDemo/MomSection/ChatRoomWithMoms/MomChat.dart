import 'package:downcare/Apis/User/UserApis.dart';
import 'package:downcare/Models/MessageModel.dart';
import 'package:downcare/Modules/DeleteDialog.dart';
import 'package:downcare/Screens/HomeScreen.dart';
import 'package:downcare/Screens/MomDemo/MomSection/ChatRoomWithMoms/GroupMembers.dart';
import 'package:downcare/utils/Colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:sizer/sizer.dart';
import '../../../../Apis/Chat/ChatApis.dart';
import '../../../../Apis/SignalRService.dart';
import '../MomSection.dart';
class Momchat extends StatefulWidget {
  static const String routeName = "momgroup";
  const Momchat({super.key});

  @override
  State<Momchat> createState() => _MomchatState();
}
class _MomchatState extends State<Momchat> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _messageController = TextEditingController();
  final SignalRService _signalRService = SignalRService();
  List<MessageModel> _messages = [];
  bool _isLoading = true;
  String currentUser = "";
  String currentUserImage = "";
  @override
  void initState() {
    super.initState();
    _loadCurrentUser();
    _connectToSignalR();
    _loadOldMessages();
  }

  void _loadCurrentUser() async {
    try {
      final user = await UserApis.profile();
      setState(() {
        currentUser = user.userName ?? '';
        currentUserImage = user.imagePath ?? '';
      });
    } catch (e) {
      print("Error loading user: $e");
    }
  }

  void _connectToSignalR() async {
    await _signalRService.connect();

    _signalRService.onMessageReceived = (MessageModel messageModel) {
      if (mounted) {
        setState(() {
          _messages.add(messageModel);
        });
        Future.delayed(Duration(milliseconds: 100), () {
          _messageController.clear();
        });
        _scrollToBottom();
      }
    };

    _signalRService.onMessageDeleted = (int id) {
      _onMessageDeleted(id);
    };

    if (currentUser.isNotEmpty) {
      await _signalRService.joinGroup();
    }
  }

  void _onMessageDeleted(int id) {
    setState(() {
      _messages.removeWhere((msg) => msg.messageId == id);
    });
  }

  void _loadOldMessages() async {
    try {
      final msgs = await ChatApis.fetchChatMessages(1);
      setState(() {
        _messages = msgs;
        _isLoading = false;
      });
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _scrollToBottom();
      });
    } catch (e) {
      print("Error loading messages: $e");
    }
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  void _sendMessage() async {
    if (_messageController.text.isNotEmpty && _signalRService.isConnected) {
      try {
        final message = _messageController.text;
        final now = DateTime.now();
        final messageModel = MessageModel(
          messageId: now.millisecondsSinceEpoch,
          message: message,
          userName: currentUser,
          userImageURL: currentUserImage,
          displayTime: now.toLocal().toString(),
          dateTime: now.toLocal().toString(),
        );
        await _signalRService.sendMessage(message);
        setState(() {
          _messages.add(messageModel);
        });
        _messageController.clear();
        _scrollToBottom();
      } catch (e) {
        print(" $e");
      }
    } else {
      print("Failed to send !");
    }
  }

  void _showMoreOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(Icons.exit_to_app, color: Colors.red),
                title: Text('Leave the Group', style: TextStyle(fontSize: 18.sp, color: Colors.red)),
                onTap: () {
                  showDialog(context: context, builder: (context) => AlertDialog(
                      title: Text('Confirm Exit',style: TextStyle(
                        color: Colors.red,

                        fontSize: 20.sp
                      ),),
                      content: Text('Are you sure you want to leave the group?'),
                      actions: <Widget>[
                        TextButton(
                          child: Text('Cancel',style: TextStyle(
                             color: Colours.primaryblue,
                            fontSize: 16.sp
                          ),),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        TextButton(
                          child: Text('Leave',style: TextStyle(
                            fontSize: 16.sp,
                            color: Colors.red
                          ),),
                          onPressed: () async {
                        Navigator.pop(context);
                        if (mounted) {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (context) => HomeScreen()),
                                (Route<dynamic> route) => false,
                          );
                        await _signalRService.leaveGroup();
                        }
                        },
                        ),
                      ]
                   ,
                  ),);
                },
              ),
              ListTile(
                leading: Icon(Icons.group, color: Colours.primaryblue),
                title: Text('Group Members', style: TextStyle(fontSize: 18.sp, color: Colours.primaryblue)),
                onTap: () {
                  Navigator.pop(context);
                  showDialog(
                    context: context,
                    barrierDismissible: true,
                    builder: (context) => GroupMembers(),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  String formatDate(String dateTimeStr) {
    try {
      final dt = DateTime.parse(dateTimeStr);
      return "${dt.day}-${dt.month}-${dt.year} at ${dt.hour}:${dt.minute.toString().padLeft(2, '0')}";
    } catch (_) {
      return "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text("Moms Group"),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert_rounded, color: Colors.white),
            onPressed: () {
              _showMoreOptions(context);
            },
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
        controller: _scrollController,
        padding: EdgeInsets.all(3.w),
        itemCount: _messages.length,
        itemBuilder: (context, index) {
          final msg = _messages[index];
          final isMine = msg.userName == currentUser;

          if (msg.userName == 'System') {
            return Center(
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 1.h),
                padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  msg.message,
                  style: TextStyle(
                    fontStyle: FontStyle.italic,
                    fontSize: 12.sp,
                    color: Colors.black87,
                  ),
                ),
              ),
            );
          }

          final messageWidget = Container(
            margin: EdgeInsets.symmetric(vertical: 1.h),
            alignment: isMine ? Alignment.centerRight : Alignment.centerLeft,
            child: Row(
              mainAxisAlignment: isMine ? MainAxisAlignment.start : MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (isMine)
                  CircleAvatar(
                    backgroundColor: Colours.primaryblue,
                    foregroundColor: Colors.white,
                    radius: 15,
                    child: Text(
                      msg.userName.isNotEmpty ? msg.userName[0].toUpperCase() : '?',
                      style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
                    ),
                  ),
                SizedBox(width: 2.w),
                Flexible(
                  child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colours.primarygrey,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Column(
                      crossAxisAlignment:
                      isMine ? CrossAxisAlignment.start : CrossAxisAlignment.end,
                      children: [
                        Text(
                          msg.userName,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 13.sp,
                            color: Colours.primaryblue,
                          ),
                        ),
                        SizedBox(height: 0.5.h),
                        Text(
                          msg.message,
                          style: TextStyle(fontSize: 15.sp),
                        ),
                        SizedBox(height: 0.5.h),
                        Text(
                          formatDate(msg.dateTime),
                          style: TextStyle(fontSize: 11.sp, color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                ),
                if (!isMine)
                  CircleAvatar(
                    backgroundColor: Colours.primaryblue,
                    foregroundColor: Colors.white,
                    radius: 15,
                    child: Text(
                      msg.userName.isNotEmpty ? msg.userName[0].toUpperCase() : '?',
                      style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
                    ),
                  ),
              ],
            ),
          );

          if (isMine) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Slidable(
                key: ValueKey(msg.messageId),
                endActionPane: ActionPane(
                  motion: const BehindMotion(),
                  extentRatio: 0.25,
                  children: [
                    SlidableAction(
                      onPressed: (_) async {
                        final confirm = await showDialog(
                          context: context,
                          builder: (_) => DeleteDialog(),
                        );
                        if (confirm == true) {
                          try {
                            await ChatApis.deleteMessage(msg.messageId);

                          } catch (_) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("Failed to delete message")),
                            );
                          }
                        }
                      },
                      backgroundColor: Colors.redAccent,
                      foregroundColor: Colors.white,
                      icon: Icons.delete_outline,
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ],
                ),
                child: messageWidget,
              ),
            );
          } else {
            return messageWidget;
          }
        },
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.only(
          bottom: MediaQuery.viewInsetsOf(context).bottom,
          left: 3.w,
          right: 3.w,
        ),
        margin: EdgeInsets.only(bottom: 2.h),
        color: Colours.primarygrey,
        child: Row(
          children: [
            Expanded(
              child: TextField(
                keyboardType: TextInputType.multiline,
                maxLines: null,
                minLines: 1,
                controller: _messageController,
                decoration: InputDecoration(
                  hintText: "Type your message",
                  hintStyle: TextStyle(color: Colours.primaryblue),
                  border: InputBorder.none,
                ),
              ),
            ),
            IconButton(
              onPressed: _sendMessage,
              icon: Icon(Icons.send, color: Colours.primaryblue),
            ),
          ],
        ),
      ),
    );
  }
}