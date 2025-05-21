import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../utils/Colors.dart';


class InputField extends StatelessWidget {
  final TextEditingController controller;
  final String? hint;

  const InputField({super.key, required this.controller, this.hint});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 1.h),
      padding: EdgeInsets.only(left: 2.w),
      decoration: BoxDecoration(
        color: Colours.primarygrey,
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hint,
          hintStyle: TextStyle(color: Colors.grey.shade600),
        ),
      ),
    );
  }
}
