
import 'package:downcare/Screens/Welcome.dart';
import 'package:downcare/utils/AppTheme.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import '../utils/AppRoutes.dart';
void main (){

  runApp(MyApp());

}
class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  void initState() {
    super.initState();
    checkChildStatusOnStart();
  }

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, screenType) {
        return MaterialApp(
          theme:AppTheme.apptheme,
          initialRoute:Welcome.routeName,
          debugShowCheckedModeBanner: false,
          routes:AppRoutes.routes ,
        );
      },
    );
  }

  Future<void> checkChildStatusOnStart() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();


    await prefs.setBool("isChildAdded", false);

    print(" تم إعادة تعيين isChildAdded إلى false عند بدء التشغيل");


    bool childExists = await checkIfChildDataExistsLocally();


    if (childExists) {
      await prefs.setBool("isChildAdded", true);
      print(" تم العثور على بيانات الطفل محليًا، وتحديث isChildAdded إلى true");
    }
  }


  Future<bool> checkIfChildDataExistsLocally() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();


    String? childData = prefs.getString("childData");

    return childData != null && childData.isNotEmpty;
  }
}






















