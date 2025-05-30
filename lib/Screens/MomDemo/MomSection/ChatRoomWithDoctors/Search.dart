import 'dart:async';
import 'package:downcare/Apis/User/UserApis.dart';
import 'package:downcare/utils/Colors.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../../../Models/DocModel.dart';
import 'DoctorDetails.dart';

class DoctorSearchScreen extends StatefulWidget {
  static const String routeName = "search";

  @override
  _DoctorSearchScreenState createState() => _DoctorSearchScreenState();
}

class _DoctorSearchScreenState extends State<DoctorSearchScreen> {
  List<DocModel> _allDoctors = [];
  List<DocModel> _filteredDoctors = [];
  bool _isLoading = false;
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    _fetchAllDoctors();
  }

  Future<void> _fetchAllDoctors() async {
    setState(() => _isLoading = true);
    try {
      final doctors = await UserApis.getdoctors("");
      setState(() {
        _allDoctors = doctors;
        _filteredDoctors = doctors;
      });
    } catch (e) {
      print("Error fetching doctors: $e");
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(Duration(milliseconds: 500), () {
      _filterDoctors(query);
    });
  }

  void _filterDoctors(String query) {
    if (query.isEmpty) {
      setState(() {
        _filteredDoctors = _allDoctors;
      });
    } else {
      setState(() {
        _filteredDoctors = _allDoctors.where((doctor) {
          final nameLower = doctor.name.toLowerCase();
          final governorateLower = doctor.Governorate.toLowerCase();
          final searchLower = query.toLowerCase();
          return nameLower.contains(searchLower) || governorateLower.contains(searchLower);
        }).toList();
      });
    }
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
            : _filteredDoctors.isEmpty
            ? Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/images/bluedoc.png", width: 20.w),
              Text(
                "No doctors found",
                style: TextStyle(color: Colors.grey, fontSize: 15.sp),
              ),
            ],
          ),
        )
            : ListView.separated(
          separatorBuilder: (context, index) => SizedBox(height: 1.h),
          itemCount: _filteredDoctors.length,
          itemBuilder: (context, index) {
            final doctor = _filteredDoctors[index];
            return GestureDetector(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  DoctorDetails.routeName,
                  arguments: doctor,
                );
              },
              child: Card(

                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 3,
                child: Padding(
                  padding: EdgeInsets.all(12),
                  child: Row(
                    children: [

                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: doctor.image.isNotEmpty
                            ? Image.network(
                          doctor.image,
                          width: 15.w,
                          height: 15.w,
                          fit: BoxFit.cover,
                        )
                            : Container(
                          width: 15.w,
                          height: 15.w,
                          color: Colours.primaryblue, 
                          child: Center(
                            child: Text(
                              doctor.name.isNotEmpty ? doctor.name[0].toUpperCase() : "?",
                              style: TextStyle(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      )
                      ,
                      SizedBox(width: 4.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              " ${doctor.name}",
                              style: TextStyle(
                                color: Colours.primaryblue,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 0.5.h),
                            Text(
                              doctor.Governorate,
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 12.sp,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Icon(Icons.arrow_forward_ios, size: 18, color: Colours.primaryblue),
                    ],
                  ),
                ),
              ),
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

