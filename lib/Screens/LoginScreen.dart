import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:goolemapuse/Screens/HomeScreen.dart';
import 'package:goolemapuse/Screens/LoginWithEmailPass.dart';
import 'package:goolemapuse/Screens/SignUpScreen.dart';
import 'package:goolemapuse/SigninBloc/SignInBlocMainEvents.dart';
import 'package:goolemapuse/SigninBloc/SignInBlocMainState.dart';
import 'package:goolemapuse/SigninBloc/SignInMainBloc.dart';

import '../auth/AuthMainBloc.dart';
import '../auth/AuthMainState.dart';
import '../utilities/SnackBarType.dart';



class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<StatefulWidget> createState (){
    return _LoginScreen();
  }

}

class _LoginScreen extends State<LoginScreen>{

  String? error;


   TextEditingController _phone = TextEditingController();
   TextEditingController _otp = TextEditingController();

   @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _phone.dispose();
    _otp.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SafeArea(
          bottom: false,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text('Login in or Signup',style: TextStyle(fontSize: 18.sp,fontWeight: FontWeight.bold),),
              ),
              Divider(color: Colors.black12,),
              Padding(padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Welcome to RentHere",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                  SizedBox(height: 10.h,),
                  Container(
                    height: height*0.15,
                    decoration:BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Colors.black45
                      )
                  ),
                    child: Column(
                      children: [
                        Expanded(
                          flex:1,
                          child: Container(
                            width: double.infinity,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 10,top: 10),
                              child: Text("Nepal(+977)",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                            )
                          ),
                        ),
                        Divider(color: Colors.black45,),
                        Expanded(
                          flex: 1,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextField(
                              controller: _phone,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Phone Number",
                              ),
                            ),
                          ),
                        )


                      ],
                    ),

                  ),

                  SizedBox(height: height*0.01,),
                  RichText(text: TextSpan(
                    text: "This is an Crucial number,Company can call you message you to confirm. "
                        ,style: TextStyle(color: Colors.black,fontSize: 15),
                    children: [
                      TextSpan(
                        text: "Privacy Policy",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15,decoration: TextDecoration.underline)
                      )
                    ]

                  )),
                  SizedBox(height: height*0.02,),
                GestureDetector(
                  onTap: (){
                    setState(() {
                      ShowSnacBar(context: context, discrip: "Sorry, This Service not available now", type: SnackBarType.Error);
                    });
                  },
                  child: Container(
                      height: height*0.05,width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.pink
                      ),
                      child: Center(child: Text("Continue",style: TextStyle(color: Colors.white,fontSize: 22,fontWeight: FontWeight.bold),))),
                ),

                  SizedBox(height: height*0.01,),
                  Row(
                    children: [
                      Expanded(child: Container(height: 1,color: Colors.black26)),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('Or'),
                      ),
                      Expanded(child: Container(height: 1,color: Colors.black26)),
                    ],
                  ),
                  SizedBox(height: height*0.03,),
                  BlocConsumer<AuthMianBloc,AuthMainState>(
                    listener: (context,state){
                      if(state is SignInUserWithGoogleSuccessState)
                        {
                          ShowSnacBar(context: context, discrip:"SignedUp  with Google Successfully ", type: SnackBarType.Success);
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
                        }
                      if(state is SignInErrorState)
                        {
                          ShowSnacBar(context: context, discrip:state.errMsg, type: SnackBarType.Error);
                        }

                    },
                    builder: (context,sate) {
                      return SocialIcon('assets/images/google.png', "Continue With Google",height,(){});
                    }
                  ),
                  SizedBox(height: height*0.026,),
                  SocialIcon('assets/images/facebook.png', "Continue With Facebook",height,(){}),
                  SizedBox(height: height*0.026,),
                  SocialIcon('assets/images/apple.png', "Continue With Apple",height,(){}),
                  SizedBox(height: height*0.027,),
                  SocialIcon('assets/images/email2.png', "Continue With Email",height,(){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginwithEmailPass()));
                  }),
                  SizedBox(height: height*0.03,),
                  TextButton(onPressed: (){
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>SignUpScreen()));
                  }, child: Center(
                    child: Text("Create a new account?",
                      style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.black87),),
                  ))





                ],
              ),)
            ],
          ),
        ),
      ),
    );
  }

}

Widget SocialIcon(String path, String hint,double height,VoidCallback onTap){
  return InkWell(
    onTap: onTap,
    child: Container(
      height:height*0.06 ,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: BoxBorder.all(
          color:  Colors.black87,
              width: 1
        )
      ),
      child: Padding(
        padding: EdgeInsets.only(left: 10,right: 35),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(path,height: 30.h,),
              Text(hint,style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600),)
            ],
          ),
        ),
      )


    ),
  );
}