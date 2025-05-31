import 'package:downcare/Apis/Article/ArticleApis.dart';
import 'package:downcare/utils/Colors.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class OtherDoctorsArticles extends StatelessWidget {
  static const String routeName = "articles";
  const OtherDoctorsArticles({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Articles of other doctors",
          style: TextStyle(fontSize: 17.sp),
        ),
        backgroundColor: Colours.primaryblue,
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: ArticleApis.getArticles(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator(color: Colours.primaryblue));
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                "Something went wrong! Try again",
                style: TextStyle(color: Colors.red, fontSize: 16.sp),
              ),
            );
          }

          return Padding(
            padding: const EdgeInsets.all(12.0),
            child: ListView.separated(
              itemCount: snapshot.data?.length ?? 0,
              separatorBuilder: (context, index) => SizedBox(height: 2.h),
              itemBuilder: (context, index) {
                final article = snapshot.data![index];
                return TweenAnimationBuilder<double>(
                  tween: Tween<double>(begin: 0, end: 1),
                  duration: Duration(milliseconds: 400 + (index * 100)),
                  builder: (context, value, child) {
                    return Opacity(
                      opacity: value,
                      child: Transform.translate(
                        offset: Offset(0, (1 - value) * 30),
                        child: child,
                      ),
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: Colours.primarygrey,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.yellow.shade100.withOpacity(0.6),
                          blurRadius: 8,
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              backgroundColor: Colours.primaryblue,
                              radius: 18,
                              backgroundImage: article.imageUrl?.isNotEmpty ?? false
                                  ? NetworkImage(article.imageUrl!)
                                  : null,
                              child: article.imageUrl?.isNotEmpty ?? false
                                  ? null
                                  : Text(
                                article.userName[0].toUpperCase(),
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                            SizedBox(width: 3.w),
                            Text(
                              article.userName,
                              style: TextStyle(
                                fontSize: 15.sp,
                                color: Colours.primaryblue,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 2.h),
                        Text(
                          article.content,
                          style: TextStyle(
                            fontSize: 14.5.sp,
                            height: 1.5,
                            color: Colors.black87,
                          ),
                        ),
                        SizedBox(height: 2.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Icon(
                              Icons.calendar_today_outlined,
                              color: Colours.primaryblue,
                              size: 4.w,
                            ),
                            SizedBox(width: 1.w),
                            Text(
                              "${article.date.day.toString().padLeft(2, '0')}-"
                                  "${article.date.month.toString().padLeft(2, '0')}-"
                                  "${article.date.year}",
                              style: TextStyle(
                                fontSize: 12.sp,
                                color: Colors.grey.shade700,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
