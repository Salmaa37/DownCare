import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../utils/Colors.dart';

class RoleSelector extends StatelessWidget {
  final String selectedRole;
  final Function(String) onRoleSelected;

  const RoleSelector({
    super.key,
    required this.selectedRole,
    required this.onRoleSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("Please select your role",
            style: TextStyle(color: Colours.primaryblue, fontSize: 18.sp)),
        SizedBox(height: 2.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _roleOption("mom", "assets/images/momrole.png", "Mom"),
            _roleOption("doctor", "assets/images/docrole.png", "Doctor"),
          ],
        ),
      ],
    );
  }

  Widget _roleOption(String role, String imagePath, String label) {
    bool isSelected = selectedRole == role;
    return InkWell(
      onTap: () => onRoleSelected(role),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        padding: EdgeInsets.all(1.h),
        decoration: BoxDecoration(
          color: isSelected
              ? Colours.primaryblue.withOpacity(0.2)
              : Colors.transparent,
          border: Border.all(
            color: isSelected ? Colours.primaryblue : Colors.transparent,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Image.asset(imagePath, width: 15.w),
            SizedBox(height: 1.h),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? Colours.primaryblue : Colors.black,
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ),
      ),
    );
  }
}
