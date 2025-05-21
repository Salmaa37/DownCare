
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../Models/Child.dart';
import '../../Models/ChildReportModel.dart';
import '../../Models/LinguisticsSectionModel.dart';
import '../../Models/TestModel.dart';
class ChildApis{

  static Future<void> AddChild(
      ChildModel child, {
        required Function onSuccess,
        required Function(String) onError,
      }) async {
    final String apiUrl = "http://downcare.runasp.net/api/Child";
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json",
          "Accept": "application/json",
        },
        body: jsonEncode(child.toJson()),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {

        await prefs.setString("childData", jsonEncode(child.toJson()));
        await prefs.setBool("isChildAdded", true);

        print(" تم إضافة الطفل بنجاح ");
        onSuccess();
      } else {
        print(" ${response.body}");
        onError("Failed to add the child !");
      }
    } catch (e) {

      onError("Server connection error. Please try again later.");
    }
  }



  static Future<List<LinguisticsSectionModel>> getLinguisticsDetails(String? level) async {

    Uri url = Uri.parse("http://downcare.runasp.net/api/Child/ActivityData");
    http.Response response = await http.get(
      url.replace(queryParameters: {"level":level}),
      headers: {
        "Accept": "application/json"
      },
    );
    if (response.statusCode == 200) {

      List<dynamic> jsonResponse = jsonDecode(response.body);

      List<LinguisticsSectionModel> dataList = jsonResponse.map((item) => LinguisticsSectionModel.fromJson(item)).toList();

      return dataList;
    } else {

      print(" فشل جلب البيانات: ${response.statusCode} - ${response.body}");
      throw Exception("فشل جلب البيانات");
    }
  }




  static Future<ChildReportModel?> getChildReport() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    final url = Uri.parse('http://downcare.runasp.net/api/Child/Report');

    try {
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': '*/*',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        return ChildReportModel.fromJson(data);
      } else {
        print(' ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('$e');
      return null;
    }
  }


  static Future<List<TestModel>> fetchQuestions(String level) async {

    final encodedLevel = Uri.encodeComponent(level);
    final url = Uri.parse('http://downcare.runasp.net/api/Child/TestData?level=$encodedLevel');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(utf8.decode(response.bodyBytes));
      return data.map((item) => TestModel.fromJson(item)).toList();
    } else {
      throw Exception('${response.statusCode}');
    }
  }

  static Future<List<TestModel>> fetchquestions(String level) async {
    final url = Uri.parse('http://downcare.runasp.net/api/Child/TestData?level=$level');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(utf8.decode(response.bodyBytes));
      return data.map((item) => TestModel.fromJson(item)).toList();
    } else {
      throw Exception('${response.statusCode}');
    }
  }

  static  Future<bool> updateScore({
    required String type,
    required String level,
    required int score,
  }) async {
    final url = Uri.parse('http://downcare.runasp.net/api/Child/Score');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    final response = await http.post(
      url,
      headers: {
        'accept': '*/*',
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'type': type,
        'level': level,
        'score': score,
      }),
    );
    if (response.statusCode == 200) {
      print("Success: ${response.body}");
      return true;
    } else {
      print("Failed: ${response.statusCode} - ${response.body}");
      return false;
    }
  }
}