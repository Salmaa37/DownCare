import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../Models/Article.dart';
class ArticleApis{

  static Future<void> sendArticle(
      String content, {
        required Function onSuccess,
        required Function(String) onError,
      }) async {

    final String apiUrl = "http://downcare.runasp.net/api/Article";
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          "Authorization":"Bearer $token",

          "Content-Type": "application/json",
          "Accept": "application/json",
        },
        body: jsonEncode({
          "content":content
        }),
      );

      print("Response Status: ${response.statusCode}");
      print("Response Body: ${response.body}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        onSuccess();
        print("تم نشر المقال بنجاح");

      } else {
        print(" ${response.body}");

        String errorMessage = 'UnExpected error ! Please try again .';

        try {
          final responseBody = response.body;

          if (responseBody.startsWith('"') && responseBody.endsWith('"')) {
            errorMessage = responseBody.replaceAll('"', '');
          }
          else if (responseBody.isNotEmpty && !responseBody.startsWith('{')) {

            errorMessage = responseBody;
          }
          else {
            final Map<String, dynamic> responseData = jsonDecode(responseBody);

            if (responseData.containsKey('errors') && responseData['errors'] is Map) {

              Map<String, dynamic> errors = responseData['errors'];
              List<String> errorMessages = [];

              errors.forEach((key, value) {
                if (value is List) {
                  errorMessages.addAll(value.map((e) => "$key: $e"));
                }
              });

              errorMessage = errorMessages.join("\n");

            } else if (responseData.containsKey('Error') && responseData['Error'] is List) {
              errorMessage = (responseData['Error'] as List).join("\n");

            } else if (responseData.containsKey('title')) {
              errorMessage = responseData['title'];

            } else if (responseData.containsKey('message')) {
              errorMessage = responseData['message'];

            } else {
              errorMessage = responseBody;
            }
          }

        } catch (e) {

          errorMessage = "UnExpected error ! Please try again .";
        }

        onError(errorMessage);
      }

    } catch (e) {

      onError("Server connection error. Please try again later.");
    }
  }



  static Future<List<ArticleModel>> getArticles() async {

    Uri url = Uri.parse("http://downcare.runasp.net/api/Article");

    http.Response response = await http.get(
      url,
      headers: {
        "Accept": "application/json"
      },
    );

    if (response.statusCode == 200) {

      List<dynamic> jsonResponse = jsonDecode(response.body);

      List<ArticleModel> articleList = jsonResponse.map((item) => ArticleModel.fromJson(item)).toList();

      return articleList;
    } else {

      print("  ${response.statusCode} - ${response.body}");
      throw Exception("Failed to get articles !");
    }
  }
}