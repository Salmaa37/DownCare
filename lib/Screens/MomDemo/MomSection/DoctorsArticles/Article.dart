import 'package:downcare/Apis/Article/ArticleApis.dart';
import 'package:downcare/utils/Colors.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
class Article extends StatelessWidget {
  static const String routeName = "article";
  const Article({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Articles of other doctors",
          style: TextStyle(fontSize: 17.sp),
        ),
        backgroundColor: Colours.primaryblue,

      ),
      body: FutureBuilder(
        future: ArticleApis.getArticles(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator(color: Colours.primaryblue));
          }
          if (snapshot.hasError) {
            return Center(child: Text("Something went wrong!"));
          }
          if (!snapshot.hasData || (snapshot.data as List).isEmpty) {
            return Center(
              child: Text(
                "No articles published yet!",
                style: TextStyle(fontSize: 17.sp),
              ),
            );
          }

          return Padding(
            padding: EdgeInsets.all(12),
            child: ListView.separated(
              itemCount: snapshot.data?.length ?? 0,
              separatorBuilder: (context, index) => SizedBox(height: 2.h),
              itemBuilder: (context, index) {
                final article = snapshot.data![index];
                return Container(
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colours.primarygrey,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 6,
                        offset: Offset(0, 3),
                      )
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
                            Icons.calendar_month_outlined,
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
                      )
                    ],
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
