import 'dart:convert';
import 'package:downcare/Models/LinguisticsSectionModel.dart';
import 'package:downcare/Models/LoginUserModel.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../Models/DocModel.dart';
class Api {
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

    print("🔍 Response Status Code: ${response.statusCode}");
    print("📝 Response Body: ${response.body}");

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      print("✅ بيانات المستخدم: $jsonResponse"); // ✅ تأكد أن البيانات صحيحة
      return LoginUserModel.fromJson(jsonResponse);
    } else {
      print("❌ فشل جلب البيانات : ${response.statusCode} - ${response.body}");
      throw Exception("فشل جلب البيانات");
    }
  }



  static Future<void> updateProfile(LoginUserModel user,{required Function onSuccess}) async {
    try {
      Uri url = Uri.parse("http://downcare.runasp.net/api/User");
      SharedPreferences prefs = await SharedPreferences.getInstance();

      String? token = prefs.getString('token');

      var request = http.MultipartRequest('PUT', url);


      request.headers.addAll({
        "Authorization": "Bearer $token",
        "Accept": "application/json"
      });

      request.fields['Name'] = user.userName;
      request.fields['Email'] = user.email;
      request.fields['Phone'] = user.phone;
      request.fields['Governate'] = user.governorate;

      if (user.bio != null) {
        request.fields['Specialization'] = user.bio!;
      }

      if (user.imagePath != null && user.imagePath!.isNotEmpty) {
        request.files.add(await http.MultipartFile.fromPath(
          'ImageFile',
          user.imagePath!,
        ));
      }

      var response = await request.send();


      var responseBody = await response.stream.bytesToString();

      if (response.statusCode == 200) {
        print("✅ تحديث البيانات بنجاح: $responseBody");
        onSuccess();
      } else {
        print("❌ فشل تحديث البيانات: ${response.statusCode} - $responseBody");
      }
    } catch (e) {
      print("❌ خطأ أثناء التحديث: $e");
    }
  }




  static Future<List<LinguisticsSectionModel>> getLinguisticsDetails(String? type) async {

    Uri url = Uri.parse("http://downcare.runasp.net/api/Child/ActivityData");
    http.Response response = await http.get(
      url.replace(queryParameters: {"type":type}),
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


}
