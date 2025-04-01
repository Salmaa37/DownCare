import 'package:downcare/Apis/ApiManager.dart';
import 'package:downcare/Screens/UserAccount/LoginBtn.dart';
import 'package:downcare/Screens/UserAccount/TxtField.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../Models/UserModel.dart';
import '../../ReusableComponents/Alert.dart';
import '../../utils/AppImages.dart';
import '../../utils/Colors.dart';
import 'Login.dart';
class SignUp extends StatefulWidget {
  static const String routeName ="signup";
   SignUp({super.key});
  @override
  State<SignUp> createState() => _SignUpState();
}
class _SignUpState extends State<SignUp> {
  bool secure = true;
  String selectedRole ="";
 final usernameController=TextEditingController();
  final emailController=TextEditingController();
  final passwordController=TextEditingController();
  final confirmPasswordController=TextEditingController();
  final phoneController=TextEditingController();
  final governorateController=TextEditingController();
  final roleController=TextEditingController();
  final k =GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset("${AppImages.loginbg}",
          fit: BoxFit.fill,
          width: double.infinity,),
        Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: Colors.transparent,
          body: Padding(
            padding:  EdgeInsets.symmetric(
                vertical: 4.h,
                horizontal: 2.w
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(text: "SIGN UP\n ", style: TextStyle(color: Colours.primaryblue, fontSize:25.sp)),
                        TextSpan(text: 'with DownCare',
                            style: TextStyle(
                                color:Colors.black ,
                                fontSize: 15.sp,
                                fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                 SizedBox(
                   height:15.h ,
                 ),
                 Form(
                   key: k,
                   child: Column(
                     spacing: 2.h,
                     children: [
                       TxtField(hinttxt: "User name", controller: usernameController, cardcolor: Colours.primaryblue, hintcolor: Colors.white,stylecolor: Colors.white,),
                       TxtField(hinttxt: "Email", controller:emailController, cardcolor: Colours.primaryblue, hintcolor: Colors.white,stylecolor: Colors.white,),
                       Container(
                         decoration: BoxDecoration(
                             color:Colours.primaryblue,
                             borderRadius: BorderRadius.circular(20)
                         ),
                         padding: EdgeInsets.symmetric(
                             horizontal: 2.w
                         ),
                         child: TextFormField(
                           obscureText: secure,
                           style: TextStyle(
                               fontSize: 16.sp,
                               color: Colors.white
                           ),
                           controller: passwordController,
                           keyboardType: TextInputType.emailAddress,
                           decoration: InputDecoration(
                               suffixIcon: IconButton(onPressed: (){
                                 secure? Icons.visibility : Icons.visibility_off;
                                 setState(() {
                                   secure = !secure;
                                 });
                               }, icon: Icon(Icons.remove_red_eye_outlined,color: Colors.white,)),
                               border: InputBorder.none,
                               hintStyle: TextStyle(
                                   fontSize: 16.sp,
                                   color: Colors.white
                               ),
                               hintText: "Password"
                           ),
                         ),
                       ),
                       Container(
                         decoration: BoxDecoration(
                             color:Colours.primaryblue,
                             borderRadius: BorderRadius.circular(20)
                         ),
                         padding: EdgeInsets.symmetric(
                             horizontal: 2.w
                         ),
                         child: TextFormField(
                           obscureText: secure,
                           style: TextStyle(
                               fontSize: 16.sp,
                               color: Colors.white
                           ),
                           controller: confirmPasswordController,
                           keyboardType: TextInputType.emailAddress,
                           decoration: InputDecoration(
                               suffixIcon: IconButton(onPressed: (){
                                 secure? Icons.visibility : Icons.visibility_off;
                                 setState(() {
                                   secure = !secure;
                                 });
                               }, icon: Icon(Icons.remove_red_eye_outlined,color: Colors.white,)),
                               border: InputBorder.none,
                               hintStyle: TextStyle(
                                   fontSize: 16.sp,
                                   color: Colors.white
                               ),
                               hintText: "Confirm Password"
                           ),
                         ),
                       ),
                       TxtField(hinttxt: "Phone", controller: phoneController, cardcolor: Colours.primaryblue, hintcolor: Colors.white,stylecolor: Colors.white,),
                       TxtField(hinttxt: "Governorate", controller: governorateController, cardcolor: Colours.primaryblue, hintcolor: Colors.white,stylecolor: Colors.white,),
                       Center(
                         child: Text("Please select your role ",style: TextStyle(
                           color: Colours.primaryblue,
                           fontSize: 18.sp
                         ),),
                       ),
                       Row(
                         mainAxisAlignment: MainAxisAlignment.spaceAround,
                         children: [
                           InkWell(
                             onTap: () {
                               selectedRole="mom";
                               print(selectedRole);
                               setState(() {

                               });
                             },
                             child: Column(
                               children: [
                                 Image.asset("assets/images/momrole.png",width: 15.w,),
                                 Text("Mom")
                               ],
                             ),
                           ),
                           InkWell(
                             onTap: () {
                               selectedRole="doctor";
                               setState(() {

                               });
                             },
                             child: Column(
                               children: [
                                 Image.asset("assets/images/docrole.png",width: 15.w,),
                                 Text("Doctor")
                               ],
                             ),
                           )
                         ],)])
                 )],
              ),
            ),
          ),
          bottomNavigationBar: Padding(
            padding:  EdgeInsets.only(
                bottom: 1.h
            ),
            child: BottomAppBar(
              color: Colors.white,
              padding: EdgeInsets.zero,
              elevation: 0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: LoginBtn(txt: "Confirm", onclick: (){
                      if(k.currentState!.validate()){
                        UserModel usermodel=
                        UserModel(userName: usernameController.text, email: emailController.text, governorate: governorateController.text, role: selectedRole, phone: phoneController.text);
                        ApiManager.signUpUser(usermodel,
                            onError: (error) {
                              showDialog(context: context, builder: (context) {
                                return Alert(txt: "$error",title: "Error!",titleColor: Colors.red,);
                              },);
                            },
                            password: passwordController.text,
                            Confirmpassword:confirmPasswordController.text ,
                            onsuccess: (selectedRole){
                              showDialog(context: context, builder: (context) {
                                return Alert(txt: "Please check your email", title: "Account created successfully !", titleColor: Colors.green);

                              },);
                            });
                      }
                    }),
                  ),
                  SizedBox(
                    height: 0.3.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("if you have an account ",style: TextStyle(
                        fontSize: 16.sp
                      ),),
                      GestureDetector(
                        onTap: (){
                          Navigator.pushNamed(context, Login.routeName);
                        },
                        child: Text("LOG IN ",style: TextStyle(
                          color: Colours.primaryblue,
                          fontSize: 17.sp
                        ),),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),),
      ],
    );
  }
}


