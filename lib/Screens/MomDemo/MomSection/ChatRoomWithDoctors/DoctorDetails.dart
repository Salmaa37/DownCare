import 'package:downcare/Models/DocModel.dart';
import 'package:downcare/Modules/AppButton.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../../../Modules/ProfileCard.dart';
import '../../../../utils/Colors.dart';
import 'DoctorChat.dart';

class DoctorDetails extends StatelessWidget {
  static const String routeName = "doc details";

  const DoctorDetails({super.key});

  @override
  Widget build(BuildContext context) {
    var model = ModalRoute.of(context)?.settings.arguments as DocModel;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colours.primaryblue),
        backgroundColor: Colors.white,
        title: Text(
          "Dr. ${model.name}",
          style: TextStyle(color: Colours.primaryblue, fontSize: 18.sp),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(14.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child:CircleAvatar(
                  backgroundColor:Colours.primaryblue,
                  radius: 100,
                  backgroundImage: model.image.isNotEmpty
                      ? NetworkImage(model.image)
                      : null,
                  child: model.image.isEmpty
                      ? Text(
                    model.name.isNotEmpty ? model.name[0].toUpperCase() : "?",
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  )
                      : null,
                ),
              ),
              SizedBox(height: 2.h),
              _buildDetailSection("User Name", model.name),
              _buildDetailSection("Email", model.email),
              _buildDetailSection("Phone", model.phone),
              _buildDetailSection("Governorate", model.Governorate),
              _buildDetailSection("Specialization", model.bio)
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        padding: EdgeInsets.zero,
        elevation: 0,
        child: Center(
          child: Padding(
            padding: EdgeInsets.only(bottom: 1.h),
            child: AppButton(
              txt: "Connect",
              onclick: () {

                Navigator.pushReplacementNamed(
                  context,
                  DoctorChat.routeName,
                  arguments: model,
                );
              },
              colorbtn: Colours.primaryyellow,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDetailSection(String title, String? value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(color: Colours.primaryblue, fontSize: 16.sp),
        ),
        ProfileCard(label: value ?? "Not Available"),
        SizedBox(height: 1.h),
      ],
    );
  }
}
