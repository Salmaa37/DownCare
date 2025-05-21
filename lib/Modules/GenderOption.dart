import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../utils/Colors.dart';


class GenderOption extends StatelessWidget {
  final String value;
  final String imagePath;
  final String label;
  final String selectedGender;
  final Function(String) onSelect;

  const GenderOption({
    super.key,
    required this.value,
    required this.imagePath,
    required this.label,
    required this.selectedGender,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    bool isSelected = selectedGender == value;

    return InkWell(
      onTap: () => onSelect(value),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        padding: EdgeInsets.all(1.h),
        decoration: BoxDecoration(
          color: isSelected ? Colours.primaryblue.withOpacity(0.2) : Colors.transparent,
          border: Border.all(
            color: isSelected ? Colours.primaryblue : Colors.transparent,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Image.asset(imagePath, width: 20.w),
            SizedBox(height: 1.h),
            Text(
              label,
              style: TextStyle(
                fontSize: 17.sp,
                color: isSelected ? Colours.primaryblue : Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
