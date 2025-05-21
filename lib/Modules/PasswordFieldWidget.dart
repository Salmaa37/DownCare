import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../utils/Colors.dart';

class PasswordFieldWidget extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final bool isSecure;
  final VoidCallback toggleSecure;

  const PasswordFieldWidget({
    required this.label,
    required this.controller,
    required this.isSecure,
    required this.toggleSecure,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 1.5.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: TextStyle(color: Colours.primaryblue, fontSize: 16.sp)),
          SizedBox(height: 1.h),
          Container(
            padding: EdgeInsets.only(left: 2.w),
            decoration: BoxDecoration(
              color: Colours.primarygrey,
              borderRadius: BorderRadius.circular(20),
            ),
            child: TextField(
              controller: controller,
              obscureText: isSecure,
              decoration: InputDecoration(
                suffixIcon: IconButton(
                  onPressed: toggleSecure,
                  icon: Icon(
                    isSecure ? Icons.visibility : Icons.visibility_off,
                    color: Colours.primaryblue,
                  ),
                ),
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
