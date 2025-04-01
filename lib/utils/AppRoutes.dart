import 'package:flutter/cupertino.dart';
import '../Screens/DoctorDemo/ChangeDoctorPass.dart';
import '../Screens/DoctorDemo/ChatRooms.dart';
import '../Screens/DoctorDemo/DoctorArticle.dart';
import '../Screens/DoctorDemo/DoctorEditProfile.dart';
import '../Screens/DoctorDemo/DoctorProfile.dart';
import '../Screens/DoctorDemo/OtherDoctorsArticles.dart';
import '../Screens/DoctorDemo/WelcomeDoc.dart';
import '../Screens/HomeScreen.dart';
import '../Screens/MomDemo/ChildSection/ChildData.dart';
import '../Screens/MomDemo/ChildSection/ChildReport.dart';
import '../Screens/MomDemo/ChildSection/ChildSection.dart';
import '../Screens/MomDemo/ChildSection/Communication/LevelDetails.dart';
import '../Screens/MomDemo/ChildSection/Communication/LevelTest.dart';
import '../Screens/MomDemo/ChildSection/Communication/SectionLevels.dart';
import '../Screens/MomDemo/ChildSection/Communication/TestResult.dart';
import '../Screens/MomDemo/ChildSection/Linguistics/LinguisticsDetails.dart';
import '../Screens/MomDemo/ChildSection/Linguistics/LinguisticsLevels.dart';
import '../Screens/MomDemo/ChildSection/Linguistics/LinguisticsResult.dart';
import '../Screens/MomDemo/ChildSection/Linguistics/LinguisticsTest.dart';
import '../Screens/MomDemo/ChildSection/SkillsDevelopment/SkillsDevelopment.dart';
import '../Screens/MomDemo/MomSection/AboutDown.dart';
import '../Screens/MomDemo/MomSection/Article.dart';
import '../Screens/MomDemo/MomSection/DoctorChat.dart';
import '../Screens/MomDemo/MomSection/DoctorDetails.dart';
import '../Screens/MomDemo/MomSection/Feedbacks.dart';
import '../Screens/MomDemo/MomSection/MomChat.dart';
import '../Screens/MomDemo/MomSection/MomSection.dart';
import '../Screens/MomDemo/MomSection/Search.dart';
import '../Screens/SplashScreen.dart';
import '../Screens/UserAccount/ChangePass.dart';
import '../Screens/UserAccount/EditProfile.dart';
import '../Screens/UserAccount/ForgotPass.dart';
import '../Screens/UserAccount/Login.dart';
import '../Screens/UserAccount/PassCode.dart';
import '../Screens/UserAccount/Profile.dart';
import '../Screens/UserAccount/ResetPass.dart';
import '../Screens/UserAccount/SignUp.dart';
import '../Screens/Welcome.dart';
class AppRoutes {
  static Map<String, WidgetBuilder> routes = {
    ChildReport.routeName:(context)=>ChildReport(),
    ChildData.routeName:(context)=>ChildData(),
    DoctorEditProfile.routeName: (context) => DoctorEditProfile(),
    DoctorProfile.routeName: (context) => DoctorProfile(),
    ChangeDoctorPass.routeName: (context) => ChangeDoctorPass(),
    HomeScreen.routeName: (context) => HomeScreen(),
    MomSection.routeName: (context) => MomSection(),
    ChildSection.routeName: (context) => ChildSection(),
    Momchat.routeName: (context) => Momchat(),
    DoctorChat.routeName: (context) => DoctorChat(),
    SkillsDevelopment.routeName: (context) => SkillsDevelopment(),
    Welcome.routeName: (context) => Welcome(),
    Login.routeName: (context) => Login(),
    Feedbacks.routeName: (context) => Feedbacks(),
    AboutDown.routeName: (context) => AboutDown(),
    ForgotPass.routeName: (context) => ForgotPass(),
    ResetPass.routeName: (context) => ResetPass(),
    Profile.routeName: (context) => Profile(),
    EditProfile.routeName: (context) => EditProfile(),
    WelcomeDoc.routeName: (context) => WelcomeDoc(),
    SplahScreen.routeName: (context) => SplahScreen(),
    DoctorArticle.routeName: (context) => DoctorArticle(),
    OtherDoctorsArticles.routeName: (context) => OtherDoctorsArticles(),
    ChatRooms.routeName: (context) => ChatRooms(),
    Article.routeName: (context) => Article(),
    SignUp.routeName: (context) => SignUp(),
    ChangePass.routeName: (context) => ChangePass(),
    PassCode.routeName: (context) => PassCode(),
    DoctorSearchScreen.routeName: (context) => DoctorSearchScreen(),
    DoctorDetails.routeName: (context) => DoctorDetails(),
    SectionLevels.routeName: (context) => SectionLevels(),
    LevelDetails.routeName: (context) => LevelDetails(),
    LevelTest.routeName: (context) => LevelTest(),
    TestResult.routeName: (context) => TestResult(),
    LinguisticsLevels.routeName: (context) => LinguisticsLevels(),
    LinguisticsDetails.routeName: (context) => LinguisticsDetails(),
    LinguisticsTest.routeName: (context) => LinguisticsTest(),
    LinguisticsResult.routeName: (context) => LinguisticsResult(),
  };
}