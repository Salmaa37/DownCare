import 'dart:convert';
import 'package:downcare/Models/Article.dart';
import 'package:downcare/Models/Child.dart';
import 'package:downcare/Models/Feedback.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Models/UserModel.dart';
import 'package:http/http.dart' as http;
class ApiManager {
  static Future<void> signUpUser(UserModel user, {required String password, required String Confirmpassword, required Function onsuccess, required Function(String) onError, // Callback لعرض رسالة الخطأ
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
        onsuccess(user.role);
      } else {
        print("خطأ أثناء التسجيل: ${response.statusCode} - ${response.body}");

        String errorMessage = 'حدث خطأ غير متوقع';

        try {
          final Map<String, dynamic> responseData = jsonDecode(response.body);

          // 🔍 فحص أنواع مختلفة من الـ Keys للرسائل الخطأ
          if (responseData.containsKey('errors') && responseData['errors'] is Map) {
            // إذا كانت الأخطاء تحت Key اسمه "errors"
            Map<String, dynamic> errors = responseData['errors'];
            List<String> errorMessages = [];

            errors.forEach((key, value) {
              if (value is List) {
                errorMessages.addAll(value.map((e) => "$key: $e"));
              }
            });

            errorMessage = errorMessages.join("\n");

          } else if (responseData.containsKey('Error') && responseData['Error'] is List) {
            // إذا كانت الأخطاء تحت Key اسمه "Error" (كما في حالتك)
            errorMessage = (responseData['Error'] as List).join("\n");

          } else if (responseData.containsKey('title')) {
            // في حالة وجود عنوان عام للخطأ
            errorMessage = responseData['title'];

          } else {
            errorMessage = response.body;
          }

        } catch (e) {
          print("خطأ أثناء تحليل رسالة الـ JSON: $e");
          errorMessage = "حدث خطأ غير متوقع. برجاء المحاولة مرة أخرى.";
        }

        onError(errorMessage);
      }
    } catch (e) {
      print("خطأ في الاتصال: $e");
      onError("خطأ في الاتصال بالسيرفر. يرجى المحاولة لاحقًا.");
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

        if (responseData.containsKey('token')) {
          String token = responseData['token'];


          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString('token', token);

          // ✅ التحقق من نجاح الحفظ عبر استرجاع التوكن وطباعته
          String? savedToken = prefs.getString('token');
          print("✅ تم حفظ التوكن بنجاح: $savedToken");

          onsuccess();
        } else {
          onError("لم يتم العثور على التوكن في الاستجابة.");
        }
      } else {
        print("❌ فشل تسجيل الدخول: ${response.body}");

        String errorMessage = 'حدث خطأ غير متوقع';

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
          print("⚠️ خطأ أثناء تحليل JSON: $e");
          errorMessage = "حدث خطأ غير متوقع. برجاء المحاولة مرة أخرى.";
        }
        onError(errorMessage);
      }
    } catch (e) {
      print("⚠️ خطأ في الاتصال: $e");
      onError("خطأ في الاتصال بالسيرفر. يرجى المحاولة لاحقًا.");
    }
  }


  static Future<void> SendFeedback(
      String content, {
        required Function onSuccess,
        required Function(String) onError,
      }) async {
    final String apiUrl = "http://downcare.runasp.net/api/Feedback";

    try {

      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json",
          "Accept": "application/json",
        },
        body: jsonEncode({"content": content}),
      );
      print("Response Status: ${response.statusCode}");
      print("Response Body: ${response.body}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        onSuccess();
        print("تم نشر الفيدباك بنجاح");
      } else {
        print("فشل النشر: ${response.body}");

        String errorMessage = 'حدث خطأ غير متوقع. برجاء المحاولة مرة أخرى.';

        try {
          final responseBody = response.body;
          if (responseBody.startsWith('"') && responseBody.endsWith('"')) {
            errorMessage = responseBody.replaceAll('"', '');
          } else if (responseBody.isNotEmpty && !responseBody.startsWith('{')) {
            errorMessage = responseBody;
          } else {
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
          print("خطأ أثناء تحليل الـ JSON: $e");
          errorMessage = "حدث خطأ غير متوقع. برجاء المحاولة مرة أخرى.";
        }
        onError(errorMessage);
      }
    } catch (e) {
      print("خطأ في الاتصال: $e");
      onError("خطأ في الاتصال بالسيرفر. يرجى المحاولة لاحقًا.");
    }
  }



  static Future<List<FeedbackModel>> getFeedbacks() async {

    Uri url = Uri.parse("http://downcare.runasp.net/api/Feedback");
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
      List<FeedbackModel> feedbackList = jsonResponse.map((item) => FeedbackModel.fromJson(item)).toList();

      return feedbackList;
    }

    print(" فشل عرض الفيدباك : ${response.statusCode} - ${response.body}");
    throw Exception("فشل جلب البيانات");
  }


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
        print("فشل نشر المقال: ${response.body}");

        String errorMessage = 'حدث خطأ غير متوقع. برجاء المحاولة مرة أخرى.';

        try {
          final responseBody = response.body;

          // التحقق إذا كان الـ Response مجرد نص بدون JSON
          if (responseBody.startsWith('"') && responseBody.endsWith('"')) {
            errorMessage = responseBody.replaceAll('"', ''); // إزالة علامات التنصيص
          }
          else if (responseBody.isNotEmpty && !responseBody.startsWith('{')) {
            // إذا كان النص مباشر بدون JSON
            errorMessage = responseBody;
          }
          else {
            final Map<String, dynamic> responseData = jsonDecode(responseBody);

            if (responseData.containsKey('errors') && responseData['errors'] is Map) {
              // إذا كانت الأخطاء تحت Key اسمه "errors"
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
          print("خطأ أثناء تحليل الـ JSON: $e");
          errorMessage = "حدث خطأ غير متوقع. برجاء المحاولة مرة أخرى.";
        }

        onError(errorMessage);
      }

    } catch (e) {
      print("خطأ في الاتصال: $e");
      onError("خطأ في الاتصال بالسيرفر. يرجى المحاولة لاحقًا.");
    }
  }



  static Future<List<ArticleModel>> getArticles() async {

    Uri url = Uri.parse("http://downcare.runasp.net/api/Article");
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

      List<ArticleModel> articleList = jsonResponse.map((item) => ArticleModel.fromJson(item)).toList();

      return articleList;
    } else {

      print(" فشل جلب البيانات: ${response.statusCode} - ${response.body}");
      throw Exception("فشل جلب البيانات");
    }
  }


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
        // ✅ حفظ بيانات الطفل في SharedPreferences
        await prefs.setString("childData", jsonEncode(child.toJson()));
        await prefs.setBool("isChildAdded", true);

        print("✅ تم إضافة الطفل بنجاح وتخزين بياناته محليًا");
        onSuccess();
      } else {
        print("❌ فشل إضافة الطفل: ${response.body}");
        onError("فشل إضافة الطفل.");
      }
    } catch (e) {
      print("⚠️ خطأ في الاتصال: $e");
      onError("خطأ في الاتصال بالسيرفر. يرجى المحاولة لاحقًا.");
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
        print("تم تغيير كلمة المرور بنجاح");
        onSuccess();
      } else {
        print("فشل تغيير كلمة المرور: ${response.body}");

        String errorMessage = 'حدث خطأ غير متوقع. برجاء المحاولة مرة أخرى.';

        try {
          final responseBody = response.body;

          // التحقق إذا كان الـ Response مجرد نص بدون JSON
          if (responseBody.startsWith('"') && responseBody.endsWith('"')) {
            errorMessage = responseBody.replaceAll('"', ''); // إزالة علامات التنصيص المزدوجة
          }
          else if (responseBody.isNotEmpty && !responseBody.startsWith('{')) {
            // إذا كان النص بدون JSON (مباشر)
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
          print("خطأ أثناء تحليل الـ JSON: $e");
          errorMessage = "حدث خطأ غير متوقع. برجاء المحاولة مرة أخرى.";
        }

        onError(errorMessage);
      }
    } catch (e) {
      print("خطأ في الاتصال: $e");
      onError("خطأ في الاتصال بالسيرفر. يرجى المحاولة لاحقًا.");
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
        print("تم إرسال كود إعادة تعيين كلمة المرور بنجاح");
      } else {
        print("فشل الطلب: ${response.body}");

        String errorMessage = 'حدث خطأ غير متوقع. برجاء المحاولة مرة أخرى.';

        try {
          final responseBody = response.body;

          // التحقق إذا كان الـ Response مجرد نص بدون JSON
          if (responseBody.startsWith('"') && responseBody.endsWith('"')) {
            errorMessage = responseBody.replaceAll('"', ''); // إزالة علامات التنصيص
          }
          else if (responseBody.isNotEmpty && !responseBody.startsWith('{')) {
            // إذا كان النص بدون JSON (مباشر)
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
          print("خطأ أثناء تحليل الـ JSON: $e");
          errorMessage = "حدث خطأ غير متوقع. برجاء المحاولة مرة أخرى.";
        }

        onError(errorMessage);
      }

    } catch (e) {
      print("خطأ في الاتصال: $e");
      onError("خطأ في الاتصال بالسيرفر. يرجى المحاولة لاحقًا.");
    }
  }





  static Future<void> code(
      String email,
      String code, {
        required Function onSuccess,
        required Function(String) onError,
      }) async {
    final String apiUrl = "http://downcare.runasp.net/api/Account/verify-reset-code";

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
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
        print("فشل التحقق من الكود: ${response.body}");

        String errorMessage = 'حدث خطأ غير متوقع. برجاء المحاولة مرة أخرى.';

        try {
          final responseBody = response.body;

          // التحقق إذا كان الـ Response مجرد نص بدون JSON
          if (responseBody.startsWith('"') && responseBody.endsWith('"')) {
            errorMessage = responseBody.replaceAll('"', ''); // إزالة علامات التنصيص
          }
          else if (responseBody.isNotEmpty && !responseBody.startsWith('{')) {
            // إذا كان النص بدون JSON (مباشر)
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
          print("خطأ أثناء تحليل الـ JSON: $e");
          errorMessage = "حدث خطأ غير متوقع. برجاء المحاولة مرة أخرى.";
        }

        onError(errorMessage);
      }

    } catch (e) {
      print("خطأ في الاتصال: $e");
      onError("خطأ في الاتصال بالسيرفر. يرجى المحاولة لاحقًا.");
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

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
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
        print("تم تعيين كلمة المرور بنجاح");
        onSuccess();
      } else {
        print("فشل تعيين كلمة المرور: ${response.body}");

        String errorMessage = 'حدث خطأ غير متوقع. برجاء المحاولة مرة أخرى.';

        try {
          final responseBody = response.body;

          // التحقق إذا كان الـ Response مجرد نص بدون JSON
          if (responseBody.startsWith('"') && responseBody.endsWith('"')) {
            errorMessage = responseBody.replaceAll('"', ''); // إزالة علامات التنصيص
          }
          else if (responseBody.isNotEmpty && !responseBody.startsWith('{')) {
            // إذا كان النص بدون JSON (مباشر)
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
          print("خطأ أثناء تحليل الـ JSON: $e");
          errorMessage = "حدث خطأ غير متوقع. برجاء المحاولة مرة أخرى.";
        }

        onError(errorMessage);
      }

    } catch (e) {
      print("خطأ في الاتصال: $e");
      onError("خطأ في الاتصال بالسيرفر. يرجى المحاولة لاحقًا.");
    }
  }


}

























// static Future<void> sendFeedback(FeedbackModel feedback, {required Function onSuccess, required Function(String) onError}) async {
// final String apiUrl = "http://downcare.runasp.net/api/Feedback/AddFeedback";
//
// try {
// final response = await http.post(
// Uri.parse(apiUrl),
// headers: {
// "Authorization": "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJqdGkiOiJmZjFhNjFmYS05ZGE4LTQ1YWQtYWFhYi1hZGM3MDFjNmU2YTQiLCJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9uYW1laWRlbnRpZmllciI6IjkzMTQ2NTFmLWI2NzktNDM2OS1hOTUxLTNlN2M1NzYxNDFkNSIsImh0dHA6Ly9zY2hlbWFzLnhtbHNvYXAub3JnL3dzLzIwMDUvMDUvaWRlbnRpdHkvY2xhaW1zL25hbWUiOiJ5ZWhpYSIsImV4cCI6MTc3MTA5NjY2NCwiaXNzIjoiaHR0cDovL2xvY2FsaG9zdDo1MTczLyIsImF1ZCI6Imh0dHA6Ly9sb2NhbGhvc3Q6NDIwMC8ifQ.gO5h0s4k-Rv68tX8wo3Av8rNG8CafPKVsr0VMHuBi5o",
// "Content-Type": "application/json",
// "Accept": "application/json"
// },
// body: jsonEncode(feedback.toJson()),
// );
//
// if (response.statusCode == 200 || response.statusCode == 201) {
//
// onSuccess();
// print(" تم نشر الفيدباك بنجاح ");
// } else {
// print(response.statusCode);
// print(" فشل النشر : ${response.body}");
// onError(response.body);
// }
// } catch (e) {
// print(" خطأ في الاتصال: $e");
// onError(e.toString());
// }
// }
//
// static Future<void> AddChild(ChildModel child, {required Function onSuccess, required Function(String) onError}) async {
// final String apiUrl = "http://downcare.runasp.net/api/Child/AddChild";
//
// try {
// final response = await http.post(
// Uri.parse(apiUrl),
// headers: {
// "Authorization": "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJqdGkiOiJmZjFhNjFmYS05ZGE4LTQ1YWQtYWFhYi1hZGM3MDFjNmU2YTQiLCJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9uYW1laWRlbnRpZmllciI6IjkzMTQ2NTFmLWI2NzktNDM2OS1hOTUxLTNlN2M1NzYxNDFkNSIsImh0dHA6Ly9zY2hlbWFzLnhtbHNvYXAub3JnL3dzLzIwMDUvMDUvaWRlbnRpdHkvY2xhaW1zL25hbWUiOiJ5ZWhpYSIsImV4cCI6MTc3MTA5NjY2NCwiaXNzIjoiaHR0cDovL2xvY2FsaG9zdDo1MTczLyIsImF1ZCI6Imh0dHA6Ly9sb2NhbGhvc3Q6NDIwMC8ifQ.gO5h0s4k-Rv68tX8wo3Av8rNG8CafPKVsr0VMHuBi5o",
// "Content-Type": "application/json",
// "Accept": "application/json"
// },
// body: jsonEncode(child.toJson()),
// );
//
// if (response.statusCode == 200 || response.statusCode == 201) {
// final data = jsonDecode(response.body);
// onSuccess();
// print(" التسجيل ناجح: ${data}");
// } else {
// print(response.statusCode);
// print(" فشل التسجيل: ${response.body}");
// onError(response.body);
// }
// } catch (e) {
// print(" خطأ في الاتصال: $e");
// onError(e.toString());
// }
// }

//
// static Future<void> forgetpass(String email, {required Function onsuccess}) async {
// final String apiUrl = "http://downcare.runasp.net/api/Account/ForgetPassword";
//
// try {
// final Uri url = Uri.parse(apiUrl).replace(queryParameters: {"email": email});
//
// final response = await http.post(
// url,
// headers: {
// "Accept": "application/json",
// },
// );
//
// if (response.statusCode == 200) {
// print("Reset Password code has been sent to your email");
// onsuccess();
// } else {
// print(" فشل الطلب: ${response.statusCode} - ${response.body}");
// }
// } catch (e) {
// print(" خطأ في الاتصال: $e");
// }
// }
//
//
// static Future<void> code(String email, String code,{required Function onsuccess}) async {
// final String apiUrl = "http://downcare.runasp.net/api/Account/verify-reset-code";
// try {
// final response = await http.post(
// Uri.parse(apiUrl),
// headers: {  "Accept": "application/json",
// "Content-Type": "application/json",
// },
// body:  jsonEncode({
// "email":email,
// "code":code,
//
// }),
// );
// if (response.statusCode == 200) {
//
// print("تم التاكد من الكود بنجاح ");
// onsuccess();
//
// } else {
// print(" فشل : ${response.body}");
// }
// } catch (e) {
// print(" خطأ في الاتصال: $e");
// }
// }


