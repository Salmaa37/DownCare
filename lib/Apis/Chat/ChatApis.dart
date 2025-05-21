import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../Models/ChatRoomModel.dart';
import '../../Models/GroupMemberModel.dart';
import '../../Models/MessageModel.dart';
class ChatApis{
  static Future<List<MessageModel>> fetchChatMessages(int chatRoomId) async {
    final String baseUrl = 'http://downcare.runasp.net/api/Chat/Messages/';

    final response = await http.get(Uri.parse('$baseUrl$chatRoomId'));

    if (response.statusCode == 200) {
      final List<dynamic> decoded = jsonDecode(response.body);
      return decoded.map((item) => MessageModel.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load messages');
    }
  }

  static const String baseUrl = "http://downcare.runasp.net/api";

  static Future<List<GroupMemberModel>> fetchGroupMembers() async {
    final url = Uri.parse("$baseUrl/Chat/GroupMembers");

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((item) => GroupMemberModel.fromJson(item)).toList();
    } else {
      throw Exception("فشل تحميل أعضاء الجروب: ${response.statusCode}");
    }
  }


  static Future<void> deleteMessage(int messageId) async {
    final url = Uri.parse('http://downcare.runasp.net/api/Chat/Message/$messageId');

    final response = await http.delete(
      url,
      headers: {
        'Content-Type': 'application/json',

      },
    );
    if (response.statusCode == 200) {
      print('Message deleted successfully.');
    } else {
      print('Failed to delete message. Status code: ${response.statusCode}');
      print('Response body: ${response.body}');
    }
  }


  static Future<List<ChatRoomModel>> fetchChatRooms() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    final response = await http.get(
      Uri.parse("http://downcare.runasp.net/api/Chat/ChatRooms"),
      headers: {
        'accept': '*/*',
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode == 200) {

      List<dynamic> data = json.decode(response.body);
      return data.map((chatRoom) => ChatRoomModel.fromJson(chatRoom)).toList();
    } else {

      throw Exception('Failed to load chat rooms');
    }
  }

  static Future<List<MessageModel>> fetchPrivateMessages(String recipientUserId) async {
    final String baseUrl = 'http://downcare.runasp.net/api/Chat/PrivateMessages/';
    final url = '$baseUrl$recipientUserId';
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    print("Calling API: $url");
    final response = await http.get(Uri.parse(url),headers: {
      "Authorization":"Bearer $token",
    });

    if (response.statusCode == 200) {
      final List<dynamic> decoded = jsonDecode(response.body);
      return decoded.map((item) => MessageModel.fromJson(item)).toList();
    } else {
      print("Failed to fetch messages. Status code: ${response.statusCode}");
      print("Response body: ${response.body}");
      throw Exception('Failed to load messages');
    }
  }
}