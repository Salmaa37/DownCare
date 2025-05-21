
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../Models/UserModel.dart';
class AccountApis{
  static Future<void> signUpUser(
      UserModel user, {
        required String password,
        required String Confirmpassword,
        required Function onsuccess,
        required Function(String) onError,
      }) async {
    final String apiUrl = "http://downcare.runasp.net/api/account/register";

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
        },
        body: jsonEncode({
          "confirmPassword": Confirmpassword,
          "role": user.role,
          "governate": user.governorate,
          "phone": user.phone,
          "userName": user.userName,
          "email": user.email,
          "password": password,
        }),
      );

      print("Response Status: ${response.statusCode}");
      print("Response Body: ${response.body}");

      if (response.statusCode == 200) {
        print("تم التسجيل بنجاح: ${response.body}");


        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('userRole', user.role);

        onsuccess(user.role);
      } else {
        print(" ${response.statusCode} - ${response.body}");

        String errorMessage = 'UnExpected Error !';

        try {
          final Map<String, dynamic> responseData = jsonDecode(response.body);

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

          } else {
            errorMessage = response.body;
          }

        } catch (e) {

          errorMessage = "UnExpected Error ! Please try again .";
        }

        onError(errorMessage);
      }
    } catch (e) {

      onError("Server connection error. Please try again later.");
    }
  }


  static Future<void> logInUser(
      String email,
      String password, {
        required Function onsuccess,
        required Function(String) onError,
      }) async {
    final String apiUrl = "http://downcare.runasp.net/api/account/login";

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
        },
        body: jsonEncode({
          "email": email,
          "password": password,
        }),
      );

      print("Response Status: ${response.statusCode}");
      print("Response Body: ${response.body}");

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);

        if (responseData.containsKey('token') && responseData.containsKey('role')) {
          String token = responseData['token'];
          String role = responseData['role'];

          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString('token', token);
          await prefs.setString('role', role);

          onsuccess();
        } else {
          onError("Login failed: Missing token or role.");
        }
      } else {
        String errorMessage = 'Unexpected error occurred.';

        try {
          final Map<String, dynamic> responseData = jsonDecode(response.body);

          if (responseData.containsKey('errors') && responseData['errors'] is Map) {
            Map<String, dynamic> errors = responseData['errors'];
            List<String> errorMessages = [];

            errors.forEach((key, value) {
              if (value is List) {
                errorMessages.addAll(value.map((e) => "$e"));
              }
            });

            errorMessage = errorMessages.join("\n");
          } else if (responseData.containsKey('Error') &&
              responseData['Error'] is List) {
            errorMessage = (responseData['Error'] as List).join("\n");
          } else if (responseData.containsKey('title')) {
            errorMessage = responseData['title'];
          } else {
            errorMessage = response.body;
          }
        } catch (e) {
          errorMessage = "Something went wrong. Please try again.";
        }

        onError(errorMessage);
      }
    } catch (e) {
      onError("Could not connect to the server. Check your internet connection.");
    }
  }



  static Future<void> ChangePass(currentPassword,newPassword,confirmNewPassword,
      {required Function onSuccess,required Function(String) onError,
      }) async {
    final String apiUrl = "http://downcare.runasp.net/api/User/ChangePassword";
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          "Authorization":"Bearer $token",


        },
        body: jsonEncode({
          "currentPassword": currentPassword,
          "newPassword": newPassword,
          "confirmPassword":confirmNewPassword,
        }),
      );

      print("Response Status: ${response.statusCode}");
      print("Response Body: ${response.body}");

      if (response.statusCode == 200) {
        print("تم تغيير كلمة السر بنجاح");
        onSuccess();
      } else {
        print(" ${response.body}");

        String errorMessage = 'UnExpected error ! Olease try again .';

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

            } else if (responseData.containsKey('message')) {
              errorMessage = responseData['message'];

            } else if (responseData.containsKey('title')) {
              errorMessage = responseData['title'];

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

      onError("Server connection error. Please try again later");
    }
  }



  static Future<void> forgetpass(
      String email, {
        required Function onSuccess,
        required Function(String) onError,
      }) async {
    final String apiUrl = "http://downcare.runasp.net/api/Account/ForgetPassword";

    try {
      final Uri url = Uri.parse(apiUrl).replace(queryParameters: {"email": email});

      final response = await http.post(
        url,
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
        },
      );

      print("Response Status: ${response.statusCode}");
      print("Response Body: ${response.body}");

      if (response.statusCode == 200) {
        onSuccess();
        print("تم إرسال كود  بنجاح");
      } else {
        print("${response.body}");

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

      onError("Server connection error. Please try again later");
    }
  }





  static Future<void> code(
      String email,
      String code, {
        required Function onSuccess,
        required Function(String) onError,
      }) async {
    final String apiUrl = "http://downcare.runasp.net/api/Account/verify-reset-code";
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Authorization': 'Bearer $token',
          "Accept": "application/json",
          "Content-Type": "application/json",
        },
        body: jsonEncode({
          "email": email,
          "code": code,
        }),
      );

      print("Response Status: ${response.statusCode}");
      print("Response Body: ${response.body}");

      if (response.statusCode == 200) {
        print("تم التاكد من الكود بنجاح");
        onSuccess();
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

      onError("Server connection error. Please try again later");
    }
  }



  static Future<void> resetpass(
      String email,
      String code,
      String password,
      String confirmpass, {
        required Function onSuccess,
        required Function(String) onError,
      }) async {

    final String apiUrl = "http://downcare.runasp.net/api/Account/ResetPassword";
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Authorization': 'Bearer $token',
          "Accept": "application/json",
          "Content-Type": "application/json",
        },
        body: jsonEncode({
          "email": email,
          "code": code,
          "password": password,
          "confirmPassword": confirmpass,
        }),
      );

      print("Response Status: ${response.statusCode}");
      print("Response Body: ${response.body}");

      if (response.statusCode == 200) {
        print("تم تغيير كلمة السر بنجاح");
        onSuccess();
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
      onError("Server connection error. Please try again later");
    }
  }

}