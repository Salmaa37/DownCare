import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../../Apis/SignalRService.dart';
import '../../../utils/Colors.dart';
class DoctorChat extends StatefulWidget {
  static const String routeName = "doctorchat";
  @override
  _DoctorChatState createState() => _DoctorChatState();
}
class _DoctorChatState extends State<DoctorChat> {
  final TextEditingController _messageController = TextEditingController();
  final SignalRService _signalRService = SignalRService();
  List<String> _messages = [];
  String? doctorId;
  @override
  void initState() {
    super.initState();
    _connectToSignalR();
  }
  void _connectToSignalR() async {
    await _signalRService.connect();
    _signalRService.onMessageReceived = (message) {
      setState(() {
        _messages.add(message);
      });
    };
  }
  void _sendMessage() {
    if (_messageController.text.isNotEmpty && doctorId != null) {
      _signalRService.sendMessage(doctorId!, _messageController.text);
      setState(() {
        _messages.add("You: ${_messageController.text}");
        _messageController.clear();
      });
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    doctorId = ModalRoute.of(context)?.settings.arguments as String?;

  }
  @override
  void dispose() {
    _signalRService.disconnect();
    _messageController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text("Chat with Doctor"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  bool isMe = _messages[index].startsWith("You:");
                  return Align(
                    alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 5),
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: isMe ? Colours.primaryblue : Colors.black,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        _messages[index],
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            _buildMessageInput(),
          ],
        ),
      ),
    );
  }

  Widget _buildMessageInput() {
    return Container(
      padding: EdgeInsets.only(
        bottom: MediaQuery.viewInsetsOf(context).bottom,
        left: 2.w,
        right: 2.w,
      ),
      margin: EdgeInsets.symmetric(
        vertical: 2.h,
        horizontal: 3.w,
      ),
      decoration: BoxDecoration(
        color: Colours.primarygrey,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _messageController,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "Type your message...",
                hintStyle: TextStyle(color: Colours.primaryblue),
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.send, color: Colours.primaryblue),
            onPressed: _sendMessage,
          ),
        ],
      ),
    );
  }
}
