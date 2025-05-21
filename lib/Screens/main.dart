
import 'package:downcare/utils/AppTheme.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../utils/AppRoutes.dart';
import 'Welcome.dart';
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}
class MyApp extends StatefulWidget {
  State<MyApp> createState() => _MyAppState();
}
class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, screenType) {
        return MaterialApp(
          theme: AppTheme.apptheme,
          initialRoute: Welcome.routeName,
          debugShowCheckedModeBanner: false,
          routes: AppRoutes.routes,
        );
      },
    );
  }
}
