import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:goolemapuse/CubitsBloc/FetchUserInfoCubit.dart';
import 'package:goolemapuse/Screens/ExploreScreen.dart';
import 'package:goolemapuse/Screens/LoginScreen.dart';
import 'package:goolemapuse/auth/AuthMainBloc.dart';
import 'package:goolemapuse/auth/AuthMainState.dart';
import 'package:goolemapuse/auth/AuthMainevents.dart';
import 'package:lottie/lottie.dart';

import '../CubitsBloc/BottomIndexSelector.dart';
import '../CubitsBloc/FetchUserState.dart';

class ProfileSection extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ProfileSection();
  }

}

class _ProfileSection extends State<ProfileSection>{

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<FetchUserInfoCubit>().fetchUserDetails();
  }
  @override
  Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      leading: IconButton(onPressed: (){
        context.read<BottomIndexSelector>().indexSelector(0);
      }, icon: Icon(Icons.arrow_back),),
      title: Text("Profile",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
    ),
    body: SafeArea(child: RefreshIndicator(
      onRefresh: ()async{
        await   context.read<FetchUserInfoCubit>().fetchUserDetails();
      },
      child: SingleChildScrollView(
        child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10,vertical: 25),
                child:  BlocBuilder<FetchUserInfoCubit,FetchUserState>(
                    builder:(context,state)
                    {
                      return Align(
                        alignment: Alignment.topCenter,
                        child: Column(
                          children: [
                               Stack(
                                 clipBehavior: Clip.none,
                                 children:[ CircleAvatar(
                                  radius: 65,
                                  backgroundImage: state.isLoading
                                      ? null
                                      : NetworkImage(state.image),
                                  child: state.isLoading
                                      ? Lottie.asset('assets/images/iloading.json')
                                      : null,
        
                                 ),
                                   Positioned(
                                     bottom: -10,right: 0,
                                       child: IconButton(onPressed: (){
        
                                         context.read<AuthMianBloc>().add(UpdateprofilePicture2());
        
                                       }, icon: CircleAvatar(
                                     backgroundColor: Colors.green,
                                     radius: 15,
                                       child: Icon(Icons.add,color: Colors.white,))))
                                 ]
                               ),
                            SizedBox(height: 12.h,),
                           state.name.isEmpty ? Text("Username......")  : Text(state.name,style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),),
                            SizedBox(height: 6.h,),
                            state.email.isEmpty ? Text("Email......")  : Text(state.email,style: TextStyle(fontSize: 18,fontWeight: FontWeight.w400,color: Colors.grey),),
                            SizedBox(height: 6.h,),
                            state.joined_date.isEmpty ? Text("Joined At......")  : Text("Joined: ${state.joined_date}",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w400,color: Colors.grey),),
                            SizedBox(height: 8.h,),
                            BlocConsumer<AuthMianBloc,AuthMainState>(
                              listener: (context,state){
                                if(state is SignOutSuccessState)
                                  {
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
                                  }
        
                              },
                              builder: (context,state) {
                                if(state is SignOutLoadingState)
                                  {
                                    return SizedBox(
                                      height: 50.h,
                                      width: 200.w,
                                      child: ElevatedButton(onPressed: (){
                                        context.read<AuthMianBloc>().add(SignOut1());
        
                                      },
                                          style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.blue,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(15)
                                              )
                                          ),
                                          child: Row(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Icon(Icons.logout,color: Colors.white,size: 25,),
                                              SizedBox(width: 5.w,),
                                              Text("Logging Out..",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),)
                                            ],)),
                                    );
                                  }
                                return SizedBox(
                                  height: 50.h,
                                  width: 200.w,
                                  child: ElevatedButton(onPressed: (){
                                    context.read<AuthMianBloc>().add(SignOut1());
        
                                  },
                                      style: ElevatedButton.styleFrom(
                                       backgroundColor: Colors.blue,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(15)
                                        )
                                      ),
                                      child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                    Icon(Icons.logout,color: Colors.white,size: 25,),
                                    SizedBox(width: 5.w,),
                                    Text("Logout",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),)
                                  ],)),
                                );
                              }
                            )
        
        
        
        
                          ],
                        ),
                      );
        
                    }
                ),
        ),
      ),
    ))
  );
  }


}