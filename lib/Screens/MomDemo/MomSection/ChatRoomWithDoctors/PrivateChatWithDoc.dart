import 'package:downcare/Apis/User/UserApis.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:sizer/sizer.dart';
import '../../../../Apis/Chat/ChatApis.dart';
import '../../../../Apis/SignalRService.dart';
import '../../../../Models/ChatRoomModel.dart';
import '../../../../Models/MessageModel.dart';
import '../../../../utils/Colors.dart';
import '../../../../Modules/DeleteDialog.dart';
class PrivateChatWithDoc extends StatefulWidget {
  static const String routeName = "privateChat";
  final ChatRoomModel chatRoom;
  const PrivateChatWithDoc({super.key, required this.chatRoom});
  @override
  State<PrivateChatWithDoc> createState() => _PrivateChatWithDocState();
}
class _PrivateChatWithDocState extends State<PrivateChatWithDoc> {
  final TextEditingController _messageController = TextEditingController();
  final SignalRService _signalRService = SignalRService();
  final ScrollController _scrollController = ScrollController();
  DateTime date=DateTime.now();
  List<MessageModel> _messages = [];
  bool _isLoading = true;
  String currentUser = "";
  String currentUserImage = "";
  bool isUserLoaded = false;
  bool _isSending = false;
  bool _isConnected = false;
  @override
  void initState() {
    super.initState();
    _loadCurrentUser();
    _connectToSignalR();
    _loadOldMessages();
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    _signalRService.disconnect();
    super.dispose();
  }

  void _loadCurrentUser() async {
    try {
      final user = await UserApis.profile();
      setState(() {
        currentUser = user.userName ?? '';
        currentUserImage = user.imagePath ?? '';
        isUserLoaded = true;
      });
    } catch (e) {
      print("Error loading user: $e");
    }
  }
  void _connectToSignalR() async {
    await _signalRService.connect();
    setState(() {
      _isConnected = _signalRService.isConnected;
    });

    _signalRService.onMessageReceived = (MessageModel messageModel) {
      print(" ${messageModel.message}");
      if (mounted) {
        setState(() {
          _messages.add(messageModel);
          print(" ${messageModel.message}");
        });
        Future.delayed(Duration(milliseconds: 100), () {
          _messageController.clear();
        });
        _scrollToBottom();
      }
    };
  }

  void _loadOldMessages() async {
    try {
      final msgs = await ChatApis.fetchChatMessages(widget.chatRoom.id);
      setState(() {
        _messages = msgs;
        _isLoading = false;
      });
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _scrollToBottom();
      });

    } catch (e) {
      print("Error loading messages: $e");
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }


  Future<void> _sendMessage() async {
    if (!isUserLoaded) {
      print(" User not loaded");
      return;
    }
    if (_messageController.text.trim().isEmpty) {
      print(" Message is empty");
      return;
    }


    if (widget.chatRoom.recipientUserId == null || widget.chatRoom.recipientUserId.isEmpty) {
      print(" Recipient is invalid");
      return;
    }

    final message = _messageController.text.trim();
    if (message.isEmpty) return;

    setState(() {
      _isSending = true;
    });

    final newMessage = MessageModel(
      messageId: DateTime.now().millisecondsSinceEpoch,
      message: message,
      userName: currentUser,
      userImageURL: currentUserImage,
      displayTime: DateTime.now().toLocal().toString(),
      dateTime: DateTime.now().toLocal().toString(),
    );

    try {

      setState(() {
        _messages.add(newMessage);
      });
      _scrollToBottom();
      _messageController.clear();

      print('Sending message: ${newMessage}');


      if (!_signalRService.isConnected) {
        print(" Not connected to SignalR - attempting to reconnect");
        await _signalRService.connect();
      }

      if (_signalRService.isConnected) {
        await _signalRService.sendDoctorMessage(
            widget.chatRoom.recipientUserId!, message);
      } else {
        throw Exception("Failed to connect to SignalR");
      }
    } catch (e) {
      print(" Failed to send message: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to send message")),
      );

      setState(() {
        _messages.removeWhere((m) => m.messageId == newMessage.messageId);
      });
    } finally {
      setState(() {
        _isSending = false;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            CircleAvatar(
              backgroundColor: Colors.white,
              radius: 15,
              backgroundImage: widget.chatRoom.imageUrl?.isNotEmpty ?? false
                  ? NetworkImage(widget.chatRoom.imageUrl ?? "")
                  : null,
              child: widget.chatRoom.imageUrl?.isNotEmpty ?? false
                  ? null
                  : Text(
                widget.chatRoom.name[0].toUpperCase(),
                style: TextStyle(
                  color: Colours.primaryblue,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ),
            SizedBox(
              width: 1.5.w,
            ),
            Text("${widget.chatRoom.name}"),
          ],
        ),
      ),

      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
          controller: _scrollController,
        padding: EdgeInsets.all(3.w),
        itemCount: _messages.length,
        itemBuilder: (context, index) {
          final msg = _messages[index];
          print("عرض الرسالة: ${msg.message}");
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

          final isMine = msg.userName == currentUser;
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
                      msg.userName.isNotEmpty
                          ? msg.userName[0].toUpperCase()
                          : '?',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                      ),
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
                      crossAxisAlignment: isMine?CrossAxisAlignment.start:CrossAxisAlignment.end,
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
                          "${date.day}-${date.month}-${date.year} at ${date.hour}:${date.minute} ",
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
                      msg.userName.isNotEmpty
                          ? msg.userName[0].toUpperCase()
                          : '?',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
              ]
              ,
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
                            setState(() {
                              _messages.removeAt(index);
                            });
                          } catch (e) {
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
                onSubmitted: (_) => _sendMessage(),
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
}}