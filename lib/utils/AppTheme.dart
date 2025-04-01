import 'package:downcare/utils/Colors.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
class AppTheme{
  static ThemeData apptheme = ThemeData(

      bottomNavigationBarTheme: BottomNavigationBarThemeData(
          type: BottomNavigationBarType.shifting,
          unselectedItemColor: Colors.white,
          selectedItemColor: Colors.white,
          elevation: 0,
          selectedLabelStyle: TextStyle(
            fontSize: 14.sp,
          )),
      dividerTheme: DividerThemeData(
          color: Colors.transparent
      ),
      appBarTheme: AppBarTheme(
          titleTextStyle:TextStyle(
              fontFamily:"Inknut Antiqua" ,
              color: Colors.white,
              fontSize: 16.sp
          ) ,
          iconTheme: IconThemeData(

            size: 9.w, color: Colors.white
          ),
          toolbarHeight: 80,
          titleSpacing: 0,
          color: Colours.primaryblue
      ),
      fontFamily: "Inknut Antiqua"
  );
}