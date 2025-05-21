import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../Models/DocModel.dart';
import '../../Models/LoginUserModel.dart';
class UserApis{
  static Future<LoginUserModel> profile() async {
    Uri url = Uri.parse("http://downcare.runasp.net/api/User");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    http.Response response = await http.get(
      url,
      headers: {
        "Authorization": "Bearer $token",
        "Accept": "application/json"
      },
    );

    print(" Response Status Code: ${response.statusCode}");
    print(" Response Body: ${response.body}");

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      print(" بيانات اليوزر : $jsonResponse");
      return LoginUserModel.fromJson(jsonResponse);
    } else {
      print(" فشل تحميل البيانات : ${response.statusCode} - ${response.body}");
      throw Exception("فشل تحميل البيانات");
    }
  }


  static Future<void> updateProfile(
      LoginUserModel user, {
        File? imageFile,
        required Function onSuccess,
        required Function(String) onError,
      }) async {
    try {
      Uri url = Uri.parse("http://downcare.runasp.net/api/User");
      SharedPreferences prefs = await SharedPreferences.getInstance();

      String? token = prefs.getString('token');

      var request = http.MultipartRequest('PUT', url);

      request.headers.addAll({
        "Authorization": "Bearer $token",
        "Accept": "application/json",
      });

      request.fields['Name'] = user.userName;
      request.fields['Email'] = user.email;
      request.fields['Phone'] = user.phone;
      request.fields['Governate'] = user.governorate;
      if (user.bio != null) {
        request.fields['Specialization'] = user.bio!;
      }

      if (imageFile != null) {
        request.files.add(await http.MultipartFile.fromPath(
          'ImageFile',
          imageFile.path,
        ));
      }

      var response = await request.send();
      var responseBody = await response.stream.bytesToString();

      if (response.statusCode == 200) {
        print("تحديث البيانات بنجاح: $responseBody");
        onSuccess();
      } else {
        print("فشل تحديث البيانات: ${response.statusCode} - $responseBody");
        final errorMessage = _extractErrorMessage(responseBody);
        onError(errorMessage);
      }
    } catch (e) {
      print("Exception: $e");
      onError("UnExpected error .Please try again !");
    }
  }

  static String _extractErrorMessage(String body) {
    try {
      final responseData = jsonDecode(body);

      if (responseData.containsKey('errors') && responseData['errors'] is Map) {
        Map<String, dynamic> errors = responseData['errors'];
        return errors.values.expand((e) => e).join("\n");
      } else if (responseData.containsKey('Error')) {
        return (responseData['Error'] as List).join("\n");
      } else if (responseData.containsKey('title')) {
        return responseData['title'];
      } else {
        return body;
      }
    } catch (_) {
      return "Server connection error. Please try again later.";
    }
  }

  static Future<List<DocModel>> getdoctors(String query) async {
    Uri url = Uri.parse("http://downcare.runasp.net/api/User/Search").replace(queryParameters: {
      "search":query
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    http.Response response = await http.get(
      url,
      headers: {
        "Authorization":"Bearer $token",
        "Accept": "application/json"
      },
    );
    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = jsonDecode(response.body);
      List<DocModel> docList = jsonResponse.map((item) => DocModel.fromJson(item)).toList();
      return docList;
    }
    print(" فشل عرض الفيدباك : ${response.statusCode} - ${response.body}");
    throw Exception("فشل جلب البيانات");
  }

  static Future<List<DocModel>> getDoctors() async {
    Uri url = Uri.parse("http://downcare.runasp.net/api/User/Doctors");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    http.Response response = await http.get(
      url,
      headers: {
        "Authorization":"Bearer $token",

        "Accept": "application/json"
      },
    );
    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = jsonDecode(response.body);
      List<DocModel> doctorList = jsonResponse.map((item) => DocModel.fromJson(item)).toList();

      return doctorList;
    }

    print(" فشل عرض الدكاترة : ${response.statusCode} - ${response.body}");
    throw Exception("فشل عرض الدكاترة ");
  }
}