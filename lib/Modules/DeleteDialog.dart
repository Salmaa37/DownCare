import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../utils/Colors.dart';
class DeleteDialog extends StatelessWidget {
  const DeleteDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Confirm',style: TextStyle(
        fontSize: 20.sp,
        fontWeight: FontWeight.bold,

      )),
      content: Text('Do you want to delete this message ?',style: TextStyle(
        fontSize: 17.sp,

      )),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, false),
          child: Text('Cancel',style: TextStyle(
              fontSize: 17.sp,
              color: Colours.primaryblue
          ),),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context, true),
          child: Text('Delete',style: TextStyle(
              color: Colors.red,
              fontSize: 17.sp
          ),),
        ),
      ],
    );
  }
}
