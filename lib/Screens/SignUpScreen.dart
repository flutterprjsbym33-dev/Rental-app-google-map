import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:goolemapuse/Screens/HomeScreen.dart';
import 'package:goolemapuse/SigninBloc/SignInBlocMainEvents.dart';
import 'package:goolemapuse/SigninBloc/SignInMainBloc.dart';
import 'package:goolemapuse/auth/AuthMainBloc.dart';

import 'package:goolemapuse/utilities/SnackBarType.dart';

import '../SigninBloc/SignInBlocMainState.dart';
import '../auth/AuthMainState.dart';
import '../auth/AuthMainevents.dart';
import 'LoginScreen.dart';

class SignUpScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SignUpScreen();
  }

}

class _SignUpScreen extends State<SignUpScreen>{

  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  TextEditingController _fullname = TextEditingController();

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
                child: Text(' Signup',style: TextStyle(fontSize: 18.sp,fontWeight: FontWeight.bold),),
              ),
              Divider(color: Colors.black12,),
              Padding(padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Welcome to RentHere",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                    SizedBox(height: 10.h,),
                    Container(
                      height: height*0.25,
                      decoration:BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                              color: Colors.black45
                          )
                      ),
                      child: Column(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextField(
                                controller: _fullname,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Full Name",
                                ),
                              ),
                            ),
                          ),
                          Divider(color: Colors.black45,),
                          Expanded(
                            flex: 1,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextField(
                                controller: _email,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Email",
                                ),
                              ),
                            ),
                          ),
                          Divider(color: Colors.black45,),
                          Expanded(
                            flex: 1,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextField(
                                controller: _password,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Password",
                                ),
                              ),
                            ),
                          )


                        ],
                      ),

                    ),
                    SizedBox(height: height*0.02,),
                    RichText(text: TextSpan(
                        text: "This is an Crucial Process,Please enter valid and strong details.   "
                        ,style: TextStyle(color: Colors.black,fontSize: 15),
                        children: [
                          TextSpan(
                              text: "Privacy Policy",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15,decoration: TextDecoration.underline)
                          )
                        ]

                    )),
                    SizedBox(height: height*0.02,),
                    BlocConsumer<AuthMianBloc,AuthMainState>(
                      listener: (context,state){
                        if(state is SignInErrorState)
                        {
                          ShowSnacBar(context: context, discrip:state.errMsg, type: SnackBarType.Error);
                        }
                        if(state is SignInUserWithEmailSuccessState)
                          {
                            ShowSnacBar(context: context, discrip:"SignUp Successfully with Email", type: SnackBarType.Success);
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
                          }
                      },
                      builder: (context,state) {
                        if(state is AuthInitialState)
                          {
                            return GestureDetector(
                              onTap: (){
                                context.read<AuthMianBloc>().add(CreateUserWithEmail(fullName: _fullname.text, email: _email.text, pass: _password.text));

                              },
                              child: Container(
                                  height: height*0.05,width: double.infinity,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.pink
                                  ),
                                  child: Center(child: Text("Continue",style: TextStyle(color: Colors.white,fontSize: 22,fontWeight: FontWeight.bold),))),
                            );
                          }
                        if(state is SignInLoadingState)
                        {
                          return GestureDetector(
                            onTap: (){},
                            child: Container(
                                height: height*0.05,width: double.infinity,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.pink
                                ),
                                child: Center(child: CircularProgressIndicator())),
                          );
                        }



                        return   GestureDetector(
                          onTap: (){
                            context.read<AuthMianBloc>().add(CreateUserWithEmail(fullName: _fullname.text, email: _email.text, pass: _password.text));

                          },
                          child: Container(
                              height: height*0.05,width: double.infinity,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.pink
                              ),
                              child: Center(child: Text("Continue",style: TextStyle(color: Colors.white,fontSize: 22,fontWeight: FontWeight.bold),))),
                        );
                      }
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
                    SizedBox(height: height*0.02,),
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
                          return SocialIcon('assets/images/google.png', "Continue With Google",height,(){
                            context.read<AuthMianBloc>().add(GoogleSignIn());
                          });
                        }
                    ),
                    SizedBox(height: height*0.026,),
                    SocialIcon('assets/images/facebook.png', "SignUp With Facebook",height,(){}),
                    SizedBox(height: height*0.026,),
                    SocialIcon('assets/images/apple.png', "SignUp With Apple",height,(){}),
                    SizedBox(height: height*0.027,),
                    SocialIcon('assets/images/email2.png', "SignUp With Email",height,(){}),
                    SizedBox(height: height*0.03,),






                  ],
                ),)
            ],
          ),
        ),
      ),
    );
  }

}