import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import '../../../utils/Colors.dart';
class WebSocketScreen extends StatefulWidget {
  static const String routeName="websocket";

  final WebSocketChannel channel;
  const WebSocketScreen({super.key, required this.channel});

  @override
  State<WebSocketScreen> createState() => _WebSocketScreenState();
}
class _WebSocketScreenState extends State<WebSocketScreen> {
  final TextEditingController messageController = TextEditingController();
  List<String> messages = [];
  @override
  void initState() {
    super.initState();
    widget.channel.stream.listen((message) {
      setState(() {
        messages.add(message);
      });
    });
  }
  void _sendMessage() {
    if (messageController.text.isNotEmpty) {
      widget.channel.sink.add(messageController.text);
      setState(() {
        messages.add(" ${messageController.text}");
        messageController.clear();
      });
    }
  }

  @override
  void dispose() {
    widget.channel.sink.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        actions: [
          Icon(Icons.more_vert_rounded, color: Colors.white,)
        ],
        title: Text("Moms Group"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: messages.isEmpty
            ? Center(child: Text("No messages yet"))
            : ListView.builder(
          itemCount: messages.length,
          itemBuilder: (context, index) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 17,
                  backgroundImage: AssetImage("assets/images/person.jpg"),
                ),
                SizedBox(width: 2.w),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colours.primarygrey,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.symmetric(vertical: 5),
                    child: Text(
                      messages[index],
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: Colours.primaryblue,
                      ),
                    ),
                  ),
                )
              ],
            );
          },
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.only(
            bottom: MediaQuery.viewInsetsOf(context).bottom,
            left: 2.w,
            right: 2.w),
        margin: EdgeInsets.symmetric(vertical: 2.h, horizontal: 3.w),
        color: Colours.primarygrey,
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: messageController,
                decoration: InputDecoration(
                  hintStyle: TextStyle(color: Colours.primaryblue),
                  border: InputBorder.none,
                  hintText: "Type your message",
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
