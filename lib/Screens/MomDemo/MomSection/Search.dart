import 'dart:async';
import 'package:downcare/utils/Colors.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../../Apis/Api.dart';
import '../../../Models/DocModel.dart';
import 'DoctorDetails.dart';

class DoctorSearchScreen extends StatefulWidget {
  static const String routeName = "search";

  @override
  _DoctorSearchScreenState createState() => _DoctorSearchScreenState();
}

class _DoctorSearchScreenState extends State<DoctorSearchScreen> {
  List<DocModel> _doctors = [];
  bool _isLoading = false;
  Timer? _debounce;

  Future<void> _searchDoctors(String query) async {
    if (query.isEmpty) {
      setState(() => _doctors = []);
      return;
    }

    setState(() => _isLoading = true);

    try {
      final doctors = await Api.getdoctors(query);
      setState(() => _doctors = doctors);
    } catch (e) {
      print("Error fetching doctors: $e");
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(Duration(milliseconds: 500), () {
      _searchDoctors(query);
    });
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Top Doctors"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colours.primarygrey,
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextField(
                style: TextStyle(
                  color: Colours.primaryblue,
                  fontWeight: FontWeight.w600,
                ),
                decoration: InputDecoration(
                  hintStyle: TextStyle(
                    color: Colours.primaryblue,
                    fontSize: 15.sp,
                  ),
                  hintText: 'Enter doctor name or governorate',
                  border: InputBorder.none,
                  prefixIcon: Icon(Icons.search, color: Colours.primaryblue),
                  contentPadding: EdgeInsets.symmetric(vertical: 10),
                ),
                onChanged: _onSearchChanged,
              ),
            ),
            SizedBox(height: 2.h),
            Expanded(
              child: _isLoading
                  ? Center(child: CircularProgressIndicator())
                  : _doctors.isEmpty
                  ? Center(child: Column(
                 mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset("assets/images/bluedoc.png",width: 20.w,),
                      Text("No doctors found", style: TextStyle(color: Colors.grey,fontSize: 15.sp)),
                    ],
                  ))
                  : ListView.separated(
                separatorBuilder: (context, index) => Divider(),
                itemCount: _doctors.length,
                itemBuilder: (context, index) {
                  final doctor = _doctors[index];
                  return ListTile(
                    title: Text(
                      "Dr. ${doctor.name}",
                      style: TextStyle(
                        color: Colours.primaryblue,
                        fontSize: 17.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    trailing: Icon(Icons.arrow_forward_ios, size: 16, color: Colours.primaryblue),
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        DoctorDetails.routeName,
                        arguments: doctor,
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
